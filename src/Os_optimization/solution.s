	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.globl	min
	.type	min, @function
min:
.LFB46:
	.cfi_startproc
	endbr64
	cmp	edi, esi
	mov	eax, esi
	cmovle	eax, edi
	ret
	.cfi_endproc
.LFE46:
	.size	min, .-min
	.globl	isAlpha
	.type	isAlpha, @function
isAlpha:
.LFB47:
	.cfi_startproc
	endbr64
	and	edi, -33
	xor	eax, eax
	sub	edi, 65
	cmp	dil, 25
	setbe	al
	ret
	.cfi_endproc
.LFE47:
	.size	isAlpha, .-isAlpha
	.globl	isAlphaOrNum
	.type	isAlphaOrNum, @function
isAlphaOrNum:
.LFB48:
	.cfi_startproc
	endbr64
	mov	edx, edi
	movsx	edi, dil
	call	isAlpha
	mov	r8d, eax
	mov	eax, 1
	test	r8d, r8d
	jne	.L3
	sub	edx, 48
	xor	eax, eax
	cmp	dl, 9
	setbe	al
.L3:
	ret
	.cfi_endproc
.LFE48:
	.size	isAlphaOrNum, .-isAlphaOrNum
	.globl	incrementElement
	.type	incrementElement, @function
incrementElement:
.LFB49:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movsx	rdx, esi
	mov	r15, rdi
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	lea	r14, map[rip]
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rdx
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, r14
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	xor	ebx, ebx
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	mov	r12d, DWORD PTR map_size[rip]
.L8:
	cmp	r12d, ebx
	jle	.L13
	cmp	DWORD PTR 132[r14], r13d
	jne	.L9
	mov	rsi, r15
	mov	rdi, r14
	mov	QWORD PTR 8[rsp], rdx
	call	strncmp@PLT
	mov	rdx, QWORD PTR 8[rsp]
	test	eax, eax
	jne	.L9
	movsx	rbx, ebx
	imul	rbx, rbx, 136
	inc	DWORD PTR 128[rbp+rbx]
	jmp	.L7
.L9:
	inc	ebx
	add	r14, 136
	jmp	.L8
.L13:
	movsx	rdi, r12d
	mov	ecx, 128
	mov	rsi, r15
	inc	r12d
	imul	rdi, rdi, 136
	add	rdi, rbp
	call	__strncpy_chk@PLT
	mov	DWORD PTR map_size[rip], r12d
	mov	DWORD PTR 132[rax], r13d
	mov	DWORD PTR 128[rax], 1
.L7:
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
.LFE49:
	.size	incrementElement, .-incrementElement
	.globl	parseIdentifiers
	.type	parseIdentifiers, @function
parseIdentifiers:
.LFB50:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	or	ecx, -1
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	or	r13d, -1
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	mov	r12d, 127
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	xor	ebx, ebx
	sub	rsp, 144
	.cfi_def_cfa_offset 192
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 136[rsp], rax
	xor	eax, eax
	mov	eax, 1
.L15:
	movsx	edi, BYTE PTR 0[rbp+rbx]
	test	dil, dil
	je	.L29
	lea	esi, 1[rbx]
	test	ecx, ecx
	jns	.L16
	test	eax, eax
	je	.L16
	call	isAlpha
	mov	ecx, -1
	test	eax, eax
	cmovne	r13d, esi
	cmovne	ecx, ebx
	jmp	.L17
.L16:
	cmp	ecx, -1
	je	.L17
	call	isAlphaOrNum
	test	eax, eax
	jne	.L21
	sub	r13d, ecx
	movsx	rsi, ecx
	lea	rdi, 8[rsp]
	mov	ecx, 128
	cmp	r13d, 127
	cmovg	r13d, r12d
	add	rsi, rbp
	movsx	r14, r13d
	mov	rdx, r14
	call	__strncpy_chk@PLT
	lea	esi, 1[r13]
	mov	BYTE PTR 8[rsp+r14], 0
	or	r13d, -1
	mov	rdi, rax
	call	incrementElement
	or	ecx, -1
	jmp	.L17
.L21:
	mov	r13d, esi
