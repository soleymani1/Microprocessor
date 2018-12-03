
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
INCLUDE emu8086.inc

org 100h

LEA SI,AR2
CALL PRINT_STRING

MOV BX,05h
LEA SI,arr1

L1: CALL SCAN_NUM
CALL CLEAR_SCREEN
MOV [SI],CX
INC SI
DEC BX
JNZ L1


call sort


MOV AH,00h
LEA SI,arr1
MOV CX,0005h
L2: MOV AL,[SI]
CALL PRINT_NUM
PRINT " "
INC SI
DEC CX
JNZ L2

ret


merge proc
;void merge(int arr[], int l, int m, int r)
;    {
;        // Find sizes of two subarrays to be merged
;        int n1 = m - l + 1;
;        int n2 = r - m;
;        

    mov al, med
    sub al, low
    inc al
    mov n1, al
    
    mov al, high
    sub al, med
    mov n2, al
    
;        /* Create temp arrays */
;        int L[] = new int [n1];
;        int R[] = new int [n2];
; 
;       /*Copy data to temp arrays*/
;       for (int i=0; i<n1; ++i)
;            L[i] = arr[l + i];
;        for (int j=0; j<n2; ++j)
;            R[j] = arr[m + 1+ j];
;   
    mov al, n1
    mov ah, 00h
    mov cx, ax
    mov si, 00h
    mov bl, low
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
    mov bl, med
    inc bl
    mov bh, 00
    for2:
        mov dl, arr1[bx+si]
        mov arr3[si], dl
        inc si
        dec cx
        jnz for2
        
    
; 
;        /* Merge the temp arrays */
; 
;        // Initial indexes of first and second subarrays
;        int i = 0, j = 0;
; 
;        // Initial index of merged subarry array
;        int k = l;
;        while (i < n1 && j < n2)
;       {
;            if (L[i] <= R[j])
;            {
;                arr[k] = L[i];
;                i++;
;            }
;            else
;            {
;                arr[k] = R[j];
;                j++;
;            }
;            k++;
;        }
;        

    mov si, 00h;i
    mov di, 00h;j
    mov bl, low
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
    
;        /* Copy remaining elements of L[] if any */
;        while (i < n1)
;        {
;            arr[k] = L[i];
;            i++;
;            k++;
;        }
; 
;        /* Copy remaining elements of R[] if any */
;        while (j < n2)
;        {
;            arr[k] = R[j];
;            j++;
;            k++;
;        }
;    }

    endmerge:     
    ret
merge endp

sort proc
;    void sort(int arr[], int l, int r)
;   {
;       if (l < r)
;        {
;            // Find the middle point
;            int m = (l+r)/2;
; 
;            // Sort first and second halves
;            sort(arr, l, m);
;            sort(arr , m+1, r);
; 
;            // Merge the sorted halves
;            merge(arr, l, m, r);
;        }
;    }
    ;pop ax
    ;pop bx
    ;mov r,bl
    
    mov al, l
    cmp al, r
    jge endif
    mov ah, r
    add al, ah
    mov ah, 00h
    mov dl, 02h
    div dl
    mov m, al
        
    mov dl, r ;to keep r
    mov rt, dl
    mov r, al
    
    mov al, l
    mov ah, 00h
    push ax
    mov al, m
    mov ah, 00h
    push ax
    mov al, rt
    mov ah, 00h
    push ax

    ;mov ah, 00h
    ;mov dl, l
    ;mov dh, 00h
    ;push dx
    ;push ax
    call sort
    
    pop ax
    mov r, al
    pop ax
    mov m, al
    
    mov ah,00h
    push ax
    
    mov al, r
    mov ah, 00h
    push ax
    
    ;mov dl, l ;to keep l
    ;mov l2, dl
    ;pop ax
    ;mov m, al
    ;push ax
    mov dl, m
    inc dl
    mov l, dl
    ;;;mov dl, rt
    ;;;mov r, dl
    ;;;mov dh,00h
    ;;;push dx
    call sort
    ;mov al, l
    ;mov low, al
    ;mov al, m
    ;mov med, al
    ;mov al, r
    ;mov high, al
    pop ax
    mov high, al
    pop ax
    mov med, al
    pop ax
    mov low, al 
    call merge    
        
    endif:
    ret
sort endp

l db 00h;change to ?
r db 04h;change to ?
rt db ? ; to keep r
m db ?
low db ?
med db ?
high db ?
arr1 db 6 DUP(?)
arr2 db 5 DUP(?)
arr3 db 5 DUP(?)
n1 db ?
n2 db ?
AR2 db "ENTER ARRAY ELEMENTS:",0

DEFINE_PRINT_STRING
DEFINE_GET_STRING
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_NUM
DEFINE_CLEAR_SCREEN