#!/usr/bin/env python3

# type: ignore

from pwn import libcdb
import argparse

parser = argparse.ArgumentParser(
    prog="unstrip_libc",
    description="retrieve debug symbols for specified libc"
)

parser.add_argument("libc", help="path to libc file")

args = parser.parse_args()

result = libcdb.unstrip_libc(args.libc)
if result:
    print("libc unstripped")
else:
    print("failed to unstrip libc")
