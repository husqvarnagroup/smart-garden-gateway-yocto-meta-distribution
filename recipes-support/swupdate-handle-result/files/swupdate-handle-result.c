#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <systemd/sd-bus.h>
#include <unistd.h>

#define SERVICE_NAME "accessory_2dserver_2eservice"
#define SERVICE_PATH "/org/freedesktop/systemd1/unit/" SERVICE_NAME

static pid_t get_service_pid(sd_bus *bus)
{
    int rc;
    sd_bus_error sderr = SD_BUS_ERROR_NULL;
    uint32_t pid = 0;

    rc = sd_bus_get_property_trivial(
        bus, "org.freedesktop.systemd1", SERVICE_PATH,
        "org.freedesktop.systemd1.Service", "MainPID", &sderr, 'u', &pid);
    if (rc < 0) {
        fprintf(
            stderr, "sd_bus_get_property_trivial: %d: %s\n", rc, sderr.message);
        return -1;
    }

    return (pid_t)pid;
}

static int stop_service(sd_bus *bus)
{
    int rc;
    sd_bus_error sderr = SD_BUS_ERROR_NULL;

    rc = sd_bus_call_method(
        bus, "org.freedesktop.systemd1", SERVICE_PATH,
        "org.freedesktop.systemd1.Unit", "Stop", &sderr, NULL, "s", "replace");
    if (rc < 0) {
        fprintf(stderr, "sd_bus_call_method: %d: %s\n", rc, sderr.message);
        return -1;
    }

    return 0;
}

static void handle_signal(int s)
{
    if (s == SIGALRM) {
        fprintf(stderr, "TIMEOUT\n");
        exit(0);
    }
}

int main(int argc, char **argv)
{
    int rc;
    sd_bus *bus = NULL;
    pid_t pid;
    unsigned int sleeptime = 5;

    if (argc != 2) {
        fprintf(stderr, "Invalid arguments\n");
        return -1;
    }

    if (strcmp(argv[1], "SUCCESS")) {
        fprintf(stderr, "update status: '%s', ignore\n", argv[1]);
        return -1;
    }

    signal(SIGALRM, handle_signal);
    alarm(1 * 60 * 60);

    rc = sd_bus_open_system(&bus);
    if (rc < 0) {
        fprintf(stderr, "sd_bus_open_system: %d\n", rc);
        return -1;
    }

    for (;;) {
        pid = get_service_pid(bus);
        if (!pid) {
            fprintf(stderr, "service not running\n");
            break;
        }

        fprintf(stderr, "send SIGUSR1 to %d ...\n", pid);
        rc = kill(pid, SIGUSR1);
        if (rc) {
            perror("kill");
            break;
        }

        // the first wait is short in case the service terminated immediately
        sleep(sleeptime);
        sleeptime = 60;
    }

    fprintf(stderr, "stop service ...\n");

    rc = stop_service(bus);
    if (rc) {
        fprintf(stderr, "failed to stop service\n");
        return -1;
    }

    return 0;
}
