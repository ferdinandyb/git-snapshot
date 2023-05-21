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

struct compressed_bitmap *new_compressed_ewah(void)
{
	return compress_ewah_bitmap(ewah_new());
}

void free_compressed_bitmap(struct compressed_bitmap *bitmap)
{
	if (!bitmap)
		return;

	switch (bitmap->type) {
	case TYPE_EWAH:
		ewah_pool_free(&bitmap->u.ewah);
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

struct bitmap *compressed_as_bitmap(struct compressed_bitmap *bitmap)
{
	switch (bitmap->type) {
	case TYPE_EWAH:
		return ewah_to_bitmap(compressed_as_ewah(bitmap));
	}
	unknown_bitmap_type(bitmap->type);
}

void compressed_bitmap_set(struct compressed_bitmap *bitmap, size_t i)
{
	switch (bitmap->type) {
	case TYPE_EWAH:
		ewah_set(&bitmap->u.ewah, i);
		return;
	}
	unknown_bitmap_type(bitmap->type);
}