.L17:
	movsx	edi, BYTE PTR 0[rbp+rbx]
	call	isAlphaOrNum
	test	eax, eax
	sete	al
	inc	rbx
	movzx	eax, al
	jmp	.L15
.L29:
	mov	rax, QWORD PTR 136[rsp]
	xor	rax, QWORD PTR fs:40
	je	.L19
	call	__stack_chk_fail@PLT
.L19:
	add	rsp, 144
	.cfi_def_cfa_offset 48
	pop	rbx
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE50:
	.size	parseIdentifiers, .-parseIdentifiers
	.globl	readStringInBuffer
	.type	readStringInBuffer, @function
readStringInBuffer:
.LFB51:
	.cfi_startproc
	endbr64
	mov	eax, 1
	test	rdi, rdi
	je	.L47
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	lea	r14, buffer[rip]
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r15, r14
	lea	r13, 99999[r14]
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, r14
	push	rcx
	.cfi_def_cfa_offset 64
.L32:
	mov	r12d, ebx
	mov	rdi, rbp
	sub	r12d, r14d
	call	fgetc@PLT
	cmp	eax, -1
	je	.L33
	cmp	rbx, r13
	je	.L50
	mov	BYTE PTR [rbx], al
	inc	rbx
	jmp	.L32
.L50:
	mov	r12d, 99999
.L33:
	movsx	rdx, r12d
	inc	eax
	mov	BYTE PTR [r15+rdx], 0
	je	.L36
	mov	eax, 2
	cmp	r12d, 99999
	je	.L30
.L36:
	xor	eax, eax
.L30:
	pop	rdx
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
.L47:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret
	.cfi_endproc
.LFE51:
	.size	readStringInBuffer, .-readStringInBuffer
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s : %d\n"
	.text
	.globl	writeMapToOutputStream
	.type	writeMapToOutputStream, @function
writeMapToOutputStream:
.LFB52:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L56
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	lea	r13, .LC0[rip]
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	xor	r12d, r12d
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	lea	rbx, map[rip]
	push	rcx
	.cfi_def_cfa_offset 48
.L53:
	cmp	r12d, DWORD PTR map_size[rip]
	jge	.L61
	mov	r8d, DWORD PTR 128[rbx]
	mov	rcx, rbx
	mov	rdx, r13
	mov	rdi, rbp
	mov	esi, 1
	xor	eax, eax
	inc	r12d
	add	rbx, 136
	call	__fprintf_chk@PLT
	jmp	.L53
.L61:
	pop	rdx
	.cfi_def_cfa_offset 40
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
.L56:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	mov	eax, 1
	ret
	.cfi_endproc
.LFE52:
	.size	writeMapToOutputStream, .-writeMapToOutputStream
	.globl	getRandomAlpha
	.type	getRandomAlpha, @function
getRandomAlpha:
.LFB53:
	.cfi_startproc
	endbr64
	push	rcx
	.cfi_def_cfa_offset 16
	call	rand@PLT
	test	al, 1
	jne	.L63
	call	rand@PLT
	mov	ecx, 26
	cdq
	idiv	ecx
	lea	eax, 97[rdx]
	jmp	.L62
.L63:
	call	rand@PLT
	mov	ecx, 26
	cdq
	idiv	ecx
	lea	eax, 65[rdx]
.L62:
	pop	rdx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE53:
	.size	getRandomAlpha, .-getRandomAlpha
	.globl	getRandomAlphaNum
	.type	getRandomAlphaNum, @function
getRandomAlphaNum:
.LFB54:
	.cfi_startproc
	endbr64
	push	rsi
	.cfi_def_cfa_offset 16
	call	rand@PLT
	test	al, 1
	jne	.L67
	xor	eax, eax
	pop	rcx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	getRandomAlpha
.L67:
	.cfi_restore_state
	call	rand@PLT
	mov	ecx, 10
	cdq
	idiv	ecx
	lea	eax, 48[rdx]
	pop	rdx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE54:
	.size	getRandomAlphaNum, .-getRandomAlphaNum
	.globl	getRandomDelimiter
	.type	getRandomDelimiter, @function
