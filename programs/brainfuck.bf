

input a brainfuck program from the command line
,
----------
[++++++++++>,----------]
<[<]>

need to translate to small numbers for easier coding later
first construct a large constant and subtract from each program character 
</
++++++ ++++++ ++++++ ++++++ ++++++ ++++++ ++++++
[-
	subtract 1 from each program character
	>\[
		->
	]
	return back
	<[<]/
]>\


plus	1	1
minus	3	2
left	18	4
right	20	3

openb	49	5
closeb	51	6

dot		4	7
comma	2	8

other	255


for each character in the bf file  convert the char to a digit as above
[
copy n up two spaces
[-/+/+\\]/[-\+/]/

if n == 1:
-
>+<[>-<
else n != 1

	if n == 2:
	-
	>+<[>-<
	else n != 2

		if n == 3:
		-
		>+<[>-<
		else n != 3

			if n == 4:
			-
			>+<[>-<
			else n != 4

				if n == 18:
				------- -------
				>+<[>-<
				else n != 18

					if n == 20:
					--
					>+<[>-<
					else n != 20

						if n == 49:
						----- ----- ----- ----- --- --- ---
						>+<[>-<
						else n != 49

							if n == 51:
							--
							>+<[>-<
							else n != 51

								\\
								[-]-
								//

							[-]]>[[-]<[-]
							if n == 51
								\\
								[-]++++++
								//
							>]<

						[-]]>[[-]<[-]
						if n ==49
							\\
							[-]+++++
							//
						>]<

					[-]]>[[-]<[-]
					if n == 20 (right)
						\\
						[-]+++
						//
					>]<

				[-]]>[[-]<[-]
				if n == 18 (left)
					\\
					[-]++++
					//
				>]<

			[-]]>[[-]<[-]
			if n == 4 (dot)
				\\
				[-]+++++++
				//
			>]<

		[-]]>[[-]<[-]
		if n == 3 (minus)
			\\
			[-]++
			//
		>]<

	[-]]>[[-]<[-]
	if n == 2 (comma)
		\\
		[-]++++++++
		//
	>]<

[-]]>[[-]<[-]
if n == 1 (plus)
	\\
	[-]+
	//
>]<\\

>
]
<[<]>

construct the masking layers for the loops and pc and tape head
[
	pc:/+\
	loops:\+
	tape head:\+
	tape cells:\[-]
	///
>]<[<]


add boundaries
/<->\-\-\-\-///
[>]
/ - \-\-\-\-///
<[<]>


main brainfuck loop:
/>
tape head = 0
\\\-///
+[-
<+>-

	copy the current command to a clean space
	\[-//+/+\\\]//[-\\+//]/

	if else chain:
	>+<-[>[-]<
	else not plus
		>+<-[>[-]<
		else not minus
			>+<-[>[-]<
			else not right
				>+<-[>[-]<
				else not left
					>+<-[>[-]<
					else not openb
						>+<-[>[-]<
						else not closeb
							>+<-[>[-]<
							else not dot
								>+<-[>[-]<[-]
								else not comma
									non brainfuck character
									do nothing
								]>[-<
								if comma
									\\\\\+[-<+]->[>]

									\,/

									+[-<+]-<///+[->+]->[>]//
								>]<
							]>[-<
							if dot
								\\\\\+[-<+]->[>]

								\./

								+[-<+]-<///+[->+]->[>]//
							>]<
						]>[-<
						if closeb
							+++++++++++++++++++++++++++++++++++++.[-]
						>]<
					]>[-<
					if openb
						++++++++++++++++++++++++++++++++++++.[-]
					>]<
				]>[-<
				if left
					\\\\\+[-<+]->[>]
					todo: check for and extend boundaries
					+<->

					+[-<+]-<///+[->+]->[>]//
				>]<
			]>[-<
			if right
				\\\\\+[-<+]->[>]
				todo: check for and extend boundaries
				+>-<

				+[-<+]-<///+[->+]->[>]//
			>]<
		]>[-<
		if minus
			\\\\\+[-<+]->[>]

			\-/

			+[-<+]-<///+[->+]->[>]//
		>]<
	]>[-<\\
	if plus
		find the start of the tape
		\\\
		+[-<+]->
		check right for a tape head
		[>]
		increment
		\+/
		find the pc again
		+[-<+]-<
		///
		+[->+]-
		>[>]

	//>]<
	
	\\
>
+]-