#Chuong trinh lab 3 bai 1: if (a%2 == 0)
#-------------------------------------------
#Data segment
	.data
#Cac cau nhap du lieu	
mess1: .asciiz "Computer Science and Engineering, HCMUT"
mess2: .asciiz "Computer Architecture 2022"
Nhap_a: .asciiz "Nhap a: "
#-------------------------------------------
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
	move $t0, $v0		#t0 = a
#Xu ly
   # s0 = 2
	li $s0, 2
   #if (a%2 == 0)
	div $t0, $s0
	mfhi $t1
	bnez $t1, else
   #then
	li $v0, 4
	la $a0, mess1
	syscall
	j end
   #else
else:
	li $v0, 4
	la $a0, mess2
	syscall
   #end
end:
#Xuat ket qua (syscall)
#Ket thuc chuong trinh (syscall)
	addiu $v0,$zero,10
	syscall
#-------------------------------------------	
#Cac chuong trinh con khac
#-------------------------------------------