org 0x7C00
bits 16

start:
  jmp main
puts:
  push si 
  push ax 

.loop: 
  lodsb 
  or al, al 
  jz .done 
  mov ah, 0x0E 
  mov bh, 0x0 
  int 0x10 
  jmp .loop

.done: 
  pop ax 
  pop si 
  ret

printloop:
  mov si, msg_hello_world
  call puts
  dec bl
  cmp bl, 0
  je return
  jmp printloop

main: 
  mov ax, 0 
  mov ds, ax 
  mov es, ax 
  mov ss, ax 
  mov sp, 0x7C00 
  
  mov bl, [counter]
  call printloop
  
  hlt

.halt: 
  jmp .halt 

return:
  hlt

msg_hello_world: db "i really hate nasm", 0x0D, 0x0A, 0
counter: db 0x01

times 510-($-$$) db 0 
dw 0AA55h
