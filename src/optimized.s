	.intel_syntax noprefix
	.text
	.globl	map_size
	.bss
	.align 4
	
	.type	map_size, @object
	.size	map_size, 4
map_size:							
	.zero	4	# int map_size = 0

	.comm	map,13600000,32			# struct MapElement map[MAP_MAX_SIZE]
	.comm	buffer,100000,32		# char buffer[BUFFER_MAX_SIZE]
	
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
	push	rbp						# /	Пролог функции
	mov	rbp, rsp					# |
		
	cmp	edi, esi					# | Сравниваем a (edi) и b (esi)
	jge	.L2							# |	Если a >= b, переходим на метку .L2
	mov	eax, edi					# |	Иначе возвращаем a через eax: eax := edi
	jmp	.L3							# | Переходим к эпилогу
.L2:		
	mov	eax, esi					# | Возвращаем b через eax: eax := esi
.L3:
	pop	rbp							# | Эпилог функции  
	ret								# \
	.size	min, .-min

# ^
# Вместо того, что бы переносить значения из регистров edi и esi, оставили аргументы там
# и работали уже с регистрами, а не со стеком. К тому же функция не вызывает другие функции.

	.globl	isAlpha
	.type	isAlpha, @function
isAlpha:			
	push	rbp						# | Пролог функции
	mov	rbp, rsp					# |
									
									# | аргумент ch был передан через edi
	cmp	dil, 96						# | Сравниваем ch (dil) и 96 ('`' -- символ перед 'a')
	jle	.L5							# | Если ch <= 96, переходим на метку .L5, в которой проверим второй операнд ||
	cmp	dil, 122					# | Иначе проверяем второй операнд &&: сравниваем ch (dil) и 122 ('z')
	jle	.L6							# | Если ch <= 122, то выражение истинно, можем не проверять второй операнд ||, поэтому переходим к возврату значения на метку .L6
.L5:								# | В .L5 проверяем ('A' <= ch && ch <= 'Z')
	cmp	dil, 64						# | Сравниваем ch (dil) и 64 ('@' -- символ перед 'A')
	jle	.L7							# | Если ch <= 64, выражение точно ложно, переходим на метку .L7 
	cmp	dil, 90						# | Сравниваем ch (dil) и 90 ('Z')
	jg	.L7							# | Если ch > 90, выражение ложно, переходим на метку .L7
.L6:
	mov	eax, 1						# | Возвращаем 1 через eax 
	jmp	.L9							# | Переходим к эпилогу
.L7:
	mov	eax, 0						# | Возвращаем 0 через eax
.L9:
	pop	rbp							# | Эпилог функции
	ret								# \
	.size	isAlpha, .-isAlpha
# ^ 
# Аналогично оптимизации min не стали ничего перемещать ни на стек, ни в другие регистры, 
# так как функция не вызывает другие функции

	.globl	isAlphaOrNum
	.type	isAlphaOrNum, @function
isAlphaOrNum:						
	push	rbp						# |
	mov	rbp, rsp					# | Пролог функции
	sub	rsp, 8						# |
									
									# | аргумент ch был передан через edi
	call	isAlpha					# | Вызываем isAlpha(edi=ch)
	test	eax, eax				# | test работает так же как и and, но не изменяет 		первый операнд и влияет только на флаговый регистр
	jne	.L11						# |	Если isAlpha вернула через eax ненулевое значение, после test ZF=0 => прыгаем на метку .L11 
	cmp	dil, 47						# | Сравниваем ch (dil) и 47 ('/' -- символ перед '0')
	jle	.L12						# | Если ch <= 47, выражение ложно, переходим к возврату 0
	cmp	dil, 57						# | Сравниваем ch (dil) и 57 ('9')
	jg	.L12						# | Если ch > 57, выражение ложно, переходим к возврату 0
.L11:				
	mov	eax, 1						# | Возвращаем 1 через eax
	jmp	.L14						# | Переходим к эпилогу
.L12:
	mov	eax, 0						# | Возвращаем 0 через eax
