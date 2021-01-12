
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// R0 * R1 = R2
// sum = 0
// while i < R1
//   sum += R0

// initialization
  @i
  M=0 // i=0
  @R2
  M=0 // sum=0

// WHICH IS HIGHER?
  @R0 // A=0
  D=M // D=RAM[0]
  @R1 // A=1
  D=D-M // D = RAM[0]-RAM[1]

  @0HIGHER // go to @0HIGHER if...
  D;JGE    // RAM[0]-RAM[1] >= 0

  @R1 // A=1
  D=M // D=RAM[1]
  @higher
  M=D // @higher=RAM[1]

  @R0 // A=0
  D=M // D=RAM[0]
  @lower
  M=D  // @lower=RAM[0]
  @LOOP
  0;JEQ // start the loop


(0HIGHER)
  @R0 // A=0
  D=M // D=RAM[0]
  @higher
  M=D // @higher=RAM[0]

  @R1 // A=1
  D=M // D=RAM[1]
  @lower
  M=D  // @lower=RAM[1]


(LOOP)
  @i
  D=M // D=i
  @higher
  D=M-D // D=higher-i
  @END
  D;JLE // if higher-i>0 jump to end
  
  // sum += lower  
  @lower
  D=M // D=lower
  @R2
  M=D+M // sum += lower

  @i
  M=M+1 // i++

  @LOOP
  0;JMP

(END)
  @END
  0; JMP

