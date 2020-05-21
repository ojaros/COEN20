//
//  lab7functions.s
//  
//
//  Created by Oliver Jaros on 5/21/20.
//

        .syntax        unified
        .cpu        cortex-m4
        .text


//uint32_t Zeller1(uint32_t k, uint32_t m, uint32_t D, uint32_t C);
    .global    Zeller1
    .thumb_func
Zeller1:
        PUSH {R4-R11}
        MOV R4,R0 //R4 <- k
        MOV R5,R1 //R5 <- m
        MOV R6,R2 //R6 <- D
        MOV R7,R3 //R7 <- C

        LDR R8,=13
        LDR R9,=5
        LDR R10,=4
        LDR R11,=2
        LDR R12,=7
        MUL R0,R5,R8 //R0 <- m * 13
        SUB R0,R0,1 //R0 <- m*13 - 1
        UDIV R0,R0,R9 //R0 <- (m*13-1)/5
        ADD R0,R0,R4 //R0 <- k + (m*13-1)/5
        ADD R0,R0,R6 //R0 <- k + (m*13-1)/5 + D

        UDIV R1,R6,R10 //R1 <- D/4
        UDIV R2,R7,R10 //R2 <- C/4
        MUL R3,R7,R11 //R3 <- 2*R3

        ADD R0,R0,R1 //R0 <- k + (m*13-1)/5 + D + D/4
        ADD R0,R0,R2 //R0 <- k + (m*13-1)/5 + D + D/4 + C/4
        SUB R0,R0,R3 //R0 <- k + (m*13-1)/5 + D + D/4 + C/4 - 2*R/3

        SDIV R1,R0,R12 //R1 <- R0/7
        MLS R0,R12,R1,R0 //R0 <- R0 - (7*R1)

        CMP R0,0
        IT LT //if R0 < 0
        ADDLT R0,R0,7 //R0 <- R0+7
        POP {R4-R11}
        BX LR

    //uint32_t Zeller2(uint32_t k, uint32_t m, uint32_t D, uint32_t C);
        .global    Zeller2
        .thumb_func
    Zeller2:
        PUSH {R4-R8}
        MOV R4,R0 //R4 <- k
        MOV R5,R1 //R5 <- m
        MOV R6,R2 //R6 <- D
        MOV R7,R3 //R7 <- C


        LDR R8,=13
        MUL R0,R5,R8 //R0 <- m * 13
        SUB R0,R0,1 //R0 <- m*13 - 1
        LDR R3,=858993460 //R3 <- 2^32 / 10
        SMULL R3,R0,R0,R3 //R0 <- (m*13-1)/5
        ADD R0,R0,R4 //R0 <- k + (m*13-1)/5
        ADD R0,R0,R6 //R0 <- k + (m*13-1)/5 + D
        ADD R0,R0,R6,LSR 2 // R0 <- k + (m*13-1)/5 + D + (D>>2)
        ADD R0,R0,R7,LSR 2 // R0 <- k + (m*13-1)/5 + D + (D>>2) + (C>>2)
        SUB R0,R0,R7,LSL 1 // R0 <- k + (m*13-1)/5 + D + (D>>2) + (C>>2) - 2C

        LDR R3,=613566757 //R2 <- 2^32 / 7
        SMULL R3,R1,R0,R3 //R1 = R0/7
        LDR R3,=7
        MLS R0,R1,R3,R0 //R0 = R0-(R1*7)
        CMP R0,0
        IT LT //if R0 < 0
        ADDLT R0,R0,7 //R0 <- R0+7
        POP {R4-R8}
        BX LR

    //uint32_t Zeller3(uint32_t k, uint32_t m, uint32_t D, uint32_t C);
        .global    Zeller3
        .thumb_func
    Zeller3:
        PUSH {R4-R9}
        MOV R4,R0 //R4 <- k
        MOV R5,R1 //R5 <- m
        MOV R6,R2 //R6 <- D
        MOV R7,R3 //R7 <- C

        LDR R8,=5
        LSL R0,R5,3 //R0 = 8*m
        ADD R0,R0,R5,LSL 2 //R0 = 12*m
        ADD R0,R0,R5 //R0 = 13*m
        SUB R0,R0,1 //R0 <- m*13 - 1
        UDIV R0,R0,R8 //R0 <- (m*13-1)/5
        ADD R0,R0,R4 //R0 <- k + (m*13-1)/5
        ADD R0,R0,R6 //R0 <- k + (m*13-1)/5 + D

        ADD R0,R0,R6,LSR 2 // R0 <- k + (m*13-1)/5 + D + (D>>2)
        ADD R0,R0,R7,LSR 2 // R0 <- k + (m*13-1)/5 + D + (D>>2) + (C>>2)
        SUB R0,R0,R7,LSL 1 // R0 <- k + (m*13-1)/5 + D + (D>>2) + (C>>2) - 2C

        LDR R9,=7
        SDIV R1,R0,R9 //R1 <- R0/7

        LSL R3,R1,3 //R3 <- 8*R1
        SUB R3,R3,R1 //R3 <- 7*R1
        SUB R0,R0,R3 //R0 <- R0 - (7*R1)

        CMP R0,0
        IT LT //if R0 < 0
        ADDLT R0,R0,7 //R0 <- R0+7
        POP {R4-R9}
        BX LR

.end
