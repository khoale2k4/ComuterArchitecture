#Chuong trinh lab5 2: nhap so thuc sau do tinh chu vi va dien tich
#-----------------------------------
#Data segment
.data
#Cac cau nhac nhap du lieu 
	prompt_radius: 	.asciiz "Nhap ban kinh duong tron (so thuc): \0"
	prompt_circum:	.asciiz "Chu vi cua hinh tron: \0"
	prompt_area:	.asciiz "Dien tich cua hinh tron: \0"
	error: 		.asciiz "Input khong hop le, nhap lai!\0"
	newline:	.asciiz "\n\0"
#Cac dinh nghia bien 
	radius: 	.float 0.0
	circum: 	.float 0.0
	are: 		.float 0.0
	pi: 		.float 3.14159
	two:		.float 2.0
	zero:		.float 0.0
#-----------------------------------
#Code segment 
.text
.globl main
#-----------------------------------
#Chuong trinh chinh
#----------------------------------- 
main:
#ham nhap ban kinh
    	jal input
#ham tinh chu vi
	jal circumference
#ham tinh dien tich
	jal area
#xuat ket qua
    	li $v0, 4
    	la $a0, prompt_circum
    	syscall
    	
    	li $v0, 2
    	l.s $f12, circum #luu gia tri cua bien circum vao f12
    	syscall
	
    	li $v0, 4
    	la $a0, newline
    	syscall
	
    	li $v0, 4
    	la $a0, prompt_area
    	syscall
	
    	li $v0, 2
    	l.s $f12, are #luu gia tri cua bien are vao f12
    	syscall
		
#ket thuc chuong trinh (syscall) 			
    	li $v0, 10
    	syscall
#-----------------------------------
#Cac chuong trinh con khac
#----------------------------------- 
circumference:
	l.s $f1, radius
	l.s $f2, pi
	l.s $f3, two
	mul.s $f4, $f2, $f1 # pi * r
	mul.s $f4, $f4, $f3 # pi * r * 2
	s.s $f4, circum	#luu ket qua vao bien circum
	
	jr $ra
	
area:
	l.s $f1, radius
	l.s $f2, pi
	mul.s $f3, $f2, $f1 # pi * r
	mul.s $f3, $f3, $f1 # pi * r * r
	s.s $f3, are	#luu ket qua vao bien are

	jr $ra
	
negative:
    	li $v0, 4
    	la $a0, error
    	syscall
    	la $a0, newline
    	syscall
    	
input:
    	li $v0, 4
    	la $a0, prompt_radius
    	syscall

    	li $v0, 6
    	syscall
    	s.s $f0, radius	#luu so vua nhap vao bien radius
    	
    	l.s $f1, radius
    	l.s $f2, zero
	c.le.s $f1, $f2 #so sanh radius voi 0 
	bc1t negative #nhap lai neu <= 0
	
	jr $ra