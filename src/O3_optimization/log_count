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
	jle	.L23
	mov	DWORD PTR 8[rsp], 0
	xor	r15d, r15d
	lea	r14, buffer[rip]
	lea	r12, delimiters[rip]
	.p2align 4,,10
	.p2align 3
.L22:
	call	rand@PLT
	lea	ebp, 1[r15]
	mov	edx, eax
	shr	edx, 31
	lea	ebx, [rax+rdx]
	and	ebx, 1
	sub	ebx, edx
	call	rand@PLT
	test	al, 1
	je	.L28
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 65
.L15:
	movsx	rdx, r15d
	mov	BYTE PTR [r14+rdx], al
	cmp	ebx, 1
	jne	.L16
	add	r15d, 2
	call	rand@PLT
	test	al, 1
	je	.L29
	call	rand@PLT
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
.L19:
	movsx	rbp, ebp
	mov	BYTE PTR [r14+rbp], al
	mov	ebp, r15d
.L16:
	call	rand@PLT
	movsx	rbx, eax
	cdq
	imul	rbx, rbx, 1717986919
	sar	rbx, 33
	sub	ebx, edx
	lea	edx, [rbx+rbx*4]
	sub	eax, edx
	mov	ebx, eax
	js	.L24
	movsx	r15, ebp
	lea	rax, buffer[rip+1]
	lea	r13, [r14+r15]
	add	r15, rax
	movsx	rax, ebx
	add	r15, rax
	.p2align 4,,10
	.p2align 3
.L21:
	call	rand@PLT
	add	r13, 1
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
	movzx	eax, BYTE PTR [r12+rax]
	mov	BYTE PTR -1[r13], al
	cmp	r13, r15
	jne	.L21
	lea	r15d, 1[rbp+rbx]
.L20:
	add	DWORD PTR 8[rsp], 1
	mov	eax, DWORD PTR 8[rsp]
	cmp	eax, DWORD PTR 12[rsp]
	jne	.L22
.L13:
	movsx	r15, r15d
	xor	eax, eax
	mov	BYTE PTR [r14+r15], 0
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
.L28:
	.cfi_restore_state
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 97
	jmp	.L15
	.p2align 4,,10
	.p2align 3
.L29:
	call	rand@PLT
	test	al, 1
	je	.L30
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 65
	jmp	.L19
	.p2align 4,,10
	.p2align 3
.L24:
	mov	r15d, ebp
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L30:
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 97
	jmp	.L19
.L23:
	xor	r15d, r15d
	lea	r14, buffer[rip]
	jmp	.L13
	.cfi_endproc
.LFE79:
	.size	fillBufferRandomly.part.0, .-fillBufferRandomly.part.0
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
	jbe	.L33
	sub	edi, 48
	xor	r8d, r8d
	cmp	dil, 9
	setbe	r8b
.L33:
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
	jg	.L40
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L38:
	add	ebp, 1
	add	rbx, 136
	cmp	r12d, ebp
	je	.L37
.L40:
	cmp	DWORD PTR 132[rbx], r13d
	jne	.L38
	mov	rdx, r14
	mov	rsi, r15
	mov	rdi, rbx
	call	strncmp@PLT
	test	eax, eax
	jne	.L38
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
.L37:
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
	sub	rsp, 168
	.cfi_def_cfa_offset 224
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 152[rsp], rax
	xor	eax, eax
	movzx	eax, BYTE PTR [rdi]
	test	al, al
	je	.L45
	mov	r12, rdi
	xor	ebx, ebx
	mov	edx, 1
	mov	r14d, -1
	mov	rsi, -1
	jmp	.L46
	.p2align 4,,10
	.p2align 3
.L74:
	mov	edx, eax
	mov	rsi, -1
	and	edx, -33
	sub	edx, 65
	cmp	dl, 25
	jbe	.L48
.L57:
	sub	eax, 48
	xor	edx, edx
	cmp	al, 9
	seta	dl
.L55:
	add	rbx, 1
	movzx	eax, BYTE PTR [r12+rbx]
	test	al, al
	je	.L45
.L46:
	mov	ecx, ebx
	lea	edi, 1[rbx]
	test	esi, esi
	jns	.L47
	test	edx, edx
	jne	.L74
.L47:
	cmp	esi, -1
	je	.L50
	mov	edx, eax
	and	edx, -33
	sub	edx, 65
	cmp	dl, 25
	jbe	.L60
	lea	edx, -48[rax]
	cmp	dl, 9
	ja	.L75
	mov	r14d, edi
	jmp	.L57
	.p2align 4,,10
	.p2align 3
