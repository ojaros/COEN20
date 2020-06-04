//
//  lab8bFunctions.s
//  
//
//  Created by Oliver Jaros on 5/28/20.
//

    .syntax        unified
    .cpu        cortex-m4
    .text

//float Discriminant(float a, float b, float c);
    .global Discriminant
    .thumb_func
Discriminant:
    VMUL.F32 S1,S1,S1               //S1 <- b*b
    VMOV S3,4.0                     //S3 <- 4.0
    VMUL.F32 S0, S0, S3             //S0 <- 4a
    VMUL.F32 S0, S0, S2             //S0 <- 4ac
    VSUB.F32 S0,S1,S0               //S0 <- b^2-4ac
    BX LR


//float Root1(float a, float b, float c);
    .global    Root1
    .thumb_func
Root1:
    PUSH {LR}
    VPUSH {S16,S17}
    VMOV S16,S0             //S16 <- a
    VMOV S17,S1             //S17 <- b
    BL Discriminant         //S0 <- Discriminant
    VSQRT.F32 S0,S0         //S0 <- sqrt(S0)
    VNEG.F32 S1,S17         //S1 <- -b
    VADD.F32 S0,S1,S0       //S0 <- -b+sqrt(S0)
    VMOV S3,2.0             //S3 <- 2.0
    VMUL.F32 S3,S3,S16      //S3 <- 2a
    VDIV.F32 S0,S0,S3       //S0 <- -b+sqrt(S0)/2a
    VPOP {S16,S17}
    POP {PC}

//float Root2(float a, float b, float c);
    .global    Root2
    .thumb_func
Root2:
    PUSH {LR}
    VPUSH {S16,S17}
    VMOV S16,S0             //S16 <- a
    VMOV S17,S1             //S17 <- b
    BL Discriminant         //S0 <- Discriminant
    VSQRT.F32 S0,S0         //S0 <- sqrt(S0)
    VNEG.F32 S1,S17         //S1 <- -b
    VSUB.F32 S0,S1,S0       //S0 <- -b-sqrt(S0)
    VMOV S3,2.0             //S3 <- 2.0
    VMUL.F32 S3,S3,S16      //S3 <- 2a
    VDIV.F32 S0,S0,S3       //S0 <- -b+sqrt(S0)/2a
    VPOP {S16,S17}
    POP {PC}


//float Quadratic(float x, float a, float b, float c);
    .global    Quadratic
    .thumb_func
Quadratic:
    VMOV S4,S0          //S4 <- x
    VMUL.F32 S4,S4,S4   //S4 <- x^2
    VMUL.F32 S1,S1,S4   //S1 <- ax^2
    VMUL.F32 S2,S2,S0   //S2 <- bx
    VADD.F32 S0,S1,S2   //S0 <- ax^2 + bx
    VADD.F32 S0,S0,S3   //S0 <- ax^2 + bx + c
    BX LR

.end