getRandomDelimiter:
.LFB55:
	.cfi_startproc
	endbr64
	push	rax
	.cfi_def_cfa_offset 16
	call	rand@PLT
	mov	ecx, 35
	cdq
	idiv	ecx
	lea	rax, delimiters[rip]
	movsx	rdx, edx
	mov	al, BYTE PTR [rax+rdx]
	pop	rdx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE55:
	.size	getRandomDelimiter, .-getRandomDelimiter
	.globl	fillBufferRandomly
	.type	fillBufferRandomly, @function
fillBufferRandomly:
.LFB56:
	.cfi_startproc
	endbr64
	cmp	edi, 14286
	jg	.L80
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	xor	r13d, r13d
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12d, edi
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	lea	rbp, buffer[rip]
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	xor	ebx, ebx
	sub	rsp, 24
	.cfi_def_cfa_offset 80
.L73:
	cmp	r12d, r13d
	movsx	r15, ebx
	jle	.L85
	call	rand@PLT
	mov	ecx, 2
	inc	ebx
	cdq
	movsx	rbx, ebx
	idiv	ecx
	xor	eax, eax
	mov	r14d, edx
	call	getRandomAlpha
	mov	BYTE PTR 0[rbp+r15], al
	mov	eax, 1
.L74:
	mov	r15d, ebx
	cmp	r14d, eax
	jl	.L86
	xor	eax, eax
	call	getRandomAlphaNum
	mov	BYTE PTR 0[rbp+rbx], al
	inc	rbx
	mov	eax, 2
	jmp	.L74
.L86:
	call	rand@PLT
	mov	esi, 5
	xor	r14d, r14d
	cdq
	idiv	esi
	mov	ebx, edx
	movsx	rdx, r15d
.L76:
	cmp	ebx, r14d
	jl	.L87
	xor	eax, eax
	mov	QWORD PTR 8[rsp], rdx
	call	getRandomDelimiter
	mov	rdx, QWORD PTR 8[rsp]
	mov	r8d, eax
	lea	rax, 0[rbp+rdx]
	mov	BYTE PTR [rax+r14], r8b
	inc	r14
	jmp	.L76
.L87:
	test	ebx, ebx
	mov	edx, -1
	cmovs	ebx, edx
	inc	r13d
	lea	ebx, 1[r15+rbx]
	jmp	.L73
.L85:
	mov	BYTE PTR 0[rbp+r15], 0
	add	rsp, 24
	.cfi_def_cfa_offset 56
	xor	eax, eax
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
.L80:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	mov	eax, 1
	ret
	.cfi_endproc
.LFE56:
	.size	fillBufferRandomly, .-fillBufferRandomly
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
.LFB57:
	.cfi_startproc
	endbr64
	mov	rax, rsi
	mov	r9d, 1000000
	mov	r8, rdx
	cqo
	imul	rdi, rdi, 1000
	idiv	r9
	imul	r8, r8, 1000
	add	rdi, rax
	mov	rax, rcx
	cqo
	idiv	r9
	add	r8, rax
	mov	rax, rdi
	sub	rax, r8
	ret
	.cfi_endproc
.LFE57:
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB58:
	.cfi_startproc
	endbr64
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	xor	r12d, r12d
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	xor	ebp, ebp
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	mov	rbx, rdi
	sub	rsp, 56
	.cfi_def_cfa_offset 96
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	lea	r13, 8[rsp]
.L90:
	cmp	rbp, rbx
	jge	.L94
	mov	edi, 14284
	inc	rbp
	mov	DWORD PTR map_size[rip], 0
	call	fillBufferRandomly
	mov	rsi, r13
	mov	edi, 1
	call	clock_gettime@PLT
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	lea	rsi, 24[rsp]
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rdx, QWORD PTR 8[rsp]
	mov	rcx, QWORD PTR 16[rsp]
	mov	rdi, QWORD PTR 24[rsp]
	mov	rsi, QWORD PTR 32[rsp]
	call	getTimeDiff
	add	r12, rax
	jmp	.L90
.L94:
	mov	rax, QWORD PTR 40[rsp]
	xor	rax, QWORD PTR fs:40
	je	.L92
	call	__stack_chk_fail@PLT