.L60:
	mov	ecx, esi
.L48:
	add	rbx, 1
	mov	r14d, edi
	movsx	rsi, ecx
	xor	edx, edx
	movzx	eax, BYTE PTR [r12+rbx]
	test	al, al
	jne	.L46
.L45:
	mov	rax, QWORD PTR 152[rsp]
	xor	rax, QWORD PTR fs:40
	jne	.L76
	add	rsp, 168
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
.L75:
	.cfi_restore_state
	sub	r14d, esi
	mov	eax, 127
	lea	r13, 16[rsp]
	mov	ecx, 128
	cmp	r14d, 127
	mov	rdi, r13
	cmovg	r14d, eax
	add	rsi, r12
	movsx	rbp, r14d
	add	r14d, 1
	mov	rdx, rbp
	call	__strncpy_chk@PLT
	mov	eax, DWORD PTR map_size[rip]
	mov	BYTE PTR 16[rsp+rbp], 0
	movsx	rdx, r14d
	mov	DWORD PTR 12[rsp], eax
	test	eax, eax
	jle	.L51
	lea	rbp, map[rip]
	xor	r15d, r15d
	movsx	rdx, r14d
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L52:
	add	r15d, 1
	add	rbp, 136
	cmp	r15d, DWORD PTR 12[rsp]
	je	.L51
.L54:
	cmp	r14d, DWORD PTR 132[rbp]
	jne	.L52
	mov	rsi, r13
	mov	rdi, rbp
	mov	QWORD PTR [rsp], rdx
	call	strncmp@PLT
	mov	rdx, QWORD PTR [rsp]
	test	eax, eax
	jne	.L52
	movsx	rcx, r15d
	mov	r14d, -1
	mov	rax, rcx
	sal	rax, 4
	add	rcx, rax
	lea	rax, map[rip]
	add	DWORD PTR 128[rax+rcx*8], 1
	movzx	eax, BYTE PTR [r12+rbx]
	.p2align 4,,10
	.p2align 3
.L50:
	mov	edx, eax
	mov	rsi, -1
	and	edx, -33
	sub	edx, 65
	cmp	dl, 25
	ja	.L57
	xor	edx, edx
	jmp	.L55
	.p2align 4,,10
	.p2align 3
.L51:
	movsx	rcx, DWORD PTR 12[rsp]
	mov	rsi, r13
	mov	rax, rcx
	mov	r15, rcx
	sal	rax, 4
	add	r15d, 1
	add	rax, rcx
	lea	rcx, map[rip]
	lea	rdi, [rcx+rax*8]
	mov	ecx, 128
	call	__strncpy_chk@PLT
	mov	DWORD PTR map_size[rip], r15d
	mov	DWORD PTR 132[rax], r14d
	mov	r14d, -1
	mov	DWORD PTR 128[rax], 1
	movzx	eax, BYTE PTR [r12+rbx]
	jmp	.L50
.L76:
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
	je	.L83
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
	lea	rbp, buffer[rip]
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	lea	r13, 99999[rbp]
	mov	rbx, rdi
	mov	r14, rbp
	mov	r15, rbp
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	jmp	.L79
	.p2align 4,,10
	.p2align 3
.L90:
	cmp	r13, r15
	je	.L89
	mov	BYTE PTR [r15], al
	add	r15, 1
.L79:
	mov	r12d, r15d
	mov	rdi, rbx
	sub	r12d, ebp
	call	fgetc@PLT
	cmp	eax, -1
	jne	.L90
	movsx	r12, r12d
	xor	eax, eax
	mov	BYTE PTR [r14+r12], 0
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
	.p2align 4,,10
	.p2align 3
.L83:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	mov	eax, 1
	ret
.L89:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
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
.LFE66:
	.size	readStringInBuffer, .-readStringInBuffer
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%s : %d\n"
	.text
	.p2align 4
	.globl	writeMapToOutputStream
	.type	writeMapToOutputStream, @function
writeMapToOutputStream:
.LFB67:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L96
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
	mov	eax, DWORD PTR map_size[rip]
	test	eax, eax
	jle	.L95
	.p2align 4,,10
	.p2align 3
.L94:
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
	jl	.L94
.L95:
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
.L96:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
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
	je	.L107
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
.L107:
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
	je	.L113
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
.L113:
	.cfi_restore_state
	call	rand@PLT
	test	al, 1
	je	.L114
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
.L114:
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
.LFE69:
	.size	getRandomAlphaNum, .-getRandomAlphaNum
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
	jg	.L118
	jmp	fillBufferRandomly.part.0
	.p2align 4,,10
	.p2align 3
