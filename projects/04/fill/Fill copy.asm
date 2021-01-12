// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// BLACKOUT
// i=SCREEN
// while !(KBD-i <= 0)
//   RAM[i] = -1
//   i+=32

(WAITFORINPUT)
  @KBD
  D=M // D=RAM[KBD]
  
  @BLACKOUT
  D;JGT // if RAM[KBD]>0, goto BLACKOUT
  @WHITEOUT
  D;JEQ // if RAM[KBD]==0, goto WHITEOUT

  @WAITFORINPUT
  0;JMP

(BLACKOUT)
  @SCREEN   
  D=A // D=@SCREEN
  @i
  M=D // i=@SCREEN

(LOOP)
  @KBD
  D=A // D=@KBD
  @i
  D=D-M // D=KBD-i
  @WAITFORINPUT
  D;JLE // if (KBD-i) =< 0 goto WAITFORINPUT
  
  @i
  A=M
  M=-1 // RAM[i]=-1

  @i
  M=M+1 // i++

  @LOOP
  0;JMP

(WHITEOUT)
  @SCREEN   
  D=A // D=@SCREEN
  @i
  M=D // i=@SCREEN

(LOOPW)
  @KBD
  D=A // D=@KBD
  @i
  D=D-M // D=KBD-i
  @WAITFORINPUT
  D;JLE // if (KBD-i) =< 0 goto WAITFORINPUT

  @i
  A=M
  M=0 // RAM[i]=-1

  @i
  M=M+1 // i++

  @LOOPW
  0;JMP

