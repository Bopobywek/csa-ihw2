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
	push	rbp						# | Пролог функции
	mov	rbp, rsp					# |
	
	mov	eax, edi					# | eax := edi -- загружаем в регистр eax первый аргумент (char ch)
	mov	BYTE PTR -4[rbp], al		# | rbp[-4] := al -- загружаем на стек первый аргумент (ch)
	cmp	BYTE PTR -4[rbp], 96		# | Сравниваем ch (rbp[-4]) и 96 ('`' -- символ перед 'a')
	jle	.L5							# | Если ch <= 96, переходим на метку .L5, в которой проверим второй операнд ||
	cmp	BYTE PTR -4[rbp], 122		# | Иначе проверяем второй операнд &&: сравниваем ch (rbp[-4]) и 122 ('z')
	jle	.L6							# | Если ch <= 122, то выражение истинно, можем не проверять второй операнд ||, поэтому переходим к возврату значения на метку .L6
.L5:								# | В .L5 проверяем ('A' <= ch && ch <= 'Z')
	cmp	BYTE PTR -4[rbp], 64		# | Сравниваем ch (rbp[-4]) и 64 ('@' -- символ перед 'A')
	jle	.L7							# | Если ch <= 64, выражение точно ложно, переходим на метку .L7 
	cmp	BYTE PTR -4[rbp], 90		# | Сравниваем ch (rbp[-4]) и 90 ('Z')
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
	.globl	isAlphaOrNum
	.type	isAlphaOrNum, @function
isAlphaOrNum:						
	endbr64							# /
	push	rbp						# |
	mov	rbp, rsp					# | Пролог функции
	sub	rsp, 8						# |
	
	mov	eax, edi					# | eax := edi -- загружаем в регистр eax первый аргумент (char ch)
	mov	BYTE PTR -4[rbp], al		# | rbp[-4] := al = ch -- загружаем на стек первый аргумент из регистра 
	movsx	eax, BYTE PTR -4[rbp]	# | eax := rbp[-4] = ch (movsx eax, byte ptr .. -- move byte to doubleword with sign-extension)
	mov	edi, eax					# | edi := eax = ch -- загружаем ch в регистр edi для передачи первого параметра
	call	isAlpha					# | Вызываем isAlpha(edi=ch)
	test	eax, eax				# | test работает так же как и and, но не изменяет первый операнд и влияет только на флаговый регистр
	jne	.L11						# |	Если isAlpha вернула через eax ненулевое значение, после test ZF=0 => прыгаем на метку .L11 
	cmp	BYTE PTR -4[rbp], 47		# | Сравниваем ch (rbp[-4]) и 47 ('/' -- символ перед '0')
	jle	.L12						# | Если ch <= 47, выражение ложно, переходим к возврату 0
	cmp	BYTE PTR -4[rbp], 57		# | Сравниваем ch (rbp[-4]) и 57 ('9')
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
	.globl	incrementElement
	.type	incrementElement, @function
incrementElement:
	endbr64							# /
	push	rbp						# |
	mov	rbp, rsp					# | Пролог функции
	sub	rsp, 32						# |
	
	mov	QWORD PTR -24[rbp], rdi		# | rbp[-24] := rdi -- загружаем на стек первый переданный через rdi аргумент (char *string)
	mov	DWORD PTR -28[rbp], esi		# | rbp[-28] := esi -- загружаем на стек второй переданный аргумент (int string_size)
	mov	DWORD PTR -4[rbp], 0		# | rbp[-4] := 0 -- заводим счётчик i = 0 для цикла for
	jmp	.L16						# | Переходим на метку .L16, в которой проверится условие продолжения цикла
