#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXSTR  2024


void main(void)
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
        }

	if (fgets(line, sizeof(line)-1, fd) == NULL)
        {
	        snprintf(line, sizeof(line), "%s", "No status");
        }

	fclose(fd);
        if(strstr(line, "Full") != NULL)
        {
                snprintf(line, sizeof(line), "\x02\uE0B3 \uF1e6 ");
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
        }

	if (fgets(temp, sizeof(temp)-1, fd) == NULL)
        {
	        snprintf(temp, sizeof(temp), "%s", "No capacity available");
        }

        value = atoi(temp); 

        if(value <= 100 && value > 85)
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
        printf("%s\n",line);
        //*temp = *line;
        //strcpy(line, "\x02");
        //strcat(line, temp);
        fclose(fd);
        
}
