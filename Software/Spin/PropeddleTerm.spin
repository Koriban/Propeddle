''***************************************************************************
''* Propeddle Terminal module
''* Copyright (C) 2014 Jac Goudsmit
''*
''* TERMS OF USE: MIT License                                                            
''*
''* Permission is hereby granted, free of charge, to any person obtaining a
''* copy of this software and associated documentation files (the
''* "Software"), to deal in the Software without restriction, including
''* without limitation the rights to use, copy, modify, merge, publish,
''* distribute, sublicense, and/or sell copies of the Software, and to permit
''* persons to whom the Software is furnished to do so, subject to the
''* following conditions:
''*
''* The above copyright notice and this permission notice shall be included
''* in all copies or substantial portions of the Software.
''*
''* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
''* OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
''* THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''***************************************************************************
''
'' This module partially emulates the video and keyboard of the Apple 1.
'' It's intended to provide a very easy-to-understand interface to the
'' keyboard and display, which only requires a few 6502 instructions to use.
''
'' The assembly code in this module starts a cog that maps 4 bytes of 6502
'' memory space. The memory map is compatible with the 6820 PIA, as used in
'' the Apple 1:
'' --------------------------------------------------------------------------
'' | Address | Mode  | Function                                             |
'' --------------------------------------------------------------------------
'' | base+0  | Read  | Gets the ASCII code of the last key pressed on the   |
'' |         |       | keyboard, with the msb set.                          |
'' |         |       | When reading this address, the msb in base+1 gets    |
'' |         |       | reset until a new code is available.                 |
'' |         ----------------------------------------------------------------
'' |         | Write | Ignored                                              |
'' --------------------------------------------------------------------------
'' | base+1  | Read  | msb is set to 1 when a new key is available. The msb |
'' |         |       | is reset when base+0 is read.                        |
'' |         ----------------------------------------------------------------
'' |         | Write | Ignored                                              |
'' --------------------------------------------------------------------------
'' | base+2  | Read  | Reads the byte last stored here by the 6502. The msb |
'' |         |       | is reset as soon as the byte has been sent to the    |
'' |         |       | display.                                             |
'' |         ----------------------------------------------------------------
'' |         | Write | If the msb is set, the byte is sent to the display.  |
'' |         |       | after the byte has been processed, the msb is reset. |
'' --------------------------------------------------------------------------
'' | base +3 | Read  | Ignored (only mapped for compatibility)              |
'' |         ----------------------------------------------------------------
'' |         | Write | Ignored (only mapped for compatibility)              |
'' --------------------------------------------------------------------------

OBJ

  hw:           "PropeddleHardware"


PUB Start(MapPtr)
'' Starts a cog that provides access to the terminal for the 6502.
''
'' Parameters:
'' - MapPtr:            First 6502 address to map (must end in %00)
                                                   
  Stop

  g_MapPtr := MapPtr

  result := cognew(@TermCog, @@0) => 0

  if result
    repeat until g_CogId ' The cog stores its own ID + 1
    

PUB Stop
'' Stops the trace cog if it is running.

  if g_CogId
    cogstop(g_CogId~ - 1)


PUB SendKey(key) | t
'' This sends a key to the 6502

  ' The Spin code is repsonsible for:
  ' - Setting bit 7 of the key code
  ' - Making sure that the top 24 bits of the key are different from before
  '   the function was called.
  ' - Making sure the RAM chip disable bits are set
  t := ((g_Key + $100) & $FFFFFF00) | key.byte | $80 | hw#con_mask_RAM 
  g_Key := t   


PUB RecvChar
'' This gets a character from the 6502
'' The result has bit 8 set if a new character is being sent to the terminal 

  result := g_Display
  g_Display := result & $7F

    
DAT

'============================================================================
' Hub access cog

                        org     0
TermCog
                        ' Adjust the hub pointers. PAR should contain @@0.
                        '
                        ' The problem we're solving here is that the Spin
                        ' compiler writes module-relative values whenever the
                        ' @ operator is used in a DAT section, instead of
                        ' absolute hub locations. The Spin language has the
                        ' @@ operator to work around this (it converts a
                        ' module-relative pointer to an absolute pointer) so
                        ' @@0 represents the offset of the current module
                        ' which we can use to convert any pointers. It's much
                        ' more efficient to convert an entire pointer table
                        ' in Assembler than in Spin. Doing it in Assembler
                        ' also prevents problems such as accidentally doing
                        ' the conversion twice.