.L14:
	leave							# | Эпилог функции
	ret								# \
	.size	isAlphaOrNum, .-isAlphaOrNum
# ^
# Мы знаем, что вызываемая функция isAlpha использует внутри себя edi только для сравнения и никак его не меняет,
# поэтому переданный параметр через edi можно никуда не перемещать, а оставить как есть.


	.globl	incrementElement
	.type	incrementElement, @function
incrementElement:
	push	rbp						# | /
	push    r13						# | | Сохраняем используемые callee-saved регистры на стек, чтобы потом их восстановить и не испортить
	push    r12						# | |
    push    r15						# | \
	mov	rbp, rsp					# | Пролог функции
	sub	rsp, 40						# |
	
	mov	r12, rdi					# | r12 := rdi -- загружаем в регистр первый переданный через rdi аргумент (char *string)
	mov	r13d, esi					# | r13d := esi -- загружаем в регистр второй переданный аргумент (int string_size)
	mov	r15d, 0						# | r15d := 0 -- заводим счётчик i = 0 для цикла for
	jmp	.L16						# | Переходим на метку .L16, в которой проверится условие продолжения цикла
.L19:
	movsx	rdx, r15d				# | rdx := r15d = i (dword to qword sign-extension)
	mov	rax, rdx					# | rax := rdx = i
	sal	rax, 4						# | /
	add	rax, rdx					# | | Считаем адрес смещение для получения map[i].key_size 
	sal	rax, 3						# | | 
	mov	rdx, rax					# | \ rdx := rax // Нужно сместиться на rdx относительно начала, чтобы получить map[i].key_size
	lea	rax, map[rip+132]			# | rax := &((rip + 132)[map]) -- адрес начала map
	mov	eax, DWORD PTR [rdx+rax]	# | eax := map[i].key_size
	cmp	r13d, eax					# | Сравниваем string_size (r13d) и map[i].key_size (eax)
	jne	.L17						# | Если map[i].key_size != string_size, условие ложно, переходим к увеличению счётчика (метка .L17)
	movsx	rdx, r15d				# | /
	mov	rax, rdx					# | | Вычисляем смещение, которое потом положим в rdx
	sal	rax, 4						# | |
	add	rax, rdx					# | |
	sal	rax, 3						# | |
	mov	rdx, rax					# | \
	lea	rax, map[rip+132]			# | rax := &(rip+132)[map] = &(map[0].key_size)
	mov	edx, DWORD PTR [rdx+rax]	# | edx := [rdx+rax] = map[i].key_size
	mov	eax, r13d					# | eax := r13d =  string_size
	mov	esi, edx					# | esi := edx = map[i].key_size -- через esi передаем второй аргумент в min
	mov	edi, eax					# | edi := eax = string_size -- через edi передаем первый аргумент в min
	call	min						# | Вызываем min(edi=string_size, esi=map[i].key_size)
									# | функция min вернула значение через eax 
	movsx	rcx, eax				# | rcx := eax (doubleword to qword with sign-extension)
	movsx	rdx, r15d				# | /
	mov	rax, rdx					# | | Вычисляем смещение, которое потом окажется в rax
	sal	rax, 4						# | |
	add	rax, rdx					# | |
	sal	rax, 3						# | \
	lea	rdx, map[rip]				# |	rdx := &rip[map] = &(map[0].key) // &(map[0]) == &(map[0].key) == map[0].key -- т.к key массив
	lea	rdi, [rax+rdx]				# | rdi := rax + rdx = &(map[i].key) -- передаем первый аргумент
	mov	rax, r12					# |	rax := r12 = string
	mov	rdx, rcx					# | rdx := rcx = min(edi=string_size, esi=map[i].key_size) -- передаем через rdx третий аргумент 
	mov	rsi, rax					# | rsi := rax = string -- передаем второй аргумент
	call	strncmp@PLT				# | Вызываем strncmp(rdi=map[i].key, rsi=string, )
									# | map[i].key -- указатель на начало массива char'ов
	test	eax, eax				# | Побитовое И без изменения самого eax
	jne	.L17						# | Если в eax был не ноль, выражение ложно, переходим к следующей итерации 
	movsx	rdx, r15d				# | /
	mov	rax, rdx					# | |
	sal	rax, 4						# | |
	add	rax, rdx					# | | Вычисляем смещение, которое потом положим в rdx
	sal	rax, 3						# | |
	mov	rdx, rax					# | \
	lea	rax, map[rip+128]			# | rax := &(rip+128)[map] = &(map[0].value)
	mov	eax, DWORD PTR [rdx+rax]	# | eax := [rdx+rax] = map[i].value
	lea	ecx, 1[rax]					# | ecx := rax[1] = rax + 1 = map[i].value + 1
	movsx	rdx, r15d				# | /
	mov	rax, rdx					# | |
	sal	rax, 4						# | | Вычисляем смещение, которое потом положим в rdx
	add	rax, rdx					# | |
	sal	rax, 3						# | |
	mov	rdx, rax					# | \
	lea	rax, map[rip+128]			# | rax := &(rip+128)[map] = &(map[0].value)
	mov	DWORD PTR [rdx+rax], ecx	# | map[i].value = [rdx+rax] := ecx = map[i].value + 1
	jmp	.L15						# | Переходим к эпилогу
