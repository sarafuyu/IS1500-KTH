  # hexmain.asm
  # Written 2015-09-04 by F Lundevall and edited 2022 by Sara Rydell.
  # Copyright abandoned - this file is in the public domain.

	.text
main:
	li	$a0,115		# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

# You can write your own code for hexasc here

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
