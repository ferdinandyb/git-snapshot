#include "git-compat-util.h"
#include "compressed-bitmap.h"

void NORETURN unknown_bitmap_type(enum compressed_bitmap_type type)
{
	BUG("unknown compressed bitmap type: %d", type);
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
