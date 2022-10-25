

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
								[-]
								//

							[-]]>[[-]<[-]
							if n == 51 (closeb)
								\\
								[-]++++++
								\++/
								//
							>]<

						[-]]>[[-]<[-]
						if n == 49 (openb)
							\\
							[-]+++++
							\+/
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
<[<]


add boundaries
/<->\ - \ - \<->\<->///
[>]
/ - \ - \ - \ - \ - ///
<[<]/>>

tape head
\\\>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>+<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<///
pc
<+>

main brainfuck loop:

+[-
<->+

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
									\\\\\+[-<+]->-[+>-]+

									\,/

									+[-<+]-<///+[->+]->-[+>-]+//
								>]<
							]>[-<
							if dot
								\\\\\+[-<+]->-[+>-]+

								\./

								+[-<+]-<///+[->+]->-[+>-]+//
							>]<
						]>[-<
						if closeb
							find the current cell
							\\\\\+[-<+]->-[+>-]+

							\[-\+\+//]\[-/+\]\

							[[-]
							if tape cell is not 0 go through the loops and find the right one to skip back to
							starts 2 below the tape
								
								///+[-<+]-///+[->+]-
								set the loop counter to 1
								<+

								[>>-[+>-]<+\\
								go through each loop marker until the counter is 0
									copy to above for if else
									[-///+/+\\\\]///[-\\\+///]/

									->+<[>-<
									else not loop start
										->+<[>-<[-]
										else neither loop start or end
											pass
										]>[-<
										if loop end take 1 from counter
											find counter
											\\+[-<+]-<
											+
											navigate back
											>>-[+>-]+//
										>]<
									]>[-<
									if loop start add 1 to counter
										\\+[-<+]-<
										-
										>>-[+>-]+//
									>]<
								\\+[-<+]-<]

								clear loop counter just in case
								[-]

								return back to 2 below the tape
								>\\\+[-<+]->-[+>-]+\\\
							]

							///+[-<+]-<///+[->+]->-[+>-]+//
						>]<
					]>[-<
					if openb
						find the current cell
						\\\\\+[-<+]->-[+>-]+

						\[-\+\+//]\[-/+\]\

						>+<[>-<[-]]>[-<
						if tape cell is 0 go through the loops and find the right one to skip to
						starts 2 below the tape
							
							///+[-<+]-///+[->+]-
							set the loop counter to 1
							<+

							[>>-[+>-]>+\\
							go through each loop marker until the counter is 0
								copy to above for if else
								[-///+/+\\\\]///[-\\\+///]/

								->+<[>-<
								else not loop start
									->+<[>-<[-]
									else neither loop start or end
										pass
									]>[-<
									if loop end take 1 from counter
										find counter
										\\+[-<+]-<
										-
										navigate back
										>>-[+>-]+//
									>]<
								]>[-<
								if loop start add 1 to counter
									\\+[-<+]-<
									+
									>>-[+>-]+//
								>]<
							\\+[-<+]-<]

							clear loop counter just in case
							[-]

							return back to 2 below the tape
							>\\\+[-<+]->-[+>-]+\\\
						>]<

						///+[-<+]-<///+[->+]->-[+>-]+//
					>]<
				]>[-<
				if left
					\\\\\+[-<+]->-[+>-]+

					check for and extend boundary if needed
					<<-\-/>+\+/
					[<+\+/>-\-/]
					+>-

					+[-<+]-<///+[->+]->-[+>-]+//
				>]<
			]>[-<
			if right
				\\\\\+[-<+]->-[+>-]+
				
				>>-\-/<+\+/
				[>+\+/<-\-/]
				+<-

				+[-<+]-<///+[->+]->-[+>-]+//
			>]<
		]>[-<
		if minus
			\\\\\+[-<+]->-[+>-]+

			\-/

			+[-<+]-<///+[->+]->-[+>-]+//
		>]<
	]>[-<\\
	if plus
		find the start of the tape
		\\\
		+[-<+]->
		check right for a tape head
		-[+>-]+
		increment
		\+/
		find the pc again
		+[-<+]-
		<///
		+[->+]-
		>-[+>-]+

	//>]<
	
	\\
>
+]-