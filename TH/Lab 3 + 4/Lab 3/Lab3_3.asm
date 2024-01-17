#Chuong trinh 22.3: switch - case
#-----------------------------------
#Data segment
	.data
#Cac cau nhac nhap/xuat du lieu
	input_case: .asciiz "Nhap case: "
	show_result: .asciiz "Ket qua: "
#-----------------------------------
#Code segment
	.text
#-----------------------------------
#Chuong trinh chinh
#-----------------------------------
main:
#Nhap (syscall)
   #Nhap input
	li $v0, 4
	la $a0, input_case
	syscall
	li $v0, 5
	syscall
   #Xu ly
	move $s0, $v0
     #t0=0, t1= 100, t2=2
	li $t0, 0
	li $t1, 100
	li $t2, 2
     # switch - kiem tra gia tri input
	beq $s0, 1, case1
	beq $s0, 2, case2
	beq $s0, 3, case3
	beq $s0, 4, case4
	j print
     # case 1: a=b+c
case1:
	add $t0, $t1, $t2
	j print
     # case 2: a=b-c
case2:
	sub $t0, $t1, $t2
	j print
     # case 3: a=b*c
case3:
	mul $t0, $t1, $t2
	j print
     # case 4: a=b/c
case4:
	div $t0, $t1, $t2
	j print
#Xuat ket qua (syscall)
print:
	la $a0, show_result
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
#-----------------------------------
#Cac chuong trinh con khac
#-----------------------------------
