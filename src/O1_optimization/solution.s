	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.globl	min
	.type	min, @function
min:
.LFB61:
	.cfi_startproc
	endbr64
	cmp	edi, esi
	mov	eax, esi
	cmovle	eax, edi
	ret
	.cfi_endproc
.LFE61:
	.size	min, .-min
	.globl	isAlpha
	.type	isAlpha, @function
isAlpha:
.LFB62:
	.cfi_startproc
	endbr64
	and	edi, -33
	sub	edi, 65
	cmp	dil, 25
	setbe	al
	movzx	eax, al
	ret
	.cfi_endproc
.LFE62:
	.size	isAlpha, .-isAlpha
	.globl	isAlphaOrNum
	.type	isAlphaOrNum, @function
isAlphaOrNum:
.LFB63:
	.cfi_startproc
	endbr64
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	ebx, edi
	movsx	edi, dil
	call	isAlpha
	mov	edx, eax
	mov	eax, 1
	test	edx, edx
	jne	.L3
	sub	ebx, 48
	cmp	bl, 9
	setbe	al
	movzx	eax, al
.L3:
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE63:
	.size	isAlphaOrNum, .-isAlphaOrNum
	.globl	incrementElement
	.type	incrementElement, @function
incrementElement:
.LFB64:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	mov	r14, rdi
	mov	r12d, esi
	mov	r13d, DWORD PTR map_size[rip]
	test	r13d, r13d
	jle	.L8
	lea	rbx, map[rip]
	mov	ebp, 0
	movsx	r15, esi
	jmp	.L11
.L9:
	add	ebp, 1
	add	rbx, 136
	cmp	ebp, r13d
	je	.L8
.L11:
	cmp	DWORD PTR 132[rbx], r12d
	jne	.L9
	mov	rdx, r15
	mov	rsi, r14
	mov	rdi, rbx
	call	strncmp@PLT
	test	eax, eax
	jne	.L9
	lea	rdx, map[rip]
	movsx	rbp, ebp
	mov	rax, rbp
	sal	rax, 4
	lea	rcx, [rax+rbp]
	mov	eax, DWORD PTR 128[rdx+rcx*8]
	add	eax, 1
	mov	DWORD PTR 128[rdx+rcx*8], eax
	jmp	.L7
.L8:
	movsx	rdx, r12d
	movsx	r15, r13d
	mov	rbx, r15
	sal	rbx, 4
	lea	rax, [rbx+r15]
	lea	rbp, map[rip]
	lea	rdi, 0[rbp+rax*8]
	mov	ecx, 128
	mov	rsi, r14
	call	__strncpy_chk@PLT
	lea	rax, [rbx+r15]
	mov	DWORD PTR 132[rbp+rax*8], r12d
	mov	DWORD PTR 128[rbp+rax*8], 1
	add	r13d, 1
	mov	DWORD PTR map_size[rip], r13d
.L7:
	add	rsp, 8
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE64:
	.size	incrementElement, .-incrementElement
	.globl	parseIdentifiers
	.type	parseIdentifiers, @function
parseIdentifiers:
.LFB65:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 152
	.cfi_def_cfa_offset 208
	mov	r13, rdi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 136[rsp], rax
	xor	eax, eax
	movzx	edi, BYTE PTR [rdi]
	test	dil, dil
	je	.L14
	mov	ebx, 0
	mov	eax, 1
	mov	r12d, -1
	mov	ebp, -1
	jmp	.L19
.L16:
	test	ebp, ebp
	js	.L17
	movsx	edi, dil
	call	isAlphaOrNum
	test	eax, eax
	je	.L18
	lea	r12d, 1[r14]
.L17:
	movsx	edi, BYTE PTR 0[r13+rbx]
	call	isAlphaOrNum
	test	eax, eax
	sete	al
	movzx	eax, al
	add	rbx, 1
	movzx	edi, BYTE PTR 0[r13+rbx]
	test	dil, dil
	je	.L14
.L19:
	mov	r14d, ebx
	test	eax, eax
	je	.L16
	test	ebp, ebp
	jns	.L16
	movsx	edi, dil
	call	isAlpha
	test	eax, eax
	je	.L17
	lea	r12d, 1[rbx]
	mov	ebp, ebx
	jmp	.L17
