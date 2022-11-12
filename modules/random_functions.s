	.intel_syntax noprefix
	.text
	.globl	getRandomAlpha
	.type	getRandomAlpha, @function
getRandomAlpha:
	push	rbp						# / 
	mov	rbp, rsp					# | Пролог функции
	
	call	rand@PLT				# | Вызываем rand()
									# | Функция rand вернула значение через eax
	and	eax, 1						# | eax := eax & 1 (получаем младший бит для проверки на четность)
	test	eax, eax				# | Побитовое И без изменения самого eax
	jne	.L39						# | Если eax != 0 => ZF = 0 => переходим на метку .L39
	call	rand@PLT				# | Вызываем rand()
									# | Функция rand вернула значение через eax
	movsx	rdx, eax				# | rdx := eax = rand()
	imul	rdx, rdx, 1321528399	# | /
	shr	rdx, 32						# | |
	mov	ecx, edx					# | | В этом блоке оптимально по скорости вычисляется rand % 26
	sar	ecx, 3						# | | Результат вычисления сохраняется в eax
	cdq								# | | div не используется, так как он не очень быстрый
	sub	ecx, edx					# | | Прочитал вот тут: https://stackoverflow.com/questions/4361979/how-does-the-gcc-implementation-of-modulo-work-and-why-does-it-not-use-the
	mov	edx, ecx					# | |
	imul	edx, edx, 26			# | |
	sub	eax, edx					# | |
	mov	edx, eax					# | |
	mov	eax, edx					# | \
	add	eax, 97						# | eax := eax + 97 // (rand() % 26) + 'a'
	jmp	.L40						# | Через eax возвращаем значение, так как оно уже там, можем переходить к эпилогу функции
.L39:
	call	rand@PLT				# | Вызываем rand()
									# | Функция rand вернула значение через eax
	movsx	rdx, eax				# |	/
	imul	rdx, rdx, 1321528399	# | |
	shr	rdx, 32						# | |
	mov	ecx, edx					# | |
	sar	ecx, 3						# | | В этом блоке оптимально по скорости вычисляется rand % 26
	cdq								# | | Результат вычисления сохраняется в eax
	sub	ecx, edx					# | |
	mov	edx, ecx					# | |
	imul	edx, edx, 26			# | | 
	sub	eax, edx					# | |
	mov	edx, eax					# | |
	mov	eax, edx					# | \
	add	eax, 65						# | eax := eax + 65 // (rand() % 26) + 'A'
									# | Через eax возвращаем значение
.L40:
	pop	rbp							# | Эпилог функции 
	ret								# \
	.size	getRandomAlpha, .-getRandomAlpha

	.globl	getRandomAlphaNum
	.type	getRandomAlphaNum, @function
getRandomAlphaNum:
	push	rbp						# | Пролог функции
	mov	rbp, rsp					# |
	
	call	rand@PLT				# | Вызываем rand()
									# | Функция вернула результата через eax
	and	eax, 1						# | eax := eax & 1 (получаем младший бит для проверки на четность)
	test	eax, eax				# | Побитовое И без изменения самого eax
	jne	.L42						# | Если eax != 0 => ZF = 0 => переходим на метку .L42
	mov	eax, 0						# | eax := 0
	call	getRandomAlpha			# | Вызываем getRandomAlpha()
	jmp	.L43						# | Так как функция getRandomAlpha тоже возвращает значение через eax, можем сразу переходить к эпилогу
.L42:
	call	rand@PLT				# | Вызываем rand()
									# | Функция rand вернула значение через eax
	mov	edx, eax					# | /
	movsx	rax, edx				# |	|
	imul	rax, rax, 1717986919	# |	|
	shr	rax, 32						# |	|
	mov	ecx, eax					# |	|
	sar	ecx, 2						# |	|
	mov	eax, edx					# |	| В этом блоке оптимально по скорости вычисляется rand % 10
	sar	eax, 31						# |	| Результат вычисления сохраняется в eax
	sub	ecx, eax					# | |
	mov	eax, ecx					# | |
	sal	eax, 2						# | |
	add	eax, ecx					# | |
	add	eax, eax					# | |
	sub	edx, eax					# | |
	mov	ecx, edx					# | |
	mov	eax, ecx					# | \
	add	eax, 48						# | eax := eax + 48 // (rand() % 10) + '0'
									# | Возвращаем значение через eax
