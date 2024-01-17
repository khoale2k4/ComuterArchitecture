# data segment
	.data
# load variable
str_s:	.asciiz	"Computer Architecture 2022"
int_cnt:	.word	26

# code segment
	.text
	.globl	main

# main
main:
# in ra chuoi ban dau
	la	$a0, str_s
	addi	$v0, $zero, 4
	syscall
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11
	syscall
	
# set variable
	la	$a0, str_s	
	la	$a1, int_cnt	
	
# main
# $a2 = left, $a3 = right, $t0 = char_left, $t1 = char_right, $t2 = temp, $t3 = count
# t4 = idx_left, t5 = idx_right
	lw	$t3, int_cnt
	la	$a2, str_s
	la	$a3, str_s
	add	$a3, $a3, $t3
	addi	$a3, $a3, -1
	addi	$t4, $zero, 0
	addi	$t5, $t3, -1

# call reverse function
	jal	reverse

# done
	la	$a0, str_s
	addi	$v0, $zero, 4
	syscall
	
# end program
end_:	addi	$v0, $zero, 10
	syscall
	
#-----------------------------------
#Cac chuong trinh con khac
#----------------------------------- 

reverse:
# $a2 = left, $a3 = right, $t0 = char_left, $t1 = char_right, $t2 = temp, $t3 = count
# t4 = idx_left, t5 = idx_right
# start ($t6 = 0 -> break)
while:	slt	$t6, $t4, $t5
	beqz	$t6, end_loop

	lb	$t0, 0($a2)
	lb	$t1, 0($a3)
	addi	$t2, $t0, 0
	addi	$t0, $t1, 0
	addi	$t1, $t2, 0
	sb	$t0, 0($a2)
	sb	$t1, 0($a3)
	
	addi	$a2, $a2, 1
	addi	$a3, $a3, -1
	addi	$t4, $t4, 1
	addi	$t5, $t5, -1
	j while
end_loop:	
	jr $ra
