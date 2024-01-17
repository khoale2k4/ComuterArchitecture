#Chuong trinh lab 5 bai 3: Tim Min, Max cua mang 20 phan tu
#-------------------------------------------
#Data segment
	.data
#Khai bao mang arr co 20 phan tu so thuc
arr: .space 640 
#Cac cau lenh nhap, xuat du lieu
prompt: .asciiz "Nhap chuoi: \n"
space: .asciiz " "
printarr: .asciiz "Chuoi da nhap: "
mess: .asciiz "\n Max la = "
mess2: .asciiz "\n Min la = "
#Khai bao bien
float0: .float 0.0
#-------------------------------------------
#Code segment
	.text
	.globl main
#-------------------------------------------
#Chuong trinh chinh
#-------------------------------------------
main:
   #Nhap chuoi
	lwc1 $f10, float0
	li $v0, 4
	la $a0, prompt
	syscall
	
	la $t2, arr 
	li $t1, 0
	li $a1, 20
	loop: 
		li $v0,6
		syscall
		sdc1 $f0, 0($t2)
		add $t2, $t2, 32
		add $t1, $t1, 1
		bne $t1, $a1, loop
   #In chuoi da nhap
	li $v0, 4
	la $a0, printarr
	syscall
	la $t2, arr 
	li $t1, 0
	li $a1, 20
	while:
		lwc1 $f12, 0($t2)
		li $v0, 2
		syscall
		li $v0, 4
		la $a0, space
		syscall
		add $t2, $t2, 32
		add $t1, $t1, 1
		bne $t1, $a1, while
   #Xuat Max (syscall)
	li $v0, 4
	la $a0, mess
	syscall
   
	jal max
	li $v0, 2
	syscall
   #Xuat Min (syscall)
	li $v0, 4
	la $a0, mess2
	syscall

	jal min
	li $v0, 2
	syscall
   #Ket thuc chuong trinh (syscall)
	li $v0, 10
	syscall
	
#-------------------------------------------	
   #Tim Max cua chuoi
	max:
		la $a1, arr
		ldc1 $f4, ($a1)
		li $t5, 1
		li $a2, 21
		loop1:
			ldc1 $f6, 0($a1)
			c.le.s $f6, $f4
			bc1t else1
			add.s $f4, $f6, $f10
			else1:
				addi $t5, $t5, 1
				addi $a1, $a1, 32
				bne $t5, $a2, loop1
		
		add.s $f12, $f4, $f10
		jr $ra
   #Tim min cua chuoi
	min:	
		la $a1, arr
		ldc1 $f4, ($a1)
		li $t5, 1
		li $a2, 21
		loop2:
			ldc1 $f6, 0($a1)
			c.lt.s $f6, $f4
			bc1f else2
			add.s $f4, $f6, $f10
			else2:
				addi $t5, $t5, 1
				addi $a1, $a1, 32
				bne $t5, $a2, loop2
		
		add.s $f12, $f4, $f10
		jr $ra