.L43:
	pop	rbp							# | Эпилог функции
	ret								# \
	.size	getRandomAlphaNum, .-getRandomAlphaNum

	.globl	getRandomDelimiter
	.type	getRandomDelimiter, @function
getRandomDelimiter:
	push	rbp						# | Пролог функции
	mov	rbp, rsp					# |
	
	call	rand@PLT				# | Вызываем rand()
									# | Функция rand вернула значение через eax
	movsx	rdx, eax				# | /
	imul	rdx, rdx, -368140053	# | |
	shr	rdx, 32						# | |
	add	edx, eax					# | |
	mov	ecx, edx					# | | 
	sar	ecx, 5						# | | В этом блоке оптимально по скорости вычисляется rand % 35
	cdq								# | | Результат вычисления сохраняется в rax
	sub	ecx, edx					# | | 
	mov	edx, ecx					# | |
	imul	edx, edx, 35			# | |
	sub	eax, edx					# | |
	mov	edx, eax					# | |
	movsx	rax, edx				# | \
	lea	rdx, delimiters[rip]		# | rdx := &rip[delimiters] -- адрес на начало массива delimiters 
	movzx	eax, BYTE PTR [rax+rdx]	# | eax := [rax+rdx] // return delimiters[rand() % 35]
									# | Через eax возвращаем значение
									
	pop	rbp							# | Эпилог функции
	ret								# \
	.size	getRandomDelimiter, .-getRandomDelimiter

	.globl	fillBufferRandomly
	.type	fillBufferRandomly, @function
fillBufferRandomly:
	push	rbp						# /
	mov	rbp, rsp					# | Пролог функции
	push	rbx						# |
	sub	rsp, 56						# |
	
	mov	DWORD PTR -36[rbp], edi		# | identifiers_n = rbp[-36] := edi = n
	cmp	edi, 14286					# |	Сравниваем n (edi) и 14286 (BUFFER_MAX_SIZE / 7 + 1)
	jle	.L47						# | Если n <= (BUFFER_MAX_SIZE / 7 + 1), переходим к инициализации переменных перед циклом
	mov	eax, 1						# | Иначе через eax возвращаем 1 
	jmp	.L48						# | И переходим к эпилогу
.L47:
	mov	r12d, 0						# | pos = r12d := 0
	mov	DWORD PTR -24[rbp], 0		# | i = rbp[-24] := 0
	jmp	.L49						# | Переходим к проверке условия продолжения цикла
.L54:
	call	rand@PLT				# | Вызываем rand(), функция возвращает значение через eax
	cdq								# | /
	shr	edx, 31						# | |
	add	eax, edx					# | | Вычисляем rand() % 2, результат вычисления в eax
	and	eax, 1						# | |
	sub	eax, edx					# | \
	add	eax, 1						# | eax := eax + 1 // (rand() % 2) + 1
	mov	r14d, eax					# | identifier_length = r14d := eax
	mov	ebx, r12d					# |	ebx := r12d = pos
	lea	eax, 1[rbx]					# |	eax := &rbx[1] = rbx + 1 = pos + 1
	mov	r12d, eax					# |	pos = r12d := eax = pos + 1
	mov	eax, 0						# | eax := 0
	call	getRandomAlpha			# | Вызываем getRandomAlpha(), функция вернула значение через eax
	movsx	rdx, ebx				# | rdx := ebx = pos (dword to qword sign-extension)
	lea	rcx, buffer[rip]			# | rcx := &rip[buffer]
	mov	BYTE PTR [rdx+rcx], al		# | buffer[pos] = [rdx+rcx] := al
	mov	r13d, 1						# | j = r13d := 1
	jmp	.L50						# | Переходим к проверке условия продолжения первого вложенного цикла
