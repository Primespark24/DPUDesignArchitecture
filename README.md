# CS401-1 Digital Design and Computer Architecture
## FP_2: DPU Design

# Introduction    
In this lab you will design the main *Data Path Unit* for your processor.  The Data Path Unit (DPU) is the core hardware of your machine that routes data flow to/from ALU(s) and registers of the processor.  The DPU also routes the instruction data from the instruction memory to the Control Unit (CU) as well as routing data from the registers, and immediate values that come with an instruction to the ALU(s). The results of the ALU(s) computations are then routed to either the main data memory or to other registers. Each of the components in the DPU must be individually tested and confirmed to be working before wiring them together, otherwise debugging the control unit will be much more difficult!

In this lab, your group will first design the final ALU for your processor and then, design the data path unit (i.e. the connections between the ALU, registers, and external memory).  This means that besides the ALU and the DPU, you will start thinking about how you want to implement the memory for your device.  

For now, it makes sense to keep the memory implementation on the FPGA because interfacing to an external memory can be complex. You may wish to include a port for an external input/output devices, but your microprocessor should be able to function without this (just like the MIPS design was able to function without an external memory or I/O)  

# ALU Update or New Design
In the first part of this lab, you will design an ALU with operations to support your language. Here are some suggestions for ALU operation, however, you are not required to implement these if your processor does not require them: 

* shifters (shl, shr) 
* arithmetic (add, sub, mul, div) 
* comparison (lt, gt, lte, gte, eq) 
* bitwise logical operations (and, or, xor, inv, etc.) 
* special purpose operations? (Are you designing a special purpose processor?) 

Additionally, if you are going to have more than one "CORE" for supporting parallelism, you will want to keep the ALU as simple and lightweight as possible.  Remember that multiplication can actually be done in software with a shift/add algorithm if you need to make a super simple ALU.  

As you work on the DPU design, try to think about the future requirements. You will eventually add a control unit (in a future lab) and at a later point you will be required to add I/O capability to your processor. Start thinking about how you want the I/O to interface with your processor?  Do you want to have a dedicated I/O instruction or will your processor treat I/O like a memory location that reads/writes to specific memory addresses in order to do I/O? 

## What to Hand In
All of the following materials will be pushed to the __group repository__ that this readme is in on Whitgit. Make sure to work as a group and help one another contribute, teach each other the material as you work on it to help yourself learn it better as well. Work to include everyone!



*******************************************************************************
## Exercise 1: Update ALU or New ALU Desgin
*******************************************************************************
As a Group choose your ALU operations and then design your ALU.

* Given the language you designed in the previous project MP1, you will identify all the mathematical operations required by the ALU. Make a table of the chosen ALU operations with a description of each operation. Leave space for adding additional operations if needed. (See page 249 in your textbook for an example table) 

    *********************************************************************
    #### Alu Operations Table
    Complete the following table for the ALU operations in your processor:
    | ALU Control Bits| Function  |
    |:---------------:|:----------:
    |                 |           |
    |                 |           |

    Fig 1. ALU Control Bits and Associated Function
    *********************************************************************

* Draw a neat, accurate, detailed hardware diagram of your ALU. I recommend doing this with an online Electronics CAD program or LTSpice. There are several free schematic tools available online, please create a professional looking hardware diagram for your ALU

    ![ALU Diagram](alu_diagram.jpg)

    Fig 2: Diagram of our ALU

* Create the VHDL implementation for just the ALU. Be sure to comment your code adequately. Include your neatly formatted VHDL code for the ALU here: 

    ```vhdl
    -- put your VHDL for our ALU here
    ```
    Fig 3: VHDL for the ALU

* Make a VHDL test bench to verify that the hardware for the new ALU design works. Be sure to comment your test bench code for your ALU adequately. Include your neatly formatted VHDL test bench code here: 

    ```vhdl
    -- put your VHDL for your ALU test bench here
    ```
    Fig 4: VHDL Test Bench for the ALU

*******************************************************************************
## Exercise 2: Data Path Unit Design
*******************************************************************************
In this exercise you will lay out your Data Path Unit, but you will NOT design the Control Unit yet. The best way to do this is like we illustrated in the lecture and powerpoint slides.

Start with your most complex instruction (e.g. if you have a memory load or memory store instruction.) Then, lay out the wires starting from the program counter to memory that looks up the instruction, to the registers, the ALUs, etc... lay out the wires and components needed to execute that first instruction.

Next, do the same for the next instruction. Will the instructions use the same data paths? Will you need to add multiplexers? What other components will you need?

Have your Assembly Language design easily accessible while you work on DPU/ALU design.  You will want to work on this as a group.

Again, start with the __most complex instructions__ and consider the following questions (this is not an exhaustive list of questions you should ask yourselves. This is to get you started...)

* What memory is required (i.e instruction, data, combined instruction/data) ? 
* How does memory connect with/route to your registers? 
* How do registers connect with/route to your ALU? 
* How is immediate data routed?
* How does data get to the inputs of the ALU(s)>
* What multiplexers are required?
  
Following a process similar to what we followed from the book when it layed out the DPU/ALU for the MIPS lw/sw instructions, lay out the basic architecture of your machine. Look further below for where you will include your architecture diagram for your DPU.

In your group, discuss the following questions before you start on the DPU design: 

