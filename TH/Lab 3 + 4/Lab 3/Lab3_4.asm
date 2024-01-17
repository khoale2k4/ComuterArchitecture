#Chuong trinh 22.4: tinh Fibonacci dung for
#-----------------------------------
#Data segment
	.data
#Cac cau nhap/xuat du lieu
input_n: .asciiz "Nhap n: "
result_fail: .asciiz "invalid input"
#-----------------------------------
#Code segment
	.text
#-----------------------------------
#Chuong trinh chinh
#-----------------------------------
main:
#Nhap (syscall)
	#Nhap n
		li $v0, 4
		la $a0, input_n
		syscall
		li $v0, 5
		syscall
		move $t0, $v0
	#Tro den failcase neu t0 < 0
		bltz $t0, failcase
	#Kiem tra gia tri t0, neu <= 1 thi tro den printn
		addi $k1, $t0, -1
		blez $k1, printn
	#f[0]=0, f[1]=1, bo dem vong lap k, s4 = n + 1
		li $s0, 0
		li $s1, 1
		li $k0, 2
		add $s4, $t0, 1
#LOOP
loop:
	add $s2, $s1, $s0 	# $s2 = f[k-1] + f[k-2]
	add $s0, $s1, 0		# f[k-2] = f[k-1]
	add $s1, $s2, 0		# f[k-1] = $s2
	add $k0, $k0, 1		# Tang bo dem k = k + 1
	bne $k0, $s4, loop	# Tro den phan "loop" neu k != n + 1
	j print
printn:
	move $a0, $t0
	li $v0, 1
	syscall
	j end
#In ket qua
print:
	move $a0, $s2
	li $v0, 1
	syscall
	j end
#In result_fail neu khong thoa man dieu kien
failcase:
	li $v0, 4
	la $a0, result_fail
	syscall
	j end
#ket thuc chuong trinh (syscall)
end: addiu $v0,$zero,10
syscall
#-----------------------------------
#Cac chuong trinh con khac
#-----------------------------------
