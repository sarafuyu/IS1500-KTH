  # analyze.asm
  # This file was written 2015 by F Lundevall and edited by Sara Rydell.

    	.text
main:
	li	$s0,0x30	# adds 30(hex)/48(dec)/0(ASCII) to s0
loop:
    	move    $a0,$s0       	# copy from s0 to a0

    	li	$v0,11        	# syscall with v0 = 11 will print out
    	syscall            	# one byte from a0 to the Run I/O window

    	addi    $s0,$s0,3    	# constnat was changed from 1 to 3 in 
    				# order to find every three characters
    				
    	li    	$t0,0x5d	# b was chamged to d in order to end the
    				# loop at the correct character
    					
    	bne    	$s0,$t0,loop
    	nop            		# delay slot filler (just in case)

stop:   j    	stop        	# loop forever here
    	nop            		# delay slot filler (just in case)
