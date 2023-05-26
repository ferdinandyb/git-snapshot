#include "git-compat-util.h"
#include "compressed-bitmap.h"
#include "gettext.h"

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

const char *bitmap_type_name(const enum compressed_bitmap_type type)
{
	switch (type) {
	case TYPE_EWAH:
		return "ewah";
	case TYPE_ROARING:
		return "roaring";
	}
	unknown_bitmap_type(type);
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
			bitmap_set(bitmap, buf[i]);

		if (n < ROARING_BUFFER_LEN)
			break;
	}

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
							(pos * BITS_IN_EWORD) + offset);
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
}

void init_roaring_iterator(struct compressed_bitmap_iterator *it,
			   struct roaring_bitmap_s *roaring)
{
#if 0
	roaring_init_iterator(roaring, &it->u.roaring);
#endif
	it->u.roaring = bitset_create();
	if (!roaring_bitmap_to_bitset(roaring, it->u.roaring))
		die(_("could not initialize roaring bitset"));

	it->type = TYPE_ROARING;
	it->roaring_pos = 0;
}

static int ewah_iterator_next_1(struct compressed_bitmap_iterator *it,
				eword_t *result)
{
	if (it->type != TYPE_EWAH)
		BUG("expected EWAH bitmap, got: %d", it->type);
	return ewah_iterator_next(result, &it->u.ewah);
}

#if 0
static int roaring_iterator_next_1(struct compressed_bitmap_iterator *it,
				   eword_t *result_p)
{
	eword_t word = 0;
	size_t i = 0;

	if (it->type != TYPE_ROARING)
		BUG("expected roaring bitmap, got: %d", it->type);

	while (i < BITS_IN_EWORD) {
		if (!it->roaring_offset)
			it->roaring_alloc = roaring_read_uint32_iterator(&it->u.roaring,
									 it->roaring_buf,
									 BITS_IN_EWORD);

		for (; it->roaring_offset < it->roaring_alloc; it->roaring_offset++) {
			eword_t mask;
			if (it->roaring_buf[it->roaring_offset] >= (it->roaring_pos + 1) * BITS_IN_EWORD)
				goto done;

			mask = (eword_t)1 << it->roaring_buf[it->roaring_offset] % BITS_IN_EWORD;
			word |= mask;
		}

		i = it->roaring_buf[it->roaring_offset] % BITS_IN_EWORD;
	}

done:
	if (result_p)
		*result_p = word;
	it->roaring_pos++;
	return it->roaring_alloc <= BITS_IN_EWORD;
}
#endif

static int roaring_iterator_next_1(struct compressed_bitmap_iterator *it,
				   eword_t *result_p)
{
	struct bitset_s *bitset = it->u.roaring;
	if (it->roaring_pos >= bitset_size_in_words(bitset)) {
		if (result_p)
			*result_p = 0;
		return 0;
	}

	if (result_p)
		*result_p = (eword_t)bitset->array[it->roaring_pos];
	return ++it->roaring_pos < bitset_size_in_words(bitset);
}

int compressed_bitmap_iterator_next(struct compressed_bitmap_iterator *it,
				    eword_t *result)
{
	switch (it->type) {
	case TYPE_EWAH:
		return ewah_iterator_next_1(it, result);
	case TYPE_ROARING:
		return roaring_iterator_next_1(it, result);
	}
	unknown_bitmap_type(it->type);
}
