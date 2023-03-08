TITLE Code Challenge    (CodeChallenge.asm)

INCLUDE Irvine32.inc

MY_FAVORITE_NUMBER = 7

.data
smallArray		BYTE	13, 10, 0

myNumbers		BYTE	63, 100, 97, 101, 104, 97, 32, 115, 108, 114, 105, 119, 116, 47, 108, 114, 105, 119, 115, 32, 115, 109, 111, 111, 100, 32, 116, 97
				BYTE	104, 87, 32, 46, 34, 114, 97, 119, 32, 114, 101, 116, 97, 108, 32, 44, 101, 115, 110, 101, 102, 102, 111, 34, 32, 115, 117, 32, 115
				BYTE	108, 108, 101, 116, 32, 109, 101, 108, 111, 103, 32, 104, 99, 97, 101, 32, 44, 121, 114, 114, 97, 72, 32, 111, 108, 108, 101, 72

myArray			BYTE	($ - myNumbers) DUP(?)

.code
main PROC
	MOV		EBX, MY_FAVORITE_NUMBER
	MOV		EDX, OFFSET myNumbers
	CALL	WriteString
	MOV		EDX, OFFSET smallArray
	CALL	WriteString
	CALL	WaitMsg
	CALL	CrLf
	CALL	CrLf
	MOV		ECX, LENGTHOF myArray
	MOV		ESI, OFFSET myNumbers
	ADD		ESI, ECX
	DEC		ESI
	MOV		EDI, OFFSET myArray
_myLoop:
	STD
	LODSB
	CLD
	STOSB
	LOOP	_myLoop
	MOV		EDX, OFFSET myArray
	MOV		ESI, EDX
	CALL	WriteString
	MOV		EDX, OFFSET smallArray
	CALL	WriteString
	CALL	WaitMsg
	CALL	CrLf
	CALL	CrLf
	MOV		ECX, LENGTHOF myArray
_myOtherLoop:
	MOV		EDX, 0
	MOV		EAX, LENGTHOF myArray
	SUB		EAX, ECX
	DIV		EBX
	CMP		EDX, 0
	JNZ		_Huh
	CMP		ECX, LENGTHOF myArray
	JE		_Huh
	PUSH	ECX
	PUSH	ESI
	SUB		ECX, LENGTHOF myArray
	ADD		ESI, ECX
	MOV		AL, [ESI]
	CALL	WriteChar
	POP		ESI
	POP		ECX
_Huh:
	LOOP	_myOtherLoop
	MOV		AL, 33
	CALL	WriteChar
	CALL	CrLf
	CALL	WaitMsg
	Invoke ExitProcess,0
main ENDP

END main