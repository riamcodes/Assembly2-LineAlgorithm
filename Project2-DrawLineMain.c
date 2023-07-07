#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include "library.h"

extern void drawline(uint32_t,uint32_t,uint32_t,uint32_t);

int main(void) {
  InitializeHardware(HEADER,"Line Drawing Algorithm");
  drawline(0,50,239,159);
  drawline(120,50,239,299);
  drawline(0,159,239,239);
}
