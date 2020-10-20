comment ! 
Assignment 3 
05-07-2020
CIS 41JA	

purpose:
This program will prompt the User to enter 3 numbers
(num1, num2, num3) to calculate the equation:
((num1 ^ 3) * num2 + 5 * ( num2 ^ 2)) / num3 

This program will assume that the user enters only numbers 
that are greater than zero and the calculation never exceed
4 bytes size.
! 

INCLUDE Irvine32.inc

.data

instruction byte "You will be entering 3 numbers ", 0
first1 byte "num1 = ", 0 
second2 byte "num2 = ", 0 
third3 byte "num3 = ", 0
equation byte "((num1 ^ 3) * num2 + 5 * ( num2 ^ 2)) / num3 = ", 0 
letterR byte " R ", 0
solutionPrompt byte "Solution:", 0


num1 dword ?
num2 dword ?
num3 dword ?
quotient dword ? 
remainder dword ? 


.code
main PROC

	; Instruction prompts 
	mov edx, offset instruction	; Informs the user to prepare to input numbers
	call writeString
	call crlf 
	call crlf 

	mov edx, offset first1		; prompts user for first number 
	call writeString 	
	call readDec 
	mov num1, eax 

	

	mov edx, offset second2		; prompts user for second number 
	call writeString 
	call readDec 
	mov num2, eax 



	mov edx, offset third3		; prompts user for third number 
	call writeString 
	call readDec 
	mov num3, eax	
	call crlf 
	call crlf 


	; Calculation part starts here
	mov eax, num1				
	mul num1					; num1 ^ 2
	mul num1					; num1 ^ 3
	mul num2					; (num1 ^ 3) * num2
	mov ebx, eax				; set ebx = (num1 ^ 3) * num2
	
	mov eax, num2 
	mul num2					; num2 ^ 2
	mov ecx, 5 
	mul ecx						; eax = 5 * (num2 ^ 2)

	add eax, ebx				; eax = ((num1 ^ 3) * num2 + 5 * (num2 ^ 2))

	sub edx, edx 
	div num3					; edx:eax / num3
	
	mov quotient, eax 
	mov remainder, edx 

	; End of Calculation part 

	; outputs results 
	mov edx, offset solutionPrompt
	call writeString
	call crlf 

	mov edx, offset equation	; print equation 
	call writeString 
	
	mov eax, quotient			; print quotient 
	call writeDec

	mov edx, offset letterR		; print letter R to label Remainder 
	call writeString

	mov eax, remainder			; print remainder 
	call writeDec
	call crlf 
	call crlf 

	exit
main ENDP
END main

; Sample Run
comment ! 
You will be entering 3 numbers

num1 = 1
num2 = 2
num3 = 3


Solution:
((num1 ^ 3) * num2 + 5 * ( num2 ^ 2)) / num3 = 7 R 1
!	