.L19:
	mov	eax, DWORD PTR -4[rbp]		# | eax := rbp[-4] = i
	movsx	rdx, eax				# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, rdx					# | rax := rdx = i
	sal	rax, 4						# | /
	add	rax, rdx					# | | Считаем адрес смещение для получения map[i].key_size 
	sal	rax, 3						# | | 
	mov	rdx, rax					# | \ rdx := rax // Нужно сместиться на rdx относительно начала, чтобы получить map[i].key_size
	lea	rax, map[rip+132]			# | rax := &((rip + 132)[map]) -- адрес начала map
	mov	eax, DWORD PTR [rdx+rax]	# | eax := map[i].key_size
	cmp	DWORD PTR -28[rbp], eax		# | Сравниваем string_size (rbp[-28]) и map[i].key_size (eax)
	jne	.L17						# | Если map[i].key_size != string_size, условие ложно, переходим к увеличению счётчика (метка .L17)
	mov	eax, DWORD PTR -4[rbp]		# | /
	movsx	rdx, eax				# | |
	mov	rax, rdx					# | |
	sal	rax, 4						# | |
	add	rax, rdx					# | |
	sal	rax, 3						# | |
	mov	rdx, rax					# |
	lea	rax, map[rip+132]			# |
	mov	edx, DWORD PTR [rdx+rax]	# |
	mov	eax, DWORD PTR -28[rbp]		# |
	mov	esi, edx					# |
	mov	edi, eax					# |
	call	min						# |
	movsx	rcx, eax				# |
	mov	eax, DWORD PTR -4[rbp]		# |
	movsx	rdx, eax				# |
	mov	rax, rdx					# |
	sal	rax, 4						# |
	add	rax, rdx					# |
	sal	rax, 3						# |
	lea	rdx, map[rip]				# |
	lea	rdi, [rax+rdx]				# |
	mov	rax, QWORD PTR -24[rbp]		# |
	mov	rdx, rcx					# |
	mov	rsi, rax					# |
	call	strncmp@PLT				# |
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
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size] = map_size
	cmp	DWORD PTR -4[rbp], eax			# | Сравниваем i (rbp[-4]) и map_size (eax)
	jl	.L19							# | Если i < map_size, совершаем итерацию цикла (тело цикла -- метка .L19)
	mov	eax, DWORD PTR -28[rbp]			# | eax := rbp[-28] = string_size
	movsx	rcx, eax					# | rcx := eax = string_size (dword to qword sign-extension)
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size] = map_size
	movsx	rdx, eax					# | rdx := eax = map_size (dword to qword sign-extension)
	mov	rax, rdx						# | rax := rdx = map_size
	sal	rax, 4							# | /
	add	rax, rdx						# | |
	sal	rax, 3							# | \
	lea	rdx, map[rip]					# | rdx := &rip[map] -- адрес начала map
	lea	rdi, [rax+rdx]					# | rdi := &([rax + rdx]) -- адрес map[map_size].key теперь в rdi через который передаем первый аргумент
	mov	rax, QWORD PTR -24[rbp]			# | rax := rbp[-24] = string
	mov	rdx, rcx						# | rdx := rcx = string_size -- третий аргумент для вызова strncpy
	mov	rsi, rax						# | rsi := rax = string -- второй аргумент для вызова strncpy
	call	strncpy@PLT					# | Вызываем strncpy(rdi=map[map_size].key, rsi=string, rdx=string_size)
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size] = map_size
	movsx	rdx, eax					# | /
	mov	rax, rdx						# |	|
	sal	rax, 4							# |	|
	add	rax, rdx						# |	|
	sal	rax, 3							# | |
	mov	rcx, rax						# | \
	lea	rdx, map[rip+132]				# | rdx := &((rip + 132)[map]) -- адрес key_size нулевого элемента
	mov	eax, DWORD PTR -28[rbp]			# | eax := rbp[-28] = string_size
	mov	DWORD PTR [rcx+rdx], eax		# | [rcx + rdx] := eax <=> map[map_size].key_size = string_size
	mov	eax, DWORD PTR map_size[rip]	# | eax := rip[map_size]
	movsx	rdx, eax					# |
	mov	rax, rdx						# |
	sal	rax, 4							# |
	add	rax, rdx						# |
	sal	rax, 3							# |
	mov	rdx, rax						# |
	lea	rax, map[rip+128]				# |  	
	mov	DWORD PTR [rdx+rax], 1			# |	
	mov	eax, DWORD PTR map_size[rip]	# |
	add	eax, 1							# | eax := eax + 1 <=> ++map_size
	mov	DWORD PTR map_size[rip], eax	# |
.L15:
	leave								# | Эпилог
	ret									# \
	.size	incrementElement, .-incrementElement
	.globl	parseIdentifiers
	.type	parseIdentifiers, @function
parseIdentifiers:
	endbr64								# /
	push	rbp							# |
	mov	rbp, rsp						# | Пролог функции
	sub	rsp, 176						# |
	
	mov	QWORD PTR -168[rbp], rdi		# | rbp[-168] := rdi -- загружаем на стек первый аргумент (char *string)
										# | Загружаем значения локальных переменных на стек
	mov	DWORD PTR -4[rbp], -1			# | rbp[-4] := -1 <=> int begin = -1 
	mov	DWORD PTR -8[rbp], -1			# | rbp[-8] := -1 <=> int end = -1
	mov	DWORD PTR -12[rbp], 1			# | rbp[-12] := 1 <=> int is_delimiter_previous = 1
	mov	DWORD PTR -16[rbp], 0			# | rbp[-16] := 0 -- заводим счётчик i <=> int i = 0
	jmp	.L21							# | Переходим к проверке условия продолжения цикла
