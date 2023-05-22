#ifndef COMPRESSED_BITMAP_H
#define COMPRESSED_BITMAP_H

#include "ewah/ewok.h"
#include "croaring/roaring.h"

enum compressed_bitmap_type {
	TYPE_EWAH = 0,
	TYPE_ROARING,
};

void NORETURN unknown_bitmap_type(enum compressed_bitmap_type type);

struct compressed_bitmap {
	union {
		struct ewah_bitmap ewah;
		struct roaring_bitmap_s roaring;
	} u;
	enum compressed_bitmap_type type;
};

struct compressed_bitmap *compress_ewah_bitmap(struct ewah_bitmap *ewah);
struct compressed_bitmap *compress_roaring_bitmap(struct roaring_bitmap_s *roaring);
struct compressed_bitmap *new_compressed_ewah(void);
struct compressed_bitmap *new_compressed_roaring(void);

void free_compressed_bitmap(struct compressed_bitmap *bitmap);

struct ewah_bitmap *compressed_as_ewah(struct compressed_bitmap *bitmap);
struct roaring_bitmap_s *compressed_as_roaring(struct compressed_bitmap *bitmap);
struct bitmap *compressed_as_bitmap(struct compressed_bitmap *bitmap);

void compressed_bitmap_set(struct compressed_bitmap *bitmap, size_t i);


#endif
