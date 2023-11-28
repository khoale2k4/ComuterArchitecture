#Chuong trinh Assignment 2 Bai 1: Nhan hai so nguyen 32bit
#-----------------------------------
#Data segment
.data
#Cac dinh nghia bien 
	filename: 	.asciiz "C:\\Users\\Administrator\\Desktop\\INT2.bin"
    	buffer: 	.space 32000
	zero: 		.word 0
	one:		.word 1
#Cac cau nhac nhap du lieu 
	remind1: 	.ascii "So bi nhan (32 bit): \0"
	remind2: 	.ascii "So nhan (32 bit): \0"
	result: 	.ascii "Ket qua duoi dang nhi phan (64 bit): \0"
	isneg:		.ascii "Ket qua la so am, ta thuc hien nhan khong dau sau do them dau tru vao ket qua\0"
	toneg:		.ascii "Them dau tru vao ket qua\0"
	step:		.ascii "Step \0"
	space: 		.ascii "\t\0"
	newline: 	.ascii "\n\0"
	colon:		.ascii ": \0"
	colonnl:	.ascii ": \n\0"
	lsb: 		.ascii "LSB: \0"
	add_tag:	.ascii "Add: \t\0"
	shift_tag:	.ascii "Shift: \t\0"	
	open_brackets:	.ascii " (\0"
	close_brackets:	.ascii ") \0"
	#s0:	so bi nha
	#s1:	so nhan
	#s2:	bit cao cua tich
	#s3:	bit thap cua tich
#-----------------------------------
#Code segment 
.text
.globl main
#-----------------------------------
#Chuong trinh chinh
#----------------------------------- 
main:	
	#t0:	bien dem
	jal load_file
	li $s2, 0 #bit cao
	li $s3, 0 #bit thap
	
	li $v0, 4
	la $a0, remind1
	syscall	
	li $v0, 35
    	move $a0, $s0
    	syscall	
	li $v0, 4
	la $a0, open_brackets
	syscall	
	li $v0, 1
    	move $a0, $s0
    	syscall
	li $v0, 4
	la $a0, close_brackets
	syscall	
	
	li $v0, 4
	la $a0, newline
	syscall
	la $a0, remind2
	syscall
	li $v0, 35
    	move $a0, $s1
    	syscall
	li $v0, 4
	la $a0, open_brackets
	syscall	
	li $v0, 1
    	move $a0, $s1
    	syscall
	li $v0, 4
	la $a0, close_brackets
	syscall	
	
	jal neg_or_pos
	
	bnez $t6, not_neg
	
	li $v0, 4
	la $a0, newline
	syscall	
	la $a0, isneg
	syscall	
	
not_neg:
	
	ori $s3, $s1, 0
	li $v0, 4
	la $a0, newline
    	syscall
	la $a0, step
	syscall
	
	li $v0, 1
	li $a0, 0
	syscall
	
	li $v0, 4
	la $a0, colon
	syscall
	
	li $v0, 35
    	move $a0, $s2
    	syscall
    	move $a0, $s3
    	syscall
    	
    	li $v0, 4
	la $a0, newline
    	syscall
	
	li $t0, 1
	j loop
		
#ket thuc chuong trinh (syscall) 	
end:
	#t6: 	kiem tra so bi nhan va so nhan co cung dau khong
	bnez $t6, pos
	neg:
	
	li $v0, 4
	la $a0, toneg
	syscall	
	la $a0, newline
	syscall	
	
	bnez $s2, neg_hi
	ori $s2, $s2, 0xFFFFFFFF
	mul $s3, $s3, -1
	j pos
	neg_hi:
	mul $s2, $s2, -1
	pos:
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 35
    	move $a0, $s2
    	syscall
    	move $a0, $s3
    	syscall
	
    	li $v0, 10
    	syscall

#-----------------------------------
#Cac chuong trinh con khac
#----------------------------------- 
loop:
	#t0:	bien dem
	#t1:	check xem da chay duoc 32 lan chua
	#t3:	bit be nhat (lsb)
	li $v0, 4
	la $a0, step
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, colonnl
	syscall
	
	li $v0, 4
	la $a0, lsb
	syscall
	la $a0, space
	syscall
	
	jal least_significant_bit
	
	li $v0, 4
	la $a0, newline
	syscall
	
	beqz $t3, skip_add
	jal add_hi
	skip_add:
		jal shift_right
	
	slti $t1, $t0, 32
	beqz $t1, end
	addi $t0, $t0, 1
	j loop

least_significant_bit:
	#t3:	bit nho nhat cua bit thap
	andi $t3, $s3, 1
	beqz $t3, print0
	
	print1:
		li $v0, 1
		lw $a0, one
		syscall
		jr $ra
		
	print0:
		li $v0, 1
		lw $a0, zero
		syscall
		jr $ra

