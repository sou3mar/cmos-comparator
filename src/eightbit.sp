cmos eight bit comparator
********* models ***********
.inc mosistsmc180.lib

********* subckt not ***********
.subckt 	not 	in		out		vdd
m1 			out		in 		0 		0 		NMOS 	(W = 0.36u 	L = 0.18u )
m2 			out		in 		vdd 	vdd 	PMOS 	(W = 0.72u 	L = 0.18u )
.ends

********* subckt nand2 ***********
.subckt 	nand2 	in1		in2		out		vdd
m1 			out		in1		n1 		n1 		NMOS 	(W = 0.72u 	L = 0.18u )
m2 			n1		in2		0 		0 		NMOS 	(W = 0.72u 	L = 0.18u )
m3 			out		in1		vdd 	vdd 	PMOS 	(W = 0.72u 	L = 0.18u )
m4 			out		in2		vdd 	vdd 	PMOS 	(W = 0.72u 	L = 0.18u )
.ends

********* subckt nand3 ***********
.subckt 	nand3 	in1		in2		in3		out		vdd
m1 			out		in1		n1 		n1 		NMOS 	(W = 1.08u 	L = 0.18u )
m2 			n1		in2		n2 		n2 		NMOS 	(W = 1.08u 	L = 0.18u )
m3 			n2		in3		0 		0 		NMOS 	(W = 1.08u 	L = 0.18u )
m4 			out		in1		vdd 	vdd 	PMOS 	(W = 0.72u 	L = 0.18u )
m5 			out		in2		vdd 	vdd 	PMOS 	(W = 0.72u 	L = 0.18u )
m6 			out		in3		vdd 	vdd 	PMOS 	(W = 0.72u 	L = 0.18u )
.ends

********* subckt xnor 2 ***********
.subckt 	xnor2 	in1		in2		out		vdd
XnotA	 	in1		notin1	vdd		not
XnotB	 	in2		notin2	vdd		not
m1 			out		notin1	n1 		n1 		NMOS 	(W = 0.72u 	L = 0.18u )
m2 			n1		in2		0 		0 		NMOS 	(W = 0.72u 	L = 0.18u )
m3 			out		in1		n2 		n2 		NMOS 	(W = 0.72u 	L = 0.18u )
m4 			n2		notin2	0 		0 		NMOS 	(W = 0.72u 	L = 0.18u )
m5 			out		in1		n3 		n3 		PMOS 	(W = 1.44u 	L = 0.18u )
m6 			n3		in2		vdd 	vdd 	PMOS 	(W = 1.44u 	L = 0.18u )
m7 			out		notin1	n4 		n4 		PMOS 	(W = 1.44u 	L = 0.18u )
m8 			n4		notin2	vdd 	vdd 	PMOS 	(W = 1.44u 	L = 0.18u )
.ends

********* subckt and2 ***********
.subckt 	and2 	in1		in2		out		vdd
Xnot	 	out1	out		vdd		not
Xnand2	 	in1		in2		out1	vdd		nand2
.ends

********* inputs ***********
v_A0	A0		0		dc=0
v_A1	A1		0		dc=1.8
v_B0	B0		0		dc=0
v_B1	B1		0		dc=1.8
v_A2	A2		0		dc=1.8
v_A3	A3		0		dc=0
v_B2	B2		0		dc=1.8
v_B3	B3		0		dc=1.8
v_A4	A4		0		dc=1.8
v_A5	A5		0		dc=0
v_B4	B4		0		PULSE (1.8 0 0ps 100ps 100ps 20ns 40ns)
v_B5	B5		0		PULSE (1.8 0 0ps 100ps 100ps 40ns 80ns)
v_A6	A6		0		PULSE (1.8 0 0ps 100ps 100ps 80ns 160ns)
v_A7	A7		0		PULSE (1.8 0 0ps 100ps 100ps 160ns 320ns)
v_B6	B6		0		PULSE (1.8 0 0ps 100ps 100ps 320ns 640ns)
v_B7	B7		0		PULSE (1.8 0 0ps 100ps 100ps 640ns 1280ns)

********* power supply ***********
vdd			vdd		0		dc=vdd

********* subckt one bit comparator circuit ***********
.subckt 		comp1 	A0		B0		A1		B1		Gt		Eq		Lt		vdd
Xnot1	 		A0		A0_n	vdd						not
Xnot2	 		A1		A1_n	vdd						not
Xnot3	 		B0		B0_n	vdd						not
Xnot4	 		B1		B1_n	vdd						not
Xnand2_1	 	A1		B1_n	n1		vdd				nand2
Xnand2_2	 	n1		n2		Gt		vdd				nand2
Xnand2_3	 	A1_n	B1		n3		vdd				nand2
Xnand2_4	 	n3		n4		Lt		vdd				nand2
Xnand3_1	 	A0		B0_n	x1		n2		vdd		nand3
Xnand3_2	 	B0		A0_n	x1		n4		vdd		nand3
Xand2_1	 		x1		x0		Eq		vdd				and2
Xxnor2_1	 	A1		B1		x1		vdd				xnor2
Xxnor2_2	 	A0		B0		x0		vdd				xnor2
.ends

********* 8 bit comparator circuit ***********
Xcomp1_7		Gt6		Lt6		A7		B7		out_Gt		out_Eq		out_Lt		vdd		comp1
Xcomp1_6		Gt5		Lt5		A6		B6		Gt6			Eq6			Lt6			vdd		comp1
Xcomp1_5		Gt4		Lt4		A5		B5		Gt5			Eq5			Lt5			vdd		comp1
Xcomp1_4		Gt3		Lt3		A4		B4		Gt4			Eq4			Lt4			vdd		comp1
Xcomp1_3		Gt2		Lt2		A3		B3		Gt3			Eq3			Lt3			vdd		comp1
Xcomp1_2		Gt1		Lt1		A2		B2		Gt2			Eq2			Lt2			vdd		comp1
Xcomp1_1		A0		B0		A1		B1		Gt1			Eq1			Lt1			vdd		comp1

********* load ***********
CL1				out_Gt		0		10f
CL2				out_Lt		0		10f
CL3				out_Eq		0		10f

******* simulations *********
.tran 20ps 1280ns
.options post nomod
.param vdd=1.8

.end
