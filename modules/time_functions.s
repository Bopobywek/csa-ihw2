	.intel_syntax noprefix
	.text
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
	push	rbp						# | Пролог функции
	mov	rbp, rsp					# |
	
	mov	QWORD PTR -32[rbp], rdi		# | rbp[-32] := rsi = ts1.tv_sec
	mov	QWORD PTR -24[rbp], rsi		# | rbp[-24] := rsi = ts1.tv_nsec
	mov	QWORD PTR -48[rbp], rdx		# | rbp[-48] := rdx = ts2.tv_sec
	mov	QWORD PTR -40[rbp], rcx		# | rbp[-40] := rdx = ts2.tv_nsec
	
	mov	rax, QWORD PTR -32[rbp]		# | rax := rbp[-32] = ts1.tv_sec
	imul	rsi, rax, 1000			# | rsi := rax * 1000 = ts1.tv_sec * 1000
	mov	rcx, QWORD PTR -24[rbp]		# \ rcx := rbp[-24] = ts1.tv_nsec
	movabs	rdx, 4835703278458516699 # | /
	mov	rax, rcx					# /  |
	imul	rdx						# |  |
	sar	rdx, 18						# |  | Какая-то сложная (и наверняка оптимальная по скорости) арифметика
	mov	rax, rcx					# |  |
	sar	rax, 63						# |  |
	sub	rdx, rax					# |  |
	mov	rax, rdx					# |  \
	add	rax, rsi					# | rax := rax + rsi
	mov	QWORD PTR -8[rbp], rax		# | rbp[-8] := rax = ts1_ms
	mov	rax, QWORD PTR -48[rbp]		# | rax := rbp[-48] = ts2.tv_sec
	imul	rsi, rax, 1000			# | rsi := rax * 1000
	mov	rcx, QWORD PTR -40[rbp]		# \ rcx := rbp[-40] = ts2.tv_nsec
	movabs	rdx, 4835703278458516699 # | /
	mov	rax, rcx					# /  |
	imul	rdx						# |  |
	sar	rdx, 18						# |  |
	mov	rax, rcx					# |  | Какая-то сложная (и наверняка оптимальная по скорости) арифметика
	sar	rax, 63						# |  |
	sub	rdx, rax					# |  |
	mov	rax, rdx					# |  \
	add	rax, rsi					# | rax := rax + rsi
	mov	QWORD PTR -16[rbp], rax		# | rbp[-16] := rax = ts2_ms
	mov	rax, QWORD PTR -8[rbp]		# | rax := rbp[-8] = ts1_ms
	sub	rax, QWORD PTR -16[rbp]		# | rax := rax - rbp[-16] = ts1_ms - ts2_ms
									# | Возвращаем результат через rax
	
	pop	rbp							# | Эпилог функции
	ret								# \
	.size	getTimeDiff, .-getTimeDiff

	.globl	measureTime
	.type	measureTime, @function
measureTime:
	push	rbp						# | Пролог функции
	mov	rbp, rsp					# |
	sub	rsp, 80						# |
	
	mov	QWORD PTR -72[rbp], rdi		# | rbp[-72] := rdi = sample_size -- загружаем на стек переданный аргумент
	mov	QWORD PTR -8[rbp], 0		# | elapsed = rbp[-8] := 0
	mov	DWORD PTR -20[rbp], 14284	# | identifiers_n = rbp[-20] := 14284 = BUFFER_MAX_SIZE / 7 - 1
	mov	QWORD PTR -16[rbp], 0		# | i = rbp[-16] := 0
	jmp	.L58						# | Переходим к проверке условия продолжения цикла
.L59:
	mov	DWORD PTR map_size[rip], 0	# | rip[map_size] = map_size := 0
	mov	eax, DWORD PTR -20[rbp]		# | eax := rbp[-20] = identifiers_n
	mov	edi, eax					# | edi := eax = identifiers_n -- через edi будем передавать в функцию первый аргумент
	call	fillBufferRandomly		# | Вызываем fillBufferRandomly(edi=identifiers_n)
	lea	rax, -48[rbp]				# | rax := &rbp[-48] = rbp - 48 = &start
	mov	rsi, rax					# | rsi := rax = &start -- второй аргумент для функции
	mov	edi, 1						# | edi := 1 = CLOCK_MONOTONIC -- первый аргумент для функции
	call	clock_gettime@PLT		# | Вызываем clock_gettime(edi=1, rsi=&start) 
	lea	rdi, buffer[rip]			# | rdi := &rip[buffer] -- первый аргумент для вызова функции
	call	parseIdentifiers		# | Вызываем parseIdentifiers(rdi=&rip[buffer])
	lea	rsi, -64[rbp]				# | rax := &rbp[-64] = rbp - 64 = &end -- передаем второй аргумент 
	mov	edi, 1						# | edi := 1 = CLOCK_MONOTONIC
	call	clock_gettime@PLT		# | Вызываем clock_gettime(edi=1, rsi=&end) 
	mov	rax, QWORD PTR -48[rbp]		# | rax := rbp[-48] = start.tv_sec
	mov	rdx, QWORD PTR -40[rbp]		# |	rdx := rbp[-40] = start.tv_nsec
	mov	rdi, QWORD PTR -64[rbp]		# | rdi := rbp[-64] = end.tv_sec
	mov	rsi, QWORD PTR -56[rbp]		# | rsi := rbp[-56] = end.tv_nsec
	mov	rcx, rdx					# | rcx := rdx = start.tv_nsec
	mov	rdx, rax					# | rdx := rax = start.tv_sec
	call	getTimeDiff				# |	Вызываем getTimeDiff(rdi=end.tv_sec, rsi=end.tv_nsec, rdx=start.tv_sec, rcx=start.tv_nsec)
	add	QWORD PTR -8[rbp], rax		# | elapsed = rbp[-8] := rbp[-8] + rax //elapsed += getTimeDiff(end, start);
	add	QWORD PTR -16[rbp], 1		# | ++i
.L58:
	mov	rax, QWORD PTR -16[rbp]		# | rax := rbp[-16] = i
	cmp	rax, QWORD PTR -72[rbp]		# | Сравниваем i (rax) и sample_size (rbp[-72])
	jl	.L59						# | Если i < sample_size, переходим к телу цикла
	mov	rax, QWORD PTR -8[rbp]		# | rax := rbp[-8] = elapsed
									# | Возвращаем значение из функции через eax
									
	leave							# | Эпилог функции
	ret								# \
	.size	measureTime, .-measureTime
