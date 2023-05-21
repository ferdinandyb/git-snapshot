#ifndef COMPRESSED_BITMAP_H
#define COMPRESSED_BITMAP_H

#include "ewah/ewok.h"

enum compressed_bitmap_type {
	EWAH,
};

struct compressed_bitmap {
	union {
		struct ewah_bitmap ewah;
	} u;
	enum compressed_bitmap_type type;
};

struct compressed_bitmap *compress_ewah_bitmap(struct ewah_bitmap *ewah);
struct compressed_bitmap *new_compressed_ewah(void);

struct ewah_bitmap *compressed_as_ewah(struct compressed_bitmap *bitmap);

void compressed_bitmap_set(struct compressed_bitmap *bitmap, size_t i);

#endif
