.model small 
.stack 100h
.data 
    platform        db 0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h,0DBh,14h 
    platformRight   dw ?         
    platformLeft    dw ?         
    line_title      db 0DBh,0Fh  
    line            dw 0005h     
    ball            db 02h,0Ah     
    size_platform   dw 001Ah                   
    size_line       dw 00A0h                       
    platformLoc     dw 0F50h         
    ballLoc         dw 0FA0h     
    repeat          dw 8F00h     
    endLine         dw 0FA0h     
    byteDivider     db 0002h     
    curX            dw 005Ah     
    curY            dw 0017h     
    vectorX         dw -2h      
    vectorY         dw -1h       
    points          dw 0000h                              
    max_coints      dw 01F4h                     
    points_str      db 10 dup(?)            
    LEN             dw 0                         
    score           db ' ',0Fh,'s',0Ah,'c',0Ah,'o',0Ah,'r',0Ah,'e',0Ah,':',0Ah,' ',0Fh ,' ',0h,' ',07h  ,' ',07h
    size_score      dw 0x0015h 


           
    rules  db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,'C',0Ah,'l',0Ah,'i',0Ah,'c',0Ah,'k',0Ah,' ',0Fh
           db 'o',0Ah,'n',0Ah,' ',0Fh,'t',0Ah,'h',0Ah,'e',0Ah,' ',0Fh,'a',0Ah,'r',0Ah,'r',0Ah,'o',0Ah,'w',0Ah
           db ' ',0Fh,'(',0Fh,'<',0Bh,'-',0Bh,')',0Fh,' ',0Fh,'t',0Ah,'o',0Ah,' ',0Fh,'t',0Ah,'u',0Ah,'r',0Ah
           db 'n',0Ah,' ',0Fh,'l',0Ah,'e',0Ah,'f',0Ah,'t',0Ah,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh 
            
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,'C',0Ah,'l',0Ah,'i',0Ah,'c',0Ah,'k',0Ah,' ',0Fh
           db 'o',0Ah,'n',0Ah,' ',0Fh,'t',0Ah,'h',0Ah,'e',0Ah,' ',0Fh,'a',0Ah,'r',0Ah,'r',0Ah,'o',0Ah,'w',0Ah
           db ' ',0Fh,'(',0Fh,'-',0Bh,'>',0Bh,')',0Fh,' ',0Fh,'t',0Ah,'o',0Ah,' ',0Fh,'t',0Ah,'u',0Ah,'r',0Ah
           db 'n',0Ah,' ',0Fh,'r',0Ah,'i',0Ah,'g',0Ah,'h',0Ah,'t',0Ah,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh  
              
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,'T',0Ah,'o',0Ah,' ',0Fh,'s',0Ah,'t',0Ah,'a',0Ah
           db 'r',0Ah,'t',0Ah,' ',0Fh,'t',0Ah,'h',0Ah,'e',0Ah,' ',0Fh,'g',0Ah,'a',0Ah,'m',0Ah,'e',0Ah,' ',0Fh 
           db 'p',0Ah,'r',0Ah,'e',0Ah,'s',0Ah,'s',0Ah,' ',0Fh,'a',0Ah,'n',0Ah,'y',0Ah,' ',0Fh,'k',0Ah,'e',0Ah
           db 'y',0Ah,'!',0Ah,'!',0Ah,'!',0Ah
           
    size_rules dw 01A8h   
    
    game_over   db 'G',0Ah,'A',0Ah,'M',0Ah,'E',0Ah,' ',0h,'O',0Ah,'V',0Ah,'E',0Ah,'R',0Ah
    winner      db 'W',0Ah,'I',0Ah,'N',0Ah 
    flag        db 0
    curSpeed    dw 8F00h           
    
    SPA     equ 20h                       
    PL      equ 0FEh                  
   
    LEFT    equ 4B00h     
    RIGHT   equ 4D00h       
    ENTER   equ 1C0Dh    
    
