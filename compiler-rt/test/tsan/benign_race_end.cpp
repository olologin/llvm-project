// RUN: %clang_tsan -O1 %s -o %t && %deflake %run %t 2>&1 | FileCheck %s
#include "test.h"

int Global;

void *Thread(void *x) {
  Global = 42;
  barrier_wait(&barrier);
  return 0;
}

int main() {
  barrier_init(&barrier, 2);
  ANNOTATE_BENIGN_RACE(Global);
  ANNOTATE_BENIGN_RACE_END(Global);
  pthread_t t;
  pthread_create(&t, 0, Thread, 0);
  barrier_wait(&barrier);
  Global = 43;
  pthread_join(t, 0);
  fprintf(stderr, "Done\n");
  return 0;
}

// CHECK: WARNING: ThreadSanitizer: data race
// CHECK: Done