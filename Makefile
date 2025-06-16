PREFIX = arm-none-eabi-
CC = $(PREFIX)gcc
AS = $(PREFIX)as
LD = $(PREFIX)ld
OBJCOPY = $(PREFIX)objcopy
SIZE = $(PREFIX)size
RM = rm -f

TARGET = cortex_m_led_blink

CPU = cortex-m3
ASFLAGS = -mcpu=$(CPU) -mthumb -g
LDFLAGS = -Ttext 0x08000000

AS_SRC = $(TARGET).s

OPENOCD = openocd
OPENOCD_INTERFACE = interface/stlink.cfg
OPENOCD_TARGET = target/stm32f1x.cfg

all: $(TARGET).bin

$(TARGET).o: $(AS_SRC)
	$(AS) $(ASFLAGS) -o $@ $<

$(TARGET).elf: $(TARGET).o
	$(LD) $(LDFLAGS) -o $@ $<
	$(SIZE) $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

clean:
	$(RM) *.o *.elf *.bin

.PHONY: all clean