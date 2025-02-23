/*
lib_posix.c - dynamic library code for POSIX systems
Copyright (C) 2018 Flying With Gauss

This program is free software: you can redistribute it and/sor modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
*/
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include "platform/platform.h"
#if XASH_LIB == LIB_POSIX
#ifdef XASH_IRIX
#include "platform/irix/dladdr.h"
#endif
#include "common.h"
#include "library.h"
#include "filesystem.h"
#include "server.h"
#include "platform/android/lib_android.h"
#include "platform/emscripten/lib_em.h"
#include "platform/apple/lib_ios.h"

#ifdef XASH_DLL_LOADER // wine-based dll loader
void * Loader_LoadLibrary (const char *name);
void * Loader_GetProcAddress (void *hndl, const char *name);
void Loader_FreeLibrary(void *hndl);
void *Loader_GetDllHandle( void *hndl );
const char * Loader_GetFuncName( void *hndl, void *func);
const char * Loader_GetFuncName_int( void *wm , void *func);
#endif


#ifdef XASH_NO_LIBDL
#ifndef XASH_DLL_LOADER
#error Enable at least one dll backend!!!
#endif // XASH_DLL_LOADER

void *dlsym(void *handle, const char *symbol )
{
	Con_DPrintf( "%s( %p, \"%s\" ): stub\n", __func__, handle, symbol );
	return NULL;
}

void *dlopen(const char *name, int flag )
{
	Con_DPrintf( "%s( \"%s\", %d ): stub\n", __func__, name, flag );
	return NULL;
}

int dlclose(void *handle)
{
	Con_DPrintf( "%s( %p ): stub\n", __func__, handle );
	return 0;
}

char *dlerror( void )
{
	return "Loading ELF libraries not supported in this build!\n";
}

int dladdr( const void *addr, Dl_info *info )
{
	return 0;
}
#endif // XASH_NO_LIBDL

extern qboolean COM_CheckLibraryDirectDependency( const char *name, const char *depname, qboolean directpath );

extern void *COM_LoadLibrary( const char *dllname, int build_ordinals_table, qboolean directpath );

extern void COM_FreeLibrary( void *hInstance );

extern void *COM_GetProcAddress( void *hInstance, const char *name );

extern void *COM_FunctionFromName( void *hInstance, const char *pName );

extern const char *COM_NameForFunction( void *hInstance, void *function );

#endif // _WIN32