.L118:
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
	mov	rax, rdi
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
	sub	rsp, 104
	.cfi_def_cfa_offset 160
	mov	QWORD PTR 24[rsp], rdi
	mov	rdi, QWORD PTR fs:40
	mov	QWORD PTR 88[rsp], rdi
	xor	edi, edi
	test	rax, rax
	jle	.L133
	lea	rax, 48[rsp]
	xor	r15d, r15d
	mov	QWORD PTR 16[rsp], 0
	lea	r13, buffer[rip]
	mov	QWORD PTR 32[rsp], rax
	lea	rax, 64[rsp]
	mov	QWORD PTR 40[rsp], rax
	.p2align 4,,10
	.p2align 3
.L131:
	mov	QWORD PTR 8[rsp], r15
	mov	r14d, 14284
	xor	ebx, ebx
	mov	DWORD PTR map_size[rip], 0
	.p2align 4,,10
	.p2align 3
.L130:
	call	rand@PLT
	lea	ebp, 1[rbx]
	mov	edx, eax
	shr	edx, 31
	lea	r12d, [rax+rdx]
	and	r12d, 1
	sub	r12d, edx
	call	rand@PLT
	test	al, 1
	je	.L139
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 65
.L123:
	movsx	rdx, ebx
	mov	BYTE PTR 0[r13+rdx], al
	cmp	r12d, 1
	je	.L140
	mov	ebx, ebp
.L124:
	call	rand@PLT
	movsx	r12, eax
	cdq
	imul	r12, r12, 1717986919
	sar	r12, 33
	sub	r12d, edx
	lea	edx, [r12+r12*4]
	sub	eax, edx
	mov	r12d, eax
	js	.L128
	movsx	rbp, ebx
	lea	rax, buffer[rip+1]
	lea	r15, 0[r13+rbp]
	add	rbp, rax
	movsx	rax, r12d
	add	rbp, rax
	.p2align 4,,10
	.p2align 3
.L129:
	call	rand@PLT
	lea	rdi, delimiters[rip]
	add	r15, 1
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
	cdqe
	movzx	eax, BYTE PTR [rdi+rax]
	mov	BYTE PTR -1[r15], al
	cmp	r15, rbp
	jne	.L129
	lea	ebx, 1[rbx+r12]
.L128:
	sub	r14d, 1
	jne	.L130
	mov	rsi, QWORD PTR 32[rsp]
	mov	edi, 1
	movsx	rbx, ebx
	mov	r15, QWORD PTR 8[rsp]
	mov	BYTE PTR 0[r13+rbx], 0
	call	clock_gettime@PLT
	lea	rdi, buffer[rip]
	add	r15, 1
	call	parseIdentifiers
	mov	rsi, QWORD PTR 40[rsp]
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rsi, QWORD PTR 72[rsp]
	movabs	rax, 4835703278458516699
	imul	rcx, QWORD PTR 64[rsp], 1000
	imul	rdi, QWORD PTR 48[rsp], 1000
	imul	rsi
	sar	rsi, 63
	movabs	rax, 4835703278458516699
	sar	rdx, 18
	sub	rdx, rsi
	mov	rsi, QWORD PTR 56[rsp]
	add	rcx, rdx
	imul	rsi
	sar	rsi, 63
	sar	rdx, 18
	sub	rdx, rsi
	add	rdx, rdi
	sub	rcx, rdx
	add	QWORD PTR 16[rsp], rcx
	cmp	QWORD PTR 24[rsp], r15
	jne	.L131
.L120:
	mov	rax, QWORD PTR 88[rsp]
	xor	rax, QWORD PTR fs:40
	jne	.L141
	mov	rax, QWORD PTR 16[rsp]
	add	rsp, 104
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
.L140:
	.cfi_restore_state
	add	ebx, 2
	call	rand@PLT
	test	al, 1
	je	.L142
	call	rand@PLT
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
.L127:
	movsx	rbp, ebp
	mov	BYTE PTR 0[r13+rbp], al
	jmp	.L124
	.p2align 4,,10
	.p2align 3
.L139:
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 97
	jmp	.L123
	.p2align 4,,10
	.p2align 3
.L142:
	call	rand@PLT
	test	al, 1
	je	.L143
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 65
	jmp	.L127
	.p2align 4,,10
	.p2align 3
