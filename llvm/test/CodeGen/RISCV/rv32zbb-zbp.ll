; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32ZBB
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zbp -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32ZBP

define i32 @andn_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: andn_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    and a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: andn_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    andn a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: andn_i32:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    andn a0, a0, a1
; RV32ZBP-NEXT:    ret
  %neg = xor i32 %b, -1
  %and = and i32 %neg, %a
  ret i32 %and
}

define i64 @andn_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: andn_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a3, a3
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    and a0, a2, a0
; RV32I-NEXT:    and a1, a3, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: andn_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    andn a0, a0, a2
; RV32ZBB-NEXT:    andn a1, a1, a3
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: andn_i64:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    andn a0, a0, a2
; RV32ZBP-NEXT:    andn a1, a1, a3
; RV32ZBP-NEXT:    ret
  %neg = xor i64 %b, -1
  %and = and i64 %neg, %a
  ret i64 %and
}

define i32 @orn_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: orn_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    or a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: orn_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    orn a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: orn_i32:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    orn a0, a0, a1
; RV32ZBP-NEXT:    ret
  %neg = xor i32 %b, -1
  %or = or i32 %neg, %a
  ret i32 %or
}

define i64 @orn_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: orn_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a3, a3
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    or a0, a2, a0
; RV32I-NEXT:    or a1, a3, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: orn_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    orn a0, a0, a2
; RV32ZBB-NEXT:    orn a1, a1, a3
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: orn_i64:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    orn a0, a0, a2
; RV32ZBP-NEXT:    orn a1, a1, a3
; RV32ZBP-NEXT:    ret
  %neg = xor i64 %b, -1
  %or = or i64 %neg, %a
  ret i64 %or
}

define i32 @xnor_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: xnor_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: xnor_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    xnor a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: xnor_i32:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    xnor a0, a0, a1
; RV32ZBP-NEXT:    ret
  %neg = xor i32 %a, -1
  %xor = xor i32 %neg, %b
  ret i32 %xor
}

define i64 @xnor_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: xnor_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a1, a1, a3
; RV32I-NEXT:    xor a0, a0, a2
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: xnor_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    xnor a0, a0, a2
; RV32ZBB-NEXT:    xnor a1, a1, a3
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: xnor_i64:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    xnor a0, a0, a2
; RV32ZBP-NEXT:    xnor a1, a1, a3
; RV32ZBP-NEXT:    ret
  %neg = xor i64 %a, -1
  %xor = xor i64 %neg, %b
  ret i64 %xor
}

declare i32 @llvm.fshl.i32(i32, i32, i32)

define i32 @rol_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: rol_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    sll a2, a0, a1
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    srl a0, a0, a1
; RV32I-NEXT:    or a0, a2, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: rol_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    rol a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: rol_i32:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    rol a0, a0, a1
; RV32ZBP-NEXT:    ret
  %or = tail call i32 @llvm.fshl.i32(i32 %a, i32 %a, i32 %b)
  ret i32 %or
}

; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

declare i64 @llvm.fshl.i64(i64, i64, i64)

