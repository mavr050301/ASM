.model tiny
.code 
putc    macro   char
        push    ax
        mov     al, char
        mov     ah, 0Eh
        int     10h     
        pop     ax
endm
org 100h 
jmp start
overflow db  0Dh,0Ah,"Overflow$"
msg1 db  0Dh,0Ah, 'enter first number: $'
msg2 db 0Dh,0Ah,"enter the operator:    +  -  *  /     : $"
msg3 db 0Dh,0Ah,"enter second number: $"
msg4 db  0dh,0ah , 'Result  : $' 
err1 db  0Dh,0Ah,"wrong operator!", 0Dh,0Ah , '$' 
err2 db  0Dh,0Ah,"Wrong number$"

opr db '?'

num1 dw ?
num2 dw ? 
num3 dw ? 
check1 dw ?
check2 dw ? 
ten             DW      10  
print_num_plus       proc    near
        push    dx
        push    ax

        cmp     ax, 0
        jnz     not_zero

        putc    '0'
        jmp     printed

not_zero:
        cmp     num1, 32768
        jbe maybepositive 
        jae maybe
        jmp positive
        negativ:
        neg     ax
        putc    '-'
        jmp positive
maybepositive:
        cmp num2, 32768
        jbe positive 
        jmp positive
maybe:
 cmp num2, 32768
 jbe positive
 jae negativ             
positive:

        call    print_num_uns
printed:
        pop     ax
        pop     dx
        ret
print_num_plus       endp 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_num_minus       proc    near
        push    dx
        push    ax

        cmp     ax, 0
        jnz     not_zer

        putc    '0'
        jmp     printed

not_zer:  
         cmp     num1, 32768
         jbe maybepositivemin    
         jae negativmin
         maybepositivemin:
         cmp     num2, 32768
         jbe checksign 
         jae positivemin
         
         checksign:
         push ax
         mov ax,num1
         cmp ax,num2
         pop ax
         jae positivemin 
         
         negativmin:
         cmp     num2, 32768
         jae positivemin
         neg     ax
         putc    '-'
         jmp positivemin             
positivemin:

        call    print_num_uns
printedmin:
        pop     ax
        pop     dx
        ret
print_num_minus       endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

print_num_mul       proc    near
        push    dx
        push    ax

        cmp     ax, 0
        jnz     not_zeromul

        putc    '0'
        jmp     printed

not_zeromul:
        cmp     num1, 32768
        jbe maybepositivemul 
        jae maybenegativemul
maybepositivemul:
        cmp num2, 32768
        jbe positivemul
        jae convertmul
maybenegativemul:
        cmp num2, 32768
        jbe convertmul
        jae positive 
        convertmul:  
        neg     ax
        putc    '-'
        jmp positivemin     
positivemul:

        call    print_num_uns
printedmul:
        pop     ax
        pop     dx
        ret
print_num_mul       endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_num_div       proc    near
        push    dx
        push    ax

        cmp     ax, 0
        jnz     not_zerodiv

        putc    '0'
        jmp     printed

not_zerodiv:
        cmp     num1, 32768
        jbe maybepositivediv 
        jae maybenegativediv
maybepositivediv:
        cmp num2, 32768
        jbe positivediv
        jae convertdiv
maybenegativediv:
        cmp num2, 32768
        jbe convertdiv
        jae positivediv 
        convertdiv:  
        putc    '-'
        jmp positivediv     
positivediv:

        call    print_num_uns
printeddiv:
        pop     ax
        pop     dx
        ret
print_num_div       endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_num_uns   proc    near
        push    ax
        push    bx
        push    cx
        push    dx

       
        mov     cx, 1
        mov     bx, 10000      
        cmp     AX, 0
        jz      print_zero

begin_print:

        cmp     bx,0
        jz      end_print

        cmp     cx, 0
        je      calc
        cmp     ax, bx
        jb      skip
calc:
        mov     cx, 0   

        mov     dx, 0
        div     bx       
        add     al, 30h    
        putc    al
        mov     ax, dx  

skip:
        push    ax
        mov     dx, 0
        mov     ax, bx
        div     CS:ten  
        mov     bx, ax
        pop     ax

        jmp     begin_print
        
print_zero:
        putc    '0'
        
end_print:

        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
