INCLUDE emu8086.inc

org 100h

PRINT "ENTER ARRAY ELEMENTS:"

MOV BX,05h
LEA SI,arr1

L1: CALL SCAN_NUM
CALL CLEAR_SCREEN
MOV [SI],CX
INC SI
DEC BX
JNZ L1



CALL mergesort



MOV AH,00h
LEA SI, arr1
MOV CX,0005h

L2: MOV AL,[SI]
CALL PRINT_NUM
PRINT " "
INC SI
DEC CX
JNZ L2


ret  


mergesort PROC 

    mov si, 0001h;curr_size
    mov cl, n
    dec cl
    mov ch, 00h
    mov m,cl
    L3: mov cx, si
    cmp cl, m ; curr_size<n-1
    jg finish
    
    mov di, 0000h; left_start
    L5: mov cl, m
    mov ch,00h
    cmp di, cx ;left_start<n-1
    jge L4
        mov ax, di ;ax(mid)
        add ax, si
        dec ax   ; ax = di+si-1
        mov mid, al
        
        mov dx, 0002h
        mov ax, si
        mul dx
        dec ax
        add ax, di
        cmp ax, cx ;min(left_start + 2*curr_size - 1, n-1)
        jg L6  
        mov rightend, al
        jmp L7
        
        
        L6: mov rightend, cl
          
        L7: 
        mov dx, di
        mov leftstart, dl 
        call merge
        
        mov dx, 0002h
        mov ax, si
        mul dx ; ax = 2*currsize
        mov bl, leftstart
        mov di, bx
        add di, ax
        
        jmp L5
        
        
        
    
    

    L4:  ;curr_size = 2*curr_size
    mov dx, 0002h
    mov ax, si
    mul dx
    mov si, ax
    jmp L3
    finish:
    ret
mergesort endp

merge PROC
    mov al, mid
    sub al, leftstart
    inc al
    mov n1, al
    
    mov al, rightend
    sub al, mid
    mov n2, al
  
    mov al, n1
    mov ah, 00h
    mov cx, ax
    mov si, 00h
    mov bl, leftstart
    mov bh, 00h
    for1:
        mov dl, arr1[bx+si]
        mov arr2[si], dl
        inc si
        dec cx
        jnz for1
    
    mov al, n2
    mov ah, 00h
    mov cx, ax
    mov si, 00h
    mov bl, mid
    inc bl
    mov bh, 00
    for2:
        mov dl, arr1[bx+si]
        mov arr3[si], dl
        inc si
        dec cx
        jnz for2
        
    mov si, 00h;i
    mov di, 00h;j
    mov bl, leftstart
    mov bh, 00h;bx=k
    
    while1:
        mov cl, n1
        mov ch, 00h
        cmp si, cx
        jge endwhile1n2
        mov cl, n2
        mov ch, 00h
        cmp di, cx
        jge endwhile1n1
    
        mov dl, arr2[si]
        cmp dl, arr3[di]
        jg endif1
        mov dl, arr2[si]
        mov arr1[bx], dl
        inc si
        jmp endelse
    
    
    endif1:
        mov dl, arr3[di]
        mov arr1[bx], dl
        inc di
    
    
    endelse:
    inc bx
    jmp while1
    
    
    
             
    
    
    endwhile1n1:
        mov cl, n1
        mov ch, 00h
            while2: cmp si, cx
            jge endmerge
            mov dl, arr2[si]
            mov arr1[bx], dl
            inc si
            inc bx
            jmp while2
        
        
            
    
    endwhile1n2:
        mov cl, n2
        mov ch, 00h
            while3: cmp di, cx
            jge endmerge
            mov dl, arr3[di]
            mov arr1[bx], dl
            inc di
            inc bx
            jmp while3
    
    endmerge:     
    ret
merge endp
    


currsize db ?
leftstart db ?
n db 5
m db ?
n1 db ?
n2 db ?
mid db ?
rightend db ?

arr1 db 5 DUP(?)
arr2 db 5 DUP(?)
arr3 db 5 DUP(?)


DEFINE_PRINT_STRING
DEFINE_GET_STRING
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_NUM
DEFINE_CLEAR_SCREEN