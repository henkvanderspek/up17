ENTRY(reset_handler)

MEMORY
{
    flash (rx) : ORIGIN = 0x00000000, LENGTH = 512K
    ram (rwx) : ORIGIN = 0x10000000, LENGTH = 64K
}

SECTIONS
{
    . = ALIGN(4);
    .isr_vector : {
        KEEP(*(.isr_vector))
    } > flash

    . = ALIGN(4);
    .text : {
        *(.text.reset)
        *(.text*)
        *(.rodata)
        . = ALIGN(4);
        _endflash = .;
    } > flash

    . = ALIGN(4);
    .data : {
        _sdata = .;
        *(.data)
        _edata = .;
    } > ram AT > flash

    . = ALIGN(4);
    .bss : {
        _sbss = .;
        *(.bss)
        _ebss = .;
    } > ram

    . = ALIGN(4);
    .stack : {
        *(.stack)
    } > ram
}
