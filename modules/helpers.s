	.file	"helpers.c"
	.intel_syntax noprefix
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
