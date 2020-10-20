comment ! 
5/27/2020 
Assignment 5 

Purpose: 
Collect 2 signed integers from the user 
and take the sum and difference from them. 
This Program will print starting from 
row 10 column 20. This program will clear the screen 
after each run, and will wait for user to continue to 
next prompts. The Program will run 
3 times before ending. 
! 

INCLUDE Irvine32.inc

.data
; strings 
prompt BYTE "Please enter an integer: ", 0 
sum BYTE "Sum = ", 0 
diff BYTE "Difference = ", 0 
wat BYTE "Press any key... ", 0

.code
main PROC
	
	sub edx, edx		
	mov ecx, 3				; set loop count to 3 
L1:
	mov esi, ecx			; store count 
	mov ch, 10				; store value to set X row 10 
	mov cl, 10				; store value to set Y column 20 
	
	call Clrscr				; clear screen
	call Input				; collect first integer
	mov ebx, eax			; sets aside input to collect another one
	call Input				; collect second integer
	mov edi, eax
	
	sub eax, eax			; clear eax 
	call DisplaySum			; calls procedure to add 
	call Crlf				
	call DisplayDiff		; calls procedure to sub 
	call WaitForKey			; calls procedure to Wait for a key press to cont


	mov ecx, esi			; restore count for loop
	LOOP L1
	exit
main ENDP


; Procedures 

; Locate procedure: sets the cursor position.

Locate proc
	mov dh, ch				; input x coordinate for gotoxy 
	mov dl, cl				; input y coodinate 
	call Gotoxy
	inc ch					; next row 
	ret 
Locate ENDP

; Input procedure: this procedure prompts the user and saves the input.

Input proc
	call Locate				; locate cursor to coordinates 
	mov edx, OFFSET prompt	
	call Writestring		; prompt user for signed integer 
	call ReadInt			; collect integer
	ret 
Input ENDP


;  DisplaySum: calculates and displays the sum.

DisplaySum proc	
	push ebx 
	push edi 
	push eax

	call Locate				; locate cursor for sum line 
	mov edx, OFFSET sum
	call WriteString 
	add eax, ebx			
	add eax, edi			; adds second integer to first integer 
	call WriteInt			; print sum 

	pop eax
	pop edi
	pop ebx 
	ret 
DisplaySum ENDP 


;  DisplayDiff: calculates and displays the difference. 
;  (first input - the second input)

DisplayDiff proc 
	push ebx 
	push edi 
	push eax 

	call Locate				; locate cursor for difference line 
	mov edx, OFFSET diff
	call WriteString		; print difference prompt 
	mov eax, ebx 
	sub eax, edi			; sub second integer from first integer
	call WriteInt			; print difference 
	call Locate	
	call Crlf

	pop eax
	pop edi 
	pop ebx
	ret 
DisplayDiff ENDP


; WaitForKey: displays "Press any key..." and 
;			  waits for an input

WaitForKey proc 
	call Locate
	call WaitMsg			; wait for key to continue 
	ret
WaitForKey ENDP
	
END main

; SAMPLE RUN
Comment! 
          Please enter an integer: 2
          Please enter an integer: 3
          Sum = +5
          Difference = -1                         
          Press any key to continue...  

		  Please enter an integer: 3
          Please enter an integer: -9
          Sum = -6
          Difference = +12                                                                                              
          Press any key to continue... 

		  Please enter an integer: -10
          Please enter an integer: 2
          Sum = -8
          Difference = -12                                                                                              
          Press any key to continue... 
!