add_hi:
	addu $s2, $s2, $s0
		
	li $v0, 4
	la $a0, add_tag
    	syscall
	
	li $v0, 35
    	move $a0, $s2
    	syscall
    	move $a0, $s3
    	syscall
    	
    	li $v0, 4
	la $a0, newline
    	syscall
    	
	jr $ra

shift_right:
	#t2:	kiem tra bit nho nhat cua bit cao la 0 hay 1
	andi $t2, $s2, 1
	srl $s2, $s2, 1
	srl $s3, $s3, 1
	beqz $t2, skip_lo_of_hi
	
	ori $s3, $s3, 0x80000000
	skip_lo_of_hi:
	
	li $v0, 4
	la $a0, shift_tag
    	syscall
	
	li $v0, 35
    	move $a0, $s2
    	syscall
    	move $a0, $s3
    	syscall
    	
    	li $v0, 4
	la $a0, newline
    	syscall
	
	jr $ra		
			
neg_or_pos:
	beqz $s0, zero1
	beqz $s1, zero1
	#t6: 	kiem tra so bi nhan va so nhan co cung dau khong

	#t4:	kiem tra so bi nhan am
	#t5:	kiem tra so nhan am
	slti $t4, $s0, 0
	slti $t5, $s1, 0
	mul $t6, $t4, $t5
	bnez $t6, return
	
	#t4:	kiem tra so bi nhan duong
	#t5:	kiem tra so nhan duong
	sgt $t4, $s0, 0
	sgt $t5, $s1, 0
	mul $t6, $t4, $t5
	bnez $t6, return
	
	j return
	
	zero1:
	addi $t6, $t6, 1
	
	return:
	abs $s0, $s0
	abs $s1, $s1
	jr $ra
			
load_file:
	#s4:	file descriptor
	#t0:	chua chuoi du lieu doc
	#t2:	do dai so nguyen 1
	#t3:	do dai so nguyen 2
	#t4, t5:bien tam giup chuyen so dang chuoi thanh so nguyen		
	#mo file
	li $v0, 13
    	la $a0, filename#ten file
    	li $a1, 0 	#ma 0 là ma doc file
    	syscall
    	move $s4, $v0 	#file descriptor

	#doc file
    	li $v0, 14  
    	move $a0, $s4   #file descriptor
    	la $a1, buffer	#mang de luu
    	li $a2, 32000	#kich thuoc mang
    	syscall
    
    	#dong file
    	li $v0, 16 
    	move $a0, $s4	#file descriptor
    	syscall 
    
	la $t0, buffer	
	li $t2, 0
	li $t3, 0
	li $t6, 0
	li $t7, 0
	li $s0, 0
	li $s1, 0
	
get_first_length:
	lb $t1, 0($t0)
	beq $t1, 32, end_first_length

	addi $t0, $t0, 1
	beq $t1, 45, skip_signed_len1
	addi $t2, $t2, 1
	j no_skip1
	skip_signed_len1:
	addi $t6 $t6, 1
	no_skip1:
	
	j get_first_length
	
end_first_length:
	addi $t0, $t0, 1    

get_second_length:
	lb $t1, 0($t0)
	beqz $t1, end_second_length

	addi $t0, $t0, 1
	beq $t1, 45, skip_signed_len2
	addi $t3, $t3, 1
	j no_skip2
	skip_signed_len2:
	addi $t7 $t7, 1
	no_skip2:
	j get_second_length
	
end_second_length:
	li $t4, 1
	li $t5, 1
	li $t1, 1
	
get_pow_10_first:
	beq $t1, $t2, end_pow_10_first
	addi $t1, $t1, 1
	mul $t4, $t4, 10
	j get_pow_10_first
	
end_pow_10_first:
	li $t1, 1

get_pow_10_second:
	beq $t1, $t3, end_pow_10_second
	addi $t1, $t1, 1
	mul $t5, $t5, 10
	j get_pow_10_second
	
end_pow_10_second:
    	la $t0, buffer
    	
loop1:	
	lb $t1, 0($t0)
	beq $t1, 32, end1	#check xem da xet den khoang cach chua
	beq $t1, 45, skip_signed_num1
	subi $t1, $t1, 48
	
	mul $t2, $t4, $t1
	
	addu $s0, $s0, $t2
	div $t4, $t4, 10
	skip_signed_num1:
	addi $t0, $t0, 1
	j loop1
end1:
	addi $t0, $t0, 1
	
loop2:	
	lb $t1, 0($t0)
	beqz $t1, end_load	#check xem da xet den het chuoi chua
	beq $t1, 32, end_load	#check xem da xet den khoang cach chua
	beq $t1, 45, skip_signed_num2
	subi $t1, $t1, 48
	
	mul $t3, $t5, $t1
	addu $s1, $s1, $t3
	div $t5, $t5, 10
	skip_signed_num2:
	addi $t0, $t0, 1
	j loop2

end_load:
	beqz $t6, num1_pos
	mul $s0, $s0, -1
	num1_pos:
	beqz $t7, num2_pos
	mul $s1, $s1, -1
	num2_pos:
	jr $ra
			
