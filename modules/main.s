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