print_num_uns   endp
  Input        proc    near
        push    dx
        push    ax
        push    si
        
        mov     cx, 0

        
        mov     make_minus, 0

next_digit:

        mov     ah, 00h
        int     16h
        mov     ah, 0Eh
        int     10h

        cmp     al, '-'
        je      set_minus

       
        cmp     al, 0Dh  
        jne     not_cr
        jmp     stop_input
not_cr:


        cmp     al, 8                   
        jne     backspace_checked
        mov     dx, 0                   
        mov     ax, cx                 
        div     CS:ten                  
        mov     cx, ax
        putc    ' '                     
        putc    8                       
        jmp     next_digit
backspace_checked:


        
        cmp     al, '0'
        jae     ok_AE_0
        jmp     remove_not_digit
ok_AE_0:        
        cmp     al, '9'
        jbe     ok_digit
remove_not_digit:       
        putc    8       
        putc    ' '     
        putc    8            
        jmp     next_digit       
ok_digit:


      
        push    ax
        mov     ax, cx
        mul     CS:ten                  
        mov     cx, ax
        pop     ax

        cmp     dx, 0
        jne     too_big

        sub     al, 30h

        mov     ah, 0
        mov     dx, cx      
        add     cx, ax
        jc      too_big2    

        jmp     next_digit

set_minus:
        mov     CS:make_minus, 1
        jmp     next_digit

too_big2:
        mov     cx, dx      
        mov     dx, 0      
too_big:
        mov     ax, cx
        div     CS:ten  
        mov     cx, ax
        putc    8       
        putc    ' '     
        putc    8             
        jmp    next_digit 
        
        
stop_input:
        cmp     CS:make_minus, 0
        je      not_minus
        neg     CX
not_minus:

        pop     si
        pop     ax
        pop     dx
        ret
make_minus      DB      ?      
Input        endp
start: 

lea dx, msg1
mov ah, 09h   
int 21h  
call Input
mov num1, cx 
jc over
cmp num1,32767
jbe nextnumber
over:
js nextnumber
lea dx, err2
mov ah, 09h   
int 21h
jmp exit 
;;;;;;;;;;;;;;;  
nextnumber:
lea dx, msg2
mov ah, 09h   
int 21h 
mov ah, 1   
int 21h
mov opr, al 
cmp opr, '*'
jb wrong_opr
cmp opr, '/'
ja wrong_opr
;;;;;;;;;;;;;;;;
lea dx, msg3
mov ah, 09h     
int 21h
call Input  
mov num2, cx   
jc over1
cmp num2,32767
jbe nextcom
over1:
js nextcom
lea dx, err2
mov ah, 09h   
int 21h
jmp exit
;;;;;;;;;;;;;;;;; 
nextcom:
lea dx, msg4
mov ah, 09h      
int 21h
;;;;;;;;;;;;;;;;;
cmp opr, '+'
je plus

cmp opr, '-'
je minus

cmp opr, '*'
je mult

cmp opr, '/'
je divv
;;;;;;;;;;;;;;;;;
wrong_opr:
lea dx, err1
mov ah, 09h     
int 21h
;;;;;;;;;;;;;;;;; 
exit:
 mov ax,4C00h
int 21h
;ret
;;;;;;;;;;;;;;;;   
plus:
mov ax, num1
add ax, num2
call print_num_plus   

jmp exit


;;;;;;;;;;;;;;;;;
minus:

mov ax, num1
sub ax, num2
call print_num_minus    
jmp exit



;;;;;;;;;;;;;;;;;;;;;;
mult:
push dx    
xor dx,dx
mov ax, num1
imul num2 
cmp dx,0
je printmul
cmp dx,0FFFFh
je printmul
lea dx, overflow
mov ah, 09h   
int 21h
jmp exit 
printmul:
call print_num_mul    
pop dx
jmp exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;

divv: 
xor dx,dx
mov ax, num1 
cmp num1,32767
jae convert 
cmp num2,32767
jae convert2
 divvv:
cmp num2,32767
jae convert2
idiv num2  
jmp printdiv
divvv1:
idiv num2
neg num2  
jmp printdiv

convert:
neg     ax
jmp divvv 
convert2:
neg num2
jmp divvv1
printdiv:
call print_num_div 
jmp exit
 end start   
