TARGET?=x86_64

ifeq ($(TARGET),i686)
	NASM_FMT=elf32
else
	NASM_FMT=elf64
endif

CC=$(TARGET)-elf-gcc
LD=$(TARGET)-elf-ld

asm_source_files := $(shell find src/$(TARGET) -name *.S)
asm_object_files := $(patsubst src/$(TARGET)/%.S, build/$(TARGET)/%.o, $(asm_source_files))

c_source_files := $(shell find src/$(TARGET) -name *.c)
c_object_files := $(patsubst src/$(TARGET)/%.c, build/$(TARGET)/%.o, $(c_source_files))

kernel_source_files := $(shell find src/kernel -name *.c)
kernel_object_files := $(patsubst src/kernel/%.c, build/kernel/$(TARGET)/%.o, $(kernel_source_files))

object_files := $(asm_object_files) $(c_object_files) $(kernel_object_files)

$(asm_object_files): build/$(TARGET)/%.o : src/$(TARGET)/%.S
	mkdir -p $(dir $@) && \
	nasm -f $(NASM_FMT) $(patsubst build/$(TARGET)/%.o, src/$(TARGET)/%.S, $@) -o $@

$(c_object_files): build/$(TARGET)/%.o : src/$(TARGET)/%.c
	mkdir -p $(dir $@) && \
	$(CC) -c -I src/include -ffreestanding -nostdinc $(patsubst build/$(TARGET)/%.o, src/$(TARGET)/%.c, $@) -o $@

$(kernel_object_files): build/kernel/$(TARGET)/%.o : src/kernel/%.c
	mkdir -p $(dir $@) && \
	$(CC) -c -I src/include -ffreestanding -nostdinc $(patsubst build/kernel/$(TARGET)/%.o, src/kernel/%.c, $@) -o $@

.PHONY: build
build: $(object_files)
	mkdir -p dist/$(TARGET) && \
	$(LD) -n -o dist/$(TARGET)/kernel.bin -T targets/$(TARGET)/linker.ld $(object_files)
	cp dist/$(TARGET)/kernel.bin targets/$(TARGET)/iso/boot/kernel.bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/$(TARGET)/kernel.iso targets/$(TARGET)/iso

clean:
	rm -rf build dist targets/*/iso/boot/kernel.bin
