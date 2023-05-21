#include "git-compat-util.h"
#include "compressed-bitmap.h"

struct compressed_bitmap *compress_ewah_bitmap(struct ewah_bitmap *ewah)
{
	struct compressed_bitmap *cb;

	CALLOC_ARRAY(cb, 1);

	cb->u.ewah = *ewah;
	cb->type = EWAH;

	return cb;
}

struct compressed_bitmap *new_compressed_ewah(void)
{
	return compress_ewah_bitmap(ewah_new());
}

struct ewah_bitmap *compressed_as_ewah(struct compressed_bitmap *bitmap)
{
	if (bitmap->type != EWAH)
		BUG("called compressed_as_ewah() with non-EWAH bitmap");
	return &(bitmap->u.ewah);
}

void compressed_bitmap_set(struct compressed_bitmap *bitmap, size_t i)
{
	switch (bitmap->type) {
	case EWAH:
		ewah_set(&bitmap->u.ewah, i);
		break;
	default:
		BUG("unknown compressed bitmap type: %d", bitmap->type);
	}
}
