
------
RISCV Keyboard And Display MMIO Simulator Manual
----




Ready bit to be set to 1 in the Receiver Control register  -> 0xffff000 LowOrderByte

Keystroke text area  corresponding ASCII code in -> 0xffff0004 LowOrderByte


Transmitter Control register write to the display area by detecting the Ready bit set (1) -> 0xffff0008 LowOrderByte

Transmitter Data register storing the ASCII code of the character to be displayed using a 'sw' -> 0xffff000c LowOrderByte

This triggers the simulated display to clear the Ready bit to 0, delay awhile to simulate processing the data, then set the Ready bit back to 1.  The delay is based on a count of executed instructions.
