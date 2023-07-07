		.syntax     unified
		.cpu        cortex-m4
        .equ XPIXELS,   240  // The left edge of the screen is at x = 0
        .equ YPIXELS,   320  // The top edge of the screen is at y = 0
	    .equ COLOR_BLUE,          0xFF0000FF
    	.equ COLOR_GREEN,         0xFF00FF00
	    .equ COLOR_RED,           0xFFFF0000
	    .equ COLOR_CYAN,          0xFF00FFFF
	    .equ COLOR_MAGENTA,       0xFFFF00FF
	    .equ COLOR_YELLOW,        0xFFFFFF00
	    .equ COLOR_LIGHTBLUE,     0xFF8080FF
	    .equ COLOR_LIGHTGREEN,    0xFF80FF80
	    .equ COLOR_LIGHTRED,      0xFFFF8080
	    .equ COLOR_LIGHTCYAN,     0xFF80FFFF
	    .equ COLOR_LIGHTMAGENTA,  0xFFFF80FF
	    .equ COLOR_LIGHTYELLOW,   0xFFFFFF80
	    .equ COLOR_DARKBLUE,      0xFF000080
	    .equ COLOR_DARKGREEN,     0xFF008000
	    .equ COLOR_DARKRED,       0xFF800000
	    .equ COLOR_DARKCYAN,      0xFF008080
	    .equ COLOR_DARKMAGENTA,   0xFF800080
	    .equ COLOR_DARKYELLOW,    0xFF808000
	    .equ COLOR_WHITE,         0xFFFFFFFF
	    .equ COLOR_LIGHTGRAY,     0xFFD3D3D3
	    .equ COLOR_GRAY,          0xFF808080
	    .equ COLOR_DARKGRAY,      0xFF404040
	    .equ COLOR_BLACK,         0xFF000000
	    .equ COLOR_BROWN,         0xFFA52A2A
	    .equ COLOR_ORANGE,        0xFFFFA500
	    .equ DISPLAY,             0xD0000000
		.text

		.global		pixel
	    .thumb_func
	    .align
// Draws the pixel word passed in R2 to the pixel location given by the
// column in R0 and the row in R1
// Copy your code from Lab #7 here


pixel:
//R0 contains column
//R1 contains row 
//R2 contains pixel color


MOV R3, #240 // store 240 from the formula
MUL R1, R3   //multiply 240 and row 
ADD R1, R0 // Add the column from the column given to the row 
LDR R0, =0xD0000000 //memory adress from formula to R1 //
// color  already in R2
STR R2, [R0, R1, LSL #2] // This multiplies R1 by 4 and then adds R1 and R0 memory adress and stores it in R3 ( R1 is the offset of passed in by the row+column)
		bx		lr

		.global		drawline
		.thumb_func
		.align


// Arguments:
//   R0 = x0 -> column
//   R1 = y0 -> row
//   R2 = x1 -> color 
//   R3 = y1
// Uses:
//   R4 = temp var
//   R5 = e2
//   R6 = x0
//   R7 = y0
//   R8 = x1
//   R9 = y1
//   R10 = dx
//   R11 = dy
//   R12 = error
drawline:
PUSH {R4, R5, R6, R7, R8, R9, R10, R11, R12, lr} //Give ownership of new registers to functions

MOV R6, R0 // Move the argument in R0 to R6
MOV R7, R1 // Move the rest of the arguments to new registers
MOV R8, R2 // 
MOV R9, R3 // 



//drawline(x0, y0, x1, y1)

SUB R10,R8,R6 //dx = x1 - x0

SUB R11,R7,R9 //dy = y0 - y1

ADD R12,R10,R11 //error = dx + dy

//while true ???
loopwhile:

//pixel(x0, y0, color) set parameters
MOV R0,R6
MOV R1,R7
//MOV R2, 0xFF00FF00 // COLOR_GREEN??? it wont let me compile with this constant or any other color 
LDR R2, =COLOR_MAGENTA
bl pixel

//e2 = 2 * error 
MOV R5, #2
MUL R5,R5,R12

//if e2 >= dy signed
CMP R5,R11 
bGE greaterorequal

checkdx:
CMP R5,R10
bLE lowerorsame//signed
b loopwhile

greaterorequal:
//if x0 == x1 break 
CMP R6,R8
bEQ ends

//error = error + dy
ADD R12,R12, R11
//x0 = x0 + 1
ADD R6,#1
//end if
b checkdx


//if e2 <= dx
lowerorsame: 
//if y0 == y1 break
CMP R7,R9
bEQ ends

//error = error + dx
ADD R12, R10
//y0 = y0 + 1
ADD R7, #1


//end if
//end while
b loopwhile

//return


ends:

POP {R4, R5, R6, R7, R8, R9, R10, R11, R12, pc} 
// Your assembly code goes here

		.end
