# Data segment
	.data
	
# Dinh nghia bien
str_s:	.asciiz	"Computer Architecture CSE-HCMUT"
char_c:	.byte	'r'
int_pos:	.word	-1

#-------------------------------------------
# Code segment
	.text
	.global	main
	
#-------------------------------------------
# Main function
main:
# In string co san
	la	$a0, str_s
	addi	$v0, $zero, 4
	syscall
	addi	$a0, $zero, '\n'
	addi	$v0, $zero, 11
	syscall
	
# Setup
# $a1 = str_s, $t0 = s[i], $t1 = char_c, $t2 = i (= 0)
	la	$a1, str_s
	lb	$t1, char_c
	addi	$t2, $zero, 0
	
# While loop
while:	lb	$t0, 0($a1)
	beq	$t0, $t1, end_while  # found
	beq	$t0, $zero, end_while  # reached end
	
	addi	$t2, $t2, 1
	addi	$a1, $a1, 1
	j	while
	
end_while:
# Found / Reached End (not found)
	beq	$t0, $zero, not_f
	sw	$t2, int_pos

found:	lw	$a0, int_pos
	addi	$v0, $zero, 1
	syscall
	j	end_

not_f:	addi	$a0, $zero, -1
	addi	$v0, $zero, 1
	syscall
# End program
end_:	addiu	$v0, $zero, 10
	syscall
	
#-------------------------------------------
# Cac chuong trinh con khac
#-------------------------------------------