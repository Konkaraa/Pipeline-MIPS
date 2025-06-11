In the operation of the DATAPATH, the first sub-stage (IF/FETCH) remained the same as in the first laboratory exercise (Single-Cycle Processor). Then, the output of this sub-stage was connected to the shared memory (RAM), and the output of the memory was loaded into a 32-bit register, which formed the first pipeline stage (IF/ID).

In the second sub-stage (DEC) of the DATAPATH, some minor changes were made: specifically, the multiplexers were removed from within the sub-stage and were instead port mapped externally in the DATAPATH. Other than that, this sub-stage was not fundamentally changed. Certain control signals (Flags) were given fixed values outside the Control unit (to be explained later). In this stage (DEC), the outputs were routed to 32-bit and 5-bit registers, forming the second pipeline stage (ID/EX).

The third sub-stage (EX) of the DATAPATH also remained the same, with the only addition being a new multiplexer for selecting between RT/RD. Similarly, the outputs here also went into 32-bit and 5-bit registers, forming the third pipeline stage (EX/MEM).

The fourth sub-stage (MEM) had no changes in structure compared to the first lab exercise. As before, the outputs were fed into 32-bit and 5-bit registers, forming the fourth pipeline stage (MEM/WB).

As expected, all register outputs from each pipeline stage serve as inputs to the corresponding sub-stages.
