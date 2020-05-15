//
//  lab5functions.s
//  
//
//  Created by Oliver Jaros on 5/6/20.
//
    .syntax        unified
    .cpu        cortex-m4
    .text

//void MatrixMultiply(int32_t A[3][3], int32_t B[3][3], int32_t C[3][3]);
    .global        MatrixMultiply
    .thumb_func
MatrixMultiply:
    
    PUSH {R4-R11, LR}
    MOV R7,R0 //keep A[3][3] safe in R7
    MOV R8,R1 //keep B[3][3] safe in R8
    MOV R9,R2 //keep C[3][3] safe in R9
    
//for(row=0;row<=2;row++){
   LDR R4,=0 //row(R4) <- 0
TopOfRowLoop:
    CMP R4,2 //row <= 2?
    BGT RowLoopDone //if (row>2) goto RowLoopDone, if not keep going
        
        //for(col=0;col<=2;col++){
        LDR R5,=0 //col(R5) <- 0
    TopOfColLoop:
        CMP R5,2 //col <= 2?
        BGT ColLoopDone //if (col>2) goto ColLoopDone

            //A[row][col] = 0;
            LDR R3,=3 //R3 <- 3
            MLA R1, R4, R3, R5 //R1 <- row*3 + col
            LDR R2,=0
            STR R2, [R7, R1, LSL2] //R2(0) -> A[row][col]

            //for(k=0;k<=2;k++){
            LDR R6,=0 //k(R6) <- 0
        TopOfKLoop:
            CMP R6,2 //k <= 2?
            BGT KLoopDone //if (k>2) goto KLoopDone

                //R0<-A[row][col]
                LDR R3,=3 //R12 <- 3
                MLA R10, R4, R3, R5 //R10 <- row*3 + col
                LSL R10, R10, 2 //R10 <- 4(row*3 + col)
                ADD R10, R7, R10 //R10 <- &A[0][0] + 4(row*3 + col)
                LDR R0, [R10] //R0 <- A[row][col]

                //R1 <- B[row][k]
                LDR R3,=3 //R3 <- 3
                MLA R11, R4, R3, R6 //R8 <- row*3 + k
                LDR R1, [R8, R11, LSL2] //R1 <- B[row][k]

                //R2 <- C[k][col]
                LDR R3,=3 //R3 <- 3
                MLA R12, R6, R3, R5 //R12 <- k*3 + col
                LDR R2, [R9, R12, LSL2] //R2 <- C[k][col]

                //MultAndAdd
                BL MultAndAdd
                STR R0, [R10] //MultAndAdd -> A[row][col]

            ADD R6,R6,1 //k++
            B TopOfKLoop
        KLoopDone:
        ADD R5,R5,1 //col++
        B TopOfColLoop
    ColLoopDone:
    ADD R4,R4,1 //row++
    B TopOfRowLoop
RowLoopDone:
    POP {R4-R11, PC}
    .end

