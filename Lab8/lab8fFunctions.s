//
//  lab8fFunctions.s
//  
//
//  Created by Oliver Jaros on 6/3/20.
//

    .syntax        unified
    .cpu        cortex-m4
    .text

//Q16 Q16Divide(Q16 dividend, Q16 divisor);
    .global Q16Divide
    .thumb_func
Q16Divide:
    //R0 = dividend, R1 = divisor
    //LDR R2,=quotient //R2 <- &quotient
    //LDR R3,=remainder //R3 <- &remainder
    //LDR R12,=sign //R12 <- &sign
    EOR R12,R0,R1 //R12(sign) <- dividend ^ divisor

    EOR R2,R0,R0,ASR31 //R2 <- if(R0<0),~R0
    ADD R0,R2,R0,LSR31 //R0<- if(R0<0),R2+1

    EOR R2,R1,R1,ASR31 //R2 <- if(R1<0),~R1
    ADD R1,R2,R1,LSR31 //R1<- if(R1<0),R2+1
    
    SDIV R2,R0,R1 //R2(quotient) = dividend/divisor
    MLS R3,R1,R2,R0  //R3(remainder) = dividend - (divisor*quotient) = dividend % divisor

    .REPT 16
    LSL R2,R2,1 //R2(quotient) = quotient << 1
    LSL R3,R3,1 //R3(remainder) = remainder << 1
    CMP R3,R1
    ITT HS //if (remainder >= divisor)
    SUBHS R3,R3,R1 //R3(remainder) = remainder - divisor
    ADDHS R2,R2,1 //R2(quotient) = quotient + 1
    .ENDR

    EOR R2,R2,R12,ASR31 //R2 <- if(R12<0),~R2
    ADD R0,R2,R12,LSR31 //R0<- if(R12<0),R2+1
    BX LR
.end
    
    

    

    