AdjustPtrTable                        
                        add     pointertable, PAR
                        add     AdjustPtrTable, d1
                        djnz    pointertable_len, #AdjustPtrTable

                        ' We are going to disable the RAM chip whenever we're
                        ' active, so make sure those pins are set for output.
                        mov     OUTA, #0
                        mov     DIRA, mask_RAM

                        ' Initialize jump table at start of cog
                        ' This overwrites the initialization code
                        mov     0, #ReadWrite0
                        mov     1, #ReadWrite1
                        mov     2, #ReadWrite2
                        mov     3, #ReadWrite3
                                                             
                        ' Let caller know we're running by storing cogid + 1
                        cogid   g_CogId
                        add     g_CogId, #1
                        wrlong  g_CogId, pCogId

                        ' Wait until the clock is high, then low, to
                        ' synchronize with the control cog.
                        waitpeq mask_CLK0, mask_CLK0    ' Wait until CLK0 goes high
                        waitpne mask_CLK0, mask_CLK0    ' Wait until CLK0 goes low
'tp=0
                        ' Nothing to do for one instruction, use this time to
                        ' jump to the main loop. 
                        jmp     #TermLoop


'============================================================================
' Data

' The following are used as both hub variables as well as local variables.
g_CogId                 long    0               ' Cog ID plus one       
g_MapPtr                long    0               ' 6502 address of data                                              
g_Key                   long    0               ' Key from keyboard (Hub->Cog only)
g_Display               long    0               ' Byte sent to terminal (Hub<->Cog)

' Pointers to hub version of the above which can be used in rdxxxx/wrxxxx
' instructions
pointertable
pCogId                  long    @g_CogId        ' Pointer to cogid
pMapPtr                 long    @g_MapPtr       ' Pointer to map pointer
pKey                    long    @g_Key          ' Pointer to keyboard byte
pDisplay                long    @g_Display      ' Pointer to display byte
pointertable_len        long    (@pointertable_len - @pointertable) >> 2

' Constants
mask_CLK0               long    (|< hw#pin_CLK0)
mask_RW                 long    (|< hw#pin_RW)        
mask_RAM                long    hw#con_mask_RAM
mask_DATA_RAM           long    hw#con_mask_DATA | hw#con_mask_RAM
mask_ADDR               long    hw#con_mask_ADDR

d1                      long    (|< 9)          ' 1 in destination field        
' Variables
addr                    long    0               ' Current address
data                    long    0               ' Various data

KeyFlag                 long    0               ' Bit 7 set when new kbd data available

'============================================================================
' Main Loop

TermLoop
'tp=4
                        ' Switch data bus bits back to input mode in case
                        ' we were writing data to it during the previous
                        ' cycle.                        
                        andn    DIRA, #hw#con_mask_DATA ' Take data off the data bus
TermLoop2                        
                        andn    OUTA, mask_DATA_RAM ' Enable the RAM chip too
'tp=12
                        ' Get the R/W pin into the Z flag.
                        ' Z=1 if the 6502 is writing
                        ' Z=0 if the 6502 is reading
                        test    mask_RW, INA wz
'tp=16
                        ' Get address; this must be done at this EXACT
                        ' point in time to be in sync with the control cog.  
                        mov     addr, INA
'tp=20
                        ' Convert the address to an internal address
                        ' between 0 and 3 (inclusive)
                        and     addr, mask_ADDR         ' Remove unwanted bits
                        xor     addr, g_MapPtr          ' If in range, result is 0..3
                        cmp     addr, #4 wc             ' C=1 when active
'tp=32
                        ' If we're active, disable the RAM and store the address
                        ' into the jump instruction                        
        if_c            movs    JmpIns, addr
'tp=36        
        if_c            or      OUTA, mask_RAM          ' Disable the RAM chip
'tp=40                                                
                        ' Regardless of the configured speed, the control cog
                        ' always makes CLK0 high here.
JmpIns                        
        if_c            jmp     (0)                     ' Indirect jump                                                                           
'tp=44
TermLoopPhi2
ReadWrite3
                        ' Wait until CLK0 goes low
                        waitpne mask_CLK0, mask_CLK0
'tp=0
                        jmp     #TermLoop


                        '====================================================
                        ' Read/write key code
                        '
                        ' In write mode (Z=1) there's nothing to do here
'tp=44
ReadWrite0
                        ' Get the current key from the hub
                        ' The Spin code sets bit 7 for compatibility,
                        ' and sets the RAMOE bit in the key variable too so that
                        ' the RAM chip is disabled.
        if_nz           rdlong  data, pKey             ' Get latest key from hub
'tp=52..67 read / tp=48 write
                        ' Put the key on the data bus
                        ' It 's okay if some extra bits get set, the DIRA register
                        ' will keep them from reaching the output port or from
                        ' causing any harm.
                        ' The RAM bits in the key field are set by the Spin code
                        ' so they stay high to keep the RAM chip disabled
        if_nz           or      OUTA, data
        if_nz           or      DIRA, #hw#con_mask_DATA
'tp=60..79 read / tp=52 write
                        ' Wait until the clock is low again.
                        waitpne mask_CLK0, mask_CLK0    ' Wait until CLK0 goes low
'tp=0..5                        
                        ' In the worst case where the cycle time is 80 prop clocks
                        ' and the hub instruction took the maximum time, we're now 5
                        ' clocks into the next 6502 cycle.
                        ' We have to get off the data bus NOW (possibly one cycle
                        ' later than usual, that's no big deal)
'@@@ if not worst case, wait                        
                        andn    DIRA, #hw#con_mask_DATA
'tp=4..9
                        ' In write mode, tp=4 here so we can jump back to the main
                        ' loop now and the timing will be correct.
        if_z            jmp     #TermLoop2
'tp=8..13                    
                        ' We don't have time to process this cycle in the normal
                        ' way because we're potentially running late and we're
                        ' not done processing yet. But it's safe to ignore the
                        ' 6502 during this cycle because the only way that it
                        ' would access us twice in a row would be if it would
                        ' be reading an instruction, or if it would be executing
                        ' a read-write instruction (INC or DEC). An instruction
                        ' read would not make sense, and in case of INC/DEC,
                        ' (which also doesn't make sense anyway), the write
                        ' part of the operation would need to be ignored anyway.
                        '
                        ' Reset the new-key flag
        if_nz           andn    KeyFlag, #$80
