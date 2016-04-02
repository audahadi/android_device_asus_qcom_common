/*
 * Copyright (c) 2016 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

#define LOG_TAG "PowerHAL_MSM8939_Ext"
#include <utils/Log.h>

#define LOW_POWER_MODE_PATH "/sys/module/cluster_plug/parameters/low_power_mode"

static int is_8916 = -1;

static int is_target_8916()
{
    int fd;
    char buf[10] = {0};

    if (is_8916 >= 0)
        return is_8916;

    fd = open("/sys/devices/soc0/soc_id", O_RDONLY);
    if (fd >= 0) {
        if (read(fd, buf, sizeof(buf) - 1) == -1) {
            ALOGW("Unable to read soc_id");
            is_8916 = 1;
        } else {
            int soc_id = atoi(buf);
            if (soc_id == 206 || (soc_id >= 247 && soc_id <= 250))  {
                is_8916 = 1;
            } else {
                is_8916 = 0;
            }
        }
    } else {
      is_8916 = 1;
    }

    close(fd);
    return is_8916;
}

static void sysfs_write(char *path, char *s)
{
    char buf[80];
    int len;
    int fd;

    if (path == NULL) return;

    if ((fd = open(path, O_WRONLY)) < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", path, buf);
        return;
    }

    len = write(fd, s, strlen(s));
    if (len < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing to %s: %s\n", path, buf);
    }

    close(fd);
}

void cm_power_set_interactive_ext(int on)
{
    size_t i;

    if (!is_target_8916()) {
        ALOGD("%s cluster-plug low power mode", !on ? "enabling" : "disabling");
        sysfs_write(LOW_POWER_MODE_PATH, on ? "0" : "1");
    } else {
        ALOGI("%s: MSM8916 isn't supported", __func__);
    }
}