.L17:
	add	r15d, 1						# | ++i
.L16:
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size] = map_size
	cmp	r15d, eax						# | Сравниваем i (r15d) и map_size (eax)
	jl	.L19							# | Если i < map_size, совершаем итерацию цикла (тело цикла -- метка .L19)
	movsx	rcx, r13d					# | rcx := r13d = string_size (dword to qword sign-extension)
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size] = map_size
	movsx	rdx, eax					# | rdx := eax = map_size (dword to qword sign-extension)
	mov	rax, rdx						# | rax := rdx = map_size
	sal	rax, 4							# | /
	add	rax, rdx						# | | Вычисляем смещение, которое потом окажется в rax
	sal	rax, 3							# | \
	lea	rdx, map[rip]					# | rdx := &rip[map] -- адрес начала map
	lea	rdi, [rax+rdx]					# | rdi := rax + rdx -- адрес map[map_size].key теперь в rdi через который передаем первый аргумент
	mov	rax, r12						# | rax := r12 = string
	mov	rdx, rcx						# | rdx := rcx = string_size -- третий аргумент для вызова strncpy
	mov	rsi, rax						# | rsi := rax = string -- второй аргумент для вызова strncpy
	call	strncpy@PLT					# | Вызываем strncpy(rdi=map[map_size].key, rsi=string, rdx=string_size)
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size] = map_size
	movsx	rdx, eax					# | /
	mov	rax, rdx						# |	|
	sal	rax, 4							# |	| Вычисляем смещение, которое потом будет лежать в rcx
	add	rax, rdx						# |	|
	sal	rax, 3							# | |
	mov	rcx, rax						# | \
	lea	rdx, map[rip+132]				# | rdx := &((rip + 132)[map]) -- адрес key_size нулевого элемента
	mov	DWORD PTR [rcx+rdx], r13d		# | [rcx + rdx] := r13d <=> map[map_size].key_size = string_size
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size]
	movsx	rdx, eax					# | /
	mov	rax, rdx						# | |
	sal	rax, 4							# | |
	add	rax, rdx						# | | Вычисляем смещение, которое потом будет лежать в rdx
	sal	rax, 3							# | |
	mov	rdx, rax						# | \
	lea	rax, map[rip+128]				# | rax := &(rip + 128)[map] = &(map[0].value)	
	mov	DWORD PTR [rdx+rax], 1			# |	map[i].value = [rdx+rax] := 1
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size] = map_size
	add	eax, 1							# | eax := eax + 1 = map_size + 1
	mov	DWORD PTR map_size[rip], eax	# | map_size = rip[map_size] := eax = map_size + 1
.L15:
	add rsp, 40							# | Эпилог
	pop r15								# |
	pop r12								# |
	pop r13								# |
	pop rbp								# |
	ret									# \
	.size	incrementElement, .-incrementElement