'tp=16..21
                        ' Copy the new key for use in the next cycle
                        mov     g_Key, data
'tp=20..25                        
                        ' Wait until the end of this cycle, and then go on with our
                        ' regular business.                        
                        waitpeq mask_CLK0, mask_CLK0    ' Wait until CLK0 goes high
'tp=40
                        jmp     #TermLoopPhi2

                                    
                        '====================================================
                        ' Read/write key flag
                        '
                        ' In write mode (Z=1) there's nothing to do here
'tp=44
ReadWrite1
                        ' Put the key flag on the databus when in read mode
        if_nz           or      OUTA, KeyFlag
        if_nz           or      DIRA, #hw#con_mask_DATA
'tp=52
                        ' Wait until the clock is low again.
                        waitpne mask_CLK0, mask_CLK0    ' Wait until CLK0 goes low
'tp=0
                        ' In write mode, we're done
        if_z            jmp     #TermLoop
'tp=4
                        ' We're now in the next 6502 cycle, where we can do our
                        ' processing to find out if the key has changed.
                        ' See above for explanation why this is okay.
                        '
                        ' Get the current key from the hub
                        ' The Spin code sets bit 7 for compatibility,
                        ' and sets the RAMOE bit in the key variable too so that
                        ' the RAM chip is disabled.
                        rdlong  data, pKey             ' Get latest key from hub
'tp=12..27
                        ' Wait for the clock to go high
                        waitpeq mask_CLK0, mask_CLK0    ' Wait until CLK0 goes high
'tp=40                                                
                        ' Check if new key is different from the old one.
                        ' If so, set the new-key flag.
                        ' The flag is only reset when the 6502 reads base+0
                        cmp     g_Key, data wz
        if_nz           or      KeyFlag,  #$80          ' Set new-key bit if different
                        mov     g_Key, data             ' Store the new key
'tp=52
                        jmp     #TermLoopPhi2                        

                                    
                        '====================================================
                        ' Read/write display output


ReadWrite2
'tp=44
                        ' Jump to the write code if necessary
        if_z            jmp     #WriteDisplay
'tp=48        
                        ' In read mode, get the data from the hub
                        rdbyte  g_Display, pDisplay
'tp=52..67                        
                        ' Put the data on the data bus
                        or      OUTA, g_Display
                        or      DIRA, #hw#con_mask_DATA
'tp=60..75
                        ' Wait until the clock is low again.
                        waitpne mask_CLK0, mask_CLK0    ' Wait until CLK0 goes low
'tp=0..1
                        nop
                        
                        ' In the worst case, we're running one cycle late.
                        ' We need to take the data off the data bus but we
                        ' don't have time to process this cycle. That's okay,
                        ' see above.
                        andn    DIRA, #hw#con_mask_DATA
                        andn    OUTA, mask_DATA_RAM ' Enable the RAM chip too

                        ' Wait until CLK0 goes high
                        waitpeq mask_CLK0, mask_CLK0
'tp=40
                        jmp     #TermLoopPhi2
                        


WriteDisplay
'tp=48
                        ' Get data from the data bus
                        ' Set the msb
                        mov     g_Display, INA
                        or      g_Display, #$80
'tp=52
                        wrbyte  g_Display, pDisplay     ' Discard top 24 bits
'tp=60..75
                        jmp     #TermLoopPhi2                                                



                        fit
                   