.L18:
	sub	r12d, ebp
	cmp	r12d, 127
	mov	eax, 127
	cmovg	r12d, eax
	movsx	r14, r12d
	movsx	rsi, ebp
	add	rsi, r13
	mov	r15, rsp
	mov	ecx, 128
	mov	rdx, r14
	mov	rdi, r15
	call	__strncpy_chk@PLT
	mov	BYTE PTR [rsp+r14], 0
	lea	esi, 1[r12]
	mov	rdi, r15
	call	incrementElement
	mov	r12d, -1
	mov	ebp, -1
	jmp	.L17
.L14:
	mov	rax, QWORD PTR 136[rsp]
	xor	rax, QWORD PTR fs:40
	jne	.L23
	add	rsp, 152
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L23:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE65:
	.size	parseIdentifiers, .-parseIdentifiers
	.globl	readStringInBuffer
	.type	readStringInBuffer, @function
readStringInBuffer:
.LFB66:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L29
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	mov	rbp, rdi
	mov	ebx, 0
	lea	r13, buffer[rip]
.L26:
	mov	r12d, ebx
	mov	rdi, rbp
	call	fgetc@PLT
	cmp	eax, -1
	setne	dl
	cmp	ebx, 99998
	jg	.L31
	test	dl, dl
	je	.L31
	mov	BYTE PTR 0[r13+rbx], al
	add	rbx, 1
	jmp	.L26
.L31:
	movsx	rax, r12d
	lea	rcx, buffer[rip]
	mov	BYTE PTR [rcx+rax], 0
	cmp	r12d, 99999
	jne	.L30
	mov	eax, 2
	test	dl, dl
	jne	.L24
.L30:
	mov	eax, 0
.L24:
	add	rsp, 8
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
.L29:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	mov	eax, 1
	ret
	.cfi_endproc
.LFE66:
	.size	readStringInBuffer, .-readStringInBuffer
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s : %d\n"
	.text
	.globl	writeMapToOutputStream
	.type	writeMapToOutputStream, @function
writeMapToOutputStream:
.LFB67:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L39
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	mov	r12, rdi
	cmp	DWORD PTR map_size[rip], 0
	jle	.L40
	lea	rbx, map[rip]
	mov	ebp, 0
	lea	r13, .LC0[rip]
.L38:
	mov	r8d, DWORD PTR 128[rbx]
	mov	rcx, rbx
	mov	rdx, r13
	mov	esi, 1
	mov	rdi, r12
	mov	eax, 0
	call	__fprintf_chk@PLT
	add	ebp, 1
	add	rbx, 136
	cmp	DWORD PTR map_size[rip], ebp
	jg	.L38
	mov	eax, 0
.L36:
	add	rsp, 8
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
.L39:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	mov	eax, 1
	ret
.L40:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	mov	eax, 0
	jmp	.L36
	.cfi_endproc
.LFE67:
	.size	writeMapToOutputStream, .-writeMapToOutputStream
	.globl	getRandomAlpha
	.type	getRandomAlpha, @function
getRandomAlpha:
.LFB68:
	.cfi_startproc
	endbr64
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	rand@PLT
	test	al, 1
	je	.L50
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1321528399
	sar	rdx, 35
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 65
.L46:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L50:
	.cfi_restore_state
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1321528399
	sar	rdx, 35
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 97
	jmp	.L46
	.cfi_endproc
.LFE68:
	.size	getRandomAlpha, .-getRandomAlpha
	.globl	getRandomAlphaNum
	.type	getRandomAlphaNum, @function
getRandomAlphaNum:
.LFB69:
	.cfi_startproc
	endbr64
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	rand@PLT
	test	al, 1
	je	.L55
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1717986919
	sar	rdx, 34
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	lea	edx, [rdx+rdx*4]
	add	edx, edx
	sub	eax, edx
	add	eax, 48
.L51:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L55:
	.cfi_restore_state
	mov	eax, 0
	call	getRandomAlpha
	jmp	.L51
	.cfi_endproc
.LFE69:
	.size	getRandomAlphaNum, .-getRandomAlphaNum
	.globl	getRandomDelimiter
	.type	getRandomDelimiter, @function
getRandomDelimiter:
.LFB70:
	.cfi_startproc
	endbr64
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, -368140053
	shr	rdx, 32
	add	edx, eax
	sar	edx, 5
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	edx, edx, 35
	sub	eax, edx
	cdqe
	lea	rdx, delimiters[rip]
	movzx	eax, BYTE PTR [rdx+rax]
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE70:
	.size	getRandomDelimiter, .-getRandomDelimiter
	.globl	fillBufferRandomly
	.type	fillBufferRandomly, @function
