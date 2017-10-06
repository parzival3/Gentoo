CC=gcc
CFLAGS=-O2 -s -lX11 -lasound
BAR=barDwm
FILE=barM.c
NATIVE=native_status.c
NATB=native_bar

all: bar mv

bar: ~/Git/Gentoo/Config/dwm/barM.c
	$(CC)  -o $(BAR) $(FILE) $(CFLAGS)
mv:
	mv $(BAR) ~/.dwm/barDwm
native: $(NATIVE)
	$(CC) -o  $(NATB) $(NATIVE) $(CFLAGS)


