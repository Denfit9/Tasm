.model small
.stack 256
.8086
.data
sum dw ?
num dw ?
divider dw ?
.code
main:
mov ax,@data
mov ds,ax
mov divider,0
    call input
    mov divider, 0
    mov ax,bx
    mov num,bx
    cmp ax, 0
    jne start

    start:
    cmp ax,1
    je exit3
    jne foo 
   
foo:
mov ax,num
inc divider
cmp divider, ax
ja exit2
jbe task

task:
mov dl,0
div divider
cmp dl,0
jz adding
jnz net

exit2:
mov cx,sum
sub cx , 1
sub cx,num
call show
call exit

exit3:
mov cx,0
call show
call exit

show:
    mov ax, cx
    call print
exit:
    mov ah, 04Ch
    mov al, 0
    int 21h
    
adding:
    mov cx, divider
    add sum,cx
    jmp foo


net:
    add sum,0
    jmp foo 
   

input:
    mov bx, 0
    mov ah, 01h
    int 21h
    cmp al, 2dh
    je negative
    call conv
    ret
    
negative:
    call readpos
    not bx 
    inc bx
    ret
    
readpos:
    mov ah, 01h
    int 21h
    conv:
    cmp al, 0dh
    je endline
    cmp al, 10
    je endline
    sub al, 48
    mov ah, 0
    push ax
    mov ax, 10
    mul bx
    mov bx, ax
    pop ax
    add bx, ax
    call readpos
    
endline:
    ret
    
print:
    cmp ax, 0
    jz przero
    jnl posit
    mov dl, '-'
    push ax
    mov ah, 02h
    int 21h
    pop ax
    not ax 
    inc ax
    
posit:
    cmp ax, 0
    jz zero
    mov dx, 0
    mov bx, 10
    div bx    
    add dl, 48
    push dx
    call posit
    pop dx
    push ax
    mov ah, 02h
    int 21h
    pop ax
    
zero:
    ret
    
przero:
    mov dl, 30h
    mov ah, 02h
    int 21h
    ret
end main