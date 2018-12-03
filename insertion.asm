
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

call insertion_sort

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

insertion_sort proc
    
    mov si, 0001h; si=i
    dec n
    mov cx, n
    for1: mov dl, arr[si]
        mov t, dl
        mov di, si; di=j
        for2: mov bx, di
            dec bx
            mov dl, arr[bx]
            cmp t, dl
            jge afterfor2
            
            mov dl, arr[bx]
            mov arr[di], dl
            dec di
            jnz for2
        afterfor2: mov dl, t
            mov arr[di], dl
            
            inc si
            dec cx
            jnz for1   
    
    ret
endp
      
n dw 0005h      
t db ?
arr db 5 DUP(?)
AR2 DB "ENTER ARRAY ELEMENTS:",0

DEFINE_PRINT_STRING
DEFINE_GET_STRING
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_NUM
DEFINE_CLEAR_SCREEN