# ^
# Теперь функция использует стек только для сохранения callee-saved регистров 
# Использование стека было заменено на следующие регистры: r12, r13, r15

	.globl	parseIdentifiers
	.type	parseIdentifiers, @function
parseIdentifiers:
	push	rbp						# /
	mov	rbp, rsp					# | Пролог функции
	sub	rsp, 176					# |
	
	mov	r13, rdi					# | r13 := rdi -- загружаем в регистр первый аргумент (char *string)
									# | Загружаем значения локальных переменных в регистры
	mov	r14d, -1					# | r14d := -1 <=> int begin = -1 
	mov	r15d, -1					# | r15d := -1 <=> int end = -1
	mov	r12d, 1						# | r12d := 1 <=> int is_delimiter_previous = 1
	mov	ebx, 0						# | ebx := 0 -- заводим счётчик i <=> int i = 0
	jmp	.L21						# | Переходим к проверке условия продолжения цикла
.L25:
									# | Проверяем if (is_delimiter_previous && begin < 0 && isAlpha(string[i]))
	cmp	r12d, 0						# | Сравниваем is_delimiter_previous (r12d) и 0
	je	.L22						# | Если is_delimiter_previous == 0, выражение ложно, поэтому переходим к else if (метка .L22)
	cmp	r14d, 0						# | Сравниваем begin (r14d) и 0
	jns	.L22						# | Если begin >= 0 (=> старший бит = 0), выражение ложно, переходим к else if (метка .L22)
	movsx	rdx, ebx				# | rdx := ebx = i (dword to qword sign-extension)
	mov	rax, r13					# | rax := r13 = string
	add	rax, rdx					# | rax := rax + rdx <=> rax := (string + i)
	movzx	eax, BYTE PTR [rax]		# | eax := [rax] <=> eax := string[i] (byte to dword zero-extension)
	movsx	eax, al					# | eax := al (word to dword sign-extension)
	mov	edi, eax					# | edi := eax = string[i] -- первый аргумент для вызова isAlpha загружаем в edi
	call	isAlpha					# | Вызываем isAlpha(edi=string[i])
	test	eax, eax				# | Побитовое И без изменения самого eax
	je	.L22						# | Если в eax был ноль, выражение ложно, переходим к else if (метка .L22)
									# | Иначе выражение истинно, переходим к телу условного оператора
	mov	r14d, ebx					# | r14d := ebx = i <=> begin = i
	mov	eax, ebx					# | eax := ebx = i
	add	eax, 1						# | eax := eax + 1 = i + 1
	mov	r15d, eax					# | r15d := eax <=> end = i + 1
	jmp	.L23						# | Переходим на метку .L23
.L22:
									# | else if (begin >= 0 && isAlphaOrNum(string[i]))
	cmp	r14d, 0						# | Сравниваем begin (r14d) и 0
	js	.L24						# | Если begin < 0 (=> старший бит = 1), выражение ложно, переходим к последнему else if (метка .L24)
	movsx	rdx, ebx				# | rdx := ebx = i (dword to qword sign-extension)
	mov	rax, r13					# | rax := r13 = string
	add	rax, rdx					# | rax := rax + rdx <=> rax := (string + i) -- адрес i-ого символа
	movzx	eax, BYTE PTR [rax]		# | eax := [rax] <=> eax := string[i] (byte to dword zero-extension)
	movsx	eax, al					# | eax := al = string[i] (word to dword sign-extension)
	mov	edi, eax					# | edi := eax = string[i] -- передаем первый аргумент через edi
	call	isAlphaOrNum			# | Вызываем isAlphaOrNum(edi=string[i])
	test	eax, eax				# | Побитовое И без изменения самого eax
	je	.L24						# | Если в eax был ноль, выражение ложно, переходим к последнему else if
	mov	eax, ebx					# | eax := ebx = i
	add	eax, 1						# | eax := eax + 1 = i + 1
	mov	r15d, eax					# | end = r15d := eax = i + 1
	jmp	.L23						# | Переходим на метку .L23
