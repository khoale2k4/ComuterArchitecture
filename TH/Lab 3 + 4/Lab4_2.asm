#Chuong trinh lab4 2: Tinh range cua max va min trong mot mang
#-----------------------------------
#Data segment
.data
#Cac dinh nghia bien 
	iarray: .word 10,0,1,1,1,1,1,1,1,1
	num: .word 10
#Cac cau nhac nhap du lieu 

#-----------------------------------
#Code segment 
.text
.globl main
#-----------------------------------
#Chuong trinh chinh
#----------------------------------- 
main:
#luu mang vao $a0
	la $a0, iarray
#luu so phan tu trong mang vao $a1
	lw $a1, num
#goi ham range va luu dia chi quay ve vao $ra
	jal range

#xuat ket qua
	li $v0, 1
	move $a0, $t4
	syscall
	
#ket thuc chuong trinh (syscall) 
	li $v0, 10
	syscall
#-----------------------------------
#Cac chuong trinh con khac
#----------------------------------- 
#ham range tra ve khoang cach giua max va min trong mang
range:
#luu dia chi cua $ra vao stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

#khai bao bien $t0 la max
	li $t0, 0
#goi ham max
	jal max # tra ve thanh ghi $t0
	
#tra vi tri trong mang ve lai ban dau
	la $a0, iarray
#khai bao bien $t1 la min
	li $t1, 0
#goi ham min
	jal min # tra ve thanh ghi t1

#tinh khoang cach
	sub $t4, $t0, $t1

#lay gia tri $ra trong stack ra
	lw $ra, 0($sp)
	addi $sp, $sp, 4

#quay ve
	jr $ra
	
#ham max
max:
#luu gia tri dau tien cua mang vao $t0
    	lw $t0, 0($a0)

#vi tri bat dau
    	li $t3, 0
    	#duyet mang bang loop            
    	loop_max:
    		#luu gia tri hien tai vao $t4
        	lw $t4, 0($a0)   
        	#tang vi tri hien tai len 1
        	addi $a0, $a0, 4  
        	#kiem tra xem vi tri hien tai co lon hon max
        	bge $t4, $t0, update_max 
        	j next_max
        	#cap nhat max
        	update_max:
            		move $t0, $t4 
            	#ham kiem tra dieu kien va tang vi tri
        	next_max:
        		#tang vi tri len 1
            		addi $t3, $t3, 1  
            		#kiem tra xem da het mang chua
            		blt $t3, $a1, loop_max
#quay ve
    	jr $ra
	
min:
#luu gia tri dau tien cua mang vao $t0
	lw $t1, 0($a0)

#vi tri bat dau
    	li $t3, 0            
    	#duyet mang bang loop            
    	loop_min:
    		#luu gia tri hien tai vao $t4
        	lw $t4, 0($a0)   
        	#tang vi tri hien tai len 1
        	addi $a0, $a0, 4  
        	#kiem tra xem vi tri hien tai co nho hon min
        	ble $t4, $t1, update_min 
        	j next_min
        	#cap nhat min
        	update_min:
            		move $t1, $t4 
            	#ham kiem tra dieu kien va tang vi tri
        	next_min:
        		#tang vi tri len 1
            		addi $t3, $t3, 1  
            		#kiem tra xem da het mang chua
            		blt $t3, $a1, loop_min
#quay ve
    	jr $ra

