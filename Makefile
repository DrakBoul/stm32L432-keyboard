CC = arm-none-eabi-gcc
MACH = cortex-m4
CFLAGS = -c -mcpu=$(MACH) -mthumb
LDFLAGS = -T project/link.ld -nostdlib -Wl,-Map=final.map

BUILD_DIR = build/
PROJECT_DIR = project/

FLASH = st-flash
FFLAGS = --reset write
FLASH_ADDR = 0x08000000

OBJDUMP = arm-none-eabi-objdump
SYM_TBL_FLAG = -t


$(BUILD_DIR)main.o:$(PROJECT_DIR)main.c
	$(CC) $(CFLAGS) $^ -o $@

$(BUILD_DIR)startup.o:$(PROJECT_DIR)startup.c
	$(CC) $(CFLAGS) $^ -o $@

$(BUILD_DIR)firmware.elf: $(BUILD_DIR)startup.o $(BUILD_DIR)main.o
	$(CC) $(LDFLAGS) $^ -o $@

inspect: $(BUILD_DIR)firmware.elf
	$(OBJDUMP) $(SYM_TBL_FLAG) $^
clean:
	rm $(BUILD_DIR)*

