	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.globl	map_size
	.bss
	.align 4
	.type	map_size, @object
	.size	map_size, 4
map_size:
	.zero	4
	.comm	map,13600000,32
	.comm	buffer,100000,32
	.globl	delimiters
	.data
	.align 32
	.type	delimiters, @object
	.size	delimiters, 35
delimiters:
	.ascii	"\t\n !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
	.text
	.globl	min
	.type	min, @function
min:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -4[rbp], edi
	mov	DWORD PTR -8[rbp], esi
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -8[rbp]
	jge	.L2
	mov	eax, DWORD PTR -4[rbp]
	jmp	.L3
.L2:
	mov	eax, DWORD PTR -8[rbp]
.L3:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	min, .-min
	.globl	isAlpha
	.type	isAlpha, @function
isAlpha:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	eax, edi
	mov	BYTE PTR -4[rbp], al
	cmp	BYTE PTR -4[rbp], 96
	jle	.L5
	cmp	BYTE PTR -4[rbp], 122
	jle	.L6
.L5:
	cmp	BYTE PTR -4[rbp], 64
	jle	.L7
	cmp	BYTE PTR -4[rbp], 90
	jg	.L7
.L6:
	mov	eax, 1
	jmp	.L9
.L7:
	mov	eax, 0
.L9:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	isAlpha, .-isAlpha
	.globl	isAlphaOrNum
	.type	isAlphaOrNum, @function
isAlphaOrNum:
.LFB8:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 8
	mov	eax, edi
	mov	BYTE PTR -4[rbp], al
	movsx	eax, BYTE PTR -4[rbp]
	mov	edi, eax
	call	isAlpha
	test	eax, eax
	jne	.L11
	cmp	BYTE PTR -4[rbp], 47
	jle	.L12
	cmp	BYTE PTR -4[rbp], 57
	jg	.L12
.L11:
	mov	eax, 1
	jmp	.L14
.L12:
	mov	eax, 0
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	isAlphaOrNum, .-isAlphaOrNum
	.globl	incrementElement
	.type	incrementElement, @function
incrementElement:
.LFB9:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L16
.L19:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	lea	rax, map[rip+132]
	mov	eax, DWORD PTR [rdx+rax]
	cmp	DWORD PTR -28[rbp], eax
	jne	.L17
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	lea	rax, map[rip+132]
	mov	edx, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -28[rbp]
	mov	esi, edx
	mov	edi, eax
	call	min
	movsx	rcx, eax
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	lea	rdx, map[rip]
	lea	rdi, [rax+rdx]
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, rcx
	mov	rsi, rax
	call	strncmp@PLT
	test	eax, eax
	jne	.L17
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	lea	rax, map[rip+128]
	mov	eax, DWORD PTR [rdx+rax]
	lea	ecx, 1[rax]
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	lea	rax, map[rip+128]
	mov	DWORD PTR [rdx+rax], ecx
	jmp	.L15
.L17:
	add	DWORD PTR -4[rbp], 1
.L16:
	mov	eax, DWORD PTR map_size[rip]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L19
	mov	eax, DWORD PTR -28[rbp]
	movsx	rcx, eax
	mov	eax, DWORD PTR map_size[rip]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	lea	rdx, map[rip]
	lea	rdi, [rax+rdx]
	mov	rax, QWORD PTR -24[rbp]
	mov	rdx, rcx
	mov	rsi, rax
	call	strncpy@PLT
	mov	eax, DWORD PTR map_size[rip]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	mov	rcx, rax
	lea	rdx, map[rip+132]
	mov	eax, DWORD PTR -28[rbp]
	mov	DWORD PTR [rcx+rdx], eax
	mov	eax, DWORD PTR map_size[rip]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	lea	rax, map[rip+128]
	mov	DWORD PTR [rdx+rax], 1
	mov	eax, DWORD PTR map_size[rip]
	add	eax, 1
	mov	DWORD PTR map_size[rip], eax
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	incrementElement, .-incrementElement
	.globl	parseIdentifiers
	.type	parseIdentifiers, @function
