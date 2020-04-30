.syntax		unified
.cpu		cortex-m4
.text


//void int32_t MxPlusB(int32_t x, int32_t mtop, int32_t mbtm, int32_t b) ;
  .global		MxPlusB
  .thumb_func
MxPlusB:
  PUSH {R4,R5,R6}
  LDR R6,=2
  MUL R1, R1, R0 //R1 <- dvnd*x
  MUL R4, R1, R2 //R4 <- dvnd*dvsr
  ASR R4, R4, 31 //R4 <- R4>>31
  MUL R4, R4, R2 //R4 <- R4*dvsr
  LSL R4, R4, 1 //R3 <- R4<<1
  ADD R4, R4, R2 //R4 <- R4 + dvsr
  SDIV R4, R4, R6 //R4 <- rounding

  ADD R5, R1, R4 //R5 <- dvnd + rounding
  SDIV R5, R5, R2 //R5 <- (dvnd+rounding)/dvsr

  ADD R0, R5, R3 //R0 <- mx+b

  POP {R4,R5,R6}
  BX LR
