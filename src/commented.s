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
	endbr64							# /
	push	rbp						# |	Пролог функции
	mov	rbp, rsp					# |
	
	mov	DWORD PTR -4[rbp], edi		# | rbp[-4] := edi -- кладём на стек первый аргумент (int a)
	mov	DWORD PTR -8[rbp], esi		# | rbp[-8] := edi -- кладём на стек второй аргумент (int b)
	mov	eax, DWORD PTR -4[rbp]		# | eax := rbp[-4] <=> eax := a
	cmp	eax, DWORD PTR -8[rbp]		# | Сравниваем a (eax) и b (rbp[-8])
	jge	.L2							# |	Если a >= b, переходим на метку .L2
	mov	eax, DWORD PTR -4[rbp]		# |	Иначе возвращаем a через eax: eax := rbp[-4] = a
	jmp	.L3							# | Переходим к эпилогу
.L2:		
	mov	eax, DWORD PTR -8[rbp]		# | Возвращаем b через eax: eax := rbp[-8] = b
.L3:
	pop	rbp							# | Эпилог функции  
	ret								# \
	.size	min, .-min
	.globl	isAlpha
	.type	isAlpha, @function
isAlpha:			
	endbr64							# /
	push	rbp						# | Пролог фнукции
	mov	rbp, rsp					# |
	
	mov	eax, edi					# | eax := edi -- загружаем в регистр eax первый аргумент (char ch)
	mov	BYTE PTR -4[rbp], al		# | rbp[-4] := al -- загружаем на стек первый аргумент (ch)
	cmp	BYTE PTR -4[rbp], 96		# | Сравниваем ch (rbp[-4]) и 96 ('`' -- символ перед 'a')
	jle	.L5							# | Если ch <= 96, переходим на метку .L5, в которой проверим второй операнд ||
	cmp	BYTE PTR -4[rbp], 122		# | Иначе проверяем второй операнд &&: сравниваем ch (rbp[-4]) и 122 ('z')
	jle	.L6							# | Если ch <= 122, то условие выполнено, можем не проверять второй операнд ||, поэтому переходим к возврату значения на метку .L6
.L5:								# | В .L5 проверяем ('A' <= ch && ch <= 'Z')
	cmp	BYTE PTR -4[rbp], 64		# | Сравниваем ch (rbp[-4]) и 64 ('@' -- символ перед 'A')
	jle	.L7							# | Если ch <= 64, условие точно ложно, переходим на метку .L7 
	cmp	BYTE PTR -4[rbp], 90		# | Сравниваем ch (rbp[-4]) и 90 ('Z')
	jg	.L7							# | Если ch > 90, условие ложно, переходим на метку .L7
.L6:
	mov	eax, 1						# | Возвращаем 1 через eax 
	jmp	.L9							# | Переходим к эпилогу
.L7:
	mov	eax, 0						# | Возвращаем 0 через eax
.L9:
	pop	rbp							# | Эпилог функции
	ret								# \
	
	.size	isAlpha, .-isAlpha
	.globl	isAlphaOrNum
	.type	isAlphaOrNum, @function
isAlphaOrNum:
	endbr64
	push	rbp
	mov	rbp, rsp
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
	ret
	.size	isAlphaOrNum, .-isAlphaOrNum
	.globl	incrementElement
	.type	incrementElement, @function
incrementElement:
	endbr64
	push	rbp
	mov	rbp, rsp
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
	ret
	.size	incrementElement, .-incrementElement
	.globl	parseIdentifiers
	.type	parseIdentifiers, @function
parseIdentifiers:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 176
	mov	QWORD PTR -168[rbp], rdi
	mov	DWORD PTR -4[rbp], -1
	mov	DWORD PTR -8[rbp], -1
	mov	DWORD PTR -12[rbp], 1
	mov	DWORD PTR -16[rbp], 0
	jmp	.L21
