#define _BSD_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <strings.h>
#include <sys/time.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <X11/Xlib.h>

char *tzberlin = "Europe/Kiev";

static Display *dpy;

char *
smprintf(char *fmt, ...)
{
	va_list fmtargs;
	char *ret;
	int len;

	va_start(fmtargs, fmt);
	len = vsnprintf(NULL, 0, fmt, fmtargs);
	va_end(fmtargs);

	ret = malloc(++len);
	if (ret == NULL) {
		perror("malloc");
		exit(1);
	}

	va_start(fmtargs, fmt);
	vsnprintf(ret, len, fmt, fmtargs);
	va_end(fmtargs);

	return ret;
}

char *
readfile(char *base, char *file)
{
	char *path, line[513];
	FILE *fd;

	memset(line, 0, sizeof(line));

	path = smprintf("%s/%s", base, file);
	fd = fopen(path, "r");
	if (fd == NULL)
		return NULL;
	free(path);

	if (fgets(line, sizeof(line)-1, fd) == NULL)
		return NULL;
	fclose(fd);

	return smprintf("%s", line);
}

/*
 * Linux seems to change the filenames after suspend/hibernate
 * according to a random scheme. So just check for both possibilities.
 */
char *
getbattery(char *base)
{
	char *co;
	int descap, remcap, charging;

	descap = -1;
	remcap = -1;
  charging = 1;

	co = readfile(base, "present");
	if (co == NULL || co[0] != '1') {
		if (co != NULL) free(co);
		return smprintf("not present");
	}
	free(co);

	co = readfile(base, "charge_full_design");
	if (co == NULL) {
		co = readfile(base, "energy_full_design");
		if (co == NULL)
			return smprintf("");
	}
	sscanf(co, "%d", &descap);
	free(co);

	co = readfile(base, "charge_now");
	if (co == NULL) {
		co = readfile(base, "energy_now");
		if (co == NULL)
			return smprintf("");
	}
	sscanf(co, "%d", &remcap);
	free(co);

	if (remcap < 0 || descap < 0)
		return smprintf("invalid");

  co = readfile(base, "status");
  if (co[0] == 'D')
    charging = 0;

	return smprintf("%.0f % (%s)", ((float)remcap / (float)descap) * 100, charging ? "C" : "D");
}

char*
runcmd(char* cmd) {
	FILE* fp = popen(cmd, "r");
	if (fp == NULL) return NULL;
	char ln[30];
	fgets(ln, sizeof(ln)-1, fp);
	pclose(fp);
	ln[strlen(ln)-1]='\0';
	return smprintf("%s", ln);
}



char*
getvolume() {
	int volume;
  char mute;
  char *mute_str = "";
  sscanf(runcmd("amixer | grep -A 6 Master | grep 'Front Left: Playback'\
        | grep -o '[0-9%]*%'"), "%i%%", &volume);
  sscanf(runcmd("amixer | grep -A 6 Master | grep 'Front Left: Playback'\
        | grep -P -o '(\\[on)|(\\[of)'"), "[o%c", &mute);
  if (mute == 'f')
    mute_str = "(M)";

	return smprintf("%d %% %s", volume, mute_str);
}

void
settz(char *tzname)
{
	setenv("TZ", tzname, 1);
}

char *
mktimes(char *fmt, char *tzname)
{
	char buf[129];
	time_t tim;
	struct tm *timtm;

	memset(buf, 0, sizeof(buf));
	settz(tzname);
	tim = time(NULL);
	timtm = localtime(&tim);
	if (timtm == NULL) {
		perror("localtime");
		exit(1);
	}

	if (!strftime(buf, sizeof(buf)-1, fmt, timtm)) {
		fprintf(stderr, "strftime == 0\n");
		exit(1);
	}

	return smprintf("%s", buf);
}

void
setstatus(char *str)
{
	XStoreName(dpy, DefaultRootWindow(dpy), str);
	XSync(dpy, False);
}

int
main(void)
{
	char *status;
	char *tmbln;
  //char *battery;
  char *volume;
  char *wifi;
  char *keyboard;

	if (!(dpy = XOpenDisplay(NULL))) {
		fprintf(stderr, "dwmstatus: cannot open display.\n");
		return 1;
	}

	for (;;sleep(1)) {
    volume = runcmd("amixer | grep -A 6 Master | grep 'Mono: Playback'| grep -o '[0-9%]*%'");
    wifi = runcmd("iw wlp2s0 link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//'");
    keyboard = runcmd("keyboard");
    //battery = getbattery("/sys/class/power_supply/BAT0");
		tmbln = mktimes("\ue016 %H:%M", tzberlin);

		status = smprintf("\ue26f %s  \ue203 %s  \ue21a %s   %s",
				keyboard, volume, wifi, tmbln);
		setstatus(status);
		free(tmbln);
		free(status);
	}

	XCloseDisplay(dpy);

	return 0;
}