#!/bin/sh

qemu-system-i386 -cdrom dist/i686/kernel.iso
qemu-system-x86_64 -cdrom dist/x86_64/kernel.iso