fillBufferRandomly:
.LFB71:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	mov	DWORD PTR 12[rsp], edi
	mov	eax, 1
	cmp	edi, 14286
	jg	.L58
	test	edi, edi
	jle	.L67
	mov	r14d, 0
	mov	r13d, 0
	lea	r15, buffer[rip]
	jmp	.L64
.L71:
	mov	r13d, ebp
.L65:
	call	rand@PLT
	movsx	r12, eax
	imul	r12, r12, 1717986919
	sar	r12, 33
	cdq
	sub	r12d, edx
	lea	edx, [r12+r12*4]
	sub	eax, edx
	mov	r12d, eax
	js	.L62
	movsx	rbp, r13d
	lea	rbx, 0[rbp+r15]
	lea	rax, buffer[rip+1]
	add	rbp, rax
	mov	eax, r12d
	add	rbp, rax
.L63:
	mov	eax, 0
	call	getRandomDelimiter
	mov	BYTE PTR [rbx], al
	add	rbx, 1
	cmp	rbp, rbx
	jne	.L63
	lea	r13d, 1[r12+r13]
.L62:
	add	r14d, 1
	cmp	DWORD PTR 12[rsp], r14d
	je	.L60
.L64:
	call	rand@PLT
	mov	ebx, eax
	lea	ebp, 1[r13]
	mov	eax, 0
	call	getRandomAlpha
	mov	edx, eax
	movsx	rax, r13d
	mov	BYTE PTR [r15+rax], dl
	mov	eax, ebx
	shr	eax, 31
	add	ebx, eax
	and	ebx, 1
	sub	ebx, eax
	test	ebx, ebx
	jle	.L71
	add	r13d, 2
	mov	eax, 0
	call	getRandomAlphaNum
	movsx	rbp, ebp
	mov	BYTE PTR [r15+rbp], al
	jmp	.L65
.L67:
	mov	r13d, 0
.L60:
	movsx	r13, r13d
	lea	rax, buffer[rip]
	mov	BYTE PTR [rax+r13], 0
	mov	eax, 0
.L58:
	add	rsp, 24
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE71:
	.size	fillBufferRandomly, .-fillBufferRandomly
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
.LFB72:
	.cfi_startproc
	endbr64
	mov	r10, rdx
	imul	r9, rdi, 1000
	movabs	r8, 4835703278458516699
	mov	rax, rsi
	imul	r8
	sar	rdx, 18
	sar	rsi, 63
	sub	rdx, rsi
	lea	rdi, [r9+rdx]
	imul	r10, r10, 1000
	mov	rax, rcx
	imul	r8
	sar	rdx, 18
	sar	rcx, 63
	sub	rdx, rcx
	add	r10, rdx
	mov	rax, rdi
	sub	rax, r10
	ret
	.cfi_endproc
.LFE72:
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB73:
	.cfi_startproc
	endbr64
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 56
	.cfi_def_cfa_offset 96
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	test	rdi, rdi
	jle	.L77
	mov	r12, rdi
	mov	ebx, 0
	mov	ebp, 0
	mov	r13, rsp
.L75:
	mov	DWORD PTR map_size[rip], 0
	mov	edi, 14284
	call	fillBufferRandomly
	mov	rsi, r13
	mov	edi, 1
	call	clock_gettime@PLT
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	lea	rsi, 16[rsp]
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rdx, QWORD PTR [rsp]
	mov	rcx, QWORD PTR 8[rsp]
	mov	rdi, QWORD PTR 16[rsp]
	mov	rsi, QWORD PTR 24[rsp]
	call	getTimeDiff
	add	rbp, rax
	add	rbx, 1
	cmp	r12, rbx
	jne	.L75
.L73:
	mov	rax, QWORD PTR 40[rsp]
	xor	rax, QWORD PTR fs:40
	jne	.L80
	mov	rax, rbp
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
.L77:
	.cfi_restore_state
	mov	ebp, 0
	jmp	.L73
.L80:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE73:
	.size	measureTime, .-measureTime
	.section	.rodata.str1.1
.LC1:
	.string	"r"
.LC2:
	.string	"w"
.LC3:
	.string	"r:t:s:i:o:"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"Running random tests %ld times...\n"
	.section	.rodata.str1.1
.LC5:
	.string	"Elapsed time: %ld ms\n"
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"Enter an ASCII string and finish typing with Ctrl+D"
	.align 8
.LC7:
	.string	"Error! The input file could not be read."
	.align 8
.LC8:
	.string	"\nWarning! The input string contains too many characters. Only the first %d will be read.\n"
	.align 8