.L92:
	add	rsp, 56
	.cfi_def_cfa_offset 40
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE58:
	.size	measureTime, .-measureTime
	.section	.rodata.str1.1
.LC1:
	.string	"r"
.LC2:
	.string	"w"
.LC3:
	.string	"r:t:s:i:o:"
.LC4:
	.string	"Running random tests %ld times...\n"
.LC5:
	.string	"Elapsed time: %ld ms\n"
.LC6:
	.string	"Enter an ASCII string and finish typing with Ctrl+D"
.LC7:
	.string	"Error! The input file could not be read."
.LC8:
	.string	"\nWarning! The input string contains too many characters. Only the first %d will be read.\n"
.LC9:
	.string	"\nError! Output data cannot be written."
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB59:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xor	r15d, r15d
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	mov	r14d, 42
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	xor	r13d, r13d
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	xor	r12d, r12d
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	xor	ebx, ebx
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	mov	rax, QWORD PTR stdout[rip]
	mov	rbp, QWORD PTR stdin[rip]
	mov	DWORD PTR 20[rsp], edi
	mov	QWORD PTR 24[rsp], rsi
	mov	QWORD PTR 8[rsp], rax
.L96:
	mov	rsi, QWORD PTR 24[rsp]
	mov	edi, DWORD PTR 20[rsp]
	lea	rdx, .LC3[rip]
	call	getopt@PLT
	cmp	eax, -1
	je	.L120
	cmp	eax, 63
	je	.L97
	sub	eax, 105
	cmp	eax, 11
	ja	.L96
	lea	rcx, .L100[rip]
	movsx	rax, DWORD PTR [rcx+rax*4]
	add	rax, rcx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L100:
	.long	.L104-.L100
	.long	.L96-.L100
	.long	.L96-.L100
	.long	.L96-.L100
	.long	.L96-.L100
	.long	.L96-.L100
	.long	.L103-.L100
	.long	.L96-.L100
	.long	.L96-.L100
	.long	.L102-.L100
	.long	.L101-.L100
	.long	.L99-.L100
	.section	.text.startup
.L102:
	mov	rdi, QWORD PTR optarg[rip]
	mov	ebx, 1
	call	atoi@PLT
	mov	r13d, eax
	jmp	.L96
.L104:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC1[rip]
	call	fopen@PLT
	mov	rbp, rax
	jmp	.L96
.L103:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC2[rip]
	call	fopen@PLT
	mov	QWORD PTR 8[rsp], rax
	jmp	.L96
.L101:
	mov	rdi, QWORD PTR optarg[rip]
	call	atoi@PLT
	mov	r14d, eax
	jmp	.L96
.L99:
	mov	rdi, QWORD PTR optarg[rip]
	mov	r15d, 1
	call	atoll@PLT
	mov	r12, rax
	jmp	.L96
.L120:
	mov	edi, r14d
	call	srand@PLT
	test	r15d, r15d
	je	.L106
	mov	rdx, r12
	lea	rsi, .LC4[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	rdi, r12
	call	measureTime
	lea	rsi, .LC5[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	jmp	.L97
.L106:
	test	ebx, ebx
	je	.L107
	mov	edi, r13d
	call	fillBufferRandomly
	lea	rdi, buffer[rip]
	call	puts@PLT
	jmp	.L108
.L107:
	cmp	QWORD PTR stdin[rip], rbp
	jne	.L109
	lea	rdi, .LC6[rip]
	call	puts@PLT
.L109:
	mov	rdi, rbp
	call	readStringInBuffer
	lea	rdi, .LC7[rip]
	cmp	eax, 1
	je	.L119
	cmp	eax, 2
	jne	.L108
	mov	edx, 99999
	lea	rsi, .LC8[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
.L108:
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	mov	rdi, QWORD PTR 8[rsp]
	call	writeMapToOutputStream
	test	eax, eax
	je	.L97
	lea	rdi, .LC9[rip]
.L119:
	call	puts@PLT
.L97:
	add	rsp, 40
	.cfi_def_cfa_offset 56
	xor	eax, eax
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
.LFE59:
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