define i64 @rol_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: rol_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a3, a2, 5
; RV32I-NEXT:    andi a3, a3, 1
; RV32I-NEXT:    mv a4, a1
; RV32I-NEXT:    bnez a3, .LBB7_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a4, a0
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    sll a6, a4, a2
; RV32I-NEXT:    bnez a3, .LBB7_4
; RV32I-NEXT:  # %bb.3:
; RV32I-NEXT:    mv a0, a1
; RV32I-NEXT:  .LBB7_4:
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    not a5, a2
; RV32I-NEXT:    srl a1, a1, a5
; RV32I-NEXT:    or a3, a6, a1
; RV32I-NEXT:    sll a0, a0, a2
; RV32I-NEXT:    srli a1, a4, 1
; RV32I-NEXT:    srl a1, a1, a5
; RV32I-NEXT:    or a1, a0, a1
; RV32I-NEXT:    mv a0, a3
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: rol_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    srli a3, a2, 5
; RV32ZBB-NEXT:    andi a3, a3, 1
; RV32ZBB-NEXT:    mv a4, a1
; RV32ZBB-NEXT:    bnez a3, .LBB7_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    mv a4, a0
; RV32ZBB-NEXT:  .LBB7_2:
; RV32ZBB-NEXT:    sll a6, a4, a2
; RV32ZBB-NEXT:    bnez a3, .LBB7_4
; RV32ZBB-NEXT:  # %bb.3:
; RV32ZBB-NEXT:    mv a0, a1
; RV32ZBB-NEXT:  .LBB7_4:
; RV32ZBB-NEXT:    srli a1, a0, 1
; RV32ZBB-NEXT:    not a5, a2
; RV32ZBB-NEXT:    srl a1, a1, a5
; RV32ZBB-NEXT:    or a3, a6, a1
; RV32ZBB-NEXT:    sll a0, a0, a2
; RV32ZBB-NEXT:    srli a1, a4, 1
; RV32ZBB-NEXT:    srl a1, a1, a5
; RV32ZBB-NEXT:    or a1, a0, a1
; RV32ZBB-NEXT:    mv a0, a3
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: rol_i64:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    srli a3, a2, 5
; RV32ZBP-NEXT:    andi a3, a3, 1
; RV32ZBP-NEXT:    mv a4, a1
; RV32ZBP-NEXT:    bnez a3, .LBB7_2
; RV32ZBP-NEXT:  # %bb.1:
; RV32ZBP-NEXT:    mv a4, a0
; RV32ZBP-NEXT:  .LBB7_2:
; RV32ZBP-NEXT:    sll a6, a4, a2
; RV32ZBP-NEXT:    bnez a3, .LBB7_4
; RV32ZBP-NEXT:  # %bb.3:
; RV32ZBP-NEXT:    mv a0, a1
; RV32ZBP-NEXT:  .LBB7_4:
; RV32ZBP-NEXT:    srli a1, a0, 1
; RV32ZBP-NEXT:    not a5, a2
; RV32ZBP-NEXT:    srl a1, a1, a5
; RV32ZBP-NEXT:    or a3, a6, a1
; RV32ZBP-NEXT:    sll a0, a0, a2
; RV32ZBP-NEXT:    srli a1, a4, 1
; RV32ZBP-NEXT:    srl a1, a1, a5
; RV32ZBP-NEXT:    or a1, a0, a1
; RV32ZBP-NEXT:    mv a0, a3
; RV32ZBP-NEXT:    ret
  %or = tail call i64 @llvm.fshl.i64(i64 %a, i64 %a, i64 %b)
  ret i64 %or
}

declare i32 @llvm.fshr.i32(i32, i32, i32)

define i32 @ror_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: ror_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srl a2, a0, a1
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    sll a0, a0, a1
; RV32I-NEXT:    or a0, a2, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: ror_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ror a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: ror_i32:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    ror a0, a0, a1
; RV32ZBP-NEXT:    ret
  %or = tail call i32 @llvm.fshr.i32(i32 %a, i32 %a, i32 %b)
  ret i32 %or
}

; This test is presented here in case future expansions of the experimental-b
; extension introduce instructions suitable for this pattern.

declare i64 @llvm.fshr.i64(i64, i64, i64)

define i64 @ror_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: ror_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a4, a2, 32
; RV32I-NEXT:    mv a3, a0
; RV32I-NEXT:    beqz a4, .LBB9_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a3, a1
; RV32I-NEXT:  .LBB9_2:
; RV32I-NEXT:    srl a5, a3, a2
; RV32I-NEXT:    beqz a4, .LBB9_4
; RV32I-NEXT:  # %bb.3:
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:  .LBB9_4:
; RV32I-NEXT:    slli a0, a1, 1
; RV32I-NEXT:    not a4, a2
; RV32I-NEXT:    sll a0, a0, a4
; RV32I-NEXT:    or a0, a0, a5
; RV32I-NEXT:    srl a1, a1, a2
; RV32I-NEXT:    slli a2, a3, 1
; RV32I-NEXT:    sll a2, a2, a4
; RV32I-NEXT:    or a1, a2, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: ror_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    andi a4, a2, 32
; RV32ZBB-NEXT:    mv a3, a0
; RV32ZBB-NEXT:    beqz a4, .LBB9_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    mv a3, a1
; RV32ZBB-NEXT:  .LBB9_2:
; RV32ZBB-NEXT:    srl a5, a3, a2
; RV32ZBB-NEXT:    beqz a4, .LBB9_4
; RV32ZBB-NEXT:  # %bb.3:
; RV32ZBB-NEXT:    mv a1, a0
; RV32ZBB-NEXT:  .LBB9_4:
; RV32ZBB-NEXT:    slli a0, a1, 1
; RV32ZBB-NEXT:    not a4, a2
; RV32ZBB-NEXT:    sll a0, a0, a4
; RV32ZBB-NEXT:    or a0, a0, a5
; RV32ZBB-NEXT:    srl a1, a1, a2
; RV32ZBB-NEXT:    slli a2, a3, 1
; RV32ZBB-NEXT:    sll a2, a2, a4
; RV32ZBB-NEXT:    or a1, a2, a1
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: ror_i64:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    andi a4, a2, 32
; RV32ZBP-NEXT:    mv a3, a0
; RV32ZBP-NEXT:    beqz a4, .LBB9_2
; RV32ZBP-NEXT:  # %bb.1:
; RV32ZBP-NEXT:    mv a3, a1
; RV32ZBP-NEXT:  .LBB9_2:
; RV32ZBP-NEXT:    srl a5, a3, a2
; RV32ZBP-NEXT:    beqz a4, .LBB9_4
; RV32ZBP-NEXT:  # %bb.3:
; RV32ZBP-NEXT:    mv a1, a0
; RV32ZBP-NEXT:  .LBB9_4:
; RV32ZBP-NEXT:    slli a0, a1, 1
; RV32ZBP-NEXT:    not a4, a2
; RV32ZBP-NEXT:    sll a0, a0, a4
; RV32ZBP-NEXT:    or a0, a0, a5
; RV32ZBP-NEXT:    srl a1, a1, a2
; RV32ZBP-NEXT:    slli a2, a3, 1
; RV32ZBP-NEXT:    sll a2, a2, a4
; RV32ZBP-NEXT:    or a1, a2, a1
; RV32ZBP-NEXT:    ret
  %or = tail call i64 @llvm.fshr.i64(i64 %a, i64 %a, i64 %b)
  ret i64 %or
}

