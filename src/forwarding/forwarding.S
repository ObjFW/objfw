/*
 * Copyright (c) 2008-2021 Jonathan Schleifer <js@nil.im>
 *
 * All rights reserved.
 *
 * This file is part of ObjFW. It may be distributed under the terms of the
 * Q Public License 1.0, which can be found in the file LICENSE.QPL included in
 * the packaging of this file.
 *
 * Alternatively, it may be distributed under the terms of the GNU General
 * Public License, either version 2 or 3, which can be found in the file
 * LICENSE.GPLv2 or LICENSE.GPLv3 respectively included in the packaging of this
 * file.
 */

#include "config.h"

#include "platform.h"

#ifdef OF_APPLE_RUNTIME
# if defined(OF_X86_64)
#  include "apple-forwarding-x86_64.S"
# elif defined(OF_X86)
#  include "apple-forwarding-i386.S"
# elif defined(OF_ARM64)
#  include "apple-forwarding-arm64.S"
# elif defined(OF_ARM)
#  include "apple-forwarding-arm.S"
# elif defined(OF_POWERPC)
#  include "apple-forwarding-powerpc.S"
# endif
#else
# if defined(OF_ELF)
#  if defined(OF_X86_64)
#   include "forwarding-x86_64-elf.S"
#  elif defined(OF_X86)
#   include "forwarding-x86-elf.S"
#  elif defined(OF_ARM64)
#   include "forwarding-arm64-elf.S"
#  elif defined(OF_ARM)
#   include "forwarding-arm-elf.S"
#  elif defined(OF_POWERPC)
#   include "forwarding-powerpc-elf.S"
#  elif defined(OF_MIPS)
#   include "forwarding-mips-elf.S"
#  elif defined(OF_SPARC64)
#   include "forwarding-sparc64-elf.S"
#  elif defined(OF_SPARC)
#   include "forwarding-sparc-elf.S"
#  endif
# elif defined(OF_MACH_O)
#  if defined(OF_X86_64)
#   include "forwarding-x86_64-macho.S"
#  endif
# elif defined(OF_WINDOWS)
#  if defined(OF_X86_64)
#   include "forwarding-x86_64-win64.S"
#  elif defined(OF_X86)
#   include "forwarding-x86-win32.S"
#  endif
# endif
#endif
