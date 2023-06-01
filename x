
compressed-bitmap.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <roaring_bitmap_create>:
   0:	55                   	push   %rbp
   1:	48 89 e5             	mov    %rsp,%rbp
   4:	bf 00 00 00 00       	mov    $0x0,%edi
   9:	e8 00 00 00 00       	call   e <roaring_bitmap_create+0xe>
   e:	5d                   	pop    %rbp
   f:	c3                   	ret

0000000000000010 <unknown_bitmap_type>:
{
  10:	55                   	push   %rbp
  11:	48 89 e5             	mov    %rsp,%rbp
  14:	48 83 ec 10          	sub    $0x10,%rsp
  18:	89 7d fc             	mov    %edi,-0x4(%rbp)
	BUG("unknown compressed bitmap type: %d", type);
  1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
  1e:	89 c1                	mov    %eax,%ecx
  20:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 27 <unknown_bitmap_type+0x17>
  27:	48 89 c2             	mov    %rax,%rdx
  2a:	be 07 00 00 00       	mov    $0x7,%esi
  2f:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 36 <unknown_bitmap_type+0x26>
  36:	48 89 c7             	mov    %rax,%rdi
  39:	b8 00 00 00 00       	mov    $0x0,%eax
  3e:	e8 00 00 00 00       	call   43 <bitmap_type_from_name>

0000000000000043 <bitmap_type_from_name>:
{
  43:	55                   	push   %rbp
  44:	48 89 e5             	mov    %rsp,%rbp
  47:	48 83 ec 10          	sub    $0x10,%rsp
  4b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	if (!strcmp(name, "ewah"))
  4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  53:	48 8d 15 00 00 00 00 	lea    0x0(%rip),%rdx        # 5a <bitmap_type_from_name+0x17>
  5a:	48 89 d6             	mov    %rdx,%rsi
  5d:	48 89 c7             	mov    %rax,%rdi
  60:	e8 00 00 00 00       	call   65 <bitmap_type_from_name+0x22>
  65:	85 c0                	test   %eax,%eax
  67:	75 07                	jne    70 <bitmap_type_from_name+0x2d>
		return TYPE_EWAH;
  69:	b8 00 00 00 00       	mov    $0x0,%eax
  6e:	eb 3c                	jmp    ac <bitmap_type_from_name+0x69>
	else if (!strcmp(name, "roaring"))
  70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  74:	48 8d 15 00 00 00 00 	lea    0x0(%rip),%rdx        # 7b <bitmap_type_from_name+0x38>
  7b:	48 89 d6             	mov    %rdx,%rsi
  7e:	48 89 c7             	mov    %rax,%rdi
  81:	e8 00 00 00 00       	call   86 <bitmap_type_from_name+0x43>
  86:	85 c0                	test   %eax,%eax
  88:	75 07                	jne    91 <bitmap_type_from_name+0x4e>
		return TYPE_ROARING;
  8a:	b8 01 00 00 00       	mov    $0x1,%eax
  8f:	eb 1b                	jmp    ac <bitmap_type_from_name+0x69>
	die("unknown bitmap type: '%s'", name);
  91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  95:	48 89 c6             	mov    %rax,%rsi
  98:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 9f <bitmap_type_from_name+0x5c>
  9f:	48 89 c7             	mov    %rax,%rdi
  a2:	b8 00 00 00 00       	mov    $0x0,%eax
  a7:	e8 00 00 00 00       	call   ac <bitmap_type_from_name+0x69>
}
  ac:	c9                   	leave
  ad:	c3                   	ret

00000000000000ae <bitmap_type_name>:
{
  ae:	55                   	push   %rbp
  af:	48 89 e5             	mov    %rsp,%rbp
  b2:	48 83 ec 10          	sub    $0x10,%rsp
  b6:	89 7d fc             	mov    %edi,-0x4(%rbp)
	switch (type) {
  b9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
  bd:	74 08                	je     c7 <bitmap_type_name+0x19>
  bf:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
  c3:	74 0b                	je     d0 <bitmap_type_name+0x22>
  c5:	eb 12                	jmp    d9 <bitmap_type_name+0x2b>
		return "ewah";
  c7:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # ce <bitmap_type_name+0x20>
  ce:	eb 13                	jmp    e3 <bitmap_type_name+0x35>
		return "roaring";
  d0:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # d7 <bitmap_type_name+0x29>
  d7:	eb 0a                	jmp    e3 <bitmap_type_name+0x35>
	unknown_bitmap_type(type);
  d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
  dc:	89 c7                	mov    %eax,%edi
  de:	e8 00 00 00 00       	call   e3 <bitmap_type_name+0x35>
}
  e3:	c9                   	leave
  e4:	c3                   	ret

00000000000000e5 <compress_ewah_bitmap>:
{
  e5:	55                   	push   %rbp
  e6:	48 89 e5             	mov    %rsp,%rbp
  e9:	53                   	push   %rbx
  ea:	48 83 ec 28          	sub    $0x28,%rsp
  ee:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
	CALLOC_ARRAY(cb, 1);
  f2:	be 30 00 00 00       	mov    $0x30,%esi
  f7:	bf 01 00 00 00       	mov    $0x1,%edi
  fc:	e8 00 00 00 00       	call   101 <compress_ewah_bitmap+0x1c>
 101:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
	cb->u.ewah = *ewah;
 105:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 109:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
 10d:	48 8b 0a             	mov    (%rdx),%rcx
 110:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
 114:	48 89 08             	mov    %rcx,(%rax)
 117:	48 89 58 08          	mov    %rbx,0x8(%rax)
 11b:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
 11f:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
 123:	48 89 48 10          	mov    %rcx,0x10(%rax)
 127:	48 89 58 18          	mov    %rbx,0x18(%rax)
 12b:	48 8b 52 20          	mov    0x20(%rdx),%rdx
 12f:	48 89 50 20          	mov    %rdx,0x20(%rax)
	cb->type = TYPE_EWAH;
 133:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 137:	c7 40 28 00 00 00 00 	movl   $0x0,0x28(%rax)
	return cb;
 13e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 142:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
 146:	c9                   	leave
 147:	c3                   	ret

0000000000000148 <compress_roaring_bitmap>:
{
 148:	55                   	push   %rbp
 149:	48 89 e5             	mov    %rsp,%rbp
 14c:	53                   	push   %rbx
 14d:	48 83 ec 28          	sub    $0x28,%rsp
 151:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
	CALLOC_ARRAY(cb, 1);
 155:	be 30 00 00 00       	mov    $0x30,%esi
 15a:	bf 01 00 00 00       	mov    $0x1,%edi
 15f:	e8 00 00 00 00       	call   164 <compress_roaring_bitmap+0x1c>
 164:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
	cb->u.roaring = *roaring;
 168:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 16c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
 170:	48 8b 0a             	mov    (%rdx),%rcx
 173:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
 177:	48 89 08             	mov    %rcx,(%rax)
 17a:	48 89 58 08          	mov    %rbx,0x8(%rax)
 17e:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
 182:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
 186:	48 89 48 10          	mov    %rcx,0x10(%rax)
 18a:	48 89 58 18          	mov    %rbx,0x18(%rax)
 18e:	48 8b 52 20          	mov    0x20(%rdx),%rdx
 192:	48 89 50 20          	mov    %rdx,0x20(%rax)
	cb->type = TYPE_ROARING;
 196:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 19a:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%rax)
	return cb;
 1a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 1a5:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
 1a9:	c9                   	leave
 1aa:	c3                   	ret

00000000000001ab <new_compressed_bitmap>:
{
 1ab:	55                   	push   %rbp
 1ac:	48 89 e5             	mov    %rsp,%rbp
 1af:	48 83 ec 10          	sub    $0x10,%rsp
 1b3:	89 7d fc             	mov    %edi,-0x4(%rbp)
	switch (type) {
 1b6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
 1ba:	74 08                	je     1c4 <new_compressed_bitmap+0x19>
 1bc:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
 1c0:	74 09                	je     1cb <new_compressed_bitmap+0x20>
 1c2:	eb 0e                	jmp    1d2 <new_compressed_bitmap+0x27>
		return new_compressed_ewah();
 1c4:	e8 00 00 00 00       	call   1c9 <new_compressed_bitmap+0x1e>
 1c9:	eb 11                	jmp    1dc <new_compressed_bitmap+0x31>
		return new_compressed_roaring();
 1cb:	e8 00 00 00 00       	call   1d0 <new_compressed_bitmap+0x25>
 1d0:	eb 0a                	jmp    1dc <new_compressed_bitmap+0x31>
	unknown_bitmap_type(type);
 1d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
 1d5:	89 c7                	mov    %eax,%edi
 1d7:	e8 00 00 00 00       	call   1dc <new_compressed_bitmap+0x31>
}
 1dc:	c9                   	leave
 1dd:	c3                   	ret

00000000000001de <new_compressed_ewah>:
{
 1de:	55                   	push   %rbp
 1df:	48 89 e5             	mov    %rsp,%rbp
	return compress_ewah_bitmap(ewah_new());
 1e2:	e8 00 00 00 00       	call   1e7 <new_compressed_ewah+0x9>
 1e7:	48 89 c7             	mov    %rax,%rdi
 1ea:	e8 00 00 00 00       	call   1ef <new_compressed_ewah+0x11>
}
 1ef:	5d                   	pop    %rbp
 1f0:	c3                   	ret

00000000000001f1 <new_compressed_roaring>:
{
 1f1:	55                   	push   %rbp
 1f2:	48 89 e5             	mov    %rsp,%rbp
	return compress_roaring_bitmap(roaring_bitmap_create());
 1f5:	e8 06 fe ff ff       	call   0 <roaring_bitmap_create>
 1fa:	48 89 c7             	mov    %rax,%rdi
 1fd:	e8 00 00 00 00       	call   202 <new_compressed_roaring+0x11>
}
 202:	5d                   	pop    %rbp
 203:	c3                   	ret

0000000000000204 <free_compressed_bitmap>:
{
 204:	55                   	push   %rbp
 205:	48 89 e5             	mov    %rsp,%rbp
 208:	48 83 ec 10          	sub    $0x10,%rsp
 20c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	if (!bitmap)
 210:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
 215:	74 3c                	je     253 <free_compressed_bitmap+0x4f>
	switch (bitmap->type) {
 217:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 21b:	8b 40 28             	mov    0x28(%rax),%eax
 21e:	85 c0                	test   %eax,%eax
 220:	74 07                	je     229 <free_compressed_bitmap+0x25>
 222:	83 f8 01             	cmp    $0x1,%eax
 225:	74 10                	je     237 <free_compressed_bitmap+0x33>
 227:	eb 1c                	jmp    245 <free_compressed_bitmap+0x41>
		ewah_pool_free(&bitmap->u.ewah);
 229:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 22d:	48 89 c7             	mov    %rax,%rdi
 230:	e8 00 00 00 00       	call   235 <free_compressed_bitmap+0x31>
		return;
 235:	eb 1d                	jmp    254 <free_compressed_bitmap+0x50>
		roaring_bitmap_free(&bitmap->u.roaring);
 237:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 23b:	48 89 c7             	mov    %rax,%rdi
 23e:	e8 00 00 00 00       	call   243 <free_compressed_bitmap+0x3f>
		return;
 243:	eb 0f                	jmp    254 <free_compressed_bitmap+0x50>
	unknown_bitmap_type(bitmap->type);
 245:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 249:	8b 40 28             	mov    0x28(%rax),%eax
 24c:	89 c7                	mov    %eax,%edi
 24e:	e8 00 00 00 00       	call   253 <free_compressed_bitmap+0x4f>
		return;
 253:	90                   	nop
}
 254:	c9                   	leave
 255:	c3                   	ret

0000000000000256 <compressed_as_ewah>:
{
 256:	55                   	push   %rbp
 257:	48 89 e5             	mov    %rsp,%rbp
 25a:	48 83 ec 10          	sub    $0x10,%rsp
 25e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	if (bitmap->type != TYPE_EWAH)
 262:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 266:	8b 40 28             	mov    0x28(%rax),%eax
 269:	85 c0                	test   %eax,%eax
 26b:	74 23                	je     290 <compressed_as_ewah+0x3a>
		BUG("called compressed_as_ewah() with non-EWAH bitmap");
 26d:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 274 <compressed_as_ewah+0x1e>
 274:	48 89 c2             	mov    %rax,%rdx
 277:	be 5e 00 00 00       	mov    $0x5e,%esi
 27c:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 283 <compressed_as_ewah+0x2d>
 283:	48 89 c7             	mov    %rax,%rdi
 286:	b8 00 00 00 00       	mov    $0x0,%eax
 28b:	e8 00 00 00 00       	call   290 <compressed_as_ewah+0x3a>
	return &bitmap->u.ewah;
 290:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 294:	c9                   	leave
 295:	c3                   	ret

0000000000000296 <compressed_as_roaring>:
{
 296:	55                   	push   %rbp
 297:	48 89 e5             	mov    %rsp,%rbp
 29a:	48 83 ec 10          	sub    $0x10,%rsp
 29e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	if (bitmap->type != TYPE_ROARING)
 2a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 2a6:	8b 40 28             	mov    0x28(%rax),%eax
 2a9:	83 f8 01             	cmp    $0x1,%eax
 2ac:	74 23                	je     2d1 <compressed_as_roaring+0x3b>
		BUG("called compressed_as_roaring() with non-ROARING bitmap");
 2ae:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 2b5 <compressed_as_roaring+0x1f>
 2b5:	48 89 c2             	mov    %rax,%rdx
 2b8:	be 65 00 00 00       	mov    $0x65,%esi
 2bd:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 2c4 <compressed_as_roaring+0x2e>
 2c4:	48 89 c7             	mov    %rax,%rdi
 2c7:	b8 00 00 00 00       	mov    $0x0,%eax
 2cc:	e8 00 00 00 00       	call   2d1 <compressed_as_roaring+0x3b>
	return &bitmap->u.roaring;
 2d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 2d5:	c9                   	leave
 2d6:	c3                   	ret

00000000000002d7 <roaring_to_bitmap>:
{
 2d7:	55                   	push   %rbp
 2d8:	48 89 e5             	mov    %rsp,%rbp
 2db:	48 83 ec 20          	sub    $0x20,%rsp
 2df:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
	struct bitmap *out = malloc(sizeof(struct bitmap));
 2e3:	bf 10 00 00 00       	mov    $0x10,%edi
 2e8:	e8 00 00 00 00       	call   2ed <roaring_to_bitmap+0x16>
 2ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	bitset_t *set = bitset_create();
 2f1:	e8 00 00 00 00       	call   2f6 <roaring_to_bitmap+0x1f>
 2f6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
	roaring_bitmap_to_bitset(roaring, set);
 2fa:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 2fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 302:	48 89 d6             	mov    %rdx,%rsi
 305:	48 89 c7             	mov    %rax,%rdi
 308:	e8 00 00 00 00       	call   30d <roaring_to_bitmap+0x36>
	out->words = set->array;
 30d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 311:	48 8b 10             	mov    (%rax),%rdx
 314:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 318:	48 89 10             	mov    %rdx,(%rax)
	out->word_alloc = set->arraysize;
 31b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 31f:	48 8b 50 08          	mov    0x8(%rax),%rdx
 323:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 327:	48 89 50 08          	mov    %rdx,0x8(%rax)
	return out;
 32b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
 32f:	c9                   	leave
 330:	c3                   	ret

0000000000000331 <compressed_as_bitmap>:
{
 331:	55                   	push   %rbp
 332:	48 89 e5             	mov    %rsp,%rbp
 335:	48 83 ec 10          	sub    $0x10,%rsp
 339:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
	switch (bitmap->type) {
 33d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 341:	8b 40 28             	mov    0x28(%rax),%eax
 344:	85 c0                	test   %eax,%eax
 346:	74 07                	je     34f <compressed_as_bitmap+0x1e>
 348:	83 f8 01             	cmp    $0x1,%eax
 34b:	74 18                	je     365 <compressed_as_bitmap+0x34>
 34d:	eb 2c                	jmp    37b <compressed_as_bitmap+0x4a>
		return ewah_to_bitmap(compressed_as_ewah(bitmap));
 34f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 353:	48 89 c7             	mov    %rax,%rdi
 356:	e8 00 00 00 00       	call   35b <compressed_as_bitmap+0x2a>
 35b:	48 89 c7             	mov    %rax,%rdi
 35e:	e8 00 00 00 00       	call   363 <compressed_as_bitmap+0x32>
 363:	eb 24                	jmp    389 <compressed_as_bitmap+0x58>
		return roaring_to_bitmap(compressed_as_roaring(bitmap));
 365:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 369:	48 89 c7             	mov    %rax,%rdi
 36c:	e8 00 00 00 00       	call   371 <compressed_as_bitmap+0x40>
 371:	48 89 c7             	mov    %rax,%rdi
 374:	e8 5e ff ff ff       	call   2d7 <roaring_to_bitmap>
 379:	eb 0e                	jmp    389 <compressed_as_bitmap+0x58>
	unknown_bitmap_type(bitmap->type);
 37b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 37f:	8b 40 28             	mov    0x28(%rax),%eax
 382:	89 c7                	mov    %eax,%edi
 384:	e8 00 00 00 00       	call   389 <compressed_as_bitmap+0x58>
}
 389:	c9                   	leave
 38a:	c3                   	ret

000000000000038b <compressed_bitmap_set>:
{
 38b:	55                   	push   %rbp
 38c:	48 89 e5             	mov    %rsp,%rbp
 38f:	48 83 ec 10          	sub    $0x10,%rsp
 393:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 397:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
	switch (bitmap->type) {
 39b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 39f:	8b 40 28             	mov    0x28(%rax),%eax
 3a2:	85 c0                	test   %eax,%eax
 3a4:	74 07                	je     3ad <compressed_bitmap_set+0x22>
 3a6:	83 f8 01             	cmp    $0x1,%eax
 3a9:	74 17                	je     3c2 <compressed_bitmap_set+0x37>
 3ab:	eb 59                	jmp    406 <compressed_bitmap_set+0x7b>
		ewah_set(&bitmap->u.ewah, i);
 3ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 3b1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 3b5:	48 89 d6             	mov    %rdx,%rsi
 3b8:	48 89 c7             	mov    %rax,%rdi
 3bb:	e8 00 00 00 00       	call   3c0 <compressed_bitmap_set+0x35>
		return;
 3c0:	eb 52                	jmp    414 <compressed_bitmap_set+0x89>
		if (i > UINT32_MAX)
 3c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3c7:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
 3cb:	73 23                	jae    3f0 <compressed_bitmap_set+0x65>
			BUG("cannot set bit beyond 32-bit range");
 3cd:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 3d4 <compressed_bitmap_set+0x49>
 3d4:	48 89 c2             	mov    %rax,%rdx
 3d7:	be 89 00 00 00       	mov    $0x89,%esi
 3dc:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 3e3 <compressed_bitmap_set+0x58>
 3e3:	48 89 c7             	mov    %rax,%rdi
 3e6:	b8 00 00 00 00       	mov    $0x0,%eax
 3eb:	e8 00 00 00 00       	call   3f0 <compressed_bitmap_set+0x65>
		roaring_bitmap_add(&bitmap->u.roaring, (uint32_t)i);
 3f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 3f4:	89 c2                	mov    %eax,%edx
 3f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 3fa:	89 d6                	mov    %edx,%esi
 3fc:	48 89 c7             	mov    %rax,%rdi
 3ff:	e8 00 00 00 00       	call   404 <compressed_bitmap_set+0x79>
		return;
 404:	eb 0e                	jmp    414 <compressed_bitmap_set+0x89>
	unknown_bitmap_type(bitmap->type);
 406:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 40a:	8b 40 28             	mov    0x28(%rax),%eax
 40d:	89 c7                	mov    %eax,%edi
 40f:	e8 00 00 00 00       	call   414 <compressed_bitmap_set+0x89>
}
 414:	c9                   	leave
 415:	c3                   	ret

0000000000000416 <bitmap_to_roaring>:
{
 416:	55                   	push   %rbp
 417:	48 89 e5             	mov    %rsp,%rbp
 41a:	48 83 ec 40          	sub    $0x40,%rsp
 41e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
	struct roaring_bulk_context_s ctx = { 0 };
 422:	48 c7 45 d0 00 00 00 	movq   $0x0,-0x30(%rbp)
 429:	00 
 42a:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
 431:	00 
	roaring = roaring_bitmap_create();
 432:	e8 c9 fb ff ff       	call   0 <roaring_bitmap_create>
 437:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
	if (!roaring)
 43b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
 440:	75 0a                	jne    44c <bitmap_to_roaring+0x36>
		return NULL;
 442:	b8 00 00 00 00       	mov    $0x0,%eax
 447:	e9 cd 00 00 00       	jmp    519 <bitmap_to_roaring+0x103>
	for (pos = 0; pos < bitmap->word_alloc; pos++) {
 44c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
 453:	00 
 454:	e9 9e 00 00 00       	jmp    4f7 <bitmap_to_roaring+0xe1>
		eword_t word = bitmap->words[pos];
 459:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
 45d:	48 8b 00             	mov    (%rax),%rax
 460:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
 464:	48 c1 e2 03          	shl    $0x3,%rdx
 468:	48 01 d0             	add    %rdx,%rax
 46b:	48 8b 00             	mov    (%rax),%rax
 46e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
 472:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
 479:	00 
 47a:	eb 6f                	jmp    4eb <bitmap_to_roaring+0xd5>
			if (!(word >> offset))
 47c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 480:	89 c2                	mov    %eax,%edx
 482:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 486:	89 d1                	mov    %edx,%ecx
 488:	48 d3 e8             	shr    %cl,%rax
 48b:	48 85 c0             	test   %rax,%rax
 48e:	74 55                	je     4e5 <bitmap_to_roaring+0xcf>
			offset += ewah_bit_ctz64(word >> offset);
 490:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 494:	89 c2                	mov    %eax,%edx
 496:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 49a:	89 d1                	mov    %edx,%ecx
 49c:	48 d3 e8             	shr    %cl,%rax
 49f:	f3 48 0f bc c0       	tzcnt  %rax,%rax
 4a4:	48 98                	cltq
 4a6:	48 01 45 f0          	add    %rax,-0x10(%rbp)
			if (word & ((eword_t)1 << offset))
 4aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 4ae:	89 c2                	mov    %eax,%edx
 4b0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
 4b4:	89 d1                	mov    %edx,%ecx
 4b6:	48 d3 e8             	shr    %cl,%rax
 4b9:	83 e0 01             	and    $0x1,%eax
 4bc:	48 85 c0             	test   %rax,%rax
 4bf:	74 25                	je     4e6 <bitmap_to_roaring+0xd0>
				roaring_bitmap_add_bulk(roaring, &ctx,
 4c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 4c5:	c1 e0 06             	shl    $0x6,%eax
 4c8:	89 c2                	mov    %eax,%edx
 4ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 4ce:	01 c2                	add    %eax,%edx
 4d0:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
 4d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 4d8:	48 89 ce             	mov    %rcx,%rsi
 4db:	48 89 c7             	mov    %rax,%rdi
 4de:	e8 00 00 00 00       	call   4e3 <bitmap_to_roaring+0xcd>
 4e3:	eb 01                	jmp    4e6 <bitmap_to_roaring+0xd0>
				continue;
 4e5:	90                   	nop
		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
 4e6:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
 4eb:	48 83 7d f0 3f       	cmpq   $0x3f,-0x10(%rbp)
 4f0:	76 8a                	jbe    47c <bitmap_to_roaring+0x66>
	for (pos = 0; pos < bitmap->word_alloc; pos++) {
 4f2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
 4f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
 4fb:	48 8b 40 08          	mov    0x8(%rax),%rax
 4ff:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
 503:	0f 82 50 ff ff ff    	jb     459 <bitmap_to_roaring+0x43>
	roaring_bitmap_run_optimize(roaring);
 509:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
 50d:	48 89 c7             	mov    %rax,%rdi
 510:	e8 00 00 00 00       	call   515 <bitmap_to_roaring+0xff>
	return roaring;
 515:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
 519:	c9                   	leave
 51a:	c3                   	ret

000000000000051b <init_compressed_bitmap_iterator>:
{
 51b:	55                   	push   %rbp
 51c:	48 89 e5             	mov    %rsp,%rbp
 51f:	48 83 ec 10          	sub    $0x10,%rsp
 523:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 527:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
	switch (bitmap->type) {
 52b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 52f:	8b 40 28             	mov    0x28(%rax),%eax
 532:	85 c0                	test   %eax,%eax
 534:	74 07                	je     53d <init_compressed_bitmap_iterator+0x22>
 536:	83 f8 01             	cmp    $0x1,%eax
 539:	74 22                	je     55d <init_compressed_bitmap_iterator+0x42>
 53b:	eb 40                	jmp    57d <init_compressed_bitmap_iterator+0x62>
		init_ewah_iterator(it, compressed_as_ewah(bitmap));
 53d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 541:	48 89 c7             	mov    %rax,%rdi
 544:	e8 00 00 00 00       	call   549 <init_compressed_bitmap_iterator+0x2e>
 549:	48 89 c2             	mov    %rax,%rdx
 54c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 550:	48 89 d6             	mov    %rdx,%rsi
 553:	48 89 c7             	mov    %rax,%rdi
 556:	e8 00 00 00 00       	call   55b <init_compressed_bitmap_iterator+0x40>
		return;
 55b:	eb 2e                	jmp    58b <init_compressed_bitmap_iterator+0x70>
		init_roaring_iterator(it, compressed_as_roaring(bitmap));
 55d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 561:	48 89 c7             	mov    %rax,%rdi
 564:	e8 00 00 00 00       	call   569 <init_compressed_bitmap_iterator+0x4e>
 569:	48 89 c2             	mov    %rax,%rdx
 56c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 570:	48 89 d6             	mov    %rdx,%rsi
 573:	48 89 c7             	mov    %rax,%rdi
 576:	e8 00 00 00 00       	call   57b <init_compressed_bitmap_iterator+0x60>
		return;
 57b:	eb 0e                	jmp    58b <init_compressed_bitmap_iterator+0x70>
	unknown_bitmap_type(bitmap->type);
 57d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 581:	8b 40 28             	mov    0x28(%rax),%eax
 584:	89 c7                	mov    %eax,%edi
 586:	e8 00 00 00 00       	call   58b <init_compressed_bitmap_iterator+0x70>
}
 58b:	c9                   	leave
 58c:	c3                   	ret

000000000000058d <init_ewah_iterator>:
{
 58d:	55                   	push   %rbp
 58e:	48 89 e5             	mov    %rsp,%rbp
 591:	48 83 ec 10          	sub    $0x10,%rsp
 595:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 599:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
	ewah_iterator_init(&it->u.ewah, ewah);
 59d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 5a1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 5a5:	48 89 d6             	mov    %rdx,%rsi
 5a8:	48 89 c7             	mov    %rax,%rdi
 5ab:	e8 00 00 00 00       	call   5b0 <init_ewah_iterator+0x23>
	it->type = TYPE_EWAH;
 5b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 5b4:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
}
 5bb:	90                   	nop
 5bc:	c9                   	leave
 5bd:	c3                   	ret

00000000000005be <init_roaring_iterator>:
{
 5be:	55                   	push   %rbp
 5bf:	48 89 e5             	mov    %rsp,%rbp
 5c2:	48 83 ec 10          	sub    $0x10,%rsp
 5c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 5ca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
	roaring_init_iterator(roaring, &it->u.roaring);
 5ce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
 5d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 5d6:	48 89 d6             	mov    %rdx,%rsi
 5d9:	48 89 c7             	mov    %rax,%rdi
 5dc:	e8 00 00 00 00       	call   5e1 <init_roaring_iterator+0x23>
	it->type = TYPE_ROARING;
 5e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 5e5:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
	it->roaring_alloc = 0;
 5ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 5f0:	48 c7 80 48 02 00 00 	movq   $0x0,0x248(%rax)
 5f7:	00 00 00 00 
	it->roaring_pos = 0;
 5fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 5ff:	48 c7 80 50 02 00 00 	movq   $0x0,0x250(%rax)
 606:	00 00 00 00 
	it->roaring_offset = 0;
 60a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 60e:	48 c7 80 58 02 00 00 	movq   $0x0,0x258(%rax)
 615:	00 00 00 00 
	it->roaring_has_data = 0;
 619:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 61d:	c7 80 60 02 00 00 00 	movl   $0x0,0x260(%rax)
 624:	00 00 00 
}
 627:	90                   	nop
 628:	c9                   	leave
 629:	c3                   	ret

000000000000062a <ewah_iterator_next_1>:
{
 62a:	55                   	push   %rbp
 62b:	48 89 e5             	mov    %rsp,%rbp
 62e:	48 83 ec 10          	sub    $0x10,%rsp
 632:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 636:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
	if (it->type != TYPE_EWAH)
 63a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 63e:	8b 40 40             	mov    0x40(%rax),%eax
 641:	85 c0                	test   %eax,%eax
 643:	74 2c                	je     671 <ewah_iterator_next_1+0x47>
		BUG("expected EWAH bitmap, got: %d", it->type);
 645:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 649:	8b 40 40             	mov    0x40(%rax),%eax
 64c:	89 c1                	mov    %eax,%ecx
 64e:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 655 <ewah_iterator_next_1+0x2b>
 655:	48 89 c2             	mov    %rax,%rdx
 658:	be d2 00 00 00       	mov    $0xd2,%esi
 65d:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 664 <ewah_iterator_next_1+0x3a>
 664:	48 89 c7             	mov    %rax,%rdi
 667:	b8 00 00 00 00       	mov    $0x0,%eax
 66c:	e8 00 00 00 00       	call   671 <ewah_iterator_next_1+0x47>
	return ewah_iterator_next(result, &it->u.ewah);
 671:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
 675:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 679:	48 89 d6             	mov    %rdx,%rsi
 67c:	48 89 c7             	mov    %rax,%rdi
 67f:	e8 00 00 00 00       	call   684 <ewah_iterator_next_1+0x5a>
}
 684:	c9                   	leave
 685:	c3                   	ret

0000000000000686 <roaring_iterator_next_1>:
{
 686:	55                   	push   %rbp
 687:	48 89 e5             	mov    %rsp,%rbp
 68a:	48 83 ec 30          	sub    $0x30,%rsp
 68e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
 692:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
	eword_t i = 0;
 696:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
 69d:	00 
	eword_t result = 0;
 69e:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
 6a5:	00 
	uint32_t max_val = (it->roaring_pos + 1) * BITS_IN_EWORD - 1;
 6a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 6aa:	48 8b 80 50 02 00 00 	mov    0x250(%rax),%rax
 6b1:	48 83 c0 01          	add    $0x1,%rax
 6b5:	c1 e0 06             	shl    $0x6,%eax
 6b8:	83 e8 01             	sub    $0x1,%eax
 6bb:	89 45 ec             	mov    %eax,-0x14(%rbp)
	while (i < BITS_IN_EWORD) {
 6be:	e9 77 01 00 00       	jmp    83a <roaring_iterator_next_1+0x1b4>
		if (!it->roaring_has_data) {
 6c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 6c7:	8b 80 60 02 00 00    	mov    0x260(%rax),%eax
 6cd:	85 c0                	test   %eax,%eax
 6cf:	0f 85 87 00 00 00    	jne    75c <roaring_iterator_next_1+0xd6>
			assert(!it->roaring_offset);
 6d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 6d9:	48 8b 80 58 02 00 00 	mov    0x258(%rax),%rax
 6e0:	48 85 c0             	test   %rax,%rax
 6e3:	74 28                	je     70d <roaring_iterator_next_1+0x87>
 6e5:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 6ec <roaring_iterator_next_1+0x66>
 6ec:	48 89 c1             	mov    %rax,%rcx
 6ef:	ba e1 00 00 00       	mov    $0xe1,%edx
 6f4:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 6fb <roaring_iterator_next_1+0x75>
 6fb:	48 89 c6             	mov    %rax,%rsi
 6fe:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 705 <roaring_iterator_next_1+0x7f>
 705:	48 89 c7             	mov    %rax,%rdi
 708:	e8 00 00 00 00       	call   70d <roaring_iterator_next_1+0x87>
							     it->roaring_buf,
 70d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 711:	48 8d 48 44          	lea    0x44(%rax),%rcx
			alloc = roaring_read_uint32_iterator(&it->u.roaring,
 715:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 719:	ba 80 00 00 00       	mov    $0x80,%edx
 71e:	48 89 ce             	mov    %rcx,%rsi
 721:	48 89 c7             	mov    %rax,%rdi
 724:	e8 00 00 00 00       	call   729 <roaring_iterator_next_1+0xa3>
 729:	89 45 e8             	mov    %eax,-0x18(%rbp)
			it->roaring_alloc = alloc;
 72c:	8b 55 e8             	mov    -0x18(%rbp),%edx
 72f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 733:	48 89 90 48 02 00 00 	mov    %rdx,0x248(%rax)
			if (!it->roaring_alloc)
 73a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 73e:	48 8b 80 48 02 00 00 	mov    0x248(%rax),%rax
 745:	48 85 c0             	test   %rax,%rax
 748:	0f 84 f9 00 00 00    	je     847 <roaring_iterator_next_1+0x1c1>
			it->roaring_has_data = 1;
 74e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 752:	c7 80 60 02 00 00 01 	movl   $0x1,0x260(%rax)
 759:	00 00 00 
		if (it->roaring_buf[it->roaring_offset] > max_val)
 75c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 760:	48 8b 90 58 02 00 00 	mov    0x258(%rax),%rdx
 767:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 76b:	48 83 c2 10          	add    $0x10,%rdx
 76f:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
 773:	39 45 ec             	cmp    %eax,-0x14(%rbp)
 776:	0f 82 ce 00 00 00    	jb     84a <roaring_iterator_next_1+0x1c4>
		i = it->roaring_buf[it->roaring_offset++] % BITS_IN_EWORD;
 77c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 780:	48 8b 80 58 02 00 00 	mov    0x258(%rax),%rax
 787:	48 8d 48 01          	lea    0x1(%rax),%rcx
 78b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
 78f:	48 89 8a 58 02 00 00 	mov    %rcx,0x258(%rdx)
 796:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
 79a:	48 83 c0 10          	add    $0x10,%rax
 79e:	8b 44 82 04          	mov    0x4(%rdx,%rax,4),%eax
 7a2:	89 c0                	mov    %eax,%eax
 7a4:	83 e0 3f             	and    $0x3f,%eax
 7a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		warning("%d -> %d, %64u", i, it->roaring_buf[it->roaring_offset - 1], (eword_t)(uint64_t)1<<i);
 7ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 7af:	ba 01 00 00 00       	mov    $0x1,%edx
 7b4:	89 c1                	mov    %eax,%ecx
 7b6:	48 d3 e2             	shl    %cl,%rdx
 7b9:	48 89 d1             	mov    %rdx,%rcx
 7bc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 7c0:	48 8b 80 58 02 00 00 	mov    0x258(%rax),%rax
 7c7:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
 7cb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 7cf:	48 83 c2 10          	add    $0x10,%rdx
 7d3:	8b 54 90 04          	mov    0x4(%rax,%rdx,4),%edx
 7d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 7db:	48 89 c6             	mov    %rax,%rsi
 7de:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 7e5 <roaring_iterator_next_1+0x15f>
 7e5:	48 89 c7             	mov    %rax,%rdi
 7e8:	b8 00 00 00 00       	mov    $0x0,%eax
 7ed:	e8 00 00 00 00       	call   7f2 <roaring_iterator_next_1+0x16c>
		result |= ((eword_t)1) << i;
 7f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 7f6:	ba 01 00 00 00       	mov    $0x1,%edx
 7fb:	89 c1                	mov    %eax,%ecx
 7fd:	48 d3 e2             	shl    %cl,%rdx
 800:	48 89 d0             	mov    %rdx,%rax
 803:	48 09 45 f0          	or     %rax,-0x10(%rbp)
		if (it->roaring_offset >= ARRAY_SIZE(it->roaring_buf))
 807:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 80b:	48 8b 80 58 02 00 00 	mov    0x258(%rax),%rax
 812:	48 83 f8 7f          	cmp    $0x7f,%rax
 816:	76 1d                	jbe    835 <roaring_iterator_next_1+0x1af>
			it->roaring_has_data = it->roaring_offset = 0;
 818:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 81c:	48 c7 80 58 02 00 00 	movq   $0x0,0x258(%rax)
 823:	00 00 00 00 
 827:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 82b:	c7 80 60 02 00 00 00 	movl   $0x0,0x260(%rax)
 832:	00 00 00 
		i++;
 835:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
	while (i < BITS_IN_EWORD) {
 83a:	48 83 7d f8 3f       	cmpq   $0x3f,-0x8(%rbp)
 83f:	0f 86 7e fe ff ff    	jbe    6c3 <roaring_iterator_next_1+0x3d>
 845:	eb 04                	jmp    84b <roaring_iterator_next_1+0x1c5>
				break;
 847:	90                   	nop
 848:	eb 01                	jmp    84b <roaring_iterator_next_1+0x1c5>
			break;
 84a:	90                   	nop
	if (result_p)
 84b:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
 850:	74 0b                	je     85d <roaring_iterator_next_1+0x1d7>
		*result_p = result;
 852:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
 856:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 85a:	48 89 10             	mov    %rdx,(%rax)
	warning("handing out %64.64b", (uint64_t)result);
 85d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
 861:	48 89 c6             	mov    %rax,%rsi
 864:	48 8d 05 00 00 00 00 	lea    0x0(%rip),%rax        # 86b <roaring_iterator_next_1+0x1e5>
 86b:	48 89 c7             	mov    %rax,%rdi
 86e:	b8 00 00 00 00       	mov    $0x0,%eax
 873:	e8 00 00 00 00       	call   878 <roaring_iterator_next_1+0x1f2>
	it->roaring_pos++;
 878:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 87c:	48 8b 80 50 02 00 00 	mov    0x250(%rax),%rax
 883:	48 8d 50 01          	lea    0x1(%rax),%rdx
 887:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 88b:	48 89 90 50 02 00 00 	mov    %rdx,0x250(%rax)
	return it->roaring_offset < it->roaring_alloc;
 892:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 896:	48 8b 90 58 02 00 00 	mov    0x258(%rax),%rdx
 89d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
 8a1:	48 8b 80 48 02 00 00 	mov    0x248(%rax),%rax
 8a8:	48 39 c2             	cmp    %rax,%rdx
 8ab:	0f 92 c0             	setb   %al
 8ae:	0f b6 c0             	movzbl %al,%eax
}
 8b1:	c9                   	leave
 8b2:	c3                   	ret

00000000000008b3 <compressed_bitmap_iterator_next>:
{
 8b3:	55                   	push   %rbp
 8b4:	48 89 e5             	mov    %rsp,%rbp
 8b7:	48 83 ec 10          	sub    $0x10,%rsp
 8bb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
 8bf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
	switch (it->type) {
 8c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8c7:	8b 40 40             	mov    0x40(%rax),%eax
 8ca:	85 c0                	test   %eax,%eax
 8cc:	74 07                	je     8d5 <compressed_bitmap_iterator_next+0x22>
 8ce:	83 f8 01             	cmp    $0x1,%eax
 8d1:	74 17                	je     8ea <compressed_bitmap_iterator_next+0x37>
 8d3:	eb 2a                	jmp    8ff <compressed_bitmap_iterator_next+0x4c>
		return ewah_iterator_next_1(it, result);
 8d5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 8d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8dd:	48 89 d6             	mov    %rdx,%rsi
 8e0:	48 89 c7             	mov    %rax,%rdi
 8e3:	e8 42 fd ff ff       	call   62a <ewah_iterator_next_1>
 8e8:	eb 23                	jmp    90d <compressed_bitmap_iterator_next+0x5a>
		return roaring_iterator_next_1(it, result);
 8ea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
 8ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 8f2:	48 89 d6             	mov    %rdx,%rsi
 8f5:	48 89 c7             	mov    %rax,%rdi
 8f8:	e8 89 fd ff ff       	call   686 <roaring_iterator_next_1>
 8fd:	eb 0e                	jmp    90d <compressed_bitmap_iterator_next+0x5a>
	unknown_bitmap_type(it->type);
 8ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
 903:	8b 40 40             	mov    0x40(%rax),%eax
 906:	89 c7                	mov    %eax,%edi
 908:	e8 00 00 00 00       	call   90d <compressed_bitmap_iterator_next+0x5a>
}
 90d:	c9                   	leave
 90e:	c3                   	ret
