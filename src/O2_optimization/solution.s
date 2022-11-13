	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.type	readStringInBuffer.part.0, @function
readStringInBuffer.part.0:
.LFB75:
	.cfi_startproc
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
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	lea	rbx, buffer[rip]
	lea	r13, 99999[rbx]
	mov	r14, rbx
	mov	r15, rbx
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L11:
	cmp	r13, r15
	je	.L10
	mov	BYTE PTR [r15], al
	add	r15, 1
.L2:
	mov	r12d, r15d
	mov	rdi, rbp
	sub	r12d, ebx
	call	fgetc@PLT
	cmp	eax, -1
	jne	.L11
	movsx	r12, r12d
	xor	eax, eax
	mov	BYTE PTR [r14+r12], 0
	add	rsp, 8
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
.L10:
	.cfi_restore_state
	mov	BYTE PTR buffer[rip+99999], 0
	add	rsp, 8
	.cfi_def_cfa_offset 56
	mov	eax, 2
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
.LFE75:
	.size	readStringInBuffer.part.0, .-readStringInBuffer.part.0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s : %d\n"
	.text
	.p2align 4
	.type	writeMapToOutputStream.part.0, @function
writeMapToOutputStream.part.0:
.LFB76:
	.cfi_startproc
	mov	eax, DWORD PTR map_size[rip]
	test	eax, eax
	jle	.L17
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	lea	r13, .LC0[rip]
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	mov	r12, rdi
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	xor	ebp, ebp
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	lea	rbx, map[rip]
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	.p2align 4,,10
	.p2align 3
.L14:
	mov	r8d, DWORD PTR 128[rbx]
	mov	rcx, rbx
	xor	eax, eax
	mov	rdx, r13
	mov	esi, 1
	mov	rdi, r12
	add	ebp, 1
	add	rbx, 136
	call	__fprintf_chk@PLT
	cmp	ebp, DWORD PTR map_size[rip]
	jl	.L14
	add	rsp, 8
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
	.p2align 4,,10
	.p2align 3
.L17:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	xor	eax, eax
	ret
	.cfi_endproc
.LFE76:
	.size	writeMapToOutputStream.part.0, .-writeMapToOutputStream.part.0
	.p2align 4
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
	.p2align 4
	.globl	isAlpha
	.type	isAlpha, @function
isAlpha:
.LFB62:
	.cfi_startproc
	endbr64
	and	edi, -33
	xor	eax, eax
	sub	edi, 65
	cmp	dil, 25
	setbe	al
	ret
	.cfi_endproc
.LFE62:
	.size	isAlpha, .-isAlpha
	.p2align 4
	.globl	isAlphaOrNum
	.type	isAlphaOrNum, @function
isAlphaOrNum:
.LFB63:
	.cfi_startproc
	endbr64
	mov	eax, edi
	mov	r8d, 1
	and	eax, -33
	sub	eax, 65
	cmp	al, 25
	jbe	.L22
	sub	edi, 48
	xor	r8d, r8d
	cmp	dil, 9
	setbe	r8b
.L22:
	mov	eax, r8d
	ret
	.cfi_endproc
.LFE63:
	.size	isAlphaOrNum, .-isAlphaOrNum
	.p2align 4
	.globl	incrementElement
	.type	incrementElement, @function
incrementElement:
.LFB64:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	lea	rax, map[rip]
	mov	r15, rdi
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movsx	r14, esi
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, r14
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	xor	ebp, ebp
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rax
	sub	rsp, 24
	.cfi_def_cfa_offset 80
	mov	r12d, DWORD PTR map_size[rip]
	mov	QWORD PTR 8[rsp], rax
	test	r12d, r12d
	jg	.L29
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L27:
	add	ebp, 1
	add	rbx, 136
	cmp	r12d, ebp
	je	.L26
.L29:
	cmp	DWORD PTR 132[rbx], r13d
	jne	.L27
	mov	rdx, r14
	mov	rsi, r15
	mov	rdi, rbx
	call	strncmp@PLT
	test	eax, eax
	jne	.L27
	movsx	rbp, ebp
	mov	rax, rbp
	sal	rax, 4
	add	rbp, rax
	mov	rax, QWORD PTR 8[rsp]
	add	DWORD PTR 128[rax+rbp*8], 1
	add	rsp, 24
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
	.p2align 4,,10
	.p2align 3
.L26:
	.cfi_restore_state
	movsx	rcx, r12d
	mov	rdx, r14
	mov	rsi, r15
	add	r12d, 1
	mov	rax, rcx
	sal	rax, 4
	add	rax, rcx
	mov	rcx, QWORD PTR 8[rsp]
	lea	rdi, [rcx+rax*8]
	mov	ecx, 128
	call	__strncpy_chk@PLT
	mov	DWORD PTR map_size[rip], r12d
	mov	DWORD PTR 132[rax], r13d
	mov	DWORD PTR 128[rax], 1
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
.LFE64:
	.size	incrementElement, .-incrementElement
	.p2align 4
	.globl	parseIdentifiers
	.type	parseIdentifiers, @function
