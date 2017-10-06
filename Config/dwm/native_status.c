#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <stdarg.h>
#include <X11/Xlib.h>
#include <sys/utsname.h>
#include <sys/sysinfo.h>
#include <alsa/asoundlib.h>
#include <alsa/control.h>

#define MAXSTR  2024

static void XSetRoot(const char *name);

static void XSetRoot(const char *name){
        Display *display;

        if (( display = XOpenDisplay(0x0)) == NULL ) {
                fprintf(stderr, "[barM] cannot open display!\n");
                exit(1);
        }

        XStoreName(display, DefaultRootWindow(display), name);
        XSync(display, 0);

        XCloseDisplay(display);
}



int main(void){
        char status[MAXSTR] = "normal \x01 selected \x03 warning/urgent \x04 error \x01 back to normal text" ;
        /* It is foolish to repeatedly update uname. */
        for(;;){
                XSetRoot(status);
                sleep(1);
        }
        return 0;
}
