#include "git-compat-util.h"
#include "compressed-bitmap.h"

void NORETURN unknown_bitmap_type(enum compressed_bitmap_type type)
{
	BUG("unknown compressed bitmap type: %d", type);
}

enum compressed_bitmap_type bitmap_type_from_name(const char *name)
{
	if (!strcmp(name, "ewah"))
		return TYPE_EWAH;
	else if (!strcmp(name, "roaring"))
		return TYPE_ROARING;
	die("unknown bitmap type: '%s'", name);
}

struct compressed_bitmap *compress_ewah_bitmap(struct ewah_bitmap *ewah)
{
	struct compressed_bitmap *cb;

	CALLOC_ARRAY(cb, 1);

	cb->u.ewah = *ewah;
	cb->type = TYPE_EWAH;

	return cb;
}

struct compressed_bitmap *compress_roaring_bitmap(struct roaring_bitmap_s *roaring)
{
	struct compressed_bitmap *cb;

	CALLOC_ARRAY(cb, 1);

	cb->u.roaring = *roaring;
	cb->type = TYPE_ROARING;

	return cb;
}

struct compressed_bitmap *new_compressed_bitmap(enum compressed_bitmap_type type)
{
	switch (type) {
	case TYPE_EWAH:
		return new_compressed_ewah();
	case TYPE_ROARING:
		return new_compressed_roaring();
	}
	unknown_bitmap_type(type);
}

struct compressed_bitmap *new_compressed_ewah(void)
{
	return compress_ewah_bitmap(ewah_new());
}

struct compressed_bitmap *new_compressed_roaring(void)
{
	return compress_roaring_bitmap(roaring_bitmap_create());
}

void free_compressed_bitmap(struct compressed_bitmap *bitmap)
{
	if (!bitmap)
		return;

	switch (bitmap->type) {
	case TYPE_EWAH:
		ewah_pool_free(&bitmap->u.ewah);
		return;
	case TYPE_ROARING:
		roaring_bitmap_free(&bitmap->u.roaring);
		return;
	}
	unknown_bitmap_type(bitmap->type);
}

struct ewah_bitmap *compressed_as_ewah(struct compressed_bitmap *bitmap)
{
	if (bitmap->type != TYPE_EWAH)
		BUG("called compressed_as_ewah() with non-EWAH bitmap");
	return &bitmap->u.ewah;
}

struct roaring_bitmap_s *compressed_as_roaring(struct compressed_bitmap *bitmap)
{
	if (bitmap->type != TYPE_ROARING)
		BUG("called compressed_as_roaring() with non-ROARING bitmap");
	return &bitmap->u.roaring;
}

#define ROARING_BUFFER_LEN (256)

static struct bitmap *roaring_to_bitmap(struct roaring_bitmap_s *roaring)
{
	static uint32_t buf[ROARING_BUFFER_LEN]; /* scratch space */
	struct bitmap *bitmap = bitmap_new();
	struct roaring_uint32_iterator_s it;
	uint32_t i, n;

	roaring_init_iterator(roaring, &it);

	while (1) {
		n = roaring_read_uint32_iterator(&it, buf, ROARING_BUFFER_LEN);
		for (i = 0; i < n; i++)
			bitmap_set(bitmap, (uint32_t)i);

		if (n < ROARING_BUFFER_LEN)
			break;
	}

	roaring_free_uint32_iterator(&it);

	return bitmap;
}

struct bitmap *compressed_as_bitmap(struct compressed_bitmap *bitmap)
{
	switch (bitmap->type) {
	case TYPE_EWAH:
		return ewah_to_bitmap(compressed_as_ewah(bitmap));
	case TYPE_ROARING:
		return roaring_to_bitmap(compressed_as_roaring(bitmap));
	}
	unknown_bitmap_type(bitmap->type);
}

void compressed_bitmap_set(struct compressed_bitmap *bitmap, size_t i)
{
	switch (bitmap->type) {
	case TYPE_EWAH:
		ewah_set(&bitmap->u.ewah, i);
		return;
	case TYPE_ROARING:
		if (i > UINT32_MAX)
			BUG("cannot set bit beyond 32-bit range");
		roaring_bitmap_add(&bitmap->u.roaring, (uint32_t)i);
		return;
	}
	unknown_bitmap_type(bitmap->type);
}

struct roaring_bitmap_s *bitmap_to_roaring(struct bitmap *bitmap)
{
	struct roaring_bitmap_s *roaring;
	struct roaring_bulk_context_s ctx = { 0 };
	size_t pos, offset;

	roaring = roaring_bitmap_create();
	if (!roaring)
		return NULL;