parseIdentifiers:
.LFB65:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	sub	rsp, 144
	.cfi_def_cfa_offset 192
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 136[rsp], rax
	xor	eax, eax
	movzx	eax, BYTE PTR [rdi]
	test	al, al
	je	.L34
	mov	r12, rdi
	xor	ebx, ebx
	mov	edi, 1
	mov	esi, -1
	mov	edx, -1
	mov	ebp, 127
	jmp	.L35
	.p2align 4,,10
	.p2align 3
.L54:
	and	eax, -33
	mov	edx, -1
	sub	eax, 65
	cmp	al, 25
	cmovbe	esi, ecx
	cmovbe	edx, ebx
.L37:
	movzx	ecx, BYTE PTR [r12+rbx]
	xor	edi, edi
	mov	eax, ecx
	and	eax, -33
	sub	eax, 65
	cmp	al, 25
	jbe	.L38
	sub	ecx, 48
	xor	edi, edi
	cmp	cl, 9
	seta	dil
.L38:
	add	rbx, 1
	movzx	eax, BYTE PTR [r12+rbx]
	test	al, al
	je	.L34
.L35:
	lea	ecx, 1[rbx]
	test	edx, edx
	jns	.L36
	test	edi, edi
	jne	.L54
.L36:
	cmp	edx, -1
	je	.L37
	mov	edi, eax
	and	edi, -33
	sub	edi, 65
	cmp	dil, 25
	jbe	.L44
	sub	eax, 48
	cmp	al, 9
	jbe	.L44
	sub	esi, edx
	mov	rdi, rsp
	mov	ecx, 128
	cmp	esi, 127
	mov	r13d, esi
	movsx	rsi, edx
	cmovg	r13d, ebp
	add	rsi, r12
	movsx	r14, r13d
	mov	rdx, r14
	call	__strncpy_chk@PLT
	lea	esi, 1[r13]
	mov	BYTE PTR [rsp+r14], 0
	mov	rdi, rax
	call	incrementElement
	mov	esi, -1
	mov	edx, -1
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L44:
	mov	esi, ecx
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L34:
	mov	rax, QWORD PTR 136[rsp]
	xor	rax, QWORD PTR fs:40
	jne	.L55
	add	rsp, 144
	.cfi_remember_state
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
.L55:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE65:
	.size	parseIdentifiers, .-parseIdentifiers
	.p2align 4
	.globl	readStringInBuffer
	.type	readStringInBuffer, @function
readStringInBuffer:
.LFB66:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L57
	jmp	readStringInBuffer.part.0
	.p2align 4,,10
	.p2align 3
.L57:
	mov	eax, 1
	ret
	.cfi_endproc
.LFE66:
	.size	readStringInBuffer, .-readStringInBuffer
	.p2align 4
	.globl	writeMapToOutputStream
	.type	writeMapToOutputStream, @function
writeMapToOutputStream:
.LFB67:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L59
	jmp	writeMapToOutputStream.part.0
	.p2align 4,,10
	.p2align 3
.L59:
	mov	eax, 1
	ret
	.cfi_endproc
.LFE67:
	.size	writeMapToOutputStream, .-writeMapToOutputStream
	.p2align 4
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
	je	.L64
	call	rand@PLT
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 65
	ret
	.p2align 4,,10
	.p2align 3
.L64:
	.cfi_restore_state
	call	rand@PLT
	add	rsp, 8
	.cfi_def_cfa_offset 8
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 97
	ret
	.cfi_endproc
.LFE68:
	.size	getRandomAlpha, .-getRandomAlpha
	.p2align 4
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
	je	.L68
	call	rand@PLT
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1717986919
	sar	ecx, 31
	sar	rdx, 34
	sub	edx, ecx
	lea	edx, [rdx+rdx*4]
	add	edx, edx
	sub	eax, edx
	add	eax, 48
	ret
	.p2align 4,,10
	.p2align 3
.L68:
	.cfi_restore_state
	xor	eax, eax
	add	rsp, 8
	.cfi_def_cfa_offset 8
	jmp	getRandomAlpha
	.cfi_endproc
.LFE69:
	.size	getRandomAlphaNum, .-getRandomAlphaNum
	.p2align 4
	.type	fillBufferRandomly.part.0, @function
fillBufferRandomly.part.0:
.LFB79:
	.cfi_startproc
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
	test	edi, edi
	jle	.L75
	xor	ebx, ebx
	mov	DWORD PTR 8[rsp], 0
	lea	r15, buffer[rip]
	lea	r13, delimiters[rip]
	.p2align 4,,10
	.p2align 3
