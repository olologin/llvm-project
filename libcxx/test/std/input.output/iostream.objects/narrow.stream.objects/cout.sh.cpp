//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <iostream>

// istream cout;

// XFAIL: LIBCXX-WINDOWS-FIXME

// UNSUPPORTED: executor-has-no-bash
// FILE_DEPENDENCIES: ../check-stdout.sh
// RUN: %{build}
// RUN: %{exec} bash check-stdout.sh "%t.exe" "1234"

#include <iostream>

int main(int, char**) {
    std::cout << "1234";
    return 0;
}