.L51:
	mov	ebx, r12d					# | ebx := r12d = pos
	lea	eax, 1[rbx]					# | eax := &rbx[1] = rbx + 1 = pos + 1
	mov	r12d, eax					# | pos = r12d := eax = pos + 1
	mov	eax, 0						# | eax := 0
	call	getRandomAlphaNum		# | Вызываем getRandomAlphaNum, функция вернула значение через eax
	movsx	rdx, ebx				# | rdx := ebx = pos
	lea	rcx, buffer[rip]			# | rcx := &rip[buffer] -- адрес на начало массива
	mov	BYTE PTR [rdx+rcx], al		# | buffer[pos] = [rdx+rcx] := al
	add	r13d, 1						# | ++j
.L50:		
	mov	eax, r13d					# | eax := r13d = i
	cmp	eax, r14d					# | Сравниваем j (eax) и identifier_length (r14d)
	jl	.L51						# | Если j < identifier_length, переходим к телу цикла
	call	rand@PLT				# | Вызываем rand(), функция вернула значение через eax
	mov	ecx, eax					# | ecx := eax
	movsx	rax, ecx				# | /
	imul	rax, rax, 1717986919	# | |
	shr	rax, 32						# | |
	mov	edx, eax					# | |
	sar	edx							# | | Вычисляем rand() % 5
	mov	eax, ecx					# | | В edx будет результат вычисления 
	sar	eax, 31						# | |
	sub	edx, eax					# | |
	mov	eax, edx					# | |
	sal	eax, 2						# | |
	add	eax, edx					# | |
	sub	ecx, eax					# | |
	mov	edx, ecx					# | \
	lea	eax, 1[rdx]					# | eax := &rdx[1] = rdx + 1
	mov	DWORD PTR -44[rbp], eax		# | delimiter_length = rbp[-44] := eax // int delimiter_length = 1 + (rand() % 5)
	mov	DWORD PTR -32[rbp], 0		# | j (new) = rbp[-32] := 0
	jmp	.L52						# | Переходим к проверке условия продолжения второго вложенного цикла
.L53:				
	mov	ebx, r12d					# | ebx := pos
	lea	eax, 1[rbx]					# | eax := &rbx[1] = rbx + 1 = pos + 1
	mov	r12d, eax					# | pos = r12d := eax = pos + 1
	mov	eax, 0						# | eax := 0
	call	getRandomDelimiter		# | Вызываем getRandomDelimiter(), функция вернула значения через eax
	movsx	rdx, ebx				# | rdx := ebx
	lea	rcx, buffer[rip]			# | rcx := &rip[buffer] -- адрес на начало массива
	mov	BYTE PTR [rdx+rcx], al		# | buffer[pos] = [rdx+rcx] := al
	add	DWORD PTR -32[rbp], 1		# | ++j
.L52:
	mov	eax, DWORD PTR -32[rbp]		# |	eax := rbp[-32] = j
	cmp	eax, DWORD PTR -44[rbp]		# |	Сравниваем j (eax) и delimiter_length (rbp[-44])
	jl	.L53						# |	Если j < delimiter_length, переходим к телу цикла
	add	DWORD PTR -24[rbp], 1		# | ++i
.L49:
	mov	eax, DWORD PTR -24[rbp]		# | eax := i
	cmp	eax, DWORD PTR -36[rbp]		# | Сравниваем i (eax) и identifiers_n (rbp[-36])
	jl	.L54						# | Если i < identifiers_n, переходим к телу цикла на метку .L54
	mov	eax, r12d					# | eax := r12d = pos
	cdqe							# | rax := sign-extend of eax. Копирует знак (31 бит) в старшие 32 бита регистра rax
	lea	rdx, buffer[rip]			# | rdx := &rip[buffer] -- адрес на начало массива
	mov	BYTE PTR [rax+rdx], 0		# | buffer[pos] = [rax+rdx] := 0 = '\0'
	mov	eax, 0						# | Возвращаем 0 через eax
.L48:
	add	rsp, 56						# |
	pop	rbx							# | Эпилог функции
	pop	rbp							# |
	ret								# \
	.size	fillBufferRandomly, .-fillBufferRandomly
