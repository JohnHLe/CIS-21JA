comment ! 
Assignment 4 
05-21-2020
CIS 41JA	


purpose:
This program will collect 10 integer inputs into an array.
Then will calculate the sum and mean of the array. 
Then will Rotate the members in the array forward one position for
9 times, so the last rotation will display the array in reversed order.

!

INCLUDE Irvine32.inc

.data

;string variables 
instruction BYTE "Please enter a number: ", 0
theSumIs BYTE "The sum is: ", 0 
theMeanIs BYTE "The mean is: ", 0 
divByTen BYTE "/10", 0 
space BYTE " ", 0 
originArrayPrompt BYTE "The original array: ", 0 
aftRotate BYTE "After a Rotation: ", 0 

; the array
arr DWORD 10 dup(?)


.code
main PROC
	
	; COLLECT INTEGERS INTO THE ARRAY 

	mov esi, OFFSET arr						; set pointer 
	mov ecx, LENGTHOF arr					; set loop counter
	mov edx, OFFSET instruction				
L1: 

	call WriteString 
	call ReadDec
	mov [esi], eax 
	add esi, TYPE arr
	LOOP L1
	call Crlf 


	; GET SUM OF THE ARRAY

	mov esi, OFFSET arr						
	mov ecx, LENGTHOF arr
	mov edx, OFFSET theSumis
	sub eax, eax							; move pointer 
L2:
	add eax, [esi]
	add esi, TYPE arr
	LOOP L2

	call WriteString
	call WriteDec
	call Crlf

	; GET MEAN OF THE ARRAY		(whole number and remainder/10 format)
										
	mov edx, OFFSET theMeanIs
	call WriteString
	sub edx, edx							; clear edx for div 
	mov ebx, LENGTHOF arr					; b/c can't div w/ immediate num
	div ebx									
	call WriteDec	
	mov ebx, edx							

	mov edx, OFFSET space					; space out whole num & frac
	call WriteString
	mov eax, ebx 
	call WriteDec 
	mov edx, OFFSET divByTen
	call WriteString 
	call Crlf


	; PRINT ORIGINAL ARRAY 

	mov edx, OFFSET originArrayPrompt 
	call WriteString

	mov esi, OFFSET arr
	mov ecx, LENGTHOF arr
	mov edx, OFFSET space
L3:
	mov eax, [esi]				
	call WriteDec
	call WriteString
	add esi, TYPE arr						; inc index "go next index"
	LOOP L3

	call Crlf
	


	; ROTATE THE ARRAY 

	mov esi, OFFSET arr 
	mov ecx, LENGTHOF arr 
	sub eax, eax
	dec ecx
L4: 							
	mov edx, OFFSET aftRotate				
	call WriteString 
	mov esi, SIZEOF arr - TYPE arr			; pointer to last array element
	mov edi, ecx							; save index before nested loops
											
	; SWAP LOOP "THE ROTATE"
	L5:
		mov eax, [arr + esi]				; setting a temp arr index variable    
		xchg [arr + esi - TYPE arr], eax	; swap curr index w/ last index
		mov [arr + esi], eax				; set eax back to curr index
		sub esi, TYPE arr					; dec index "go next index"
		LOOP L5 
	
	; PRINT ROTATED ARRAY 
	
	mov esi, OFFSET arr 
	mov ecx, LENGTHOF arr 
	mov edx, OFFSET space			
	L6:										; same loop as original array print
		mov eax, [esi]
		call WriteDec
		call WriteString
		add esi, TYPE arr					; inc index
		LOOP L6

	call Crlf
	mov ecx, edi							; go back original index
	LOOP L4

	exit
main ENDP
END main

Comment !
SAMPLE RUNS 

SAMPLE RUN #1 

Please enter a number: 2
Please enter a number: 3
Please enter a number: 4
Please enter a number: 5
Please enter a number: 6
Please enter a number: 7
Please enter a number: 8
Please enter a number: 9
Please enter a number: 0
Please enter a number: 10

The sum is: 54
The mean is: 5 4/10
The original array: 2 3 4 5 6 7 8 9 0 10
After a Rotation: 10 2 3 4 5 6 7 8 9 0
After a Rotation: 10 0 2 3 4 5 6 7 8 9
After a Rotation: 10 0 9 2 3 4 5 6 7 8
After a Rotation: 10 0 9 8 2 3 4 5 6 7
After a Rotation: 10 0 9 8 7 2 3 4 5 6
After a Rotation: 10 0 9 8 7 6 2 3 4 5
After a Rotation: 10 0 9 8 7 6 5 2 3 4
After a Rotation: 10 0 9 8 7 6 5 4 2 3
After a Rotation: 10 0 9 8 7 6 5 4 3 2
Press any key to close this window . . .

SAMPLE RUN #2 

Please enter a number: 1
Please enter a number: 2
Please enter a number: 3
Please enter a number: 4
Please enter a number: 5
Please enter a number: 6
Please enter a number: 7
Please enter a number: 8
Please enter a number: 9
Please enter a number: 10

The sum is: 55
The mean is: 5 5/10
The original array: 1 2 3 4 5 6 7 8 9 10
After a Rotation: 10 1 2 3 4 5 6 7 8 9
After a Rotation: 10 9 1 2 3 4 5 6 7 8
After a Rotation: 10 9 8 1 2 3 4 5 6 7
After a Rotation: 10 9 8 7 1 2 3 4 5 6
After a Rotation: 10 9 8 7 6 1 2 3 4 5
After a Rotation: 10 9 8 7 6 5 1 2 3 4
After a Rotation: 10 9 8 7 6 5 4 1 2 3
After a Rotation: 10 9 8 7 6 5 4 3 1 2
After a Rotation: 10 9 8 7 6 5 4 3 2 1
Press any key to close this window . . .
!