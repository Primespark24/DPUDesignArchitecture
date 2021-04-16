# Digital Design and Computer Architecture
## FP1: Microprocessor Language Design  

## Evaluation Rubric



| CATEGORY | Poor or missing attempt | Beginning  | Satisfactory | Excellent  |
|:--------:|:--------:|:--------:|:--------:|:--------:|
| Section 1: Comparing Processors  | Missing or extremely poor quality. | Low quality comparison of processors.  Questions answered poorly and instructions not followed. | Adequate comparison of both processors architecture, machine code, and assembly language | Excellent comparison of both processors architecture, machine code, and assembly language instructions and format. |
| Section 2: Assembly Language Design | Missing or extremely poor quality. | Beginning design. Done quickly without much thought.. | Satisfactory design. | Excellent design. Good opcode choices and architecture. |
| Section 3: Assembler | Missing or extremely poor quality. | Hard coded assembler with few comments. No variables or labels (values are hard coded in the instructions)  | Adequate assembler with one of either variables or labels. Adequately commented. | Well commented, comprehensive assembler program that supports labels and variables. And a useful program. | 
| Section 4: Assembly Language and Machine Code | Missing or extremely poor quality. | Hex listing without assembly language. |  Adequate assembly language program and associated working machine code. | Excellent assembler with comments, excellent assembly language program  |


## Introduction

### Part 1 of FP1
For the first half of FP1 you will start by comparing two real world processors. You will compare their intended purpose, their instruction sets, their architecture, their performance etc. This step will help you understand other possibilities for instruction sets and instruction set formats. It will also help you understand the architecture behind real world processors. This first part may be challenging to find information online if you pick an obscure processor or a proprietary processor that does not have much information available (yet) online. 

### Part 2 of FP1 
1.	Decide on what type of processor you want to target (e.g. general purpose or special purpose dedicated processor: e.g. graphics, a.i., dsp, etc.) 
2.	Design a new, original instruction set (i.e. assembly language) for your processor that will be capable of running non-trivial programs.  
3.	Design the machine code format for your instruction set.  
4.	Write a non-trivial assembler program that will use your new, original, assembly language (for testing purposes).
5.	Create an assembler to convert text based assembly language into the hex code machine format that your processor will execute.
6.	Run your assembler program to "assemble" each of these programs into your machine code.  

### Preview of Future FP Projects
This lab sets the stage for the future FP Projects where you will design the ALU and DPU for your original processor.  
* Your group must create an *original* processor / control unit / data path unit and NOT simply copy existing architectures. You may look at these architectures for inspiration, but, you must code the hardware from the bits on up to the higher level components.
* You will also have some sort of I/O, so when you make your language, be sure to think about how your processor will interface to the external world.

# Part 1: Processors of the World Comparison

Compare the hardware architectures and assembly/machine languages for any two or more different processors. To do this, split your group into subgroups of 1, 2 or 3. Each subgroup should report back to the main group on the results of their research. Combine the subgroups research and analysis into this document.  By researching different processors, formats, etc. your group will then decide what approach to take to your individual language and processor design.

Each subgroup should decide on the specific application area they want to focus on. Are you interested in general purpose? audio? graphics? encryption? security?  We suggest that you pick at least one processor that you are interested in learning more about. Below are some suggestions that have information for them online. 

1.	Old Style Intel 8080 or 8085 Architecture
    * http://en.wikipedia.org/wiki/Intel_8080 
    * http://www.intel-vintage.info/intelotherresources.htm#906748189 

2.	Old Style Motorola 6502 Architecture
    * http://www.visual6502.org/welcome.html
    * http://en.wikipedia.org/wiki/MOS_Technology_6502 
    * http://opencores.org/project,t65

3.	Modern General Purpose ARM Architecture
    * http://en.wikipedia.org/wiki/ARM_architecture
    * https://www.scss.tcd.ie/~waldroj/3d1/arm_arm.pdf 

4.	Modern Application Specific NVIDIA Architecture (Graphics Processor) - Very specific details can be difficult to find.

5.	Modern AMD Architecture (e.g. Ryzen)

6.	Other processor of your own choice (other than MIPS) that you can find information for.


## Section 1: Compare and Contrast all the Processor Designs Your Group Researched

The first processor researched was the Intel 8080. We decided it would be good to start by looking at something that is a bit more simple than modern designs. 
The reason we did this is because our processor will likely not have as many operations/requirements as modern architectures.


