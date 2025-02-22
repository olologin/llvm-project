//===-- Utility class to test different flavors of rint ---------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIBC_TEST_SRC_MATH_RINTTEST_H
#define LLVM_LIBC_TEST_SRC_MATH_RINTTEST_H

#include "src/__support/FPUtil/FEnvUtils.h"
#include "src/__support/FPUtil/FPBits.h"
#include "utils/MPFRWrapper/MPFRUtils.h"
#include "utils/UnitTest/FPMatcher.h"
#include "utils/UnitTest/Test.h"

#include <fenv.h>
#include <math.h>
#include <stdio.h>

namespace mpfr = __llvm_libc::testing::mpfr;

static constexpr int roundingModes[4] = {FE_UPWARD, FE_DOWNWARD, FE_TOWARDZERO,
                                         FE_TONEAREST};

template <typename T>
class RIntTestTemplate : public __llvm_libc::testing::Test {
public:
  typedef T (*RIntFunc)(T);

private:
  using FPBits = __llvm_libc::fputil::FPBits<T>;
  using UIntType = typename FPBits::UIntType;

  const T zero = T(FPBits::zero());
  const T neg_zero = T(FPBits::neg_zero());
  const T inf = T(FPBits::inf());
  const T neg_inf = T(FPBits::neg_inf());
  const T nan = T(FPBits::build_nan(1));

  static inline mpfr::RoundingMode toMPFRRoundingMode(int mode) {
    switch (mode) {
    case FE_UPWARD:
      return mpfr::RoundingMode::Upward;
    case FE_DOWNWARD:
      return mpfr::RoundingMode::Downward;
    case FE_TOWARDZERO:
      return mpfr::RoundingMode::TowardZero;
    case FE_TONEAREST:
      return mpfr::RoundingMode::Nearest;
    default:
      __builtin_unreachable();
    }
  }

public:
  void testSpecialNumbers(RIntFunc func) {
    for (int mode : roundingModes) {
      __llvm_libc::fputil::set_round(mode);
      ASSERT_FP_EQ(inf, func(inf));
      ASSERT_FP_EQ(neg_inf, func(neg_inf));
      ASSERT_FP_EQ(nan, func(nan));
      ASSERT_FP_EQ(zero, func(zero));
      ASSERT_FP_EQ(neg_zero, func(neg_zero));
    }
  }

  void testRoundNumbers(RIntFunc func) {
    for (int mode : roundingModes) {
      __llvm_libc::fputil::set_round(mode);
      mpfr::RoundingMode mpfrMode = toMPFRRoundingMode(mode);
      ASSERT_FP_EQ(func(T(1.0)), mpfr::Round(T(1.0), mpfrMode));
      ASSERT_FP_EQ(func(T(-1.0)), mpfr::Round(T(-1.0), mpfrMode));
      ASSERT_FP_EQ(func(T(10.0)), mpfr::Round(T(10.0), mpfrMode));
      ASSERT_FP_EQ(func(T(-10.0)), mpfr::Round(T(-10.0), mpfrMode));
      ASSERT_FP_EQ(func(T(1234.0)), mpfr::Round(T(1234.0), mpfrMode));
      ASSERT_FP_EQ(func(T(-1234.0)), mpfr::Round(T(-1234.0), mpfrMode));
    }
  }

  void testFractions(RIntFunc func) {
    for (int mode : roundingModes) {
      __llvm_libc::fputil::set_round(mode);
      mpfr::RoundingMode mpfrMode = toMPFRRoundingMode(mode);
      ASSERT_FP_EQ(func(T(0.5)), mpfr::Round(T(0.5), mpfrMode));
      ASSERT_FP_EQ(func(T(-0.5)), mpfr::Round(T(-0.5), mpfrMode));
      ASSERT_FP_EQ(func(T(0.115)), mpfr::Round(T(0.115), mpfrMode));
      ASSERT_FP_EQ(func(T(-0.115)), mpfr::Round(T(-0.115), mpfrMode));
      ASSERT_FP_EQ(func(T(0.715)), mpfr::Round(T(0.715), mpfrMode));
      ASSERT_FP_EQ(func(T(-0.715)), mpfr::Round(T(-0.715), mpfrMode));
    }
  }

  void testSubnormalRange(RIntFunc func) {
    constexpr UIntType count = 1000001;
    constexpr UIntType step =
        (FPBits::MAX_SUBNORMAL - FPBits::MIN_SUBNORMAL) / count;
    for (UIntType i = FPBits::MIN_SUBNORMAL; i <= FPBits::MAX_SUBNORMAL;
         i += step) {
      T x = T(FPBits(i));
      for (int mode : roundingModes) {
        __llvm_libc::fputil::set_round(mode);
        mpfr::RoundingMode mpfrMode = toMPFRRoundingMode(mode);
        ASSERT_FP_EQ(func(x), mpfr::Round(x, mpfrMode));
      }
    }
  }

  void testNormalRange(RIntFunc func) {
    constexpr UIntType count = 1000001;
    constexpr UIntType step = (FPBits::MAX_NORMAL - FPBits::MIN_NORMAL) / count;
    for (UIntType i = FPBits::MIN_NORMAL; i <= FPBits::MAX_NORMAL; i += step) {
      T x = T(FPBits(i));
      // In normal range on x86 platforms, the long double implicit 1 bit can be
      // zero making the numbers NaN. We will skip them.
      if (isnan(x)) {
        continue;
      }

      for (int mode : roundingModes) {
        __llvm_libc::fputil::set_round(mode);
        mpfr::RoundingMode mpfrMode = toMPFRRoundingMode(mode);
        ASSERT_FP_EQ(func(x), mpfr::Round(x, mpfrMode));
      }
    }
  }
};

#define LIST_RINT_TESTS(F, func)                                               \
  using LlvmLibcRIntTest = RIntTestTemplate<F>;                                \
  TEST_F(LlvmLibcRIntTest, specialNumbers) { testSpecialNumbers(&func); }      \
  TEST_F(LlvmLibcRIntTest, RoundNumbers) { testRoundNumbers(&func); }          \
  TEST_F(LlvmLibcRIntTest, Fractions) { testFractions(&func); }                \
  TEST_F(LlvmLibcRIntTest, SubnormalRange) { testSubnormalRange(&func); }      \
  TEST_F(LlvmLibcRIntTest, NormalRange) { testNormalRange(&func); }

#endif // LLVM_LIBC_TEST_SRC_MATH_RINTTEST_H