	for (pos = 0; pos < bitmap->word_alloc; pos++) {
		eword_t word = bitmap->words[pos];

		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
			if (!(word >> offset))
				continue;

			offset += ewah_bit_ctz64(word >> offset);
			if (word & ((eword_t)1 << offset))
				roaring_bitmap_add_bulk(roaring, &ctx,
							pos + offset);
		}
	}

	roaring_bitmap_run_optimize(roaring);

	return roaring;
}

void init_compressed_bitmap_iterator(struct compressed_bitmap_iterator *it,
				     struct compressed_bitmap *bitmap)
{
	switch (bitmap->type) {
	case TYPE_EWAH:
		init_ewah_iterator(it, compressed_as_ewah(bitmap));
		return;
	case TYPE_ROARING:
		init_roaring_iterator(it, compressed_as_roaring(bitmap));
		return;
	}
	unknown_bitmap_type(bitmap->type);
}

void init_ewah_iterator(struct compressed_bitmap_iterator *it,
			struct ewah_bitmap *ewah)
{
	ewah_iterator_init(&it->u.ewah, ewah);
	it->type = TYPE_EWAH;
	it->ewah.offset = 0;
	it->ewah.pos = 0;
	it->ewah.word = 0;
}

void init_roaring_iterator(struct compressed_bitmap_iterator *it,
			   struct roaring_bitmap_s *roaring)
{
	roaring_init_iterator(roaring, &it->u.roaring);
	it->type = TYPE_ROARING;

	/* not necessary, but can't hurt ... */
	it->ewah.offset = 0;
	it->ewah.pos = 0;
	it->ewah.word = 0;
}

void free_compressed_bitmap_iterator(struct compressed_bitmap_iterator *it)
{
	if (!it)
		return;

	switch (it->type) {
	case TYPE_EWAH:
		return;
	case TYPE_ROARING:
		roaring_free_uint32_iterator(&it->u.roaring);
		return;
	}
}

/*
 * TODO: could eliminate it->ewah.offset and store the bit position in pos
 * entirely.
 *
 * Existing uses of `pos` would become `it->ewah.pos / BITS_IN_EWORD`,
 * and `offset` would become `it->ewah.pos % BITS_IN_EWORD`.
 */
static int ewah_iterator_next_1(struct compressed_bitmap_iterator *it,
				size_t *result)
{
	if (it->type != TYPE_EWAH)
		BUG("expected EWAH bitmap, got: %d", it->type);

	while (it->u.ewah.pointer < it->u.ewah.buffer_size || it->ewah.offset < BITS_IN_EWORD) {
		/*
		 * If we want to read the first byte of a word, we need to get
		 * the next eword_t from the bitmap.
		 */
		if (!it->ewah.offset) {
			if (!ewah_iterator_next(&it->ewah.word, &it->u.ewah)) {
				if (result)
					*result = 0;
				return 0;
			}
		}

		/*
		 * Process the next high bit of the current eword_t.
		 */
		for (; it->ewah.offset < BITS_IN_EWORD; it->ewah.offset++) {
			/* no more bits, advance to next word */
			if (!(it->ewah.word >> it->ewah.offset))
				break;

			it->ewah.offset += ewah_bit_ctz64(it->ewah.word >> it->ewah.offset);
			if (it->ewah.word & ((eword_t)1 << it->ewah.offset)) {
				if (result)
					*result = it->ewah.pos * BITS_IN_EWORD + it->ewah.offset;
				it->ewah.offset = (it->ewah.offset + 1) % BITS_IN_EWORD;

				/*
				 * Check if we ran out of bits, and reset the
				 * iterator so that the next call to
				 * ewah_iterator_next_1() fetches a new word.
				 */
				if (!it->ewah.offset)
					it->ewah.pos++;
				return 1;
			}
		}

		/*
		 * If we didn't return from the above loop, we either ran out of
		 * bits, or all remaining bits were zeros. In either case, set
		 * the iterator's state such that it grabs a new word on the
		 * next iteration of the outer loop.
		 */
		it->ewah.pos++;
		it->ewah.offset = 0;
	}
	return 0;
}

static int roaring_iterator_next_1(struct compressed_bitmap_iterator *it,
				   size_t *result)
{
	if (it->type != TYPE_ROARING)
		BUG("expected roaring bitmap, got: %d", it->type);

	roaring_advance_uint32_iterator(&it->u.roaring);
	if (result)
		*result = it->u.roaring.has_value
			? (size_t)it->u.roaring.current_value : 0;

	return it->u.roaring.has_value;
}

int compressed_bitmap_iterator_next(struct compressed_bitmap_iterator *it,
				    size_t *result)
{
	switch (it->type) {
	case TYPE_EWAH:
		return ewah_iterator_next_1(it, result);
	case TYPE_ROARING:
		return roaring_iterator_next_1(it, result);
	}
	unknown_bitmap_type(it->type);
}
