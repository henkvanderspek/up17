# Define paths
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

SRC = src
BUILD = build
SCRIPTS = scripts

# Define source and output files
ASM_SOURCES = $(wildcard $(SRC)/*.s)
OBJECTS = $(ASM_SOURCES:$(SRC)/%.s=$(BUILD)/%.o)
ELF = $(BUILD)/main.elf
BIN = $(BUILD)/main.bin

# Define the default target
all: $(BIN)

# Rule to create the binary
$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

# Rule to create the ELF
$(ELF): $(OBJECTS)
	$(LD) -nostartfiles -v -T $(SCRIPTS)/linker.ld -o $@ $^

# Rule to assemble source files
$(BUILD)/%.o: $(SRC)/%.s
	@mkdir -p $(BUILD)
	$(AS) -o $@ $< -mthumb -mcpu=cortex-m3

# Clean rule
clean:
	rm -rf $(BUILD)

.PHONY: all clean