.L25:
	cmp	DWORD PTR -12[rbp], 0
	je	.L22
	cmp	DWORD PTR -4[rbp], 0
	jns	.L22
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -168[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	isAlpha
	test	eax, eax
	je	.L22
	mov	eax, DWORD PTR -16[rbp]
	mov	DWORD PTR -4[rbp], eax
	mov	eax, DWORD PTR -16[rbp]
	add	eax, 1
	mov	DWORD PTR -8[rbp], eax
	jmp	.L23
.L22:
	cmp	DWORD PTR -4[rbp], 0
	js	.L24
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -168[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	isAlphaOrNum
	test	eax, eax
	je	.L24
	mov	eax, DWORD PTR -16[rbp]
	add	eax, 1
	mov	DWORD PTR -8[rbp], eax
	jmp	.L23
.L24:
	cmp	DWORD PTR -4[rbp], 0
	js	.L23
	mov	eax, DWORD PTR -8[rbp]
	sub	eax, DWORD PTR -4[rbp]
	mov	esi, 127
	mov	edi, eax
	call	min
	mov	DWORD PTR -20[rbp], eax
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	eax, DWORD PTR -4[rbp]
	movsx	rcx, eax
	mov	rax, QWORD PTR -168[rbp]
	add	rcx, rax
	lea	rax, -160[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	strncpy@PLT
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	mov	BYTE PTR -160[rbp+rax], 0
	mov	eax, DWORD PTR -20[rbp]
	lea	edx, 1[rax]
	lea	rax, -160[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	incrementElement
	mov	DWORD PTR -4[rbp], -1
	mov	DWORD PTR -8[rbp], -1
.L23:
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -168[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	isAlphaOrNum
	test	eax, eax
	sete	al
	movzx	eax, al
	mov	DWORD PTR -12[rbp], eax
	add	DWORD PTR -16[rbp], 1
.L21:
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -168[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L25
	nop
	nop
	leave
	ret
	.size	parseIdentifiers, .-parseIdentifiers
	.globl	readStringInBuffer
	.type	readStringInBuffer, @function
readStringInBuffer:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	cmp	QWORD PTR -24[rbp], 0
	jne	.L27
	mov	eax, 1
	jmp	.L28
.L27:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L29
.L31:
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx
	mov	edx, DWORD PTR -8[rbp]
	mov	ecx, edx
	cdqe
	lea	rdx, buffer[rip]
	mov	BYTE PTR [rax+rdx], cl
.L29:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	DWORD PTR -8[rbp], eax
	cmp	DWORD PTR -8[rbp], -1
	je	.L30
	cmp	DWORD PTR -4[rbp], 99998
	jle	.L31
.L30:
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx
	cdqe
	lea	rdx, buffer[rip]
	mov	BYTE PTR [rax+rdx], 0
	cmp	DWORD PTR -8[rbp], -1
	je	.L32
	cmp	DWORD PTR -4[rbp], 100000
	jne	.L32
	mov	eax, 2
	jmp	.L28
.L32:
	mov	eax, 0
.L28:
	leave
	ret
	.size	readStringInBuffer, .-readStringInBuffer
	.section	.rodata
.LC0:
	.string	"%s : %d\n"
	.text
	.globl	writeMapToOutputStream
	.type	writeMapToOutputStream, @function
writeMapToOutputStream:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	cmp	QWORD PTR -24[rbp], 0
	jne	.L34
	mov	eax, 1
	jmp	.L35
.L34:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L36
.L37:
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
.L36:
	mov	eax, DWORD PTR map_size[rip]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L37
	mov	eax, 0
.L35:
	leave
	ret
	.size	writeMapToOutputStream, .-writeMapToOutputStream
	.globl	getRandomAlpha
	.type	getRandomAlpha, @function
getRandomAlpha:
	endbr64
	push	rbp
	mov	rbp, rsp
	call	rand@PLT
	and	eax, 1
	test	eax, eax
	jne	.L39
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
	jmp	.L40
.L39:
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
.L40:
	pop	rbp
	ret
	.size	getRandomAlpha, .-getRandomAlpha
	.globl	getRandomAlphaNum
	.type	getRandomAlphaNum, @function
getRandomAlphaNum:
	endbr64
	push	rbp
	mov	rbp, rsp
	call	rand@PLT
	and	eax, 1
	test	eax, eax
	jne	.L42
	mov	eax, 0
	call	getRandomAlpha
	jmp	.L43
.L42:
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
.L43:
	pop	rbp
	ret
	.size	getRandomAlphaNum, .-getRandomAlphaNum
	.globl	getRandomDelimiter
	.type	getRandomDelimiter, @function
getRandomDelimiter:
	endbr64
	push	rbp
	mov	rbp, rsp
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
	ret
	.size	getRandomDelimiter, .-getRandomDelimiter
	.globl	fillBufferRandomly
	.type	fillBufferRandomly, @function
fillBufferRandomly:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56
	mov	DWORD PTR -52[rbp], edi
	mov	eax, DWORD PTR -52[rbp]
	mov	DWORD PTR -36[rbp], eax
	cmp	DWORD PTR -52[rbp], 14286
	jle	.L47
	mov	eax, 1
	jmp	.L48
.L47:
	mov	DWORD PTR -20[rbp], 0
	mov	DWORD PTR -24[rbp], 0
	jmp	.L49
.L54:
	call	rand@PLT
	cdq
	shr	edx, 31
	add	eax, edx
	and	eax, 1
	sub	eax, edx
	add	eax, 1
	mov	DWORD PTR -40[rbp], eax
	mov	ebx, DWORD PTR -20[rbp]
	lea	eax, 1[rbx]
	mov	DWORD PTR -20[rbp], eax
	mov	eax, 0
	call	getRandomAlpha
	movsx	rdx, ebx
	lea	rcx, buffer[rip]
	mov	BYTE PTR [rdx+rcx], al
	mov	DWORD PTR -28[rbp], 1
	jmp	.L50
.L51:
	mov	ebx, DWORD PTR -20[rbp]
	lea	eax, 1[rbx]
	mov	DWORD PTR -20[rbp], eax
	mov	eax, 0
	call	getRandomAlphaNum
	movsx	rdx, ebx
	lea	rcx, buffer[rip]
	mov	BYTE PTR [rdx+rcx], al
	add	DWORD PTR -28[rbp], 1
.L50:
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -40[rbp]
	jl	.L51
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
	mov	DWORD PTR -44[rbp], eax
	mov	DWORD PTR -32[rbp], 0
	jmp	.L52
.L53:
	mov	ebx, DWORD PTR -20[rbp]
	lea	eax, 1[rbx]
	mov	DWORD PTR -20[rbp], eax
	mov	eax, 0
	call	getRandomDelimiter
	movsx	rdx, ebx
	lea	rcx, buffer[rip]
	mov	BYTE PTR [rdx+rcx], al
	add	DWORD PTR -32[rbp], 1
.L52:
	mov	eax, DWORD PTR -32[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jl	.L53
	add	DWORD PTR -24[rbp], 1
.L49:
	mov	eax, DWORD PTR -24[rbp]
	cmp	eax, DWORD PTR -36[rbp]
	jl	.L54
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	lea	rdx, buffer[rip]
	mov	BYTE PTR [rax+rdx], 0
	mov	eax, 0
.L48:
	add	rsp, 56
	pop	rbx
	pop	rbp
	ret
	.size	fillBufferRandomly, .-fillBufferRandomly
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
	endbr64
	push	rbp
	mov	rbp, rsp
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
	mov	QWORD PTR -8[rbp], rax
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
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]
	pop	rbp
	ret
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR -72[rbp], rdi
	mov	QWORD PTR -8[rbp], 0
	mov	DWORD PTR -20[rbp], 14284
	mov	QWORD PTR -16[rbp], 0
	jmp	.L58
.L59:
	mov	DWORD PTR map_size[rip], 0
	mov	eax, DWORD PTR -20[rbp]
	mov	edi, eax
	call	fillBufferRandomly
	lea	rax, -48[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdx, QWORD PTR -40[rbp]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	getTimeDiff
	add	QWORD PTR -8[rbp], rax
	add	QWORD PTR -16[rbp], 1
.L58:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -72[rbp]
	jl	.L59
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
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
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	mov	rax, QWORD PTR stdin[rip]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -20[rbp], 0
	mov	DWORD PTR -24[rbp], 0
	mov	DWORD PTR -28[rbp], 42
	mov	DWORD PTR -32[rbp], 0
	mov	QWORD PTR -40[rbp], 0
	jmp	.L62
.L70:
	cmp	DWORD PTR -48[rbp], 116
	je	.L63
	cmp	DWORD PTR -48[rbp], 116
	jg	.L62
	cmp	DWORD PTR -48[rbp], 115
	je	.L64
	cmp	DWORD PTR -48[rbp], 115
	jg	.L62
	cmp	DWORD PTR -48[rbp], 114
	je	.L65
	cmp	DWORD PTR -48[rbp], 114
	jg	.L62
	cmp	DWORD PTR -48[rbp], 111
	je	.L66
	cmp	DWORD PTR -48[rbp], 111
	jg	.L62
	cmp	DWORD PTR -48[rbp], 63
	je	.L67
	cmp	DWORD PTR -48[rbp], 105
	je	.L68
	jmp	.L62
.L65:
	mov	DWORD PTR -20[rbp], 1
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -32[rbp], eax
	jmp	.L62
.L68:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	jmp	.L62
.L66:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	jmp	.L62
.L64:
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -28[rbp], eax
	jmp	.L62
.L63:
	mov	DWORD PTR -24[rbp], 1
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -40[rbp], rax
	jmp	.L62
.L67:
	mov	eax, 0
	jmp	.L69
.L62:
	mov	rcx, QWORD PTR -80[rbp]
	mov	eax, DWORD PTR -68[rbp]
	lea	rdx, .LC3[rip]
	mov	rsi, rcx
	mov	edi, eax
	call	getopt@PLT
	mov	DWORD PTR -48[rbp], eax
	cmp	DWORD PTR -48[rbp], -1
	jne	.L70
	mov	eax, DWORD PTR -28[rbp]
	mov	edi, eax
	call	srand@PLT
	cmp	DWORD PTR -24[rbp], 0
	je	.L71
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rax
	lea	rdi, .LC4[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	measureTime
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	rsi, rax
	lea	rdi, .LC5[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L69
.L71:
	mov	DWORD PTR -44[rbp], 0
	cmp	DWORD PTR -20[rbp], 0
	je	.L72
	mov	eax, DWORD PTR -32[rbp]
	mov	edi, eax
	call	fillBufferRandomly
	lea	rdi, buffer[rip]
	call	puts@PLT
	jmp	.L73
.L72:
	mov	rax, QWORD PTR stdin[rip]
	cmp	QWORD PTR -8[rbp], rax
	jne	.L74
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	readStringInBuffer
	mov	DWORD PTR -44[rbp], eax
	jmp	.L73
.L74:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	readStringInBuffer
	mov	DWORD PTR -44[rbp], eax
.L73:
	cmp	DWORD PTR -44[rbp], 1
	jne	.L75
	lea	rdi, .LC7[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L69
.L75:
	cmp	DWORD PTR -44[rbp], 2
	jne	.L76
	mov	esi, 99999
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT
.L76:
	lea	rdi, buffer[rip]
	call	parseIdentifiers
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	writeMapToOutputStream
	mov	DWORD PTR -44[rbp], eax
	cmp	DWORD PTR -44[rbp], 0
	je	.L77
	lea	rdi, .LC9[rip]
	call	puts@PLT
.L77:
	mov	eax, 0
.L69:
	leave
	ret
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
