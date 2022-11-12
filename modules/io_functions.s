	.intel_syntax noprefix
	.text
	.globl	readStringInBuffer
	.type	readStringInBuffer, @function
readStringInBuffer:
	push	rbp						# / 
	mov	rbp, rsp					# | Пролог функции
	sub	rsp, 32						# | 
	
	mov	r12, rdi					# |	r12 := rdi -- загружаем в регистр первый аргумент (FILE *stream)
	cmp	r12, 0						# | Сравниваем stream (r12) и NULL (0)
	jne	.L27						# | Если не равны, переходим к инициализации счётчика pos
	mov	eax, 1						# | Иначе возвращаем 1 через eax // return 1
	jmp	.L28						# | И переходим к эпилогу функции
.L27:
	mov	r13d, 0						# | pos = r13d := 0
	jmp	.L29						# | Переходим к проверке условия продолжения цикла
.L31:								# | Тело цикла
	mov	eax, r13d					# | eax := r13d = pos
	lea	edx, 1[rax]					# | edx := &rax[1] = rax + 1 = pos + 1
	mov	r13d, edx					# | pos = r13d := edx = pos + 1
	mov	edx, r14d					# | edx := r14d = ch
	mov	ecx, edx					# | ecx := edx = ch
	cdqe							# | rax := sign-extend of eax. Копирует знак (31 бит) в старшие 32 бита регистра rax
	lea	rdx, buffer[rip]			# | rdx := &rip[buffer] -- адрес начала буфера 
	mov	BYTE PTR [rax+rdx], cl		# | buffer[pos] = buffer + pos = [rax+rdx] := cl = ch
.L29:
	mov	rax, r12					# | rax := r12 = stream
	mov	rdi, rax					# | rdi := rax = stream -- передаем через rdi первый аргумент
	call	fgetc@PLT				# | Вызываем fgetc(rdi=stream)
									# | Функция вернула через eax считанный символ в представлении через int или EOF == -1
	mov	r14d, eax					# | int ch = r14d := eax
	cmp	r14d, -1					# | Сравниваем ch (r14d) и -1 (EOF)
	je	.L30						# | Если равны, происходит выход из цикла, так как условие продолжения ложно
	cmp	r13d, 99998					# | Сравниваем pos (r13d) и 99998 (BUFFER_MAX_SIZE - 2)
	jle	.L31						# | Если pos <= 99998, условие продолжения цикла истинно, поэтому переходим к телу цикла
.L30:
	mov	eax, r13d					# | eax := r13d = pos
	lea	edx, 1[rax]					# | edx := &rax[1] = rax + 1 = pos + 1
	mov	r13d, edx					# | pos = r13d := edx = pos + 1
	cdqe							# | rax := sign-extend of eax. Копирует знак (31 бит) в старшие 32 бита регистра rax
	lea	rdx, buffer[rip]			# | rdx := &rip[buffer]
	mov	BYTE PTR [rax+rdx], 0		# | buffer[pos] = buffer + pos = [rax+rdx] := 0 = '\0'
	cmp	r14d, -1					# | Сравниваем ch (r14d) и -1 (EOF)
	je	.L32						# | Если равны, переходим к возврату значения 0
	cmp	r13d, 100000				# | Иначе сравниваем pos (r13d) и 100000 (BUFFER_MAX_SIZE)
	jne	.L32						# | Если не равны, переходим к возврату значения 0
	mov	eax, 2						# | Иначе возвращаем 2 через eax
	jmp	.L28						# | И переходим к эпилогу
.L32:
	mov	eax, 0						# | Возвращаем 0 через eax
.L28:
	leave							# | Эпилог функции
	ret								# \
	.size	readStringInBuffer, .-readStringInBuffer

	.section	.rodata
.LC0:
	.string	"%s : %d\n"
	.text
	.globl	writeMapToOutputStream
	.type	writeMapToOutputStream, @function
writeMapToOutputStream:
	push	rbp						# |
	mov	rbp, rsp					# | Пролог функции 
	sub	rsp, 32						# | 
	
	mov	r12, rdi					# | r12 := rdi -- загружаем в регистр первый аргумент (FILE *stream)
	cmp	r12, 0						# | Сравниваем stream (r12) и NULL (0)
	jne	.L34						# | Если не равны, переходим к инициализации счётчика цикла
	mov	eax, 1						# | Иначе возвращаем 1 через eax
	jmp	.L35						# | И переходим к эпилогу функции
.L34:
	mov	r13d, 0						# | int i = r13d := 0
	jmp	.L36						# | Переходим проверке условия продолжения цикла
.L37:								# | Тело цикла
	mov	eax, r13d					# | eax := r13d = i
	movsx	rdx, eax				# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, rdx					# |	/
	sal	rax, 4						# |	| Считаем смещение, чтобы 
	add	rax, rdx					# |	| &(map[0].value) + смещение = &(map[i].value)
	sal	rax, 3						# | |
	mov	rdx, rax					# |	\ rdx -- смещение
	lea	rax, map[rip+128]			# | rax := &(rip+128)[map] -- адрес map[0].value
	mov	ecx, DWORD PTR [rdx+rax]	# |	ecx := [rdx + rax] = map[i].value -- четвертый аргумент для вызова fprintf
	mov	eax, r13d					# | eax := r13d = i
	movsx	rdx, eax				# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, rdx					# | /
	sal	rax, 4						# | | Вычисляем смещение, которое потом будет лежать в rax
	add	rax, rdx					# | |
	sal	rax, 3						# | \
	lea	rdx, map[rip]				# | rdx := &rip[map] = &(map[0].key) -- адрес начала map 
	add	rdx, rax					# | rdx := rdx + rax = &(map[0].key) + смещение = &(map[i].key) -- третий аргумент для вызова fprintf
	mov	rax, r12					# | rax := r12 = stream
	lea	rsi, .LC0[rip]				# | rsi := rip[.LC0] = форматная строка -- передаем второй аргумент для вызова fprintf через rsi
	mov	rdi, rax					# | rdi := stream -- передаем первый аргумент
	mov	eax, 0						# | Обнуляем eax перед вызовом fprintf
	call	fprintf@PLT				#  \ Вызываем fprintf(rdi=stream, rsi=rip[.LC0], rdx=map[i].key, rcx=map[i].value)
	add	r13d, 1						#   \ ++i
.L36:								#    |
	mov	eax, DWORD PTR map_size[rip]  #  | eax := rip[map_size] = map_size
	cmp	r13d, eax					#   / Сравниваем i (r13d) и eax (map_size)
	jl	.L37						#  / Если i < map_size, переходим к следующей итерации
	mov	eax, 0						# / Иначе возвращаем 0 через eax
.L35:
	leave							# | Эпилог 
	ret								# \
	.size	writeMapToOutputStream, .-writeMapToOutputStream
