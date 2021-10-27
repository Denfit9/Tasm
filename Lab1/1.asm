.model small
.stack 256
.8086
.data 
a dw ?
b dw ?
c dw ?
d dw ?
.code

main:
mov ax, @data
mov ds, ax
call input
mov a,bx
call input
mov b,bx
call input
mov c,bx
call input
mov d,bx
mov ax,a
mul c
mov bx,b
sub bx,d
cmp ax,bx
jne firstcaseis
mov ax,a
cmp ax,d
jb firstcaseis

false1:
mov ax,b
add ax,c
mov bx,a
sub bx,d
cmp ax,bx
jb false2
mov ax,a
cmp ax,b
jnl false2

secondcaseis:
mov ax,c
mul c
mov cx,3
adding:
add ax,a
loop adding
add ax,d
sub ax,4
jmp show

false2:
mov ax,5
mul a
sub ax,b
sub ax,b
add ax,8
call show

firstcaseis:
mov ax,c
sub ax,d
mul b
add ax,a

show:
call print

stop:
mov ah, 04Ch
mov al, 0
int 21h
    
input:
mov bx, 0
mov ah, 01h
int 21h
cmp al, 2dh
je lesszero
call conv
ret
lesszero:
call read
not bx 
inc bx
ret
read:
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
call read
endline:
ret

przero:
mov dl, 30h
mov ah, 02h
int 21h
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

end main