.L25:
										# | Проверяем if (is_delimiter_previous && begin < 0 && isAlpha(string[i]))
	cmp	DWORD PTR -12[rbp], 0			# | Сравниваем is_delimiter_previous (rbp[-12]) и 0
	je	.L22							# | Если is_delimiter_previous == 0, выражение ложно, поэтому переходим к else if (метка .L22)
	cmp	DWORD PTR -4[rbp], 0			# | Сравниваем begin (rbp[-4]) и 0
	jns	.L22							# | Если begin >= 0 (=> старший бит = 0), выражение ложно, переходим к else if (метка .L22)
	mov	eax, DWORD PTR -16[rbp]			# | eax := rbp[-16] = i
	movsx	rdx, eax					# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, QWORD PTR -168[rbp]		# | rax := rbp[-168] = string
	add	rax, rdx						# | rax := rax + rdx <=> rax := (string + i)
	movzx	eax, BYTE PTR [rax]			# | eax := [rax] <=> eax := string[i] (byte to dword zero-extension)
	movsx	eax, al						# | eax := al (word to dword sign-extension)
	mov	edi, eax						# | edi := eax = string[i] -- первый аргумент для вызова isAlpha загружаем в edi
	call	isAlpha						# | Вызываем isAlpha(edi=string[i])
	test	eax, eax					# | Побитовое И без изменения самого eax
	je	.L22							# | Если в eax был ноль, выражение ложно, переходим к else if (метка .L22)
										# | Иначе выражение истинно, переходим к телу условного оператора
	mov	eax, DWORD PTR -16[rbp]			# | eax := rbp[-16] = i
	mov	DWORD PTR -4[rbp], eax			# | rbp[-4] := eax = i <=> begin = i
	mov	eax, DWORD PTR -16[rbp]			# | eax := rbp[-16] = i
	add	eax, 1							# | eax := eax + 1 = i + 1
	mov	DWORD PTR -8[rbp], eax			# | rbp[-8] := eax <=> end = i + 1
	jmp	.L23							# | Переходим на метку .L23
.L22:
										# | else if (begin >= 0 && isAlphaOrNum(string[i]))
	cmp	DWORD PTR -4[rbp], 0			# | Сравниваем begin (rbp[-4]) и 0
	js	.L24							# | Если begin < 0 (=> старший бит = 1), выражение ложно, переходим к последнему else if (метка .L24)
	mov	eax, DWORD PTR -16[rbp]			# | eax := rbp[-16] = i
	movsx	rdx, eax					# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, QWORD PTR -168[rbp]		# | rax := rbp[-168] = string
	add	rax, rdx						# | rax := rax + rdx <=> rax := (string + i) -- адрес i-ого символа
	movzx	eax, BYTE PTR [rax]			# | eax := [rax] <=> eax := string[i] (byte to dword zero-extension)
	movsx	eax, al						# | eax := al = string[i] (word to dword sign-extension)
	mov	edi, eax						# | edi := eax = string[i] -- передаем первый аргумент через edi
	call	isAlphaOrNum				# | Вызываем isAlphaOrNum(edi=string[i])
	test	eax, eax					# | Побитовое И без изменения самого eax
	je	.L24							# | Если в eax был ноль, выражение ложно, переходим к последнему else if
	mov	eax, DWORD PTR -16[rbp]			# | eax := rbp[-16] = i
	add	eax, 1							# | eax := eax + 1 = i + 1
	mov	DWORD PTR -8[rbp], eax			# | end = rbp[-8] := eax = i + 1
	jmp	.L23							# | Переходим на метку .L23