.L24:
	cmp	r14d, 0						# | Сравниваем begin (r14d) и 0
	js	.L23						# | Если begin < 0 (=> старший бит = 1), выражение ложно, переходим на метку .L23
	mov	eax, r15d					# | eax := r15d = end
	sub	eax, r14d					# | eax := eax - r14d = end - begin
	mov	esi, 127					# | esi := 127 -- передаем второй аргумент для вызова min через esi
	mov	edi, eax					# | edi := eax = end - begin -- передаем первый аргумент для вызова min через edi
	call	min						# | Вызываем min(edi=end-begin, esi=127)
									# | min вернула минимальное значение через eax
	mov	DWORD PTR -20[rbp], eax		# | int identifier_size = rbp[-20] := eax = возвращенное min значение
	movsx	rdx, eax				# | rdx := eax = identifier_size (dword to qword sign-extension) -- через rdx передаем третий аргумент для вызова функции
	movsx	rcx, r14d				# | rcx := eax = begin (dword to qword sign-extension)
	add	rcx, r13					# | rcx := rcx + rax = (string + begin)
	lea	rax, -160[rbp]				# | rax := &(rbp[-160]) = identifier -- адрес начала массива char identifier[128]
	mov	rsi, rcx					# | rsi := rcx = (string + begin) -- через rsi передаем второй аргумент для вызова функции
	mov	rdi, rax					# | rdi := rax = identifier -- передаем через rdi первый аргумент
	call	strncpy@PLT				# | Вызываем strncpy(rdi=identifier, rsi=string + begin, rdx=identifier_size)
	mov	eax, DWORD PTR -20[rbp]		# | eax := rbp[-20] = identifier_size
	cdqe							# | rax := sign-extend of eax. Копирует знак (31 бит) в старшие 32 бита регистра rax
	mov	BYTE PTR -160[rbp+rax], 0	# | (rbp+rax)[-160] = 0 <=> identifier[identifier_size] = '\0'
	mov	eax, DWORD PTR -20[rbp]		# | eax := rbp[-20] = identifier_size
	lea	edx, 1[rax]					# | edx := &(rax[1]) = rax + 1 = identifier_size + 1
	lea	rax, -160[rbp]				# | rax := &(rbp[-160]) -- адрес начала массива identifier
	mov	esi, edx					# | esi := edx = identifier_size + 1 -- передаем второй аргумент в функцию
	mov	rdi, rax					# | rdi := rax = identifier -- передаем первый аргумент в функцию
	call	incrementElement		# | Вызываем incrementElement(rdi=identifier, esi=identifier_size + 1)
	mov	r14d, -1					# | begin = r14d := -1
	mov	r15d, -1					# | end = r15d := -1
.L23:
	movsx	rdx, ebx				# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, r13	# | rax := r13 = string
	add	rax, rdx					# | rax := rax + rdx <=> rax := (string + i)
	movzx	eax, BYTE PTR [rax]		# | eax := [rax] <=> eax := string[i] (byte to dword zero-extension)
	movsx	eax, al					# | eax := al (word to dword sign-extension)
	mov	edi, eax					# | edi := eax = string[i] -- загружаем в edi первый аргумент
	call	isAlphaOrNum			# | Вызываем isAlphaOrNum(edi=string[i])
	test	eax, eax				# |	Побитовое И без изменения самого eax
	sete	al						# | Если в eax было ненулевое значение => ZF = 0 => sete установит 0 в al. Иначе ZF = 1 => sete установит 1 в al
	movzx	eax, al					# | eax := al (word to dword zero-extension)
	mov	r12d, eax					# | r12d := eax
	add	ebx, 1						# | ++i
.L21:
	mov	eax, ebx					# | eax := ebx = i
	movsx	rdx, eax				# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, r13					# | rax := r13 = string
	add	rax, rdx					# | rax := rax + rdx <=> string + i -- получаем адрес i-ого элемента
	movzx	eax, BYTE PTR [rax]		# | eax := [rax] <=> eax := *(rax) <=> eax := string[i] (byte to dword with zero-extension)
	test	al, al					# | Побитовое И без изменения самого al 
	jne	.L25						# | Если al != 0 => ZF = 0 => переход на следующую итерацию цикла
	
	
	leave							# | Эпилог функции
	ret								# \
	.size	parseIdentifiers, .-parseIdentifiers
