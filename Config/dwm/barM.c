/*
 * Copyright (C) 2014,2015 levi0x0 with enhancements by ProgrammerNerd
 * 
 * barM (bar_monitor or BarMonitor) is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 *  This is a new version of bar monitor, even less lines of code more effective.
 *
 *  Read main() to configure your new status Bar.
 *
 *  compile: gcc -o barM barM.c -O2 -s -lX11 -lasound
 *  
 *  mv barM /usr/local/bin/
 */

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

/*
 *  Put this in your .xinitrc file: 
 *
 *  barM&
 *  
 */

#define VERSION "0.12"
#define TIME_FORMAT "\uE0B3 \uF017 %H:%M \uE0B3 \uF073 %d-%m-%Y"
#define MAXSTR  2024

static const char * date(void);
static const char * getuname(void);
static const char * ram(void);
static void XSetRoot(const char *name);
static const char * get_vol(void);
static const char * battery(void);

/*Append here your functions.*/
static const char*(*const functab[])(void)={
        date,get_vol,battery
};

int main(void){
        char status[MAXSTR];
        /* It is foolish to repeatedly update uname. */
        int ret;
        {struct utsname u;
        if(uname(&u)){
                perror("uname failed");
                return 1;
        }
        //ret=snprintf(status,sizeof(status),"(%s) ",u.release);
        }
        char*off=status+ret;
        if(off>=(status+MAXSTR)){
                XSetRoot(status);
                return 1;/*This should not happen*/
        }
        for(;;){
                int left=sizeof(status)-ret,i;
                char*sta=off;
                for(i = 0; i<sizeof(functab)/sizeof(functab[0]); ++i ) {
                        int ret=snprintf(sta,left,"%s",functab[i]());
                        sta+=ret;
                        left-=ret;
                        if(sta>=(status+MAXSTR))/*When snprintf has to resort to truncating a string it will return the length as if it were not truncated.*/
                                break;
                }
                XSetRoot(status);
                sleep(1);
        }
        return 0;
}

/* Returns the date*/
static const char * date(void){
        static char date[MAXSTR];
        static char date1[MAXSTR];
        time_t now = time(0);

        strftime(date, MAXSTR, TIME_FORMAT, localtime(&now));

        sprintf(date1, "%s", date);
        
        return date1;
}
/* Returns a string that contains the amount of free and available ram in megabytes*/
static const char * ram(void){
        static char ram[MAXSTR];
        struct sysinfo s;
        sysinfo(&s);
        snprintf(ram,sizeof(ram),"%.1fM,%.1fM",((double)(s.totalram-s.freeram))/1048576.,((double)s.totalram)/1048576.);
        return ram;
}

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

static const char * get_vol(void)
{
    static char value[MAXSTR];
    int vol;
    snd_hctl_t *hctl;
    snd_ctl_elem_id_t *id;
    snd_ctl_elem_value_t *control;

// To find card and subdevice: /proc/asound/, aplay -L, amixer controls
    snd_hctl_open(&hctl, "hw:0", 0);
    snd_hctl_load(hctl);

    snd_ctl_elem_id_alloca(&id);
    snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);

// amixer controls
    snd_ctl_elem_id_set_name(id, "Master Playback Volume");

    snd_hctl_elem_t *elem = snd_hctl_find_elem(hctl, id);

    snd_ctl_elem_value_alloca(&control);
    snd_ctl_elem_value_set_id(control, id);

    snd_hctl_elem_read(elem, control);
    vol = (int)snd_ctl_elem_value_get_integer(control,0);

    snd_hctl_close(hctl);
    vol = (100 * vol)/ 87;

        if( vol <= 100 && vol > 65 )
        {
                snprintf(value, sizeof(value), "\uE0B3 \uF028%d", vol);
        }
        if( vol <= 65 && vol > 35 )
        {
                snprintf(value, sizeof(value), "\uE0B3 \uF027%d", vol);
        }
        if( vol < 35 )
        {
                snprintf(value, sizeof(value), "\uE0B3 \uF026%d", vol);
        }
    return value;
}

static const char * battery(void)
{
	static char filename[MAXSTR], line[MAXSTR] = {'\0'};
        static char temp[MAXSTR] = {'\0'};
        static const char max[] = "charge_full";
        static const char charge[] = "charge_now";
        static const char capacity[] = "capacity";
        static const char path[] = "/sys/class/power_supply/BAT0";
        static const char status[] = "status";
        int value = 0;
	FILE *fd;

	//memset(line, 0, sizeof(line));

	snprintf(filename, sizeof(filename), "%s/%s", path, status);

	fd = fopen(filename, "r");

	if (fd == NULL)
        {
	        snprintf(line, sizeof(line), "%s", "No File");
		return line;
        }

	if (fgets(line, sizeof(line)-1, fd) == NULL)
        {
	        snprintf(line, sizeof(line), "%s", "No status");
		return line;
        }

	fclose(fd);
        if(strstr(line, "Full") != NULL)
        {
                snprintf(line, sizeof(line), "\x02\uE0B3  \uF1e6 ");
        }
        else
        {
                snprintf(line, sizeof(line), "\uE0B3 ");
        }

//      GETTING THE CURRENT CHARGE VALUE       
        snprintf(filename, sizeof(filename), "%s/%s", path, capacity);
	fd = fopen(filename, "r");
	if (fd == NULL)
        {
	        snprintf(temp, sizeof(temp), "%s", "No capacity file");
		return temp;
        }

	if (fgets(temp, sizeof(temp)-1, fd) == NULL)
        {
	        snprintf(temp, sizeof(temp), "%s", "No capacity available");
		return temp;
        }

        value = atoi(temp); 

        if( value > 85)
        {
                        snprintf(temp, sizeof(temp), " \uF240 %d ", value);
        }
        if(value <= 85 && value > 65)
        {
                        snprintf(temp, sizeof(temp), " \uF241 %d ", value);
        }
        if(value <= 65 && value > 45)
        {
                        snprintf(temp, sizeof(temp), " \uF242 %d ", value);
        }
        if(value <= 45 && value > 20)
        {
                        snprintf(temp, sizeof(temp), " \uF243 %d ", value);
        }
        if(value <= 20)
        {
                        snprintf(temp, sizeof(temp), " \uF244 %d ", value);
        }
        strcat(line, temp);
        //*temp = *line;
        //strcpy(line, "\x02");
        //strcat(line, temp);
        fclose(fd);

        return line;
}

