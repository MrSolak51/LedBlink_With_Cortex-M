.syntax unified
.cpu cortex-m3
.thumb

.equ RCC_BASE,    0x40021000
.equ GPIOC_BASE,  0x40011000

.equ RCC_APB2ENR, 0x18
.equ GPIO_CRH,    0x04
.equ GPIO_ODR,    0x0C

.equ IOPCEN,      4 
.equ LED_PIN,     13

.word 0x20005000

.word reset

.text
.thumb_func
reset:
  ldr r0, =RCC_BASE
  ldr r1, [r0, #RCC_APB2ENR]
  orr r1, (1 << IOPCEN)
  str r1, [r0, #RCC_APB2ENR]

  ldr r0, =GPIOC_BASE
  ldr r1, [r0, #GPIO_CRH]
  bic r1, #0x00F00000
  orr r1, #0x00200000
  str r1, [r0, #GPIO_CRH]

main_loop:
  ldr r0, =GPIOC_BASE
  ldr r1, [r0, #GPIO_ODR]
  bic r1, (1 << LED_PIN)
  str r1, [r0, #GPIO_ODR]

  ldr r2, =2000000
1: subs r2, #1
   bne 1b

  ldr r0, =GPIOC_BASE
  ldr r1, [r0, #GPIO_ODR]
  orr r1, (1 << LED_PIN)
  str r1, [r0, #GPIO_ODR]
  
  ldr r2, =2000000
2: subs r2, #1
   bne 2b

  b main_loop