# ^
# Теперь наиболее часто использующиеся переменный хранятся не на стеке, а в регистрах
# Использованы следующие callee-saved регистры: r12, r13, r14, r15, rbx

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
# ^
# Хранение локальных переменных полностью заменено хранением в регистрах: r12, r13, r14
#

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
# ^ 
# Хранение локальных переменных полностью заменено хранением в регистрах: r12, r13
#
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
# ^
# Хранение на стеке заменено на хранение в регистрах только для наиболее использующихся переменных. Например, для таких, как pos
# Использованы следующие callee-saved регистры: r12, r13, r14
	
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
	push	rbp						# |
	mov	rbp, rsp					# | Пролог функции
	sub	rsp, 80						# |
	
	mov	DWORD PTR -68[rbp], edi		# | rbp[-68] := edi = argc
	mov	QWORD PTR -80[rbp], rsi		# | rbp[-80] := rsi = argv
	mov	rax, QWORD PTR stdin[rip]	# | rax := rip[stdin]
	mov	QWORD PTR -8[rbp], rax		# | input = rbp[-8] := rax = stdin // FILE *input = stdin
	mov	rax, QWORD PTR stdout[rip]	# | rax := rip[stdout]
	mov	QWORD PTR -16[rbp], rax		# |	output = rbp[-16] := rax = stdout // FILE *output = stdout
	mov	DWORD PTR -20[rbp], 0		# | random_flag = rbp[-20] := 0
	mov	DWORD PTR -24[rbp], 0		# | test_flag = rbp[-24] := 0
	mov	DWORD PTR -28[rbp], 42		# | seed = rbp[-28] := 42
	mov	DWORD PTR -32[rbp], 0		# |	random_n = rbp[-32] := 0
	mov	QWORD PTR -40[rbp], 0		# | sample_size = rbp[-40] := 0
	
	jmp	.L62						# | Переходим к проверке условия продолжения цикла
.L70:
	# Это switch
	# Сравнивается opt (rbp[-48]) и коды символов-опций
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
.L65:								# | case 'r'								
	mov	DWORD PTR -20[rbp], 1		# | random_flag = rbp[-20] := 1
	mov	rax, QWORD PTR optarg[rip]	# | rax := rip[optarg]
	mov	rdi, rax					# | rdi := eax = rip[optarg]
	call	atoi@PLT				# | Вызываем atoi(rdi=rip[optarg])
									# | Функция вернула результат через eax
	mov	DWORD PTR -32[rbp], eax		# | random_n = rbp[-32] := eax
	jmp	.L62						# | Переходим к проверке условия продолжения цикла
.L68:								# | case 'i'
	mov	rax, QWORD PTR optarg[rip]	# | rax := rip[optarg]
	lea	rsi, .LC1[rip]				# | rsi := &rip[.LC1]
	mov	rdi, rax					# | rdi := rax = rip[optarg]
	call	fopen@PLT				# | Вызываем fopen(rdi=rip[optarg], rsi=&rip[.LC1])
									# | Функция вернула результат через rax
	mov	QWORD PTR -8[rbp], rax		# | input = rbp[-8] := rax 
	jmp	.L62						# | Переходим к проверке условия продолжения цикла
.L66:								# | case 'o'
	mov	rax, QWORD PTR optarg[rip]	# | rax := rip[optarg]
	lea	rsi, .LC2[rip]				# | rsi := &rip[.LC2]
	mov	rdi, rax					# | rdi := rax = rip[optarg]
	call	fopen@PLT				# | Вызываем fopen(rdi=rip[optarg], rsi=&rip[.LC2])
									# | Функция вернула результат через rax
	mov	QWORD PTR -16[rbp], rax		# | output = rbp[-16] := rax
	jmp	.L62						# | Переходим к проверке условия продолжения цикла
