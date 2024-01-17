#Chuong trinh lab 3 bai 2: if (a < -3 || a >= 7)
#-------------------------------------------
#Data segment
	.data
#Cac cau nhap du lieu
Nhap_a: .asciiz "Nhap a: "
Nhap_b: .asciiz "Nhap b: "
Nhap_c: .asciiz "Nhap c: "
mess:	.asciiz "a = "
#-------------------------------------------
#Code segment
	.text
	.globl main
#-------------------------------------------
#Chuong trinh chinh
#-------------------------------------------
main:
#Nhap (syscall)
   #Nhap a
	li $v0, 4
	la $a0, Nhap_a
	syscall
	li $v0, 5
	syscall
	move $t0, $v0	#t0 = a
   #Nhap b
	li $v0, 4
	la $a0, Nhap_b
	syscall
	li $v0, 5
	syscall
	move $t1, $v0	#t1 = b
   #Nhap c
	li $v0, 4
	la $a0, Nhap_c
	syscall
	li $v0, 5
	syscall
	move $t2, $v0	#t2 = c
#Xu ly
   #s0 = a + 3, s1 = a - 7
	addi $s0, $t0, 3
	addi $s1, $t0, -7
   #if (a + 3 < 0)
	bltz $s0, then
   #if (a - 7 >= 0)
	bgez $s1, then
   #else
else:
	add $t0, $t1, $t2	#a = b + c 
	j print
   #then
then:
	mul $t0, $t1, $t2	#a = b * c
	j print
#Xuat ket qua (syscall)
print:
	li $v0, 4
	la $a0, mess
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
#Xuat ket qua (syscall)
#Ket thuc chuong trinh (syscall)
	addiu $v0,$zero,10
	syscall
#-------------------------------------------	
#Cac chuong trinh con khac
#-------------------------------------------	