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

// psuedo code:
// int scrnsize = 8192;
// int addr;
// int i;
//
// while (true) {
//	addr = SCREEN;
// 	i = 0;
//	if (KBD === 0) {
//		// Make screen white if black
//		if (RAM[addr] === -1) {
//			while (i < scrnsize)	{
//				RAM[addr] = 0;
//				addr++;
//				i++;
//			}
//		}
//	}
//	else {
//		// Make screen black if white
//		if (RAM[addr] === 0) {
//			while (i < scrnsize)	{
//				RAM[addr] = -1;
//				addr++;
//				i++;
//			}
//		}
//	}
// }


// initialize scrnsize = 8192;
@8192
D=A
@scrnsize
M=D

(LOOP)
// reset addr = SCREEN
@SCREEN
D=A
@addr
M=D

// reset i = 0
@i
M=0

// get keyboard input
@KBD
D=M

// if 0 goto EMPTY, else goto FILL
@EMPTY
D;JEQ
@FILL
0;JMP

(EMPTY)
// short circuit if already empty
@addr
A=M
D=M
@END
D;JEQ

(EMPTYLOOP)
// if (i==scrnsize) goto END
@i
D=M
@scrnsize
D=D-M
@END
D;JEQ

// Set register to 0
@addr
A=M
M=0

// i++
@i
M=M+1

// addr++
@addr
M=M+1

@EMPTYLOOP
0;JMP

(FILL)
// short circuit if already filled
@addr
A=M
D=M
@END
D;JNE

(FILLLOOP)
// if (i==scrnsize) goto END
@i
D=M
@scrnsize
D=D-M
@END
D;JEQ

// Set register to -1
@addr
A=M
M=-1

// i++
@i
M=M+1

// addr++
@addr
M=M+1

@FILLLOOP
0;JMP

// infinite loop
(END)
	@LOOP
	0;JMP