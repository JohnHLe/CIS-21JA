COMMENT !
Assignment 7
date: 06-18-2020
!

include irvine32.inc
; ===============================================
.data
  
prompt    BYTE "After each element press enter: ", 0 
initial   BYTE "Initial array:", 0 
after     BYTE "Array sorted in ascending order:", 0 
arr       DWORD 40 dup(?) 
aLength   DWORD ?
;=================================================
.code
main proc    
    mov edx, OFFSET prompt 
    call WriteString 
    call Crlf 

    ; int enter_elem(arr_addr)
    sub esp, 4      
    push OFFSET arr                     ; push array address 
    call enter_elem         
    pop aLength 

    mov edx, OFFSET initial 
    call WriteString
    call Crlf 
    ; void print_arr(arr_addr,arr_len)
    push aLength                        ; pushes array length 
    push OFFSET arr                     ; pushes array address 
    call print_arr

    call Crlf
    ; void sort_arr(arr_addr,arr_len)
    push aLength                        ; pushes array length 
    push OFFSET arr                     ; pushes array address 
    call sort_arr

    mov edx, OFFSET after
    call WriteString
    call Crlf 
    ; void print_arr(arr_addr,arr_len)
    push aLength                        ; pushes array length 
    push OFFSET arr                     ; pushes array address 
    call print_arr
	exit 
main endp

; ================================================
; int enter_elem(arr_addr)
;
; Input:
;   ARR_ADDRESS THROUGH THE STACK
; Output:
;   ARR_LENGTH THROUGH THE STACK
; Operation:
;   Fill the array and count the number of elements
;
enter_elem proc
	push ebp 
    mov ebp, esp  

    mov ebx, [ebp + 8]
    xor edi, edi                        ; zero for array size 
    ; while loop 
    ; while (count <= 40 && input != 0)
    ;{
    ;   cin >> input; 
    ;   array[count] = input; 
    ;   ++count;    
    ;}
    ;WHILE LOOP HERE
Input: 
    call ReadDec
    ; if(input = 0);
    cmp eax, 0                          ; if input is 0, stops collecting 
    je out01    
    ; if (count = 40);
    cmp edi, 40                         ; stops collecting after 40 inputs
    ja out01 

    mov [ebx], eax 
    add ebx, TYPE DWORD                 ; go next array index 
    inc edi                             ; inc size count 
    jmp Input

out01:
    mov [ebp + 12], edi                 ; mov Length to reserved stack space
    pop ebp
    ret 4                               ; clear stack 
enter_elem endp

; ================================================
; void print_arr(arr_addr,arr_len)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;  print out the array
;

print_arr proc
    push ebp
    mov ebp, esp 
    mov esi, [ebp +  8]                  ; array address  
    mov ecx, [ebp + 12]                  ; array length for count 

printLoop: 
    mov eax, [esi] 
    add esi, TYPE DWORD 
    call WriteDec                        ; print arr[count]
    mov al, ' '                           
    call WriteChar                       ; print space   
    LOOP printLoop

    pop ebp 
    ret 8                                ; clear stack
print_arr endp

; ================================================
; void sort_arr(arr_addr,arr_len)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   sort the array
;

sort_arr proc
    push ebp 
    mov ebp, esp 
    push edi
    mov esi, [ebp +  8]                 ; array address 
    mov ecx, [ebp + 12]                 ; array length
sortL: 
    mov ebx, ecx 
    mov edi, esi

    ;for (i = 0; i < length i++)
    ;{
    ;   for(k = i + 1; i < length; k++)
    ;       compare_and_swap(x_addr, y_addr);
    ;} 
    ; FOR LOOP AND NESTED FOR LOOP
    compareSwapLoop:
        add edi, TYPE DWORD 
        push edi                        ; pass second element y
        push esi                        ; pass first element x 
        call compare_and_swap
        LOOP compareSwapLoop

    mov ecx, ebx 
    add esi, TYPE DWORD                 ; next arr index 
    LOOP sortL 

    pop edi
    pop ebp 
    ret 8                               ; clear stack 
    
   ; YOU NEED TO CALL COMPARE_AND_SWAP PROCEDURE 

sort_arr endp

; ===============================================
; void compare_and_swap(x_addr,y_addr)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;  compare and call SWAP ONLY IF Y < X 
;
compare_and_swap proc
    push ebp  
    mov ebp, esp 

    push eax
    push ebx 
    push ecx
    push edi

    mov eax, [ebp +  8]                 ; second element &y 
    mov ebx, [ebp + 12]                 ; first element &x
    mov edi, [eax]                      ; y 
    mov ecx, [ebx]                      ; x 

    ;;;;;;;;;;;;;;;;;;;;;;
	;	if(y < x)
	;		swap(x, y)
	;;;;;;;;;;;;;;;;;;;;;;
    cmp ecx, 0 
    je nswp
    cmp edi, ecx 
    jbe nswp 

    push eax  
    push ebx 
    call swap 

nswp: 
    pop edi
    pop ecx
    pop ebx 
    pop eax
    pop ebp 
    ret 8                              ; clear stack
compare_and_swap endp

; =================================================
; void swap(x_addr, y_addr)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;  swap the two inputs

swap proc
    push ebp
    mov ebp, esp 

    push eax
    push ebx
    push ecx 
    push edi 

    ; swap algorithim 
    ; temp = x
    ; x = y 
    ; y = temp 
    mov ebx, [ebp +  8]
    mov eax, [ebp + 12]
    mov ecx, [eax]
    mov edi, [ebx]
    mov [ebx], ecx
    mov [eax], edi 

    pop edi
    pop ecx 
    pop ebx 
    pop eax 

    pop ebp 
    ret 8 
   ; FILL YOUR CODE HERE

swap endp


end main

; SAMPLE RUN
Comment!
After each element press enter:
1
4
3
8
99
76
34
5
2
17
0
Initial array:
1 4 3 8 99 76 34 5 2 17
Array sorted in ascending order:
1 2 3 4 5 8 17 34 76 99
!