.code 
 start:   
    main1: 
    call begin         
    call cursorHide    
    call clearScreen   
    call drawRules     
    call drawTitle     
    call drawScore     
    call points_show   
    call drawPlatform  
    call drawBall      
    call drawBreaks    
    call go             
 main:                 
    mov cx,[repeat]           
  cycle:  
    call movePlatform  
    dec cx             
    cmp cx, 0          
    jne cycle                 
    call moveBall            
    call drawBall      
    jmp main           
     
    begin:
        mov ax,@data
        mov ds, ax
        mov ah,00                         
        mov al,03     
        int 10h      
        
        push 0B800h              
        pop es                   
        mov ax, [platformLoc]                  
        mov [platformLeft], ax             
        mov [platformRight], ax  
        mov ax, [size_platform]           
        add [platformRight],ax             
        ret
     go:
        mov ah, 00h               
        int 16h   
     cursorHide:                  
        mov ah,1                 
        mov cx, 2000h             
        int 10h 
        ret
     drawScore:
        mov di, 00h           
        lea si, score         
        mov cx, [size_score]  
        rep movsb            
        ret
     drawTitle:                 
        xor ax, ax         
        mov ax, 0001h     
        mul [size_line]          
        mov di, ax         
        add ax, size_line  
     cycle_:                 
        cmp di, ax                   
        je return                    
        mov si, offset line_title  
        mov cx, 2                  
        rep movsb                 
        jmp cycle_                 
     clearScreen:               
        mov ah,6       
        mov al,0                 
        mov bh,7                   
        xor cx,cx                 
        mov dl,79            
        mov dh,24      
        int 10h
        ret
     drawBreaks:
                    
        mov ax, [line]        
        mul [size_line]        
        mov bx, ax               
        add ax, [size_line]    
        mov cx, 0032h             
     loopl:         
        call drawBlock      
        call drawSpace       
        dec cx                 
        cmp cx, 0           
        je return            
        cmp bx, ax            
        jge new_line        
        jmp loopl           
     new_line:                   
        add ax, [size_line]   
        add [line],1           
        push ax             
        mov ax, [line]      
        div [byteDivider]   
        cmp ah, 1           
        je step                
        add bx, 8             
        pop ax              
        jmp loopl               
     step:
        pop ax              
        mov bx, ax          
        sub bx, [size_line]     
        jmp loopl           
     drawBlock:                 
        push cx              
        mov cx, 0004h           
     drawBlock2:                      
        mov es:[bx], PL       
        mov es:[bx+1], 042h    
        add bx, 2               
        dec cx                
        cmp cx, 0                     
        jne drawBlock2        
        pop cx                    
        ret
     drawSpace:                     
        push cx             
        mov cx, 0004h       
     drawSpace2:
        mov es:[bx], SPA       
        mov es:[bx+1], 0h   
        add bx, 2          
        dec cx              
        cmp cx, 0           
        jne drawSpace2      
        pop cx              
        ret  
     drawPlatform:                  
        mov di, [platformLoc]      
        mov cx, [size_platform]    
        mov si, offset platform    
        cld
        rep movsb                  
        ret  
     movePlatform:             
        mov ah, 01h           
        int 16h                  
        jnz checkKey            
        ret
     checkKey:                  
        mov ah, 00h             
        int 16h 
        cmp ax, RIGHT           
        je  go_right           
        cmp ax, LEFT            
        je  go_left             
        ret
     go_right:                            
        mov bx, [platformLoc]          
        add bx, [size_platform]          
        cmp bx, [endLine]               
        jge movePlatform               
        mov es:[bx],PL                 
        mov es:[bx+1], 044h            
        mov bx, [platformLoc]          
        mov es:[bx],SPA                
        mov es:[bx+1],0h               
        add [platformLoc],2            
        add [platformRight], 2         
        add [platformLeft], 2           
        jmp movePlatform               
     go_left:                          
        cmp [platformLoc], 0F00h        
        jle movePlatform             
        sub [platformLoc], 2        
        sub [platformRight], 2      
        sub [platformLeft], 2           
        mov bx, [platformLoc]       
        add bx, [size_platform]         
        mov es:[bx],SPA             
        mov es:[bx+1],0h            
        mov bx, [platformLoc]            
        mov es:[bx],PL              
        mov es:[bx+1], 044h         
        jmp movePlatform            
     drawBall:
        xor bx, bx               
        mov bx, [ballLoc]        
        xor ax, ax              
        mov ax, [curY]           
        mul [size_line]          
        add ax, [curX]          
        mov [ballLoc], ax        
        cmp ax, bx             
        je return             
        mov di, ax               
        mov si, offset ball      
        mov cx, 2                
        cld                      
        rep movsb                
        mov es:[bx], SPA         
        mov es:[bx+1], 0h        
        ret     
        
    
     changeVectorY:          
        neg [vectorY]            
        jmp checkBorderX  
   
     changeVectorX: 
        neg [vectorX]
        jmp next  
        
     moveBall:     
                  
     checkBorderY:             
        cmp [curY], 2          
        je changeVectorY  
     
     checkBorderX:              
        xor dx, dx               
        mov dx, [size_line]    
        sub dx, [vectorX]        
        cmp [curX], dx         
        jge  changeVectorX      
        cmp [curX], 0          
        jle  changeVectorX     
     next:                       
        xor ax, ax  
        mov ax, [curY]          
        add ax, [vectorY]       
        mov [curY], ax          
        xor bx, bx
        mov bx, [curX]          
        add bx, [vectorX]       
        cmp bx, 0               
        jl back1
      next1:  
        mov [curX], bx          
        mul [size_line]          
        add ax, bx              
        mov di, ax
        push di
        mov ax, es:[di]         
        
     
     next2:  
        pop di
        mov ax, es:[di]
        cmp al, PL        
        je back_move      
        cmp [curY], 0019h          
        je gameOver
        cmp al, 0FEh           
        jne check_go_awake      
        ret  
     back1:                   
        neg [vectorX]            
        add bx, [vectorX]      
        add bx, [vectorX]      
        jmp next1   
     back_move: 
        call checkBrick       
        neg [vectorY]                    
        neg [vectorX]            
        mov ax, [curY]           
        add ax, [vectorY]      
        mov [curY], ax           
        mov ax, [curX]           
        add ax, [vectorX]      
        mov [curX], ax          
        neg [vectorX]            
        call checkChangeVector  
        ret 
               
     
     checkChangeVector:           
        mov dx, [platformLeft]       
        sub dx, [size_line] 
        cmp dx, [ballLoc]       
        je decVectorX               
        add dx, 2                
        cmp dx, [ballLoc]
        je decVectorX               
        add dx, 2
        cmp dx, [ballLoc]       
        je decVectorX               
        
        mov dx, [platformRight] 
        sub dx, [size_line]     
        cmp dx, [ballLoc]
        je incVectorX                
        sub dx, 2
        cmp dx, [ballLoc]
        je incVectorX                
        sub dx, 2
        cmp dx, [ballLoc]
        je incVectorX                
        ret
     decVectorX:  
        sub [vectorX], 2
        ret
     incVectorX:  
        add [vectorX], 2
        ret 
     
                                                      
     checkBrick:                
        cmp [curY],0018h        
        je return             
        mov ax, [curY]         
        mul [size_line]        
        mov bx, ax             
        add bx, [curX]        
     loop1:                           
        sub bx, 2               
        cmp bx, ax
        jl go1
        cmp es:[bx], SPA   
        jne loop1           
     go1:                       
        add bx, 2             
        call drawSpace
        add [points],10            
        call points_show     
        
     return:
        ret  
            
     gameOver:            
        call clearScreen         
        mov ax,000Ah
        mul [size_line]
        add ax,0048h
        mov di, ax
        mov si, offset game_over
        mov cx, 0012h
        rep movsb 
        push ax
       
        call sleep                 
        jmp reload                   
     sleep:
        mov cx,20        
        mov dx,0          
        mov ah,86h              
        int 15h                
        
     cycle_read:        
        mov ah,1              
        int 16h
        jnz read
        ret   
     read:              
        xor ah,ah               
        int 16h 
        jmp cycle_read 
          
     check_go_awake: 
        mov bx, [ballLoc]         
        add bx, [vectorX]       
        mov ax, es:[bx]         
        cmp al, 0FEh          
        jne return          
        mov ax, [curY]         
        mul [size_line]
        mov dx, ax
        add ax, [curX]           
        sub ax, [vectorX]
        mov bx, ax
        mov ax, es:[bx]         
        cmp al, 0FEh
        jne return  
              
     
     loop3:                  
        sub bx, 2
        cmp bx, dx
        je go2
        cmp es:[bx],0FEh
        je loop3
        add bx, 2
     go2:                        
        call drawSpace
        mov bx, [ballLoc]          
        add bx, [vectorX]        
     loop4:                        
        sub bx,2                  
        cmp es:[bx],0FEh
        je loop4
     next3:
        add bx,2                    
        call drawSpace
        neg [vectorY]             
        neg [vectorX]
        mov ax, [curY]
        add ax, [vectorY]
        mov [curY], ax
        mov ax, [curX]
        add ax, [vectorX]
        mov [curX], ax              
        add [points],20
        call points_show 
            
