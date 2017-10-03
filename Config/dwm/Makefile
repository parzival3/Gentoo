CC=gcc
CFLAGS=-O2 -s -lX11 -lasound
BAR=barDwm
FILE=barM.c

all: bar mv

bar: ~/Git/Gentoo/Config/dwm/barM.c
	$(CC)  -o $(BAR) $(FILE) $(CFLAGS)
mv:
	mv $(BAR) ~/.dwm/barDwm