1. What was the application area of each processor researched? 
   
        The Intel 8080 is an extended/enhanced version of the Intel 8008 microprocessor. 
        The 8008's original purpose was to operate computer terminals, calculators, 1970s industrial robots, simple computers, etc.

        The MOS 6502 was designed to be a simplified, cheaper and faster MOS 6800. 
        It was 8-bit, and used in video game consoles (eg atari 2600) and computers as well.
   
2. What "registers" did the chosen processors use? 

    Make a table similar to Table 6.1 MIPS Register Set on page 300 of your book for each processor (you can summarize this table if it's too long)

    intel 8080:

        NAME | NUMBER | USE
        ---  | ------ | ---
         A   |   7    | 8-bit accumulator
         B   |   0    | 8-bit index mb pls fix this
         C   |   0    | 8-bit index mb also
         D   |   2    | 8-bit general purpose
         E   |   3    | 8-bit general purpose
         H   |   4    | 8-bit general purpose
         L   |   5    | 8-bit general purpose
         M   |   6    | Psuedo-register, can refer to memory address in HL 
         PC  |   X    | Program counter
         BC  |   0    | Combination of 2 registers to form 16bit register 
         DE  |   1    | Combination of 2 registers to form 16bit register 
         HL  |   2    | Combination of 2 registers to form 16bit register 
         SP  |   3    | Stack pointer

        https://altairclone.com/downloads/manuals/8080%20Programmers%20Manual.pdf

    mos 6502:

        NAME | NUMBER | USE
        ---  | ------ | ---
         A   |   n/a  | 8-bit accumulator
         X   |   n/a  | 8-bit index register
         Y   |   n/a  | 8-bit index register
         P   |   7    | 1-bit processer status flag, 7 of them
         S   |   n/a  | 8-bit stack pointer 
         PC  |   X    | 16-bit Program counter
         https://en.wikipedia.org/wiki/MOS_Technology_6502
   
3. Find as information on *four different types of instructions* for each processor. If possible, find the machine code format, this may not be possible for some of the processors that were chosen, but do your best to find the lowest level instruction information possible for your processor.

        For the 8080 processor, the instructions are only 8 bits.
        Example: Instruction = |OPCODE, 2 bits||Dest reg, 3 bits||Source register, 3 bits|
        "mov a, b" will copy register B to register A, and its machine code is 01111000. Bits(0-2) are 0, which is the value of B, Bits(3-5) are 7, which is the value of A. Bits(6-7) are 01, which is the code for mov
        "ora, c" will do abitwise OR of A and C into reg A, and its machine code is 10110001. Bits(0-2) are 1, which is the value of C, Bits(3-7) is the code required to call 'ora'.
        "inx, d" will increment the combined register DE, and its machine code is 00010011. Bits(0-2) are 3, which is the value of E, Bits(3-5) are 2, which is the value of D. Bits(6-7) are 00, which helps determine if the instruction is inx
        "dcx, b" will decrement the combined register BC, and its machine code is 00001011. Bits(0-2) are 3 which is the value of E, Bits(3-5) are 1 which is the value of C. Bits(6-7) are 00, which helps determine if the instruction is dcx


        For the MOS 6502, the instructions are also 8-bits, they have the form aaabbbcc where a and c are opcodes and b defines the addressing mode 
        ORA deos a bitwise or with the bits on the accumulator and another value this looks like 000bbb01 where bb is 010 for immidatde mode, 001 fro zero-page fixed address 011 for an absolute address etc.
        "ADC, x" is add with carry on x into the accumulator register
        "CLV" clears the overflow flag 
        "ORA, x" does an or between the accumulator and x which is a memory address
        "TXA" transfer index x to accumulator



https://www.masswerk.at/6502/6502_instruction_set.html#BEQ


4. Find a high level block diagram of each of your processors. Include these diagrams in this document. Compare and contrast the high level designs for *two* of the processors your group researched.  Here are questions that can help guide you in the comparison process. You may not be able to answer all the questions, but do your best for each of the two processors:

    a. Find a high level architecture diagram showing the data path for two of the processors. Insert both diagrams here:
    ![Alt text](/IMG/1920px-Intel_8080_arch.svg.png?raw=true "Title")

    ![Alt text](/IMG/MOS_6502.png)

    b.	What are the different types of memory (register, cache, etc.) that each of these processors has built into the processor (our mips processor had 32 registers)? 

        For the 8080 processor, there is a program memory, a data memory, and a stack memory. 
        The program memory is used to store instructions and is read to the microprocessor sequentially. 
        The data memory are all 16-bit so that data can be placed anywhere.
        The stack memory is limited only by the amount of available memory (The stack grows downward as needed).

        There is also a register array that holds the memory for each register, the program counter, and stack pointer.
        https://www.elprocus.com/know-about-architecture-of-the-intel-8080-microprocessor/
        http://mielecki.ristel.pl/files/i8080-architecture.pdf 


        For the MOS 6502 processor, there is a data memory, a stack, and a vector table. 
        The data memory are all 16-bit so that data can be placed anywhere.
        The stack memory is limited only by the amount of available memory (The stack grows downward as needed).
        The vector table is used to contain the three 2-byte addresses, a pointer to code to run when an interrupt request is received; a pointer to code that runs when the CPU is reset; a pointer to code which is run when a non-maskable interrupt is received. 

    c.	How does the ALU(s) connect to the registers for each processor (refer to the diagrams in part a)? 

        For the Intel 8080, there is a 8-bit internal data bus that connects the register array to the ALU. Data from registers must go through a 'temporary register' first before going into the ALU.

        In the MOS 6502, processor takes care of deciding which two registers are being fed to the ALU. Then, all five operations are executed in parallel and the processor decides which buffer will get written to the output register by setting the control bits. In essence, the control bits which decide which operation is being executed on the inputs.

    d.	How are instructions fetched and executed for each processor? Is there an instruction cache? 

        For the 8080, when an assembly file is created, the first line must be the first address of program memory that the code is at. This line usually looks like 'org 1000h' -This tells the program counter to go that memory address.After this is done, the first instruction is loaded into an instruction register, from there, it goes to a instruction decoder which will help determine timing and control bits that come out of a 'timing and control' module. From there, the timing/control bits will execute the instruction appropriately and also increment the program counter.Then, on the next cycle, the program counter will be used to fetch the next instruction.

        The MOS 6502 has 2 cycles to fetch the instruction bytes, 2 to fetch the two bytes of a pointer,1 cycle to to fetch the data byte the bytes are sent to a decoder to tell the 6502 what to do and from there the bits are used to execute the instuction as stated and change the PC

    e.	Do the processors pipeline instructions? 

        The Intel 8080 is nonpipelined.
        http://www.ee.hacettepe.edu.tr/~alkar/ELE336/w2-hacettepe[2016].pdf

        The MOS 6502 was pipleined.

    f.	What clock speeds do the processors run at? 

        The intel 8080 runs at clock speed between 2 MHz to 3.125 MHz.

        The MOS 6502 run a clock speed from 1MHz to 3MHz

## Section 2: Processor Language Design

   Design the programmer’s view of the architecture for your processor (as a group). 
   
   Make two tables. 
   * The first table will contain the registers and 
   * The second table will contain the instructions for your processor. 
   
   >>### TABLE 2A:  
   >>A diagram of the registers (and their purposes) for your custom processor  

    All Registers are 32 bits: When we use floating point we will use Vivado's 32 bit single precision format
    
| NAME | NUMBER | USE   |
| :---:| :---:  | :---: |
| $S0  |   1    |  32 bit general purpose, saved between calls |
| $S1  |   2    |  32 bit general purpose, saved between calls |
| $S2  |   3    |  32 bit general purpose, saved between calls |
| $S3  |   4    |  32 bit general purpose, saved between calls |
| $S4  |   5    |  32 bit general purpose, saved between calls |
| $S5  |   6    |  32 bit general purpose, saved between calls |
| $S6  |   7    |  32 bit general purpose, saved between calls |
| $S7  |   8    |  32 bit general purpose, saved between calls |
| $T0  |   9    |  32 bit general purpose, saved between calls |
| $T1  |   10    |  32 bit general purpose, not saved between calls |
| $T2  |   11    |  32 bit general purpose, not saved between calls |
| $T3  |   12    |  32 bit general purpose, not saved between calls |
| $T4  |   13    |  32 bit general purpose, not saved between calls |
| $T5  |   14    |  32 bit general purpose, not saved between calls |
| $T6  |   15    |  32 bit general purpose, not saved between calls |
| $T7  |   16    |  32 bit general purpose, not saved between calls |
| $0   |   17    |  Constant value of 0, non floating point |
| $f0  |   18    |  Constant value of 0, floating point |
| $SP  |   19    |  Stack pointer |
| $RA  |   20    |  Return address|
| $M0  |   32    | 32 bit memory storage, saved between calls |
| $M1  |   33    | 32 bit memory storage, saved between calls |
| $M2  |   34    | 32 bit memory storage, saved between calls |
| $M3  |   35    | 32 bit memory storage, saved between calls |
| $M4  |   36    | 32 bit memory storage, saved between calls |
| $M5  |   37    | 32 bit memory storage, saved between calls |
| $M6  |   38    | 32 bit memory storage, saved between calls |
| $M7  |   39    | 32 bit memory storage, saved between calls |
| $M8  |   40    | 32 bit memory storage, saved between calls |
| $M9  |   41    | 32 bit memory storage, saved between calls |
| $M10  |   42    | 32 bit memory storage, saved between calls |
| $M11  |   43    | 32 bit memory storage, saved between calls |
| $M12  |   44    | 32 bit memory storage, saved between calls |
| $M13  |   45    | 32 bit memory storage, saved between calls |
| $M14  |   46    | 32 bit memory storage, saved between calls |
| $M15  |   47    | 32 bit memory storage, saved between calls |
| $M16  |   48    | 32 bit memory storage, saved between calls |
| $M17  |   49    | 32 bit memory storage, saved between calls |
| $M18  |   50    | 32 bit memory storage, saved between calls |
| $M19  |   51    | 32 bit memory storage, saved between calls |
| $M20  |   52    | 32 bit memory storage, saved between calls |
| $M21  |   53    | 32 bit memory storage, saved between calls |
| $M22  |   54    | 32 bit memory storage, saved between calls |
| $M23  |   55    | 32 bit memory storage, saved between calls |
| $M24  |   56    | 32 bit memory storage, saved between calls |
| $M25  |   57    | 32 bit memory storage, saved between calls |
| $M26  |   58    | 32 bit memory storage, saved between calls |
| $M27  |   59    | 32 bit memory storage, saved between calls |
| $M28  |   60    | 32 bit memory storage, saved between calls |
| $M29  |   61    | 32 bit memory storage, saved between calls |
| $M30  |   62    | 32 bit memory storage, saved between calls |
| $M31  |   63    | 32 bit memory storage, saved between calls |


### TABLE 2B:
Machine Code Instruction Format: 64 bits: 

x means that the value depends on the runtime

0: F/I-Type: |2 Bit instruction type| 5 bits op | 13 Extra | 6 RS |6 RD | 32 Immediate/Float|

| Instruction| Instruction_Type | Opcode | Extra | RS  | RD | Immediate|
|:----:| :----:|:----:|:----:|:----:|:----:|:----:|
| Addfi      |    00            | 00000  |  13   |  x  | x  |   x      |

1: R-Type:   |2 Bit instruction type| 5 bits op| 39 bit extra| 6 RT | 6 RD | 6 RS |

| Instruction| Instruction_Type | Opcode | Extra | RT | RD | RS |
|:---:| :---:|:---:|:---:|:---:|:---:|:---:|
| Sub        |    01            | 00010  |  39   | x  | x  | x  |
| Add        |    01            | 00001  |  39   | x  | x  | x  |
| Mul        |    01            | 00011  |  39   | x  | x  | x  |
| Div        |    01            | 00100  |  39   | x  | x  | x  |
| Mod        |    01            | 00101  |  39   | x  | x  | x  |
| And        |    01            | 00110  |  39   | x  | x  | x  |
| Or         |    01            | 00111  |  39   | x  | x  | x  |

2: J-Type:   |2 Bit instruction type| 5 bits op| 6 RD | 32 Immediate/Float |Offset from current line 19 bits|
| Instruction| Instruction_Type | Opcode | RD    | Immediate | Jump Offset |
|:---:| :---:|:---:|:---:|:---:     |:---:   |
| beq        |   10              |  01010 |  x    |   x       |  calculate  |
| bne        |   10              |  01011 |  x    |   x       |  calculate  |
| jump        |   10             |  01100 |  x    |   x       |  calculate  |

3:  M-Type:   |2 Bit instruction type| 5 bits op| 45 bits Extra | 6 RD | 6 mem_loc |

| Instruction | Instruction Type| Opcode | Extra | RD | Memory Location |
| :---: | :---: | :---: | :---: | :---:| :---: |
| lw         |    11                | 01000    |  45           | x    | x  |  x |
| sw         |    11                | 01001    |  45           | x    | x   | x |

Lw and sw are only to be called in the assembly program when using a defined variable. It is not defined to be able to load from one register to another, or store from one register to another. For that purpose, use add. 
***


   >>A list of the instructions that you are going to build for your the processor.  

    Math Instructions (we are only implementing arithmetic operator for floating )
    (Float Immediate Type)
    FI-Type: 
    - Addfi 
    R-Type:
    - Add (add two registers)
    - Sub
    - Mul
    - Div
    - Mod

    Basic Instruction
    R-Type: 
    - And 
    - Or
    M-Type:
    - lw
    - sw

    J-Type:
    - beq
    - bne 
    - Jump

### Important Tips
* Don’t start with too many instructions! Start with the basics (about 8 instructions) 
* Have some stretch instructions as well as basic instructions.  
* Each person in the group (after group consultation) must be personally responsible for the hardware of at least one instruction. 
* Your processor will need enough instructions to do useful work.
* You processor must have enough instructions to be able to run a useful program.


## Section 3: Assembler for your Processor
Create an assembler for your processor. Push the assembler code to witgit as a sub-folder of this group project repository.

- Read line by line
- Have special characters: $ in front of every register
- Dictionary of hex codes for each instruction
- Additional dictionary for the registers that is used to translate the registers into hex
- Have different types for different instructions (R-type, I-type, J-type)





### Keep It Simple
You may write this in any language you wish. I highly recommend python. 

This simple program should be able to read your assembly language program word by word and then convert each line to the machine code that your group designed.  

The assembler should be able to ignore comments, and it should be able to figure out target addresses for jump statements. You may include variables if you wish (like MASM does) but this is not required.

### Simple Assembler Pseudo Code
You may re-use this pseudo code, (or you may write your own). The purpose of this pseudo code is to give you an example of how an assembler program could work:

```python
# Process the variable definitions
set DataMemoryAddressOfInstruction = 0
for each variable definition at the top of the program 
    # (these are variables that will be stored in memory
    Determine the size of memory required for that variable.

    # Insert a { name : (DataMemoryAddressOfInstruction, size) } key value pair 
    # into a dictionary i.e. use the name as an index (key) to store the assigned 
    # memory address of the variable along with the number of bytes the variable requires.

    # Given the size of the first variable encountered, 
    # compute the memory address location for the next variable. 
    DataMemoryAddressOfInstruction += size

set MemoryAddressOfInstruction = 0
for each line of assembly language: 

    set NextHexCode = ""
    
    # Strip comments from the line of code read 

    if line of assembly language code has a label :  

        Store MemoryAddressOfInstruction in a dictionary indexed by the label

        Determine the assembly language keyword on the line of code 

        Based on assembler keyword update NextHexCode contents

    if line of code has arguments : 

        Based on argument types (register, variable, immediate) 
        and instruction type update NextHexCode 

    print NextHexCode to the output machine code file. 

    # Update the memory Address
    MemoryAddressOfInstruction += Size of Instruction Just Processed
```
### Another Option for Writing an Assembler

* Define a grammar for your assembly language and build a recursive descent parser (https://en.wikipedia.org/wiki/Recursive_descent_parser ) 
 
* Use the utilities Lexx and Yacc (you will have to learn these on your own) 

## Section 4: Assembly Language Code
Write an assembly language program using the language that you designed.  
Use your assembler from Section 3 to compile the assembly language into hex based machine code. 
Include your assembly language code program here (make sure your program includes comments) 

```asm
// Test assembly language file for Micro-Pirate-Processors
// Computer architecture
// FP1
// 3/31/2021
// Zachary Bowyer, Benjamin Greenwood, Niklas Roberts, Garrett O'Shaughnessy, Brycen Martin

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Single line comment

//Registers have a preceding $
//Each part of any instruction will be separated by a comma ','

// Saved value registers are $S0 - $S7
// Temporary value registers are $T0 - $T7
// Stack pointer is $SP
// Return address is $RA
// Constant non-floating point 0 is $0
// Constant floating point 0 is $f0

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//Program begin
.data           //Program must start with .data, variables defined in data segment
    // There MUST be spaces seperating declarations, 'memoryTest1=12' is invalid
    var memoryTest1 = 12 --Since there are 32 registers, the address of this should be 33
.main           //Once variables are defined, instructions are written
    //Test I-type and R-type instructions
    addfi, $S0, $0, 5     //Put floating point value of 5 into saved register 0
    addfi, $S1, $0, 10.76   //Put floating point value of 10.76 into saved register 1
    addfi, $S2, $0, 7.76    //Put floating point value of 10.76 into saved register 2
    sub, $S3, $S2, $S1  //Put S2 - S1 into register S3
    mul, $S4, $S2, $S1  //Put S2 * S1 into register S4
    div, $S5, $S2, $S1  //Put S2 / S1 into register S5
    mod, $S6, $S2, $S1  //Put S2 mod S1 into register S6
    add, $S7, $S2, $S1 //Put S2 + S1 into S7 ( Register addition)

    //Test more R-type instructions
    addfi, $T0, $0, 5      //Put non floating point value of 5 into temp register 0
    addfi, $T1, $0, 6      //Put non floating point value of 6 into temp register 1
    and, $T3, $T0, $T1   //Put T0 AND T1 into T3
    or, $T4, $T0, $T1    //Put T0 OR T1 into T4

    //Test special instructions (Also I-type)
    lw, $T5, memoryTest1 //Put value of 12 into temporary register 5
    sw, $T0, memoryTest1 //Put value of 5 into our variable memoryTest1

    jump, label1
    addfi, $S0, $0, 5     //Should be skipped
    addfi, $S0, $0, 5     //Should be skipped
    addfi, $S0, $0, 5     //Should be skipped
    addfi, $S0, $0, 5     //Should be skipped
    label label1: //When a label is defined, the next instruction should start at exactly the next line
    beq, $T0, 5, label2 //Should be taken
    addfi, $S0, $0, 5     //Should be skipped

    label label2:
    bne, $T0, 6, label3 //Shouldnt be taken
    addfi, $S0, $0, 5     
    label label3:

    beq, $T1, 5, label4 //Shouldnt be taken
    addfi, $S0, $0, 5     //Should be skipped
    label label4:

    bne, $T1, 6, label5 //Should be taken
    addfi, $S0, $0, 5     
    label label5:
.end    //Use .end to determine end of program. Set PC and all other signals to 0
```

### Compiled Binary and Hex values
```
0000000000000000000000100101000101000001010000000000000000000000 : 0000025141400000
1101001000000000000000000000000000000000000000000000001001100000 : d200000000000260
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
0000000000000000000000001001000101000001001011000010100011110110 : 00000091412c28f6
0000000000000000000000001101000101000000111110000101000111101100 : 000000d140f851ec
0100010000000000000000000000000000000000000000000100000011000010 : 44000000000040c2
0100011000000000000000000000000000000000000000000101000011000010 : 46000000000050c2
0100100000000000000000000000000000000000000000000110000011000010 : 48000000000060c2
0100101000000000000000000000000000000000000000000111000011000010 : 4a000000000070c2
0100001000000000000000000000000000000000000000001000000011000010 : 42000000000080c2
0000000000000000000000100101000101000000101000000000000000000000 : 0000025140a00000
0000000000000000000000101001000101000000110000000000000000000000 : 0000029140c00000
0100110000000000000000000000000000000000000000001100001001001010 : 4c0000000000c24a
0100111000000000000000000000000000000000000000001101001001001010 : 4e0000000000d24a
1101000000000000000000000000000000000000000000000000001110100000 : d0000000000003a0
1101001000000000000000000000000000000000000000000000001001100000 : d200000000000260
1001100000000000000000000000000000000000000000000000000000010011 : 9800000000000013
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
1001010001001010000001010000000000000000000000000000000000010101 : 944a050000000015
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
1001011001001010000001100000000000000000000000000000000000010111 : 964a060000000017
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
1001010001010010000001010000000000000000000000000000000000011001 : 9452050000000019
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
1001011001010010000001100000000000000000000000000000000000011011 : 965206000000001b
0000000000000000000000000101000101000000101000000000000000000000 : 0000005140a00000
```


### Make sure to push your changes to Whitgit!


## What to Hand In:  

* All the answers to the questions should be formatted neatly in a markdown file and submitted to the whitgit group project folder. 
* Be sure to check the evaluation rubric given here. 