.L64:								# | case 's'
	mov	rax, QWORD PTR optarg[rip]	# | rax := rip[optarg]
	mov	rdi, rax					# | rdi := rax = rip[optarg]
	call	atoi@PLT				# | Вызываем atoi(rdi=rip[optarg])
									# | Функция вернула результат через eax
	mov	DWORD PTR -28[rbp], eax		# | seed = rbp[-28] := eax
	jmp	.L62						# | Переходим к проверке условия продолжения цикла
.L63:								# | case 't'
	mov	DWORD PTR -24[rbp], 1		# | test_flag = rbp[-24] := 1
	mov	rax, QWORD PTR optarg[rip]	# | rax := rip[optarg]
	mov	rdi, rax					# | rdi := rax = rip[optarg]
	call	atoll@PLT				# | Вызываем atoll(rdi=rip[optarg])
									# | Функция вернула результат через rax
	mov	QWORD PTR -40[rbp], rax		# | sample_size = rbp[-40] := rax
	jmp	.L62						# | Переходим к проверке условия продолжения цикла
.L67:
	mov	eax, 0						# | Возвращаем 0 через eax
	jmp	.L69						# | Переходим к эпилогу
.L62:
	mov	rcx, QWORD PTR -80[rbp]		# | rcx := rbp[-80] = argv
	mov	eax, DWORD PTR -68[rbp]		# | eax := rbp[-68] = argc
	lea	rdx, .LC3[rip]				# | rdx := &rip[.LC3] -- адрес начала строки с опциями (3 аргумент для вызова getopt)
	mov	rsi, rcx					# | rsi := rcx = argv
	mov	edi, eax					# | edi := eax = argc
	call	getopt@PLT				# | Вызываем getopt(edi=argc, rsi=argv, rdx=&rip[.LC3])
									# | Функция через eax вернула значение
	mov	DWORD PTR -48[rbp], eax		# | opt = rbp[-48] := eax
	cmp	DWORD PTR -48[rbp], -1		# | Сравниваем opt (rbp[-48]) и -1
	jne	.L70						# | Если opt != - 1, переходим к телу цикла
	mov	eax, DWORD PTR -28[rbp]		# |	eax := rbp[-28] = seed
	mov	edi, eax					# | edi := eax = seed
	call	srand@PLT				# |	Вызываем srand(edi=seed)
	cmp	DWORD PTR -24[rbp], 0		# | Сравниваем test_flag (rbp[-24]) и 0
	je	.L71						# | Если равны, переходим на метку .L71
	mov	rax, QWORD PTR -40[rbp]		# | rax := rbp[-40] = sample_size
	mov	rsi, rax					# |	rsi := rax = sample_size
	lea	rdi, .LC4[rip]				# | rdi := &rip[.LC4]
	mov	eax, 0						# | eax := 0
	call	printf@PLT				# | Вызываем printf(rdi=&rip[.LC4], rsi=sample_size)
	mov	rax, QWORD PTR -40[rbp]		# | rax := rbp[-40] = sample_size
	mov	rdi, rax					# | rdi := rax = sample_size
	call	measureTime				# | Вызываем measureTime(rdi=sample_size)
									# | Функция вернула значение через rax
	mov	QWORD PTR -56[rbp], rax		# | elapsed = rbp[-56] := rax 
	mov	rax, QWORD PTR -56[rbp]		# | rax := rbp[-56] = elapsed
	mov	rsi, rax					# | rsi := rax = elapsed
	lea	rdi, .LC5[rip]				# |	rdi := &rip[.LC5]
	mov	eax, 0						# | eax := 0
	call	printf@PLT				# | Вызываем printf(rdi=&rip[.LC5], rsi=elapsed)
	mov	eax, 0						# | Возвращаем 0 через eax
	jmp	.L69						# | Переходим к эпилогу
