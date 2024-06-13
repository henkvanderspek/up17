.cpu cortex-m3

.global reset_handler
.global __initial_sp
.global default_handler
.global _start

/* Define the stack top */
.equ __initial_sp, 0x10008000

/* Define LED Pin (onboard LED is on P1.18 or P1.28) */
.equ LED_PIN, 18

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
.word __initial_sp          /* Initial stack pointer */
.word reset_handler         /* Reset handler */
.word default_handler       /* NMI handler */
.word default_handler       /* Hard Fault handler */
.word default_handler       /* MPU Fault handler */
.word default_handler       /* Bus Fault handler */
.word default_handler       /* Usage Fault handler */
.word 0                     /* Reserved */
.word 0                     /* Reserved */
.word 0                     /* Reserved */
.word 0                     /* Reserved */
.word default_handler       /* SVCall handler */
.word default_handler       /* Debug Monitor handler */
.word 0                     /* Reserved */
.word default_handler       /* PendSV handler */
.word default_handler       /* SysTick handler */

/* External Interrupts */
.word default_handler       /* Watchdog Timer */
.word default_handler       /* Timer0 */
.word default_handler       /* Timer1 */
.word default_handler       /* Timer2 */
.word default_handler       /* Timer3 */
.word default_handler       /* UART0 */
.word default_handler       /* UART1 */
.word default_handler       /* UART2 */
.word default_handler       /* UART3 */
.word default_handler       /* PWM1 */
.word default_handler       /* I2C0 */
.word default_handler       /* I2C1 */
.word default_handler       /* I2C2 */
.word default_handler       /* SPI */
.word default_handler       /* SSP0 */
.word default_handler       /* SSP1 */
.word default_handler       /* PLL0 Lock (Main PLL) */
.word default_handler       /* Real Time Clock */
.word default_handler       /* External Interrupt 0 */
.word default_handler       /* External Interrupt 1 */
.word default_handler       /* External Interrupt 2 */
.word default_handler       /* External Interrupt 3 */
.word default_handler       /* A/D Converter */
.word default_handler       /* Brown-Out Detect */
.word default_handler       /* USB */
.word default_handler       /* CAN */
.word default_handler       /* General Purpose DMA */
.word default_handler       /* I2S */
.word default_handler       /* Ethernet */
.word default_handler       /* Repetitive Interrupt Timer */
.word default_handler       /* Motor Control PWM */
.word default_handler       /* Quadrature Encoder Interface */
.word default_handler       /* PLL1 Lock (USB PLL) */
.word default_handler       /* USB Activity */
.word default_handler       /* CAN Activity */

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

/* Data section */
.data
.align 4

/* Define the end of stack */
.section .stack, "aw", %nobits
_estack:
    .space 512  /* Adjust size as needed */
