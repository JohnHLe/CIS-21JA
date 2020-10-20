comment ! 
6/04/2020 
Assignment 6

Purpose: 
This program  program that:
Takes a unsigned number as an input.
Prints back to the console all the primes that are larger 
than 1 but not larger than the number that has been 
! 

INCLUDE Irvine32.inc

.data
; strings 
prompt BYTE "Please enter an integer: ", 0 
primePrompt BYTE "Primes found until the given number: ", 0
space BYTE " ", 0

.code
main PROC
	
	sub eax, eax
	mov edx, OFFSET prompt 
	call WriteString 
	call ReadInt
	mov edx, OFFSET primePrompt
	call WriteString 
	call Crlf
	sub edx, edx
	call printPrimes 
	call WaitMsg
	exit
main ENDP


; Procedures 

; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; isPrime Procedure
; Returns 1 if number is prime, 0 otherwise
; WHILE LOOP USED IN C++ LANGUAGE
;	int i = 2 
;	while(i < Input){
;		if (Input % i == 0)
;			return False; 
;		i++; 
;	}
;	return True;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
isPrime Proc 
	cmp eax, 0			; If Statement: if(eax == 0) 
	je notPrime			; False: 0 is not a prime num
	cmp eax, 1			; If Statement: if(eax == 1) 
	je notPrime			; False: 1 is not a prime num

	mov ebx, 2			; int i = 2 	

	; WHILE LOOP
	; To check if input prime
retest:
	push eax
	cmp eax, ebx		; If Statement: if(i==2)
	je prime			; 2 is a Prime number
	cmp ebx, eax		; while(i < Input)
	je prime			
	sub edx, edx		; clear edx 
	div ebx				
	cmp edx, 0			; Input % i == 0
	je notPrime 
	pop eax				; reset eax back to input value
	inc ebx		
	jg retest			; loops while loop 
notPrime:
	pop eax 
	xor edi, edi		
	ret					; Return 0 
prime: 
	pop eax
	xor edi, edi		
	inc edi				
	ret					; Return 1
isPrime ENDP
	
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; printPrimes Procedure
; Prints back to the console all the primes that are 
; larger than 1 but not larger than the number that has been entered.
; WHILE LOOP USED IN C++ LANGUAGE
;	int i = 1
;	while(i <= Input){
;		i++;
;		if (isPrime(i))
;			cout << " " << i;
;	}
;	return True;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printPrimes Proc 

	push eax 
	mov ecx, eax
	pop eax
	mov eax, 1 

	; WHILE LOOP 
	; To print out the prime numbers before the input number
priming:
	inc eax 
	call isPrime 
	cmp edi, 1				; If Statement: if(isPrime)
	jae pp					; True: if number is prime
	jnae skipp				; False: if number is not prime

pp:							; if number is prime 
	call WriteDec
	mov edx, OFFSET space
	call WriteString		; print space
	cmp eax, ecx			; If Statement: if reached the input value
	je noMore				; return to main 
	jmp priming

skipp:
	cmp eax, ecx			; If Statement: if reached the input value
	je noMore				; return to main 
	jmp priming
noMore:
	ret						; return to main 
ret
printPrimes ENDP 
END main

; SAMPLE RUN
Comment! 

Please enter an integer: 44
Primes found until the given number:
2 3 5 7 11 13 17 19 23 29 31 37 41 43 Press any key to continue...

!