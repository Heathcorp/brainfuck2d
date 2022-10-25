# Usage
### Compile the program:
``make brainfuck2d``
### Run the program, give your brainfuck script file as the first argument:
``./brainfuck2d programs/hello.bf``

# Language
Standard Brainfuck programming applies, with two extra opcodes:

``/``	Move up one space on the 2D tape

``\``	Move down one space on the 2D tape

## Special characters
``#``	Debug: Print the grid surrounding the tape head

``$``	Debug: Print the value of the current cell

``~``	Debug: Exit the program