.LC9:
	.string	"\nError! Output data cannot be written."
	.text
	.globl	main
	.type	main, @function
main:
.LFB74:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	mov	r12d, edi
	mov	rbp, rsi
	mov	r13, QWORD PTR stdin[rip]
	mov	r14, QWORD PTR stdout[rip]
	mov	QWORD PTR 24[rsp], 0
	mov	DWORD PTR 20[rsp], 0
	mov	DWORD PTR 12[rsp], 42
	mov	r15d, 0
	mov	DWORD PTR 16[rsp], 0
	lea	rbx, .L86[rip]
.L99:
	lea	rdx, .LC3[rip]
	mov	rsi, rbp
	mov	edi, r12d
	call	getopt@PLT
	cmp	eax, -1
	je	.L101
	cmp	eax, 63
	je	.L83
	lea	edx, -105[rax]
	cmp	edx, 11
	ja	.L99
	ja	.L99
	mov	eax, edx
	movsx	rax, DWORD PTR [rbx+rax*4]
	add	rax, rbx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L86:
	.long	.L90-.L86
	.long	.L99-.L86
	.long	.L99-.L86
	.long	.L99-.L86
	.long	.L99-.L86
	.long	.L99-.L86
	.long	.L89-.L86
	.long	.L99-.L86
	.long	.L99-.L86
	.long	.L88-.L86
	.long	.L87-.L86
	.long	.L85-.L86
	.text
.L88:
	mov	edx, 10
	mov	esi, 0
	mov	rdi, QWORD PTR optarg[rip]
	call	strtol@PLT
	mov	DWORD PTR 20[rsp], eax
	mov	DWORD PTR 16[rsp], 1
	jmp	.L99
.L90:
	lea	rsi, .LC1[rip]
	mov	rdi, QWORD PTR optarg[rip]
	call	fopen@PLT
	mov	r13, rax
	jmp	.L99
.L89:
	lea	rsi, .LC2[rip]
	mov	rdi, QWORD PTR optarg[rip]
	call	fopen@PLT
	mov	r14, rax
	jmp	.L99
.L87:
	mov	edx, 10
	mov	esi, 0
	mov	rdi, QWORD PTR optarg[rip]
	call	strtol@PLT
	mov	DWORD PTR 12[rsp], eax
	jmp	.L99
.L85:
	mov	edx, 10
	mov	esi, 0
	mov	rdi, QWORD PTR optarg[rip]
	call	strtoll@PLT
	mov	QWORD PTR 24[rsp], rax
	mov	r15d, 1
	jmp	.L99
.L101:
	mov	edi, DWORD PTR 12[rsp]
	call	srand@PLT
	test	r15d, r15d
	jne	.L102
	cmp	DWORD PTR 16[rsp], 0
	jne	.L103
	cmp	QWORD PTR stdin[rip], r13
	je	.L104
	mov	rdi, r13
	call	readStringInBuffer
.L97:
	cmp	eax, 1
	je	.L105
	cmp	eax, 2
	je	.L106
.L95:
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	mov	rdi, r14
	call	writeMapToOutputStream
	test	eax, eax
	jne	.L107
.L83:
	mov	eax, 0
	add	rsp, 40
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L102:
	.cfi_restore_state
	mov	rbx, QWORD PTR 24[rsp]
	mov	rdx, rbx
	lea	rsi, .LC4[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	mov	rdi, rbx
	call	measureTime
	mov	rdx, rax
	lea	rsi, .LC5[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	jmp	.L83
.L103:
	mov	edi, DWORD PTR 20[rsp]
	call	fillBufferRandomly
	lea	rdi, buffer[rip]
	call	puts@PLT
	jmp	.L95
.L104:
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	rdi, r13
	call	readStringInBuffer
	jmp	.L97
.L105:
	lea	rdi, .LC7[rip]
	call	puts@PLT
	jmp	.L83
.L106:
	mov	edx, 99999
	lea	rsi, .LC8[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	jmp	.L95
.L107:
	lea	rdi, .LC9[rip]
	call	puts@PLT
	jmp	.L83
	.cfi_endproc
.LFE74:
	.size	main, .-main
	.globl	delimiters
	.data
	.align 32
	.type	delimiters, @object
	.size	delimiters, 35
delimiters:
	.ascii	"\t\n !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
	.comm	buffer,100000,32
	.comm	map,13600000,32
	.globl	map_size
	.bss
	.align 4
	.type	map_size, @object
	.size	map_size, 4
map_size:
	.zero	4
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
