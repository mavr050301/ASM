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
err3 db  0Dh,0Ah,"Cannot be divided by zero$"
opr db '?'

num1 dw ?
num2 dw ? 
ten             DW      10   
flag_minus_1      DB      ? 
flag_minus_2      DB      ?  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_num_plus       proc    near
        push    dx
        push    ax

        cmp     ax, 0
        jnz     not_zero

        putc    '0'
        jmp     printed

not_zero:
       cmp flag_minus_1,0
       je firstpositive           ;;;
       jmp firstnegative                    
        
        
                               ;;;
       firstpositive:
       cmp flag_minus_2,0
       je positive
       push ax
       neg num2
       mov ax,num2
       cmp num1,ax
       ja gopositive
       jmp makeneg
       
       gopositive:
       pop ax
       jmp positive
       
       
       firstnegative:
       cmp flag_minus_2,0
       je secondpositive
       jmp makenegoutpop 
       
       secondpositive:
       push ax
       neg num1
       mov ax,num1
       cmp ax,num2
       ja makeneg
       jmp gopositive
         
         
      
      
       makeneg:
       pop ax 
       makenegoutpop:
       neg     ax
       putc    '-'
       jmp positive
       
                      
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
        jnz     not_zeromin

        putc    '0'
        jmp     printed

not_zeromin:  
       cmp flag_minus_1,0
       je firstpositivemin 
       jmp firstnegativemin 
        
        
        
       firstpositivemin:
       cmp flag_minus_2,0
       je secondpositivemin 
       jmp positivemin
        
        
       firstnegativemin:
       cmp flag_minus_2,0
       je makejustnegmin 
       push ax
       mov ax,num1
       cmp ax,num2
       ja makenegmin 
       jmp makenegoutpopmin 
       secondpositivemin:
       push ax
       mov ax,num1
       cmp ax,num2
       ja makenegmin
       jmp makenegoutpopmin
       
       makenegmin:
       pop ax
       jmp positivemin 
       makenegoutpopmin:
       pop ax
       makejustnegmin:
       neg ax
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
        push ax
        xor ax,ax
        mov al,flag_minus_1
        xor al,flag_minus_2
        cmp al,1
        je makemulneg 
        jmp positivemul 
        
        makemulneg: 
        putc    '-'    
positivemul:
        pop ax
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
       push ax
        xor ax,ax
        mov al,flag_minus_1
        xor al,flag_minus_2
        cmp al,1
        je makedivneg 
        jmp positivediv 
        
        makedivneg: 
        putc    '-'     
positivediv:
        pop ax
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
        jae     ok_by_0
        jmp     remove_not_digit
ok_by_0:        
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
        cmp cx,32767         
        ja over                   
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

checkflags proc

checknum1:
cmp num1,32767
ja setflag1

checknum2:
cmp num2,32767
ja setflag2
jbe exitflag 
setflag1: 
mov flag_minus_1,1 
jmp checknum2
setflag2: 
mov flag_minus_2,1 

exitflag:
ret
    
checkflags endp
;;;;;;;;;;;;;;;;;;START;;;;;;;;;;;;;;;;
start: 
lea dx, msg1
mov ah, 09h   
int 21h  
call Input
mov num1, cx
jmp nextnumber
over:
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
;;;;;;;;;;;;;;;;; 

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
call checkflags 
call print_num_plus   

jmp exit


;;;;;;;;;;;;;;;;;
minus:

mov ax, num1
sub ax, num2 
call checkflags 
call print_num_minus    
jmp exit



;;;;;;;;;;;;;;;;;;;;;;
mult:
call checkflags
  
cmp flag_minus_1,1
je makenum1pos
jmp checknum2mul 

makenum1pos:
neg num1

checknum2mul:
cmp flag_minus_2,1
je makenum2pos  
jmp gomul 

makenum2pos:
neg num2
  
gomul:

mov ax, num1
mul num2
jc overmul 
jmp printmul

overmul:
lea dx, overflow
mov ah, 09h   
int 21h
jmp exit 

printmul:
call print_num_mul    
jmp exit


;;;;;;;;;;;;;;;;;;;;;;;;;;;

divv: 
call checkflags
  
cmp flag_minus_1,1
je makenum1posdiv
jmp checknum2div 

makenum1posdiv:
neg num1

checknum2div:
cmp flag_minus_2,1
je makenum2posdiv  
jmp godiv 

makenum2posdiv:
neg num2
  
godiv:
xor dx,dx
cmp num2,0
je overdiv
mov ax, num1
div num2  
jmp printdiv

overdiv:
lea dx, err3
mov ah, 09h   
int 21h
jmp exit  

printdiv:
call print_num_div 
jmp exit
 end start   