* Are you planning to create a Harvard architecture or a Von Neumann architecture? 
* Are you making a single cycle or multi-cycle processor? Why? (Multi-cycle is more challenging than single cycle to implement!)
* How will your program counter update? Will it reuse the ALU (hence you need a multi-cycle processor) or will you have a separate adder to update the program counter? 
* What about registers? What is your register naming scheme, and how many registers will you have? 
* Will your processor need to compute branch addresses or offset addresses? If so how will that be handled? 
* You will be required to add I/O your processor in the future, do you want memory mapped I/O (treat it like a memory address) or do you want a specific instructions that does I/O? 

### Data Path Unit Design in VHDL

Make all the components for the DPU using vhdl. Wire up the components using port maps (similar to how we did for MIPS). Include the vhdl component files in this repository folder. 

### Data Path Unit Design Schematic

Use Vivado to render your high level schematic. If you have used a modular design this should look ok. If it is too messy, you will need to do a manual schematic using a free online cad tool as you did earlier.

    ![ALU Diagram](dpu_diagram.jpg)

    Fig 5: Schematic of the DPU


*******************************************************************************
## Exercise 3: Design Walkthrough an FP_2 Mini Presentations
*******************************************************************************
On the due date for this design, groups will take 5-6 minutes (max) and present your DPU design to the class.  

* Minute 1: Does your new ALU design differ from previous designs (if so why, if not, why not)? Show a hardware diagram of your ALU. 
* Minute 2: Show a neat hardware diagram of your DPU and talk about your design.  
* Minute 3: Identify the control signals that your components will need. Will you need a FSM based Control Unit, or, will you need a multi-cycle control unit?
* Minutes 4-5: Summary. What went well? What not so well?  Did you do anything above and beyond the requirements (not required)?  What are you most proud of in your design?  

*******************************************************************************
## Exercise 4: Group Reflection (After Action Review or a Retrospective)
*******************************************************************************
After your group has presented your DPU to the class, as a group you should get together and discuss the following questions. Stick to facts, i.e. this is not about blame or praise, this is about decoding what happened and how the team worked (or didn't as the case may be) work together. It is not used for grading purposes or for praising/condeming participants. The goal is to identify truths about how the process went, and how to replicate strenghts in the future and how to mitigate weaknesses.  

In the real world, if you don't do this well your product may fail, and people will lose jobs, etc., Thus, this is a *very important part of the project!*. The purpose of this portion is not to critique OR to grade success or failure of one another. Rather, in this section, the purpose is to process and to identify weaknesses (in your project execution) that need improvement and strengths that might be sustained for the next parts of the project. (e.g. weaknesses - we waited till the last night before this was due... strengths - we collaborated well, listened well and had fun working together.)

* Purpose: "What did the group expect to happen in making FP_2?"
* Results: "What actually occurred as you worked on the DPU for FP_2?"
* Causes: "What caused the difference between the expectations and the results?"
* Implications: "What can our group learn from this to become stronger?"

Questions to Guide the Discussion. Take Notes.

1. Did the group achieve its goals?
2. If so, what factors allowed for this?
3. If not, what factors caused this?
4. What were the barriers present?
5. How can the group mitigate these barriers in the future?

### Summary of Observations
In this section, include your summary of the groups observations.

*******************************************************************************
### Grading Criteria
*******************************************************************************

 | CATEGORY | Poor or missing attempt | Beginning  | Satisfactory | Excellent  |
|:--------:|:--------:|:--------:|:--------:|:--------:|
| Exercise 1 (10 pts): New ALU Design |Missing or extremely poor quality.   |  No justification for the ALU design chosen, and simply copied the MIPS ALU without modification. Weak comments in the VHDL code. | Adequate justification of ALU design chosen.  Rudimentary testbench verifies some of the operations in the ALU. ALU hardware diagram adequate but could be better.   | Excellent ALU design. Excellent justifications given for both the design and the number of ALU operations implemented/ Neat professional ALU hardware diagram and neat tables. |
|Exercise 2: DPU Design  | Missing or extremely poor quality.  | Little thought given to questions about the DPU design. Messy hardware diagram. Missing control signals and signal names.  | Adequate hardware design. Some signals adequately documented.   | Excellent DPU design. Neat professional diagram (not hand drawn) Clear effort to consider all planned instruction data paths. Neatly documented control signals ready for control unit design in the next project. |
|Exercise 3: Design Walkthough  | Missing or extremely poor quality.  | Addressed some of the required items.   | Adequate address of the required items. Showed and discussed the hardware DPU design.  | Excellent presentation of both the ALU and the DPU. Clear consideration of tradeoffs in design. . |
|Exercise 4: Group Reflection After Action Review  | Missing or extremely poor quality.  | Poor discussion of the group dynamics. No ideas for how to mitigate issues raised. People had thin skins (easily upset) or thick skins (dont care about the fact there were serious issues in how the group functioned) | Adequate discussion of the group dynamics. Some thought given to how the group can work better in the future. Did one person do all the work? Did you all collaborate?    |Excellent discussion of group dynamics with clear suggestions for how your group will do better on the final two projects. How will you ensure that everyone gains an understanding of what is going on with the design? Good discussion of how the group manageed it’s time? Good discussion of what the group can do better?  |