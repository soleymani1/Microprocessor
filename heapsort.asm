
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
INCLUDE emu8086.inc
org 100h


LEA SI,AR2
CALL PRINT_STRING

MOV BX,05h
LEA SI,arr

L2: CALL SCAN_NUM
CALL CLEAR_SCREEN
MOV [SI],CX
INC SI
DEC BX
JNZ L2


call heapsort


MOV AH,00h
LEA SI,arr
MOV CX,0005h

L3: MOV AL,[SI]
CALL PRINT_NUM
PRINT " "
INC SI
DEC CX
JNZ L3




ret

heapify proc
    
    mov al, j
    mov largest, al
    mov dl, 02h
    mul dl
    inc al
    mov l, al
    inc al
    mov r, al
    
    mov al, l
    cmp al, m
    jge if2
    mov bl, l
    mov bh, 00h
    mov si, bx ;si=l
    mov bl, largest
    mov bh, 00h
    mov di, bx ;di=largest
    mov dl, arr[si]
    cmp dl, arr[di]
    jle if2
    mov al, l
    mov largest, al 
    
    if2:
        mov al, r
        cmp al, m
        jge if3
        mov bl, r
        mov bh, 00h
        mov si, bx ;si=r
        mov bl, largest
        mov bh, 00h
        mov di, bx ;di=largest
        mov dl, arr[si]
        cmp dl, arr[di]
        jle if3
        mov al, r
        mov largest, al
        
    if3:
        mov bl, largest
        cmp bl, j
        je endif3
        
        mov bl, j
        mov bh, 00h
        mov si, bx;j
        mov dl, arr[si];arr[j]
        mov bl, largest
        mov bh, 00h
        mov di, bx;largest
        mov dh, arr[di]
        mov arr[si], dh
        mov arr[di], dl
        
        mov al, largest
        mov j, al
        call heapify
        
        
          
    
    
    endif3:
    ret
endp


heapsort proc
    mov al, n
    mov dl, 02h
    div dl
    dec al
    mov i, al
    for1: CMP i, 0000h
        jl next
        mov al, n
        mov m, al
        mov ah, i
        mov j, ah 
        CALL heapify
        dec i
        jmp for1
        
     
    next: mov al, n
        dec al
        mov i, al
    for2: cmp i, 0000h
        jl endfor2
        
        mov bl, i
        mov bh, 00h
        mov dl, arr[0000h]
        mov dh, arr[bx]
        mov arr[0000h], dh
        mov arr[bx], dl
        
        mov j,00h
        mov al, i
        mov m, al 
        call heapify
        
        dec i
        jmp for2


    endfor2:
    ret
endp

n db 5
i db ?
m db ?
j db ?
largest db ?
l db ?
r db ?
AR2 db "ENTER ARRAY ELEMENTS:",0
arr db 5 DUP(?)



DEFINE_PRINT_STRING
DEFINE_GET_STRING
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_NUM
DEFINE_CLEAR_SCREEN