.L74:
	call	rand@PLT
	lea	r12d, 1[rbx]
	mov	ebp, eax
	xor	eax, eax
	call	getRandomAlpha
	mov	r8d, eax
	movsx	rax, ebx
	mov	BYTE PTR [r15+rax], r8b
	mov	eax, ebp
	shr	eax, 31
	add	ebp, eax
	and	ebp, 1
	sub	ebp, eax
	cmp	ebp, 1
	jne	.L71
	xor	eax, eax
	movsx	r12, r12d
	add	ebx, 2
	call	getRandomAlphaNum
	mov	BYTE PTR [r15+r12], al
	mov	r12d, ebx
.L71:
	call	rand@PLT
	movsx	rbx, eax
	cdq
	imul	rbx, rbx, 1717986919
	sar	rbx, 33
	sub	ebx, edx
	lea	edx, [rbx+rbx*4]
	sub	eax, edx
	mov	ebx, eax
	js	.L76
	movsx	rbp, r12d
	lea	rax, buffer[rip+1]
	lea	r14, [r15+rbp]
	add	rbp, rax
	movsx	rax, ebx
	add	rbp, rax
	.p2align 4,,10
	.p2align 3
.L73:
	call	rand@PLT
	add	r14, 1
	movsx	rdx, eax
	mov	esi, eax
	imul	rdx, rdx, -368140053
	sar	esi, 31
	shr	rdx, 32
	add	edx, eax
	sar	edx, 5
	sub	edx, esi
	imul	edx, edx, 35
	sub	eax, edx
	cdqe
	movzx	eax, BYTE PTR 0[r13+rax]
	mov	BYTE PTR -1[r14], al
	cmp	r14, rbp
	jne	.L73
	lea	ebx, 1[r12+rbx]
.L72:
	add	DWORD PTR 8[rsp], 1
	mov	eax, DWORD PTR 8[rsp]
	cmp	eax, DWORD PTR 12[rsp]
	jne	.L74
.L70:
	movsx	rbx, ebx
	xor	eax, eax
	mov	BYTE PTR [r15+rbx], 0
	add	rsp, 24
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
	.p2align 4,,10
	.p2align 3
.L76:
	.cfi_restore_state
	mov	ebx, r12d
	jmp	.L72
.L75:
	xor	ebx, ebx
	lea	r15, buffer[rip]
	jmp	.L70
	.cfi_endproc
.LFE79:
	.size	fillBufferRandomly.part.0, .-fillBufferRandomly.part.0
	.p2align 4
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
	mov	ecx, eax
	imul	rdx, rdx, -368140053
	sar	ecx, 31
	shr	rdx, 32
	add	edx, eax
	sar	edx, 5
	sub	edx, ecx
	imul	edx, edx, 35
	sub	eax, edx
	lea	rdx, delimiters[rip]
	cdqe
	movzx	eax, BYTE PTR [rdx+rax]
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE70:
	.size	getRandomDelimiter, .-getRandomDelimiter
	.p2align 4
	.globl	fillBufferRandomly
	.type	fillBufferRandomly, @function
fillBufferRandomly:
.LFB71:
	.cfi_startproc
	endbr64
	cmp	edi, 14286
	jg	.L83
	jmp	fillBufferRandomly.part.0
	.p2align 4,,10
	.p2align 3
.L83:
	mov	eax, 1
	ret
	.cfi_endproc
.LFE71:
	.size	fillBufferRandomly, .-fillBufferRandomly
	.p2align 4
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
.LFB72:
	.cfi_startproc
	endbr64
	movabs	r8, 4835703278458516699
	mov	rax, rsi
	mov	r10, rdx
	sar	rsi, 63
	imul	r8
	mov	rax, rcx
	sar	rcx, 63
	imul	r9, rdi, 1000
	imul	r10, r10, 1000
	sar	rdx, 18
	sub	rdx, rsi
	lea	rdi, [r9+rdx]
	imul	r8
	mov	rax, rdi
	sar	rdx, 18
	sub	rdx, rcx
	add	r10, rdx
	sub	rax, r10
	ret
	.cfi_endproc
.LFE72:
	.size	getTimeDiff, .-getTimeDiff
	.p2align 4
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB73:
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
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	test	rdi, rdi
	jle	.L89
	mov	rbp, rdi
	xor	r15d, r15d
	xor	r12d, r12d
	mov	r14, rsp
	movabs	rbx, 4835703278458516699
	lea	r13, 16[rsp]
	.p2align 4,,10
	.p2align 3