.L24:
	cmp	DWORD PTR -4[rbp], 0			# | Сравниваем begin (rbp[-4]) и 0
	js	.L23							# | Если begin < 0 (=> старший бит = 1), выражение ложно, переходим на метку .L23
	mov	eax, DWORD PTR -8[rbp]			# | eax := rbp[-8] = end
	sub	eax, DWORD PTR -4[rbp]			# | eax := eax - rbp[-4] = end - begin
	mov	esi, 127						# | esi := 127 -- передаем второй аргумент для вызова min через esi
	mov	edi, eax						# | edi := eax = end - begin -- передаем первый аргумент для вызова min через edi
	call	min							# | Вызываем min(edi=end-begin, esi=127)
										# | min вернула минимальное значение через eax
	mov	DWORD PTR -20[rbp], eax			# | int identifier_size = rbp[-20] := eax = возвращенное min значение
	mov	eax, DWORD PTR -20[rbp]			# | eax := rbp[-20] = identifier_size
	movsx	rdx, eax					# | rdx := eax = identifier_size (dword to qword sign-extension) -- через rdx передаем третий аргумент для вызова функции
	mov	eax, DWORD PTR -4[rbp]			# | eax := rbp[-4] = begin
	movsx	rcx, eax					# | rcx := eax = begin (dword to qword sign-extension)
	mov	rax, QWORD PTR -168[rbp]		# | rax := rbp[-168] = string
	add	rcx, rax						# | rcx := rcx + rax = (string + begin)
	lea	rax, -160[rbp]					# | rax := &(rbp[-160]) = identifier -- адрес начала массива char identifier[128]
	mov	rsi, rcx						# | rsi := rcx = (string + begin) -- через rsi передаем второй аргумент для вызова функции
	mov	rdi, rax						# | rdi := rax = identifier -- передаем через rdi первый аргумент
	call	strncpy@PLT					# | Вызываем strncpy(rdi=identifier, rsi=string + begin, rdx=identifier_size)
	mov	eax, DWORD PTR -20[rbp]			# | eax := rbp[-20] = identifier_size
	cdqe								# | rax := sign-extend of eax. Копирует знак (31 бит) в старшие 32 бита регистра rax
	mov	BYTE PTR -160[rbp+rax], 0		# | (rbp+rax)[-160] = 0 <=> identifier[identifier_size] = '\0'
	mov	eax, DWORD PTR -20[rbp]			# | eax := rbp[-20] = identifier_size
	lea	edx, 1[rax]						# | edx := &(rax[1]) = rax + 1 = identifier_size + 1
	lea	rax, -160[rbp]					# | rax := &(rbp[-160]) -- адрес начала массива identifier
	mov	esi, edx						# | esi := edx = identifier_size + 1 -- передаем второй аргумент в функцию
	mov	rdi, rax						# | rdi := rax = identifier -- передаем первый аргумент в функцию
	call	incrementElement			# |  Вызываем incrementElement(rdi=identifier, esi=identifier_size + 1)
	mov	DWORD PTR -4[rbp], -1			# | begin = rbp[-4] := -1
	mov	DWORD PTR -8[rbp], -1			# | end = rbp[-8] := -1
.L23:
	mov	eax, DWORD PTR -16[rbp]		# | eax := rbp[-16] = i
	movsx	rdx, eax				# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, QWORD PTR -168[rbp]	# | rax := rbp[-168] = string
	add	rax, rdx					# | rax := rax + rdx <=> rax := (string + i)
	movzx	eax, BYTE PTR [rax]		# | eax := [rax] <=> eax := string[i] (byte to dword zero-extension)
	movsx	eax, al					# | eax := al (word to dword sign-extension)
	mov	edi, eax					# | edi := eax = string[i] -- загружаем в edi первый аргумент
	call	isAlphaOrNum			# | Вызываем isAlphaOrNum(edi=string[i])
	test	eax, eax				# |	Побитовое И без изменения самого eax
	sete	al						# | Если в eax было ненулевое значение => ZF = 0 => sete установит 0 в al. Иначе ZF = 1 => sete установит 1 в al
	movzx	eax, al					# | eax := al (word to dword zero-extension)
	mov	DWORD PTR -12[rbp], eax		# | rbp[-12] := eax
	add	DWORD PTR -16[rbp], 1		# | ++i
.L21:
	mov	eax, DWORD PTR -16[rbp]		# | eax := rbp[-16] = i
	movsx	rdx, eax				# | rdx := eax = i (dword to qword sign-extension)
	mov	rax, QWORD PTR -168[rbp]	# | rax := rbp[-168] = string
	add	rax, rdx					# | rax := rax + rdx <=> string + i -- получаем адрес i-ого элемента
	movzx	eax, BYTE PTR [rax]		# | eax := [rax] <=> eax := *(rax) <=> eax := string[i] (byte to dword with zero-extension)
	test	al, al					# | Побитовое И без изменения самого al 
	jne	.L25						# | Если al != 0 => ZF = 0 => переход на следующую итерацию цикла
	
	nop								# | Выравнивание 
	nop								# | Выравнивание
	
	leave							# | Эпилог функции
	ret								# \
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
