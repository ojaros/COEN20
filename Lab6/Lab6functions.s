//
//  Lab6functions.s
//  
//
//  Created by Oliver Jaros on 5/13/20.
//

        .syntax        unified
        .cpu        cortex-m4
        .text


    //void PutNibble(void *nibbles, uint32_t which, uint32_t value);
        .global    PutNibble
        .thumb_func
    PutNibble:
                            //R0 = nibbles, R1 = which, R2 = value
        PUSH {R4, R5}
        MOV R4, R0          //R4 <- nibbles
        MOV R5, R1          //R5 <- which
        LSR R5, R5, 1       //R5 <- which/2
        ADD R4, R4, R5      //R4 <- nibbles + which/2
        LDRB R4, [R4]       //R4 <- byte that has nibble we want
        AND R1, R1, 1       //R1 <- R1 & 1, if 0 even, if 1 odd
        CMP R1, 0
        ITE EQ
        BFIEQ R4, R2, 0, 4  //R4<3..0> <- R2<4>
        BFINE R4, R2, 4, 4  //R4<4..8> <- R2<4>
        STRB R4,[R0, R5]    //R4 -> byte with address of nibbles + which/2
        POP {R4, R5}
        BX LR


    //uint32_t GetNibble(void *nibbles, uint32_t which);
        .global    GetNibble
        .thumb_func
    GetNibble:
                            //R0 = nibbles, R1 = which
        PUSH {R4, R5}
        MOV R4, R0          //R4 <- nibbles
        MOV R5, R1          //R5 <- which
        LSR R5, R5, 1       //R5 <- which/2
        ADD R4, R4, R5      //R4 <- nibbles + which/2
        LDRB R4, [R4]       //R4 <- byte that has nibble we want
        AND R1, R1, 1       //R4 <- R4 & 1, if 0 even, if 1 odd
        CMP R1, 0
        ITE EQ
        UBFXEQ R0, R4, 0, 4 //R0 <- R4<3..0>
        UBFXNE R0, R4, 4, 4 //R0 <- R4<8..4>
        POP {R4, R5}
        BX LR

.end





