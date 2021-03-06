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

#ifdef HAVE_VFP2
.fpu vfp
#endif

.globl OFForward
.globl OFForward_stret

.section .text
OFForward:
#ifdef HAVE_VFP2
	vstmdb	sp!, {d0-d7}
#endif
	stmfd	sp!, {r0-r4, lr}

	ldr	r4, sel_forwardingTargetForSelector_$indirect_.L0
.L0:
	add	r4, pc

	bl	object_getClass(PLT)

	mov	r1, r4
	bl	class_respondsToSelector(PLT)

	cmp	r0, #0
	beq	0f

	ldr	r0, [sp, #0]
	mov	r1, r4
	bl	objc_msg_lookup(PLT)

	mov	r12, r0
	ldr	r0, [sp, #0]
	mov	r1, r4
	ldr	r2, [sp, #4]
	blx	r12

	cmp	r0, #0
	beq	0f
	ldr	r1, [sp, #0]
	cmp	r0, r1
	beq	0f

	str	r0, [sp, #0]
	ldr	r1, [sp, #4]
	bl	objc_msg_lookup(PLT)

	mov	r12, r0
	ldmfd	sp!, {r0-r4, lr}
#ifdef HAVE_VFP2
	vldmia	sp!, {d0-d7}
#endif

	bx	r12

0:
	ldmfd	sp!, {r0-r4, lr}
#ifdef HAVE_VFP2
	vldmia	sp!, {d0-d7}
#endif
	b	OFMethodNotFound(PLT)
.type OFForward, %function
.size OFForward, .-OFForward

OFForward_stret:
#ifdef HAVE_VFP2
	vstmdb	sp!, {d0-d7}
#endif
	stmfd	sp!, {r0-r4, lr}

	ldr	r4, sel_forwardingTargetForSelector_$indirect_.L1
.L1:
	add	r4, pc

	mov	r0, r1
	bl	object_getClass(PLT)

	mov	r1, r4
	bl	class_respondsToSelector(PLT)

	cmp	r0, #0
	beq	0f

	ldr	r0, [sp, #4]
	mov	r1, r4
	bl	objc_msg_lookup(PLT)

	mov	r12, r0
	ldr	r0, [sp, #4]
	mov	r1, r4
	ldr	r2, [sp, #8]
	blx	r12

	cmp	r0, #0
	beq	0f
	ldr	r1, [sp, #4]
	cmp	r0, r1
	beq	0f

	str	r0, [sp, #4]
	ldr	r1, [sp, #8]
	bl	objc_msg_lookup_stret(PLT)

	mov	r12, r0
	ldmfd	sp!, {r0-r4, lr}
#ifdef HAVE_VFP2
	vldmia	sp!, {d0-d7}
#endif

	bx	r12

0:
	ldmfd	sp!, {r0-r4, lr}
#ifdef HAVE_VFP2
	vldmia	sp!, {d0-d7}
#endif
	b	OFMethodNotFound_stret(PLT)
.type OFForward_stret, %function
.size OFForward_stret, .-OFForward_stret

init:
	ldr	r0, module$indirect_.L2
.L2:
	add	r0, pc
	b	__objc_exec_class(PLT)

sel_forwardingTargetForSelector_$indirect_.L0:
	.long sel_forwardingTargetForSelector_-(.L0+8)
sel_forwardingTargetForSelector_$indirect_.L1:
	.long sel_forwardingTargetForSelector_-(.L1+8)
module$indirect_.L2:
	.long module-(.L2+8)

.section .init_array, "aw", %init_array
	.long init

.section .rodata
str_forwardingTargetForSelector_:
	.asciz "forwardingTargetForSelector:"

.section .data
sel_forwardingTargetForSelector_:
	.long str_forwardingTargetForSelector_, 0
	.long 0, 0
symtab:
	.long 0, sel_forwardingTargetForSelector_
	.short 0, 0
	.long 0
	.long 0
module:
	.long 8, 16, 0, symtab

#ifdef OF_LINUX
.section .note.GNU-stack, "", %progbits
#endif
