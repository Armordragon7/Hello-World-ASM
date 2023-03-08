TITLE Code Challenge    (CodeChallenge.asm)

INCLUDE Irvine32.inc	;Import library

MY_FAVORITE_NUMBER = 7	; Constant value

.data	; Global data
smallArray		BYTE	13, 10, 0 ; Byte array containing Cr, Lf with 0 to prevent array merging (IDK why) P.S this is identical to CALL CrLf :D

myNumbers		BYTE	63, 100, 97, 101, 104, 97, 32, 115, 108, 114, 105, 119, 116, 47, 108, 114, 105, 119, 115, 32, 115, 109, 111, 111, 100, 32, 116, 97
				BYTE	104, 87, 32, 46, 34, 114, 97, 119, 32, 114, 101, 116, 97, 108, 32, 44, 101, 115, 110, 101, 102, 102, 111, 34, 32, 115, 117, 32, 115
				BYTE	108, 108, 101, 116, 32, 109, 101, 108, 111, 103, 32, 104, 99, 97, 101, 32, 44, 121, 114, 114, 97, 72, 32, 111, 108, 108, 101, 72	; Long byte array (single array)

myArray			BYTE	($ - myNumbers) DUP(?)	; Initializes another array. Current location counter ($) - myNumbers = length of myNumbers. DUP operator allocates space for array. (? means uninitialized values)

.code	; Code to run
main PROC	; Proc being ran. (Doesn't need to be main BTW)
	MOV		EBX, MY_FAVORITE_NUMBER		; MOV moves a value from one location to the next. Usage:  MOV	Destination, Source
	MOV		EDX, OFFSET myNumbers		; OFFSET moves memory address instead of actual value
	CALL	WriteString					; Prints string value from EDX to screen.
	MOV		EDX, OFFSET smallArray		; This will cause a CRLF (newline) with the next line
	CALL	WriteString
	CALL	WaitMsg						; This pauses code execution until use input
	CALL	CrLf	
	CALL	CrLf
	MOV		ECX, LENGTHOF myArray		; ECX is a counting register. This is how _myLoop knows when to stop. (When ECX hits 0)
	MOV		ESI, OFFSET myNumbers		; ESI is source array, moving memory address
	ADD		ESI, ECX					; Go to the end of the array
	DEC		ESI							; Decrement by 1 to only read the values need
	MOV		EDI, OFFSET myArray			; EDI is Destination array, moving memory address
_myLoop:								; code label (Basically a goto point)					
	STD									; Sets Direction status flag to true. (primitives will decrement pointer aka move backwards) 
	LODSB								; Loads byte memory addressed by ESI into accumulator
	CLD									; Clear Direction Flag (primitives will increment pointer aka move forward)
	STOSB								; Store accumulator contents into memory addressed by EDI
	LOOP	_myLoop						; Loop until ECX hits 0. This auto decrements ECX. This loop reverses myNumbers into myArray.
	MOV		EDX, OFFSET myArray
	MOV		ESI, EDX
	CALL	WriteString					; Print reversed array
	MOV		EDX, OFFSET smallArray
	CALL	WriteString
	CALL	WaitMsg
	CALL	CrLf
	CALL	CrLf
	MOV		ECX, LENGTHOF myArray
_myOtherLoop:
	MOV		EDX, 0						; This clear is required for DIV since this is where the remainder goes
	MOV		EAX, LENGTHOF myArray
	SUB		EAX, ECX					; Subtract length of myArray by loop number and store in EAX
	DIV		EBX							; EAX/EBX
	CMP		EDX, 0						; See if there is a remainder aka does 7 go into the loop iterator evenly. (This is to grab the 7th value)
	JNZ		_Huh						; Jump not zero, to _Huh (This skips printing characters)
	CMP		ECX, LENGTHOF myArray		; Edge case, the first loop check
	JE		_Huh						; Jump equal to _Huh (This skips printing characters) The checks are similar to a (if EDX == 0 and ECX != lengthof array)
	PUSH	ECX							; Pushes the value in ECX to top of stack
	PUSH	ESI							; Pushes the value in ESI to top of stack
	SUB		ECX, LENGTHOF myArray		; Takes current value in loop/ECX minus length of array and store in ECX
	ADD		ESI, ECX					; Add ESI (array pointer) with negative value of loop iterator to get to the character index
	MOV		AL, [ESI]					; Move value at ESI address into AL register 16 bit AL is lower and AH is higher. Together, they make EAX.
	CALL	WriteChar					; Writes character from AL to screen
	POP		ESI							; Pop top of stack into ESI (restores value from before) 
	POP		ECX							; Pop top of stack into ECX (restores value from before) 
_Huh:									; Goto that skips printing characters
	LOOP	_myOtherLoop				; Loops through myArray once
	MOV		AL, 33						; Move the value 33 in AL. (! in ascii)
	CALL	WriteChar
	CALL	CrLf
	CALL	WaitMsg						; Holds screen from closing.
	Invoke ExitProcess,0				; Exit
main ENDP

END main