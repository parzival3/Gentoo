#!/bin/bash

# Instruction for install the gnu-arm-eabi tool-chain
echo "Link inside the script"
# Link to the arm developer site 
# https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads
echo "Untar the gcc-toolchin with tar -xjvf **toolchain** -C **dest-dir**"
echo "Compile the ncurse package with the tinfo flags"
echo "Install guile version > 2.0"
echo "Download the last version of gdb from the  link in the description"

#
#https://ftp.gnu.org/gnu/gdb/ 
#

echo "Extract it and configure it with  the options insdide the script"

#  sed -i "/ac_cpp=/s/\$CPPFLAGS/\$CPPFLAGS -O2/" libiberty/configure
#
#   ./configure \ --target=$_target \ --prefix=/usr \ --enable-languages=c,c++ \
#   --enable-multilib \ --enable-interwork \ --with-system-readline \
#  --disable-nls \ --with-python=/usr/bin/python3 \ --with-guile=guile-2.0 \
#  --with-system-gdbinit=/etc/gdb/gdbinit 
# 

echo "Make and Make DESTDIR="$pkgdir" install"


