
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
INCLUDE emu8086.inc

org 100h

LEA SI,AR2
CALL PRINT_STRING

MOV BX,05h
LEA SI,arr

L1: CALL SCAN_NUM
CALL CLEAR_SCREEN
MOV [SI],CX
INC SI
DEC BX
JNZ L1


call quicksort


MOV AH,00h
LEA SI,arr
MOV CX,0005h

L2: MOV AL,[SI]
CALL PRINT_NUM
PRINT " "
INC SI
DEC CX
JNZ L2

ret

quicksort proc
    
    mov al, low
    cmp al, high
    jge afterif
    
    mov al, low
    mov ah, high
    mov low2, al
    mov high2, ah
    call partition
    mov al, pi
    dec al
    mov ah, high
    mov hightemp, ah
    mov high, al
    call quicksort
    
    mov al, pi
    inc al
    mov low, al
    mov ah, hightemp
    mov high, ah
    call quicksort 
    
    
        
    
    
    afterif:
    ret
quicksort endp

partition proc

    mov bl, high2
    mov bh, 00h
    mov dl, arr[bx]
    mov pivot, dl
    mov al, low2
    dec al
    mov i, al
    
    mov al, low2
    mov j, al
    for: mov al, j 
        cmp al, high2               
        jge afterfor 
        mov bl, j
        mov bh, 00h
        mov dl, arr[bx]
        cmp dl, pivot
        jg afterif2
        inc i
        mov bl, i
        mov bh, 00h
        mov si, bx
        mov bl, j
        mov bh, 00h
        mov di, bx
        mov dl, arr[si]
        mov dh, arr[di]
        mov arr[di], dl
        mov arr[si], dh
        
    
    
        afterif2: inc j
        jmp for
        
    
    afterfor:
        mov bl, i
        mov bh, 00h
        inc bl
        mov si, bx
        mov bl, high2
        mov bh, 00h
        mov di, bx
        
        mov dl, arr[si]
        mov dh, arr[di]
        mov arr[si], dh
        mov arr[di], dl
        
        mov ah, i
        inc ah
        mov pi, ah
    
    ret
partition endp


low db 0h
high db 04h
hightemp db ?
low2 db ?
high2 db ?
pi db ?
pivot db ?
i db ?
j db ?
arr db 6 DUP(?)
AR2 db "ENTER ARRAY ELEMENTS:",0


DEFINE_PRINT_STRING
DEFINE_GET_STRING
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_NUM
DEFINE_CLEAR_SCREEN