#pragma once
#include <stdint.h>

#define TSTRING_UTF16

#if defined(TSTRING_UTF8) + defined(TSTRING_UTF16) != 1
#error "Exactly one of the TSTRING_UTFXXX definitions must be defined"
#endif