points_show:                         
    push bx                
    mov ax, [max_coints]    
    cmp [points], ax        
    je win                  
    lea bx, points          
    lea di, points_str      
    call pointsTOstr                      
    
    mov cx, LEN             
    mov di, 10h              
    lea si, points_str      
    cld                     
    rep movsb                          
    pop bx                  
    ret 
         
pointsTOstr PROC   
                        
    push ax
    push bx
    push cx
    push di    

    mov ax, [bx]
    mov bx, 10
    xor cx, cx       
division:
    xor dx, dx
    div bx          
    push dx         
    inc cx          
    cmp ax, 0       
    jne division    
    
    mov LEN, cx   
    add LEN, cx    
save_in_str:
    pop dx
    add dl, '0'         
    mov [di], dl        
    inc di              
    mov [di], 0Fh       
    inc di              
    loop save_in_str    
       
    
    pop di 
    pop cx
    pop bx
    pop ax
    ret
endp 

drawRules proc
    mov di, 00h            
    lea si, rules          
    mov cx, [size_rules]   
    rep movsb              
    
    mov ah, 1              
    int 21h 
    call clearScreen    
ret
endp

reload:     
    
    mov ah, 00h
    int 16h
    mov bx, ENTER
    cmp ax, bx 
    jne endProgram   
    
    mov [points], 0
    mov [platformLoc],0F50h
    mov [ballLoc],0FA0h
    mov [curX],005Ah
    mov [curY],0017h
    mov [vectorX],-2h
    mov [vectorY],-1h  
    mov [line], 5 
    mov [repeat],8F00h
    mov [flag], 0 
   
    call begin
    call clearScreen 
    call drawTitle 
    call drawScore
    call points_show 
    call drawPlatform 
    call drawBall
    call drawBreaks
    call go 
    jmp main    
    
endProgram:  
    call clearScreen
    mov ax, 4C00h
    int 21h
win:        
        call clearScreen
        mov ax,000Ah
        mul [size_line]
        add ax,0048h
        mov di, ax
        mov si, offset winner
        mov cx,000Eh
        rep movsb 
        push ax
        call sleep
        jmp reload   
        
        