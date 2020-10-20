INCLUDE Irvine32.inc

.data
myarray word 100h, 200h, 0ah 
sum dword ? 


ENDM
.code
main PROC
	sub esp, 4 
	push lengthof myarray 
	push OFFSET myarray 
	call ProcTwo 
	pop sum 
	exit
main ENDP

ProcTwo proc
	push ebp 
	mov ebp, esp 
	push eax
	push ecx 
	push esi 
	mov ecx, [ebp + 12]
	mov esi, [ebp +  8] 
	xor eax, eax 
L1: 
	add ax, [esi]
	add esi, 2 
	LOOP L1 
	mov [ebp + 16], eax 
	pop esi 
	pop ecx 
	pop eax 
	pop ebp 
	ret 8 
ProcTwo ENDP 

END main

