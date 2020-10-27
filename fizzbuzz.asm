STDOUT equ 1
SYS_WRITE equ 1
SYS_EXIT equ 60

section .data
	fizz db "Fizz"
	buzz db "Buzz"
	nl db 10

section .bss
	num resb 3

section .text
	global _start
_start:

	mov rbx,1	;Set the counter to one.
	mainloop:
	
	;Write Fizz if the counter is divisible by 3.
	xor rdx,rdx
	mov rdi,3
	mov rax,rbx
	div rdi	
	test rdx,rdx
	jnz not_div_by_3
	
	mov rax,SYS_WRITE
	mov rdi,STDOUT
	mov rsi,fizz
	mov rdx,4
	syscall

	not_div_by_3:

	;Write Buzz if the counter is divisible by 5.
	xor rdx,rdx
	mov rdi,5
	mov rax,rbx
	div rdi
	test rdx,rdx
	jnz not_div_by_5

	mov rax,SYS_WRITE
	mov rdi,STDOUT
	mov rsi,buzz
	mov rdx,4
	syscall

	not_div_by_5:


	;Write the number if the counter isn't divisible by 3 or 5.
	xor rdx,rdx
	mov rdi,3
	mov rax,rbx
	div rdi
	test rdx,rdx
	jz div_by_3_or_5
	xor rdx,rdx
	mov rdi,5
	mov rax,rbx
	div rdi
	test rdx,rdx
	jz div_by_3_or_5

	;Convert the counter to ASCII and push it to the stack.
	xor rcx,rcx
	mov rax,rbx
	mov rdi,10
	convertloop:
	
	xor rdx,rdx
	div rdi
	add rdx,48
	push rdx
	inc rcx

	test rax,rax
	jnz convertloop

	;Copy the number from the stack to num.
	mov rdi,num
	mov rdx,rcx
	copyloop:
	pop rax
	mov [rdi],ax
	inc rdi
	loop copyloop

	mov rax,SYS_WRITE
	mov rdi,STDOUT
	mov rsi,num
	syscall

	div_by_3_or_5:

	mov rax,SYS_WRITE
	mov rdi,STDOUT
	mov rsi,nl
	mov rdx,1
	syscall

	;Repeat the loop 100 times.
	inc rbx
	cmp rbx,100
	jle mainloop

	mov rax,SYS_EXIT
	mov rdi,0
	syscall
