  # timetemplate.asm
  # Written 2015 by F Lundevall and edited 2022 by Sara Rydell.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text more text lots of text\0"
	.text
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,1000		# originally 2
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

  # you can write your code for subroutine "hexasc" below this line
	
hexasc:
	blt 	$a0,0,stop 	# if input is less than 0, stop
	nop
	andi 	$a0,$a0,0xF	# if input is greater than 1111=15, remove excess bits
	blt 	$a0,10,dec 	# if input is less than 10, print decimal number
	nop
	blt 	$a0,16,hex 	# if input is less than 17, print hex-dec number
	nop
	j 	stop		# otherwise, stop
	nop
dec: 
	addi 	$v0,$a0,48 	# calculates the decimal number
	jr 	$ra
	nop
hex: 
	addi 	$v0,$a0,55 	# calculates the hex-dec nubmer
	jr 	$ra
	nop
stop:	
	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

delay:
	PUSH 	$s1
	PUSH 	$s2
	
	li 	$s2,150		# changeable constant (4711 original)
	j 	loop1		
	nop
loop1: 				# while ms > 0 loop
	addi 	$a0,$a0,-1 	# ms = ms – 1
	li 	$s1,0 		# i = 0
	j 	loop2
	nop
loop2: 				# for i < constant loop
	addi 	$s1,$s1,1	# i = i + 1
	blt 	$s1,$s2,loop2	# continue if i < constant
	nop
	bgtz 	$a0,loop1	
	nop
	
	POP	$s2
	POP	$s1
	jr 	$ra
	nop
			
time2string:
	PUSH 	$ra
	PUSH 	$s0
	PUSH 	$s1
	PUSH 	$s2
	PUSH 	$s3
	PUSH 	$s4
	PUSH 	$s5
	PUSH 	$s6
	PUSH 	$s7
	
	move 	$s7,$a0		# address to t7
	move 	$s0,$a1		# time string from a1 ato t0
			
	andi 	$s1,$s0,0xF000  # F0:00
	andi 	$s2,$s0,0xF00   # 0F:00
	andi 	$s3,$s0,0xF0    # 00:F0
	andi 	$s4,$s0,0xF	# 00:0F
	
	srl 	$s1,$s1,12 	# isolates numbers
	srl 	$s2,$s2,8	
	srl 	$s3,$s3,4
			
	move 	$a0,$s1		# prepares the values
	jal 	hexasc		# finds the ascii character
	nop
	sb 	$v0,0($s7)	# saves number to create time string

	move	$a0,$s2		# -||-
	jal	hexasc
	nop
	sb	$v0,1($s7)
	
	addi 	$s5,$0,58	# adds the colon
	sb	$s5,2($s7)	# saves the colon for time string
	
	move	$a0,$s3		# -||-
	jal	hexasc
	nop
	sb	$v0,3($s7)
	
	move	$a0,$s4		# -||-
	jal	hexasc 
	nop
	# surprise assignment
	beq 	$v0,57,nine 	# if v0 = 9, go to nine
	nop
	bne 	$v0,57,last	# if v0 != 9, go to last
	nop
nine:
	# 78 73 78 69 = N I N E
	li $t1, 78
	nop
	li $t2, 73
	nop
	li $t3, 69
	nop
	
	sb $t1,4($s7) # N
	sb $t2,5($s7) # I
	sb $t1,6($s7) # N
	sb $t3,7($s7) # E
	
	addi 	$t6,$0,0x00	# adds the NULL byte
	sb	$t6,8($s7)
	
	POP 	$s7
	POP 	$s6
	POP 	$s5
	POP 	$s4
	POP 	$s3
	POP 	$s2
	POP 	$s1
	POP 	$s0	
	POP 	$ra
	jr 	$ra
	nop
last:
	sb $v0,4($s7)
	
	addi $t6,$0,0x00	# adds the NULL byte
	sb $t6,5($s7)
	
	POP 	$s7
	POP 	$s6
	POP 	$s5
	POP 	$s4
	POP 	$s3
	POP 	$s2
	POP 	$s1
	POP 	$s0	
	POP 	$ra
	jr 	$ra
	nop