parseIdentifiers:
.LFB10:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 192
	mov	QWORD PTR -184[rbp], rdi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	DWORD PTR -164[rbp], -1
	mov	DWORD PTR -160[rbp], -1
	mov	DWORD PTR -156[rbp], 1
	mov	DWORD PTR -152[rbp], 0
	jmp	.L21
.L25:
	cmp	DWORD PTR -156[rbp], 0
	je	.L22
	cmp	DWORD PTR -164[rbp], 0
	jns	.L22
	mov	eax, DWORD PTR -152[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -184[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	isAlpha
	test	eax, eax
	je	.L22
	mov	eax, DWORD PTR -152[rbp]
	mov	DWORD PTR -164[rbp], eax
	mov	eax, DWORD PTR -152[rbp]
	add	eax, 1
	mov	DWORD PTR -160[rbp], eax
	jmp	.L23
.L22:
	cmp	DWORD PTR -164[rbp], 0
	js	.L24
	mov	eax, DWORD PTR -152[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -184[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	isAlphaOrNum
	test	eax, eax
	je	.L24
	mov	eax, DWORD PTR -152[rbp]
	add	eax, 1
	mov	DWORD PTR -160[rbp], eax
	jmp	.L23
.L24:
	cmp	DWORD PTR -164[rbp], 0
	js	.L23
	mov	eax, DWORD PTR -160[rbp]
	sub	eax, DWORD PTR -164[rbp]
	mov	esi, 127
	mov	edi, eax
	call	min
	mov	DWORD PTR -148[rbp], eax
	mov	eax, DWORD PTR -148[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -164[rbp]
	movsx	rcx, eax
	mov	rax, QWORD PTR -184[rbp]
	add	rcx, rax
	lea	rax, -144[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	strncpy@PLT
	mov	eax, DWORD PTR -148[rbp]
	cdqe
	mov	BYTE PTR -144[rbp+rax], 0
	mov	eax, DWORD PTR -148[rbp]
	lea	edx, 1[rax]
	lea	rax, -144[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	incrementElement
	mov	DWORD PTR -164[rbp], -1
	mov	DWORD PTR -160[rbp], -1
.L23:
	mov	eax, DWORD PTR -152[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -184[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	isAlphaOrNum
	test	eax, eax
	sete	al
	movzx	eax, al
	mov	DWORD PTR -156[rbp], eax
	add	DWORD PTR -152[rbp], 1
.L21:
	mov	eax, DWORD PTR -152[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -184[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L25
	nop
	mov	rax, QWORD PTR -8[rbp]
	xor	rax, QWORD PTR fs:40
	je	.L26
	call	__stack_chk_fail@PLT
.L26:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	parseIdentifiers, .-parseIdentifiers
	.globl	readStringInBuffer
	.type	readStringInBuffer, @function
readStringInBuffer:
.LFB11:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	cmp	QWORD PTR -24[rbp], 0
	jne	.L28
	mov	eax, 1
	jmp	.L29
.L28:
	mov	DWORD PTR -8[rbp], 0
	jmp	.L30
.L32:
	mov	eax, DWORD PTR -8[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -8[rbp], edx
	mov	edx, DWORD PTR -4[rbp]
	mov	ecx, edx
	cdqe
	lea	rdx, buffer[rip]
	mov	BYTE PTR [rax+rdx], cl
.L30:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -4[rbp], eax
	cmp	DWORD PTR -4[rbp], -1
	je	.L31
	cmp	DWORD PTR -8[rbp], 99998
	jle	.L32
.L31:
	mov	eax, DWORD PTR -8[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -8[rbp], edx
	cdqe
	lea	rdx, buffer[rip]
	mov	BYTE PTR [rax+rdx], 0
	cmp	DWORD PTR -4[rbp], -1
	je	.L33
	cmp	DWORD PTR -8[rbp], 100000
	jne	.L33
	mov	eax, 2
	jmp	.L29
.L33:
	mov	eax, 0
.L29:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	readStringInBuffer, .-readStringInBuffer
	.section	.rodata
.LC0:
	.string	"%s : %d\n"
	.text
	.globl	writeMapToOutputStream
	.type	writeMapToOutputStream, @function
writeMapToOutputStream:
.LFB12:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	cmp	QWORD PTR -24[rbp], 0
	jne	.L35
	mov	eax, 1
	jmp	.L36
.L35:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L37
.L38:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	mov	rdx, rax
	lea	rax, map[rip+128]
	mov	ecx, DWORD PTR [rdx+rax]
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, rdx
	sal	rax, 4
	add	rax, rdx
	sal	rax, 3
	lea	rdx, map[rip]
	add	rdx, rax
	mov	rax, QWORD PTR -24[rbp]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	add	DWORD PTR -4[rbp], 1
.L37:
	mov	eax, DWORD PTR map_size[rip]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L38
	mov	eax, 0
.L36:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	writeMapToOutputStream, .-writeMapToOutputStream
	.globl	getRandomAlpha
	.type	getRandomAlpha, @function
getRandomAlpha:
.LFB13:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	call	rand@PLT
	and	eax, 1
	test	eax, eax
	jne	.L40
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1321528399
	shr	rdx, 32
	mov	ecx, edx
	sar	ecx, 3
	cdq
	sub	ecx, edx
	mov	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	mov	edx, eax
	mov	eax, edx
	add	eax, 97
	jmp	.L41
.L40:
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1321528399
	shr	rdx, 32
	mov	ecx, edx
	sar	ecx, 3
	cdq
	sub	ecx, edx
	mov	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	mov	edx, eax
	mov	eax, edx
	add	eax, 65
.L41:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	getRandomAlpha, .-getRandomAlpha
	.globl	getRandomAlphaNum
	.type	getRandomAlphaNum, @function
getRandomAlphaNum:
.LFB14:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	call	rand@PLT
	and	eax, 1
	test	eax, eax
	jne	.L43
	mov	eax, 0
	call	getRandomAlpha
	jmp	.L44
.L43:
	call	rand@PLT
	mov	edx, eax
	movsx	rax, edx
	imul	rax, rax, 1717986919
	shr	rax, 32
	mov	ecx, eax
	sar	ecx, 2
	mov	eax, edx
	sar	eax, 31
	sub	ecx, eax
	mov	eax, ecx
	sal	eax, 2
	add	eax, ecx
	add	eax, eax
	sub	edx, eax
	mov	ecx, edx
	mov	eax, ecx
	add	eax, 48
.L44:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	getRandomAlphaNum, .-getRandomAlphaNum
	.globl	getRandomDelimiter
	.type	getRandomDelimiter, @function
getRandomDelimiter:
.LFB15:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, -368140053
	shr	rdx, 32
	add	edx, eax
	mov	ecx, edx
	sar	ecx, 5
	cdq
	sub	ecx, edx
	mov	edx, ecx
	imul	edx, edx, 35
	sub	eax, edx
	mov	edx, eax
	movsx	rax, edx
	lea	rdx, delimiters[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	getRandomDelimiter, .-getRandomDelimiter
	.globl	fillBufferRandomly
	.type	fillBufferRandomly, @function
fillBufferRandomly:
.LFB16:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 56
	.cfi_offset 3, -24
	mov	DWORD PTR -52[rbp], edi
	mov	eax, DWORD PTR -52[rbp]
	mov	DWORD PTR -28[rbp], eax
	cmp	DWORD PTR -52[rbp], 14286
	jle	.L48
	mov	eax, 1
	jmp	.L49
.L48:
	mov	DWORD PTR -44[rbp], 0
	mov	DWORD PTR -40[rbp], 0
	jmp	.L50
.L55:
	call	rand@PLT
	cdq
	shr	edx, 31
	add	eax, edx
	and	eax, 1
	sub	eax, edx
	add	eax, 1
	mov	DWORD PTR -24[rbp], eax
	mov	ebx, DWORD PTR -44[rbp]
	lea	eax, 1[rbx]
	mov	DWORD PTR -44[rbp], eax
	mov	eax, 0
	call	getRandomAlpha
	movsx	rdx, ebx
	lea	rcx, buffer[rip]
	mov	BYTE PTR [rdx+rcx], al
	mov	DWORD PTR -36[rbp], 1
	jmp	.L51
.L52:
	mov	ebx, DWORD PTR -44[rbp]
	lea	eax, 1[rbx]
	mov	DWORD PTR -44[rbp], eax
	mov	eax, 0
	call	getRandomAlphaNum
	movsx	rdx, ebx
	lea	rcx, buffer[rip]
	mov	BYTE PTR [rdx+rcx], al
	add	DWORD PTR -36[rbp], 1
.L51:
	mov	eax, DWORD PTR -36[rbp]
	cmp	eax, DWORD PTR -24[rbp]
	jl	.L52
	call	rand@PLT
	mov	ecx, eax
	movsx	rax, ecx
	imul	rax, rax, 1717986919
	shr	rax, 32
	mov	edx, eax
	sar	edx
	mov	eax, ecx
	sar	eax, 31
	sub	edx, eax
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	sub	ecx, eax
	mov	edx, ecx
	lea	eax, 1[rdx]
	mov	DWORD PTR -20[rbp], eax
	mov	DWORD PTR -32[rbp], 0
	jmp	.L53
.L54:
	mov	ebx, DWORD PTR -44[rbp]
	lea	eax, 1[rbx]
	mov	DWORD PTR -44[rbp], eax
	mov	eax, 0
	call	getRandomDelimiter
	movsx	rdx, ebx
	lea	rcx, buffer[rip]
	mov	BYTE PTR [rdx+rcx], al
	add	DWORD PTR -32[rbp], 1
.L53:
	mov	eax, DWORD PTR -32[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L54
	add	DWORD PTR -40[rbp], 1
.L50:
	mov	eax, DWORD PTR -40[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L55
	mov	eax, DWORD PTR -44[rbp]
	cdqe
	lea	rdx, buffer[rip]
	mov	BYTE PTR [rax+rdx], 0
	mov	eax, 0
.L49:
	add	rsp, 56
	pop	rbx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	fillBufferRandomly, .-fillBufferRandomly
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
.LFB17:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	imul	rsi, rax, 1000
	mov	rcx, QWORD PTR -24[rbp]
	movabs	rdx, 4835703278458516699
	mov	rax, rcx
	imul	rdx
	sar	rdx, 18
	mov	rax, rcx
	sar	rax, 63
	sub	rdx, rax
	mov	rax, rdx
	add	rax, rsi
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	imul	rsi, rax, 1000
	mov	rcx, QWORD PTR -40[rbp]
	movabs	rdx, 4835703278458516699
	mov	rax, rcx
	imul	rdx
	sar	rdx, 18
	mov	rax, rcx
	sar	rax, 63
	sub	rdx, rax
	mov	rax, rdx
	add	rax, rsi
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	sub	rax, QWORD PTR -8[rbp]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB18:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 96
	mov	QWORD PTR -88[rbp], rdi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	QWORD PTR -64[rbp], 0
	mov	DWORD PTR -68[rbp], 14284
	mov	QWORD PTR -56[rbp], 0
	jmp	.L59
.L60:
	mov	DWORD PTR map_size[rip], 0
	mov	eax, DWORD PTR -68[rbp]
	mov	edi, eax
	call	fillBufferRandomly
	lea	rax, -48[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	lea	rax, -32[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdx, QWORD PTR -40[rbp]
	mov	rdi, QWORD PTR -32[rbp]
	mov	rsi, QWORD PTR -24[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	getTimeDiff
	add	QWORD PTR -64[rbp], rax
	add	QWORD PTR -56[rbp], 1
.L59:
	mov	rax, QWORD PTR -56[rbp]
	cmp	rax, QWORD PTR -88[rbp]
	jl	.L60
	mov	rax, QWORD PTR -64[rbp]
	mov	rcx, QWORD PTR -8[rbp]
	xor	rcx, QWORD PTR fs:40
	je	.L62
	call	__stack_chk_fail@PLT
.L62:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	measureTime, .-measureTime
	.section	.rodata
.LC1:
	.string	"r"
.LC2:
	.string	"w"
.LC3:
	.string	"r:t:s:i:o:"
	.align 8
.LC4:
	.string	"Running random tests %ld times...\n"
.LC5:
	.string	"Elapsed time: %ld ms\n"
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
.LFB19:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	mov	rax, QWORD PTR stdin[rip]
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -56[rbp], 0
	mov	DWORD PTR -52[rbp], 0
	mov	DWORD PTR -48[rbp], 42
	mov	DWORD PTR -44[rbp], 0
	mov	QWORD PTR -16[rbp], 0
	jmp	.L64
.L73:
	cmp	DWORD PTR -36[rbp], 63
	je	.L65
	cmp	DWORD PTR -36[rbp], 63
	jl	.L64
	cmp	DWORD PTR -36[rbp], 116
	jg	.L64
	cmp	DWORD PTR -36[rbp], 105
	jl	.L64
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 105
	cmp	eax, 11
	ja	.L64
	mov	eax, eax
	lea	rdx, 0[0+rax*4]
	lea	rax, .L67[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdqe
	lea	rdx, .L67[rip]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L67:
	.long	.L71-.L67
	.long	.L64-.L67
	.long	.L64-.L67
	.long	.L64-.L67
	.long	.L64-.L67
	.long	.L64-.L67
	.long	.L70-.L67
	.long	.L64-.L67
	.long	.L64-.L67
	.long	.L69-.L67
	.long	.L68-.L67
	.long	.L66-.L67
	.text
.L69:
	mov	DWORD PTR -56[rbp], 1
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -44[rbp], eax
	jmp	.L64
.L71:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	jmp	.L64
.L70:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	jmp	.L64
.L68:
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -48[rbp], eax
	jmp	.L64
.L66:
	mov	DWORD PTR -52[rbp], 1
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -16[rbp], rax
	jmp	.L64
.L65:
	mov	eax, 0
	jmp	.L72
.L64:
	mov	rcx, QWORD PTR -80[rbp]
	mov	eax, DWORD PTR -68[rbp]
	lea	rdx, .LC3[rip]
	mov	rsi, rcx
	mov	edi, eax
	call	getopt@PLT
	mov	DWORD PTR -36[rbp], eax
	cmp	DWORD PTR -36[rbp], -1
	jne	.L73
	mov	eax, DWORD PTR -48[rbp]
	mov	edi, eax
	call	srand@PLT
	cmp	DWORD PTR -52[rbp], 0
	je	.L74
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rdi, .LC4[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	measureTime
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	mov	rsi, rax
	lea	rdi, .LC5[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L72
.L74:
	mov	DWORD PTR -40[rbp], 0
	cmp	DWORD PTR -56[rbp], 0
	je	.L75
	mov	eax, DWORD PTR -44[rbp]
	mov	edi, eax
	call	fillBufferRandomly
	lea	rdi, buffer[rip]
	call	puts@PLT
	jmp	.L76
.L75:
	mov	rax, QWORD PTR stdin[rip]
	cmp	QWORD PTR -32[rbp], rax
	jne	.L77
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	readStringInBuffer
	mov	DWORD PTR -40[rbp], eax
	jmp	.L76
.L77:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	readStringInBuffer
	mov	DWORD PTR -40[rbp], eax
.L76:
	cmp	DWORD PTR -40[rbp], 1
	jne	.L78
	lea	rdi, .LC7[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L72
.L78:
	cmp	DWORD PTR -40[rbp], 2
	jne	.L79
	mov	esi, 99999
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT
.L79:
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	writeMapToOutputStream
	mov	DWORD PTR -40[rbp], eax
	cmp	DWORD PTR -40[rbp], 0
	je	.L80
	lea	rdi, .LC9[rip]
	call	puts@PLT
.L80:
	mov	eax, 0
.L72:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	main, .-main
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
