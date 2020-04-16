#include <stdint.h>
#include "library.h"
#include "graphics.h"
#include <math.h>

//Converts array of bits to UNSIGNED int
uint32_t Bits2Unsigned(int8_t bits[8]){
  uint32_t n = 0;
  for(int i = 7; i >= 0; i--){
    n = (2*n + bits[i]);
  }
  return n;
}

//Converts array of bits to SIGNED int
int32_t Bits2Signed(int8_t bits[8]){
  //call to unsigned function, then convert to signed
  int32_t n = (int32_t)Bits2Unsigned(bits);
  if (n > 127){
    n = n-256;
  }
  return n;
}

//increments array of Bits
void Increment(int8_t bits[8]){
  for(int i = 0; i < 8; i++){
    //if least significant bit is 0, just change it to a 1
    if (bits[i] == 0){
      bits[i] = 1;
      return;
    }
    //if LSB is 1, change value to 0 and carry on a 1 to next bit
    else{
      bits[i] = 0;
    }
  }
  return;
}

//converts given n value (unsigned) to an array of bits.
void Unsigned2Bits(uint32_t n, int8_t bits[8]){
  for(int i = 0; i < 8; i++){
    //if remainder is 1, make rightmost bit a 1
      if(n % 2 == 1){
        bits[i] = 1;
      }
      else{
        bits[i] = 0;
      }
      n = n/2;
  }
  return;
}
