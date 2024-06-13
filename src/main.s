.cpu cortex-m3

.global reset_handler
.global __initial_sp
.global default_handler
.global _start

/* Define the stack top */
.equ __initial_sp, 0x10008000

/* Define LED Pin (onboard LED is on P1.18 or P1.28) */
.equ LED_PIN, 28

/* Define GPIO base and offsets */
.equ LPC_GPIO_BASE, 0x2009C000
.equ GPIO1_BASE, LPC_GPIO_BASE + 0x20

/* Define GPIO1 register offsets */
.equ FIO1DIR, 0x00
.equ FIO1SET, 0x18
.equ FIO1CLR, 0x1C

/* Interrupt vector table */
.section .isr_vector, "a", %progbits
.align 4
.word __initial_sp
.word reset_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word 0
.word 0
.word 0
.word 0
.word default_handler
.word default_handler
.word 0
.word default_handler
.word default_handler

/* External Interrupts */
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler
.word default_handler

.thumb

/* Reset Handler */
.section .text.reset, "ax", %progbits
.thumb_func
reset_handler:
    LDR R0, =_start
    BX R0
    .pool

/* Exception Handlers */
.weak default_handler
.type default_handler, %function
default_handler:
    B .

/* Main start function */
.thumb_func
.global _start
_start:
    LDR R0, =GPIO1_BASE
    LDR R1, =1 << LED_PIN
    LDR R2, [R0, #FIO1DIR]
    ORR R2, R2, R1
    STR R2, [R0, #FIO1DIR]

    STR R1, [R0, #FIO1SET]

loop:
    B loop

/* Define the end of stack */
.section .stack, "aw", %nobits
_estack:
    .space 512