.L143:
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1321528399
	sar	ecx, 31
	sar	rdx, 35
	sub	edx, ecx
	imul	edx, edx, 26
	sub	eax, edx
	add	eax, 97
	jmp	.L127
	.p2align 4,,10
	.p2align 3
.L133:
	mov	QWORD PTR 16[rsp], 0
	jmp	.L120
.L141:
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
	xor	r15d, r15d
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	mov	r14d, 42
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
	lea	rbx, .L149[rip]
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	mov	rax, QWORD PTR stdin[rip]
	mov	r13, QWORD PTR stdout[rip]
	mov	QWORD PTR 24[rsp], 0
	mov	QWORD PTR 8[rsp], rax
	mov	DWORD PTR 20[rsp], 0
	mov	DWORD PTR 16[rsp], 0
.L173:
	lea	rdx, .LC3[rip]
	mov	rsi, rbp
	mov	edi, r12d
	call	getopt@PLT
	cmp	eax, -1
	je	.L178
	cmp	eax, 63
	je	.L146
	sub	eax, 105
	cmp	eax, 11
	ja	.L173
	movsx	rax, DWORD PTR [rbx+rax*4]
	add	rax, rbx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L149:
	.long	.L153-.L149
	.long	.L173-.L149
	.long	.L173-.L149
	.long	.L173-.L149
	.long	.L173-.L149
	.long	.L173-.L149
	.long	.L152-.L149
	.long	.L173-.L149
	.long	.L173-.L149
	.long	.L151-.L149
	.long	.L150-.L149
	.long	.L148-.L149
	.section	.text.startup
.L148:
	mov	rdi, QWORD PTR optarg[rip]
	mov	edx, 10
	xor	esi, esi
	mov	r15d, 1
	call	strtoll@PLT
	mov	QWORD PTR 24[rsp], rax
	jmp	.L173
.L150:
	mov	rdi, QWORD PTR optarg[rip]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	r14d, eax
	jmp	.L173
.L151:
	mov	rdi, QWORD PTR optarg[rip]
	mov	edx, 10
	xor	esi, esi
	call	strtol@PLT
	mov	DWORD PTR 16[rsp], 1
	mov	DWORD PTR 20[rsp], eax
	jmp	.L173
.L152:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC2[rip]
	call	fopen@PLT
	mov	r13, rax
	jmp	.L173
.L153:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC1[rip]
	call	fopen@PLT
	mov	QWORD PTR 8[rsp], rax
	jmp	.L173
.L163:
	lea	rdi, .LC7[rip]
	call	puts@PLT
.L146:
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
.L178:
	.cfi_restore_state
	mov	edi, r14d
	call	srand@PLT
	test	r15d, r15d
	jne	.L179
	cmp	DWORD PTR 16[rsp], 0
	jne	.L180
	mov	rax, QWORD PTR 8[rsp]
	cmp	QWORD PTR stdin[rip], rax
	je	.L181
	mov	rax, QWORD PTR 8[rsp]
	test	rax, rax
	je	.L163
	mov	rdi, rax
	call	readStringInBuffer.part.0
.L162:
	cmp	eax, 1
	je	.L163
	cmp	eax, 2
	jne	.L159
	mov	edx, 99999
	lea	rsi, .LC8[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
.L159:
	lea	rdi, buffer[rip]
	lea	rbx, map[rip]
	call	parseIdentifiers
	lea	rbp, .LC0[rip]
	test	r13, r13
	jne	.L165
	jmp	.L182
.L166:
	mov	r8d, DWORD PTR 128[rbx]
	mov	rcx, rbx
	mov	rdx, rbp
	mov	rdi, r13
	mov	esi, 1
	xor	eax, eax
	add	r15d, 1
	add	rbx, 136
	call	__fprintf_chk@PLT
.L165:
	cmp	r15d, DWORD PTR map_size[rip]
	jl	.L166
	jmp	.L146
.L180:
	mov	eax, DWORD PTR 20[rsp]
	cmp	eax, 14286
	jg	.L158
	mov	edi, eax
	call	fillBufferRandomly.part.0
.L158:
	lea	rdi, buffer[rip]
	call	puts@PLT
	jmp	.L159
.L182:
	lea	rdi, .LC9[rip]
	call	puts@PLT
	jmp	.L146
.L179:
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
	jmp	.L146
.L181:
	lea	rdi, .LC6[rip]
	call	puts@PLT
	cmp	QWORD PTR 8[rsp], 0
	je	.L163
	mov	rdi, QWORD PTR 8[rsp]
	call	readStringInBuffer.part.0
	jmp	.L162
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