define i32 @rori_i32_fshl(i32 %a) nounwind {
; RV32I-LABEL: rori_i32_fshl:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    slli a0, a0, 31
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: rori_i32_fshl:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    rori a0, a0, 1
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: rori_i32_fshl:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    rori a0, a0, 1
; RV32ZBP-NEXT:    ret
  %1 = tail call i32 @llvm.fshl.i32(i32 %a, i32 %a, i32 31)
  ret i32 %1
}

define i32 @rori_i32_fshr(i32 %a) nounwind {
; RV32I-LABEL: rori_i32_fshr:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a1, a0, 1
; RV32I-NEXT:    srli a0, a0, 31
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: rori_i32_fshr:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    rori a0, a0, 31
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: rori_i32_fshr:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    rori a0, a0, 31
; RV32ZBP-NEXT:    ret
  %1 = tail call i32 @llvm.fshr.i32(i32 %a, i32 %a, i32 31)
  ret i32 %1
}

define i64 @rori_i64(i64 %a) nounwind {
; RV32I-LABEL: rori_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a2, a0, 1
; RV32I-NEXT:    slli a3, a1, 31
; RV32I-NEXT:    or a2, a3, a2
; RV32I-NEXT:    srli a1, a1, 1
; RV32I-NEXT:    slli a0, a0, 31
; RV32I-NEXT:    or a1, a0, a1
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: rori_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    srli a2, a0, 1
; RV32ZBB-NEXT:    slli a3, a1, 31
; RV32ZBB-NEXT:    or a2, a3, a2
; RV32ZBB-NEXT:    srli a1, a1, 1
; RV32ZBB-NEXT:    slli a0, a0, 31
; RV32ZBB-NEXT:    or a1, a0, a1
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: rori_i64:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    srli a2, a0, 1
; RV32ZBP-NEXT:    slli a3, a1, 31
; RV32ZBP-NEXT:    or a2, a3, a2
; RV32ZBP-NEXT:    srli a1, a1, 1
; RV32ZBP-NEXT:    slli a0, a0, 31
; RV32ZBP-NEXT:    or a1, a0, a1
; RV32ZBP-NEXT:    mv a0, a2
; RV32ZBP-NEXT:    ret
  %1 = tail call i64 @llvm.fshl.i64(i64 %a, i64 %a, i64 63)
  ret i64 %1
}

define i64 @rori_i64_fshr(i64 %a) nounwind {
; RV32I-LABEL: rori_i64_fshr:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srli a2, a1, 31
; RV32I-NEXT:    slli a3, a0, 1
; RV32I-NEXT:    or a2, a3, a2
; RV32I-NEXT:    srli a0, a0, 31
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    or a1, a1, a0
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: rori_i64_fshr:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    srli a2, a1, 31
; RV32ZBB-NEXT:    slli a3, a0, 1
; RV32ZBB-NEXT:    or a2, a3, a2
; RV32ZBB-NEXT:    srli a0, a0, 31
; RV32ZBB-NEXT:    slli a1, a1, 1
; RV32ZBB-NEXT:    or a1, a1, a0
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: rori_i64_fshr:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    srli a2, a1, 31
; RV32ZBP-NEXT:    slli a3, a0, 1
; RV32ZBP-NEXT:    or a2, a3, a2
; RV32ZBP-NEXT:    srli a0, a0, 31
; RV32ZBP-NEXT:    slli a1, a1, 1
; RV32ZBP-NEXT:    or a1, a1, a0
; RV32ZBP-NEXT:    mv a0, a2
; RV32ZBP-NEXT:    ret
  %1 = tail call i64 @llvm.fshr.i64(i64 %a, i64 %a, i64 63)
  ret i64 %1
}

