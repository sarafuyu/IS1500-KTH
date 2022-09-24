  # delay.asm
  # This file was written 2022 by Sara Rydell.
  
delay:
	PUSH 	$s1
	PUSH 	$s2
	
	li 	$s2,200		# changeable constant (4711 original)
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