.L71:	
	mov	DWORD PTR -44[rbp], 0		# | status_code = rbp[-44] := 0
	cmp	DWORD PTR -20[rbp], 0		# | Сравниваем random_flag (rbp[-20]) и 0
	je	.L72						# | Если равны, переходим на метку .L72
	mov	eax, DWORD PTR -32[rbp]		# | eax := rbp[-32] = random_n
	mov	edi, eax					# | edi := eax = random_n
	call	fillBufferRandomly		# | Вызываем fillBufferRandomly(edi=random_n)
									# | Функция вернула значение через eax
	lea	rdi, buffer[rip]			# | rdi := &rip[buffer]
	call	puts@PLT				# | Вызываем puts(rdi=&rip[buffer])
	jmp	.L73						# | Переходим на метку .L73
.L72:
	mov	rax, QWORD PTR stdin[rip]	# | rax := rip[stdin]
	cmp	QWORD PTR -8[rbp], rax		# | Сравниваем input (rbp[-8]) и stdin (rax)
	jne	.L74						# | Если input != stdin, переходим на метку .L74
	lea	rdi, .LC6[rip]				# | rdi := &rip[.LC6]
	call	puts@PLT				# | Вызываем puts(rdi=&rip[.LC6])
	mov	rax, QWORD PTR -8[rbp]		# | rax := rbp[-8] = input
	mov	rdi, rax					# | rdi := rax = input
	call	readStringInBuffer		# | Вызываем readStringInBuffer(rdi=input)
									# | Функция вернула значение через eax
	mov	DWORD PTR -44[rbp], eax		# | status_code = rbp[-44] := eax
	jmp	.L73						# |	Переходим на метку .L73
.L74:
	mov	rax, QWORD PTR -8[rbp]		# | rax := rbp[-8] = input
	mov	rdi, rax					# |	rdi := rax = input
	call	readStringInBuffer		# | Вызываем readStringInBuffer(rdi=input)
									# | Функция вернула значение через eax
	mov	DWORD PTR -44[rbp], eax		# | status_code = rbp[-44] := eax
.L73:
	cmp	DWORD PTR -44[rbp], 1		# |	Сравниваем status_code (rbp[-44]) и 1
	jne	.L75						# | Если status_code != 1, переходим на метку .L75
	lea	rdi, .LC7[rip]				# | rdi := &rip[.LC7]
	call	puts@PLT				# | Вызываем puts(rdi=&rip[.LC7])
	mov	eax, 0						# | Возвращаем 0 через eax
	jmp	.L69						# | И переходим к эпилогу
.L75:			
	cmp	DWORD PTR -44[rbp], 2		# | Сравниваем status_code (rbp[-44]) и 2
	jne	.L76						# | Если status_code != 2, переходим на метку .L76
	mov	esi, 99999					# |	esi := 99999 (BUFFER_MAX_SIZE - 1)
	lea	rdi, .LC8[rip]				# | rdi := &rip[.LC8]
	mov	eax, 0						# | eax := 0
	call	printf@PLT				# | Вызываем printf(rdi=&rip[.LC8], esi=99999)
.L76:			
	lea	rdi, buffer[rip]			# | rdi := &rip[buffer]
	call	parseIdentifiers		# | Вызываем parseIdentifiers(rdi=&rip[buffer])
	mov	rax, QWORD PTR -16[rbp]		# | rax := rbp[-16] = output
	mov	rdi, rax					# | rdi := rax = output
	call	writeMapToOutputStream	# | Вызываем writeMapToOutputStream(rdi=output)
									# | Функция вернула значение через eax
	mov	DWORD PTR -44[rbp], eax		# | status_code = rbp[-44] := eax 
	cmp	DWORD PTR -44[rbp], 0		# | Сравниваем status_code (rbp[-44]) и 0
	je	.L77						# | Если status_code == 0, переходим на метку .L77
	lea	rdi, .LC9[rip]				# | rdi := &rip[.LC9]
	call	puts@PLT				# | Вызываем puts(rdi=&rip[.LC9])
.L77:
	mov	eax, 0						# | Возвращаем 0 через eax
.L69:
	leave							# | Эпилог функции
	ret								# \
	.size	main, .-main	
