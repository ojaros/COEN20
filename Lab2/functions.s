// Oliver Jaros
// April 16th, 2020
// functions.s
// This is my code for Lab2a of COEN 20.

		.syntax		unified
		.cpu		cortex-m4
		.text

	// int32_t Add(int32_t a, int32_t b);
		.global		Add
		.thumb_func
	Add:
		ADD R0, R0, R1
		BX LR

	// int32_t Less1(int32_t a);
		.global		Less1
		.thumb_func
	Less1:
		SUB R0, R0, 1
		BX LR

	// int32_t Square2x(int32_t x);
		.global		Square2x
		.thumb_func
	Square2x:
		// adding LR to stack
		PUSH {LR}
		// multiplying R0 by 2
		ADD R0, R0, R0
		// calling Square function
		BL Square
		POP {LR}
		BX LR

	// int32_t Last(int32_t x);
		.global		Last
		.thumb_func
	Last:
		// adding R4 and LR to stack
		PUSH {R4, LR}
		// setting R4 to R0
		MOV R4, R0
		// calling SquareRoot function
		BL SquareRoot
		Add R0, R4, R0
		POP {R4, LR}
		BX LR

		.end