.L87:
	mov	edi, 14284
	add	r15, 1
	mov	DWORD PTR map_size[rip], 0
	call	fillBufferRandomly.part.0
	mov	rsi, r14
	mov	edi, 1
	call	clock_gettime@PLT
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	mov	rsi, r13
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rsi, QWORD PTR 24[rsp]
	imul	rcx, QWORD PTR 16[rsp], 1000
	imul	rdi, QWORD PTR [rsp], 1000
	mov	rax, rsi
	sar	rsi, 63
	imul	rbx
	sar	rdx, 18
	sub	rdx, rsi
	mov	rsi, QWORD PTR 8[rsp]
	add	rcx, rdx
	mov	rax, rsi
	sar	rsi, 63
	imul	rbx
	sar	rdx, 18
	sub	rdx, rsi
	add	rdx, rdi
	sub	rcx, rdx
	add	r12, rcx
	cmp	rbp, r15
	jne	.L87
.L85:
	mov	rax, QWORD PTR 40[rsp]
	xor	rax, QWORD PTR fs:40
	jne	.L92
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
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
	.p2align 4,,10
	.p2align 3
.L89:
	.cfi_restore_state
	xor	r12d, r12d
	jmp	.L85
.L92:
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
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB74:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	mov	r15d, 42
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12d, edi
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rsi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	lea	rbx, .L98[rip]
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	mov	r14, QWORD PTR stdin[rip]
	mov	r13, QWORD PTR stdout[rip]
	mov	QWORD PTR 24[rsp], 0
	mov	DWORD PTR 20[rsp], 0
	mov	DWORD PTR 12[rsp], 0
	mov	DWORD PTR 16[rsp], 0
.L121:
	lea	rdx, .LC3[rip]
	mov	rsi, rbp
	mov	edi, r12d
	call	getopt@PLT
	cmp	eax, -1
	je	.L128
	cmp	eax, 63
	je	.L95
	sub	eax, 105
	cmp	eax, 11
	ja	.L121
	movsx	rax, DWORD PTR [rbx+rax*4]
	add	rax, rbx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L98:
	.long	.L102-.L98
	.long	.L121-.L98
	.long	.L121-.L98
	.long	.L121-.L98
	.long	.L121-.L98
	.long	.L121-.L98
	.long	.L101-.L98
	.long	.L121-.L98
	.long	.L121-.L98
	.long	.L100-.L98
	.long	.L99-.L98
	.long	.L97-.L98
	.section	.text.startup
.L97:
	mov	rdi, QWORD PTR optarg[rip]
	mov	edx, 10
	xor	esi, esi
	call	strtoll@PLT
	mov	DWORD PTR 12[rsp], 1
	mov	QWORD PTR 24[rsp], rax
	jmp	.L121
.L99:
	mov	rdi, QWORD PTR optarg[rip]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	r15d, eax
	jmp	.L121
.L100:
	mov	rdi, QWORD PTR optarg[rip]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	DWORD PTR 16[rsp], 1
	mov	DWORD PTR 20[rsp], eax
	jmp	.L121
.L101:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC2[rip]
	call	fopen@PLT
	mov	r13, rax
	jmp	.L121
.L102:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC1[rip]
	call	fopen@PLT
	mov	r14, rax
	jmp	.L121
.L128:
	mov	edi, r15d
	call	srand@PLT
	cmp	DWORD PTR 12[rsp], 0
	jne	.L129
	cmp	DWORD PTR 16[rsp], 0
	jne	.L130
	cmp	QWORD PTR stdin[rip], r14
	je	.L131
.L127:
	test	r14, r14
	je	.L112
	mov	rdi, r14
	call	readStringInBuffer.part.0
	cmp	eax, 1
	je	.L112
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
	test	r13, r13
	je	.L114
	mov	rdi, r13
	call	writeMapToOutputStream.part.0
	test	eax, eax
	je	.L95
.L114:
	lea	rdi, .LC9[rip]
	call	puts@PLT
.L95:
	add	rsp, 40
	.cfi_remember_state
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
.L130:
	.cfi_restore_state
	mov	eax, DWORD PTR 20[rsp]
	cmp	eax, 14286
	jg	.L107
	mov	edi, eax
	call	fillBufferRandomly.part.0
.L107:
	lea	rdi, buffer[rip]
	call	puts@PLT
	jmp	.L108
.L129:
	mov	rbx, QWORD PTR 24[rsp]
	lea	rsi, .LC4[rip]
	mov	edi, 1
	xor	eax, eax
	mov	rdx, rbx
	call	__printf_chk@PLT
	mov	rdi, rbx
	call	measureTime
	lea	rsi, .LC5[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
	jmp	.L95
.L112:
	lea	rdi, .LC7[rip]
	call	puts@PLT
	jmp	.L95
.L131:
	lea	rdi, .LC6[rip]
	call	puts@PLT
	jmp	.L127
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