define i8 @srli_i8(i8 %a) nounwind {
; RV32I-LABEL: srli_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a0, a0, 192
; RV32I-NEXT:    srli a0, a0, 6
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: srli_i8:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    andi a0, a0, 192
; RV32ZBB-NEXT:    srli a0, a0, 6
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: srli_i8:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    andi a0, a0, 192
; RV32ZBP-NEXT:    srli a0, a0, 6
; RV32ZBP-NEXT:    ret
  %1 = lshr i8 %a, 6
  ret i8 %1
}

define i8 @srai_i8(i8 %a) nounwind {
; RV32I-LABEL: srai_i8:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 24
; RV32I-NEXT:    srai a0, a0, 29
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: srai_i8:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    sext.b a0, a0
; RV32ZBB-NEXT:    srai a0, a0, 5
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: srai_i8:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    slli a0, a0, 24
; RV32ZBP-NEXT:    srai a0, a0, 29
; RV32ZBP-NEXT:    ret
  %1 = ashr i8 %a, 5
  ret i8 %1
}

define i16 @srli_i16(i16 %a) nounwind {
; RV32I-LABEL: srli_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srli a0, a0, 22
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: srli_i16:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    zext.h a0, a0
; RV32ZBB-NEXT:    srli a0, a0, 6
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: srli_i16:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    zext.h a0, a0
; RV32ZBP-NEXT:    srli a0, a0, 6
; RV32ZBP-NEXT:    ret
  %1 = lshr i16 %a, 6
  ret i16 %1
}

define i16 @srai_i16(i16 %a) nounwind {
; RV32I-LABEL: srai_i16:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slli a0, a0, 16
; RV32I-NEXT:    srai a0, a0, 25
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: srai_i16:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    sext.h a0, a0
; RV32ZBB-NEXT:    srai a0, a0, 9
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: srai_i16:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    slli a0, a0, 16
; RV32ZBP-NEXT:    srai a0, a0, 25
; RV32ZBP-NEXT:    ret
  %1 = ashr i16 %a, 9
  ret i16 %1
}

define i1 @andn_seqz_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: andn_seqz_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: andn_seqz_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    and a0, a0, a1
; RV32ZBB-NEXT:    xor a0, a0, a1
; RV32ZBB-NEXT:    seqz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: andn_seqz_i32:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    and a0, a0, a1
; RV32ZBP-NEXT:    xor a0, a0, a1
; RV32ZBP-NEXT:    seqz a0, a0
; RV32ZBP-NEXT:    ret
  %and = and i32 %a, %b
  %cmpeq = icmp eq i32 %and, %b
  ret i1 %cmpeq
}

define i1 @andn_seqz_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: andn_seqz_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    and a1, a1, a3
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: andn_seqz_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    andn a1, a3, a1
; RV32ZBB-NEXT:    andn a0, a2, a0
; RV32ZBB-NEXT:    or a0, a0, a1
; RV32ZBB-NEXT:    seqz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: andn_seqz_i64:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    andn a1, a3, a1
; RV32ZBP-NEXT:    andn a0, a2, a0
; RV32ZBP-NEXT:    or a0, a0, a1
; RV32ZBP-NEXT:    seqz a0, a0
; RV32ZBP-NEXT:    ret
  %and = and i64 %a, %b
  %cmpeq = icmp eq i64 %and, %b
  ret i1 %cmpeq
}

define i1 @andn_snez_i32(i32 %a, i32 %b) nounwind {
; RV32I-LABEL: andn_snez_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: andn_snez_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    and a0, a0, a1
; RV32ZBB-NEXT:    xor a0, a0, a1
; RV32ZBB-NEXT:    snez a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: andn_snez_i32:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    and a0, a0, a1
; RV32ZBP-NEXT:    xor a0, a0, a1
; RV32ZBP-NEXT:    snez a0, a0
; RV32ZBP-NEXT:    ret
  %and = and i32 %a, %b
  %cmpeq = icmp ne i32 %and, %b
  ret i1 %cmpeq
}

define i1 @andn_snez_i64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: andn_snez_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    not a1, a1
; RV32I-NEXT:    and a1, a1, a3
; RV32I-NEXT:    and a0, a0, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: andn_snez_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    andn a1, a3, a1
; RV32ZBB-NEXT:    andn a0, a2, a0
; RV32ZBB-NEXT:    or a0, a0, a1
; RV32ZBB-NEXT:    snez a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32ZBP-LABEL: andn_snez_i64:
; RV32ZBP:       # %bb.0:
; RV32ZBP-NEXT:    andn a1, a3, a1
; RV32ZBP-NEXT:    andn a0, a2, a0
; RV32ZBP-NEXT:    or a0, a0, a1
; RV32ZBP-NEXT:    snez a0, a0
; RV32ZBP-NEXT:    ret
  %and = and i64 %a, %b
  %cmpeq = icmp ne i64 %and, %b
  ret i1 %cmpeq
}
