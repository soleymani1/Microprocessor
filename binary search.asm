
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
INCLUDE emu8086.inc

org 100h 


LEA SI,AR2
CALL PRINT_STRING

MOV BX,05h
LEA SI,array

L2: CALL SCAN_NUM
CALL CLEAR_SCREEN
MOV [SI],CX
INC SI
DEC BX
JNZ L2


LEA SI,AR3
CALL PRINT_STRING

LEA SI,data
CALL SCAN_NUM
CALL CLEAR_SCREEN
MOV [SI],CX




CALL find

ret

find proc
    
   ;int find(int data) {
   ;int lowerBound = 0;
   ;int upperBound = MAX -1;
   ;int midPoint = -1;
   ;int comparisons = 0;      
   ;int index = -1;
	
   ;while(lowerBound <= upperBound) {
   ;   printf("Comparison %d\n" , (comparisons +1) );
   ;   printf("lowerBound : %d, intArray[%d] = %d\n",lowerBound,lowerBound,
   ;      intArray[lowerBound]);
   ;   printf("upperBound : %d, intArray[%d] = %d\n",upperBound,upperBound,
   ;      intArray[upperBound]);
   ;   comparisons++;
		
   ;   // compute the mid point
   ;   // midPoint = (lowerBound + upperBound) / 2;
   ;   midPoint = lowerBound + (upperBound - lowerBound) / 2;	
		
   ;   // data found
   ;   if(intArray[midPoint] == data) {
   ;      index = midPoint;
   ;      break;
   ;   } else {
   ;      // if data is larger 
   ;      if(intArray[midPoint] < data) {
   ;         // data is in upper half
   ;         lowerBound = midPoint + 1;
   ;      }
   ;      // data is smaller 
   ;      else {
   ;         // data is in lower half 
   ;         upperBound = midPoint -1;
   ;      }
   ;   }               
   ;}
   ;printf("Total comparisons made: %d" , comparisons);
   ;return index;
;}   
    while:
    mov ax, lowerBound
    cmp ax, upperBound
    jg notFound
    add ax, upperBound
    mov dl, 02h
    div dl
    mov ah,00h
    mov midPoint,ax
    mov bx, midPoint
    mov dl, 0h
    mov dl, array[bx]
    cmp dl, data
    je equal
    jg greater
    jl less
    
    
    equal:
      jmp found
      
      
    less: 
        mov bx, midPoint
        inc bx
        mov lowerbound, bx
        jmp while
        
    
    greater:
      mov bx, midPoint
      dec bx
      mov upperBound, bx
      jmp while
    
     
    
    
    
    
    found:
      LEA SI,foundv
      CALL PRINT_STRING
      jmp L3
    notFound:
      LEA SI,notFoundv
      CALL PRINT_STRING
      
    L3:
    ret
endp
foundv db "FOUND",0
notFoundv db "NOT FOUND",0
lowerBound DW 00h
upperBound DW 04h
midPoint DW ?
max DW 05h
array db 5 DUP(?)
AR2 db "ENTER ARRAY ELEMENTS:",0
AR3 db "ENTER DATA TO SEARCH:",0
data db ?


DEFINE_PRINT_STRING
DEFINE_GET_STRING
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_NUM
DEFINE_CLEAR_SCREEN