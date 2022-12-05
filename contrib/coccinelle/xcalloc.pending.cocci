@@
type T;
T *ptr;
@@
- ptr = xcalloc(1, \( sizeof(T) \| sizeof(*ptr) \) )
+ CALLOC(ptr)

@@
type T;
identifier ptr;
@@
- T ptr = xcalloc(1, \( sizeof(T) \| sizeof(*ptr) \) );
+ T ptr;
+ CALLOC(ptr);

@@
type T;
T *ptr;
@@
- CALLOC_ARRAY(ptr, 1)
+ CALLOC(ptr)
