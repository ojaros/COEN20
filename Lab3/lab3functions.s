    .syntax		unified
    .cpu		cortex-m4
    .text


  //void UseLDRB(void *dst, void *src)
    .global		UseLDRB
    .thumb_func
  UseLDRB:
    .REPT 512 //1 byte per loop
    LDRB R2, [R1], 1 //R2 <- R1 byte, then shifted 1 byte
    STRB R2, [R0], 1 //R2 -> *dst
    .ENDR
    BX LR

  //void UseLDRH(void *dst, void *src)
    .global		UseLDRH
    .thumb_func
  UseLDRH:
    .REPT 256 //2 bytes per loop (512/2)
    LDRH R2, [R1], 2 //R2 = *src, then post increment by 2
    STRH R2, [R0], 2 //R2 gets stored in *dst, post increment
    .ENDR
    BX LR

  //void UseLDR(void *dst, void *src)
    .global		UseLDR
    .thumb_func
  UseLDR:
    .REPT 128 //4 bytes per loop (512/4)
    LDR R2, [R1], 4 //R2 = *src, then post increment by 4
    STR R2, [R0], 4 //R2 gets stored into *dst, post increment
    .ENDR
    BX LR

  //void UseLDRD(void *dst, void *src)
    .global		UseLDRD
    .thumb_func
  UseLDRD:
    .REPT 64 //8 bytes per loop (512/8)
    LDRD R2, R3, [R1], 8 // R3.R2 <- *src, then post increment by 8
    STRD R2, R3, [R0], 8 // R3.R2 -> *dst, then post increment by 8
    .ENDR
    BX LR

  //void UseLDM(void *dst, void *src)
    .global		UseLDM
    .thumb_func
  UseLDM:
    PUSH {R4-R9}
    .REPT 16 //32 bytes per loop (512/32)
    LDMIA R1!, {R2-R9} //R2-R9 <- R1, R1 += 4 x 8registers, 32 bytes
    STMIA R0!, {R2-R9} //Store R2-R9 in R0
    .ENDR
    POP {R4-R9}
    BX LR

.end
