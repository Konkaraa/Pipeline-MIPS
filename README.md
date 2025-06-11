The main difference between this DATAPATH and those of the previously developed processors is the addition of two new sub-circuits:

-FORWARDING UNIT

-STALLS

Forwarding Unit

The Forwarding Unit takes as inputs:

*RT, RS

*EX/MEM_RD, MEM/WB_RD (which come from the output of a multiplexer)

It produces two control signals, which are used as inputs to their respective multiplexers. These two multiplexers receive the following inputs:

*Outputs of the Register File (RFA, RFB)

*Output of the ALU

*Output of the final multiplexer (between ALU_OUT and MEM_OUT)

The purpose of this sub-module is to handle specific cases where the final multiplexer has not yet propagated its value back to the DEC stage. When such a case occurs, the output signals of the two multiplexers forward the necessary data to the EX/MEM and MEM/WB pipeline stages, effectively resolving data hazards.

Stalls

The Stalls sub-circuit receives as inputs:

*RD, RT

*The RD of the previous instruction

It produces two control signals:

1. One for the IF/FETCH stage

2. One for the first pipeline stage (IF/ID)

The purpose of this module is to handle Load Delay Slot situations by inserting bubbles, i.e., disabling the PC counter for one clock cycle, allowing the pipeline to pause and prevent hazards.