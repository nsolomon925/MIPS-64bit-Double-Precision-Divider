	.data
nums:	.double	3.0
	.double 1.375
0:	.double	2.1818181818181817

	.double	1.0
	.double	0.0
1:	.double inf

	.double	1.9999999999999998
	.double	1.0000000000000002
2:	.double 1.9999999999999993

	.double	inf
	.double	4.9406564584124654e-324
3:	.double inf

	.double	0.0
	.double	0.0
4:	.word	0,0xfff80000	# nan

	.double 100.0
	.double	10.0
5:	.double	10.0

	.double	9.6276454555959567e+307
	.double	0.59999999999999998
6:	.double 1.6046075759326596e+308

	.double	9.6276454555959567e+307
	.double	0.40000000000000002
7:	.double	inf

	.double	1.2345e-307
	.double	2.0
8:	.double	6.1725e-308

	.double	1.2345e-307
	.double	10.0
9:	.double	1.2345000000000002e-308

	.double	4.9999999999999995e-308
	.double	10000000000000000
A:	.double	4.9406564584124654e-324

	.double	-1000000
	.double	3.0
B:	.double	-333333.33333333331
	
	.double	-9.9999999999999995e-07
	.double	3.0
C:	.double	-3.333333333333333e-07

	.double	0.4	
	.double	-0.1
D:	.double	-4

	.double	-27.0
	.double	-9.0
E:	.double	3.0

	.double	inf
	.double	3.0
F:	.double	inf

	.double	inf
	.double	inf
	.double	0.0

	.code
main:	addi	$a0,$0,'\f
	syscall	$print_char
	la	$t0,nums
	mov	$a0,$0
1:	l.d	$f0,($t0)
	l.d	$f2,8($t0)
	div.d	$f4,$f0,$f2
	cfc1	$a3,$FCR31
	mfc1	$t4,$f4
	mfc1	$t5,$f5
	lw	$t2,16($t0)
	lw	$t3,20($t0)
	bne	$t2,$t4,3f
	bne	$t3,$t5,3f
	addi	$t0,$t0,3*double
	addi	$a0,$a0,1
	bnez	$t2,1b
	bnez	$t3,1b
3:	
	syscall	$print_int
	syscall	$exit