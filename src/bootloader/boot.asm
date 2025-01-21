org 0x7C00
bits 16

jmp short start
nop

bdb_oem:                    db "MSWIN4.1"
bdb_bytes_per_sector:       dw 0x0200
bdb_sectors_per_cluster:    db 0x1
bdb_reserved_sectors:       dw 0x1
bdb_fat_count:              db 0x2
bdb_dir_entries_count:      dw 0x0E0
bdb_total_sectors:          dw 2880
bdb_media_descriptor_type:  db 0xF0
bdb_sectors_per_fat:        dw 0x9
bdb_sectors_per_track:      dw 0x12
bdb_heads:                  dw 0x2
bdb_hidden_sectors:         dd 0x0
bdb_large_sector_count:     dd 0x0

ebr_drive_number:           db 0x0
                            db 0x0
ebr_signature:              db 0x29
ebr_volume_id:              db 0x12,0x34,0x56,0x78
ebr_volume_label:           db "  EBRVOLM  "
ebr_system_id:              db "FAT12   "

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
