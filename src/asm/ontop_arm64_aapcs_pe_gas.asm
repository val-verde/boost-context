/*
       Copyright Edward Nevill + Oliver Kowalke 2015
   Distributed under the Boost Software License, Version 1.0.
      (See accompanying file LICENSE_1_0.txt or copy at
          http://www.boost.org/LICENSE_1_0.txt)
*/
/*******************************************************
 *                                                     *
 *  -------------------------------------------------  *
 *  |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  *
 *  -------------------------------------------------  *
 *  | 0x0 | 0x4 | 0x8 | 0xc | 0x10| 0x14| 0x18| 0x1c|  *
 *  -------------------------------------------------  *
 *  |    d8     |    d9     |    d10    |    d11    |  *
 *  -------------------------------------------------  *
 *  -------------------------------------------------  *
 *  |  8  |  9  |  10 |  11 |  12 |  13 |  14 |  15 |  *
 *  -------------------------------------------------  *
 *  | 0x20| 0x24| 0x28| 0x2c| 0x30| 0x34| 0x38| 0x3c|  *
 *  -------------------------------------------------  *
 *  |    d12    |    d13    |    d14    |    d15    |  *
 *  -------------------------------------------------  *
 *  -------------------------------------------------  *
 *  |  16 |  17 |  18 |  19 |  20 |  21 |  22 |  23 |  *
 *  -------------------------------------------------  *
 *  | 0x40| 0x44| 0x48| 0x4c| 0x50| 0x54| 0x58| 0x5c|  *
 *  -------------------------------------------------  *
 *  |    x19    |    x20    |    x21    |    x22    |  *
 *  -------------------------------------------------  *
 *  -------------------------------------------------  *
 *  |  24 |  25 |  26 |  27 |  28 |  29 |  30 |  31 |  *
 *  -------------------------------------------------  *
 *  | 0x60| 0x64| 0x68| 0x6c| 0x70| 0x74| 0x78| 0x7c|  *
 *  -------------------------------------------------  *
 *  |    x23    |    x24    |    x25    |    x26    |  *
 *  -------------------------------------------------  *
 *  -------------------------------------------------  *
 *  |  32 |  33 |  34 |  35 |  36 |  37 |  38 |  39 |  *
 *  -------------------------------------------------  *
 *  | 0x80| 0x84| 0x88| 0x8c| 0x90| 0x94| 0x98| 0x9c|  *
 *  -------------------------------------------------  *
 *  |    x27    |    x28    |    FP     |     LR    |  *
 *  -------------------------------------------------  *
 *  -------------------------------------------------  *
 *  |  40 |  41 |  42 | 43  |           |           |  *
 *  -------------------------------------------------  *
 *  | 0xa0| 0xa4| 0xa8| 0xac|           |           |  *
 *  -------------------------------------------------  *
 *  |     PC    |   align   |           |           |  *
 *  -------------------------------------------------  *
 *                                                     *
 *******************************************************/

.text
.p2align 4,,15
.globl	ontop_fcontext
.def	ontop_fcontext;	.scl	2;	.type	32;	.endef
.seh_proc	ontop_fcontext
ontop_fcontext:
.seh_endprologue
    # prepare stack for GP + FPU
    sub  sp, sp, #0xb0

    # save d8 - d15
    stp  d8,  d9,  [sp, #0x00]
    stp  d10, d11, [sp, #0x10]
    stp  d12, d13, [sp, #0x20]
    stp  d14, d15, [sp, #0x30]

    # save x19-x30
    stp  x19, x20, [sp, #0x40]
    stp  x21, x22, [sp, #0x50]
    stp  x23, x24, [sp, #0x60]
    stp  x25, x26, [sp, #0x70]
    stp  x27, x28, [sp, #0x80]
    stp  x29, x30, [sp, #0x90]

    # save LR as PC
    str  x30, [sp, #0xa0]

    # store RSP (pointing to context-data) in X5
    mov  x4, sp

    # restore RSP (pointing to context-data) from X1
    mov  sp, x0

    # load d8 - d15
    ldp  d8,  d9,  [sp, #0x00]
    ldp  d10, d11, [sp, #0x10]
    ldp  d12, d13, [sp, #0x20]
    ldp  d14, d15, [sp, #0x30]

    # load x19-x30
    ldp  x19, x20, [sp, #0x40]
    ldp  x21, x22, [sp, #0x50]
    ldp  x23, x24, [sp, #0x60]
    ldp  x25, x26, [sp, #0x70]
    ldp  x27, x28, [sp, #0x80]
    ldp  x29, x30, [sp, #0x90]

    # return transfer_t from jump
    # pass transfer_t as first arg in context function
    # X0 == FCTX, X1 == DATA
    mov x0, x4

    # skip pc
    # restore stack from GP + FPU
    add  sp, sp, #0xb0

    # jump to ontop-function
    ret x2
.seh_endproc

.section .drectve
.ascii " -export:\"ontop_fcontext\""
