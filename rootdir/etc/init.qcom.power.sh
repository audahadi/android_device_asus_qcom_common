#!/system/bin/sh
#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

export PATH=/system/bin

if [ -f /sys/devices/soc0/soc_id ]; then
    soc_id=`cat /sys/devices/soc0/soc_id`
else
    soc_id=`cat /sys/devices/system/soc/soc0/id`
fi

# Enable adaptive LMK and set vmpressure_file_min
echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo 81250 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min

# HMP scheduler settings for 8916, 8939
echo 3 > /proc/sys/kernel/sched_window_stats_policy
echo 3 > /proc/sys/kernel/sched_ravg_hist_size

case "$soc_id" in
    "206" | "247" | "248" | "249" | "250")
        # Apply MSM8916 specific Sched & Governor settings

        # HMP scheduler load tracking settings
        echo 3 > /proc/sys/kernel/sched_ravg_hist_size

        # HMP Task packing settings for 8916
        echo 20 > /proc/sys/kernel/sched_small_task
        echo 30 > /proc/sys/kernel/sched_mostly_idle_load
        echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run

        # Disable thermal core_control to update scaling_min_freq
        echo 0 > /sys/module/msm_thermal/core_control/enabled

        # Enable governor
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

        # Enable thermal core_control now
        echo 1 > /sys/module/msm_thermal/core_control/enabled

        echo "25000 1094400:50000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
        echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
        echo 998400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
        echo "1 800000:85 998400:90 1094400:80" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
        echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time

        # Bring up all cores online
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
    ;;
    "239" | "241" | "263" | "268" | "269" | "270" | "271")
        # Apply MSM8939 specific Sched & Governor settings

        # Sched Boost
        echo 1 > /proc/sys/kernel/sched_boost

        # HMP scheduler load tracking settings
        echo 5 > /proc/sys/kernel/sched_ravg_hist_size

        # HMP Task packing settings for 8939, 8929
        echo 20 > /proc/sys/kernel/sched_small_task
        echo 30 > /proc/sys/kernel/sched_mostly_idle_load
        echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run

        echo bw_hwmon > /sys/class/devfreq/cpubw/governor
        echo 20 > /sys/class/devfreq/cpubw/bw_hwmon/io_percent
        echo 40 >/sys/class/devfreq/gpubw/bw_hwmon/io_percent
        echo cpufreq > /sys/class/devfreq/mincpubw/governor

        # Disable thermal core_control to update interactive gov settings
        echo 0 > /sys/module/msm_thermal/core_control/enabled

        # Enable governor for perf cluster
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "20000 1113600:50000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
        echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
        echo 1113600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
        echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
        echo "1 960000:85 1113600:90 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
        echo 50000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
        echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

        # Enable governor for power cluster
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo "25000 800000:50000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
        echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
        echo 998400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
        echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
        echo "1 800000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
        echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
        echo 800000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

        # Enable thermal core_control now
        echo 1 > /sys/module/msm_thermal/core_control/enabled

        # Bring up all cores online
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo 1 > /sys/devices/system/cpu/cpu5/online
        echo 1 > /sys/devices/system/cpu/cpu6/online
        echo 1 > /sys/devices/system/cpu/cpu7/online

        # Enable low power modes
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

        # Enable core control and set userspace permission
        echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
        echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
        echo 68 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
        echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
        echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
        echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres
        echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
        echo 20 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
        echo 5 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
        echo 5000 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
        echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/not_preferred
        chown system:system /sys/devices/system/cpu/cpu0/core_ctl/max_cpus

        # HMP scheduler (big.Little cluster related) settings
        echo 75 > /proc/sys/kernel/sched_upmigrate
        echo 60 > /proc/sys/kernel/sched_downmigrate
    ;;
esac

case "$soc_id" in
    "206" | "247" | "248" | "249" | "250")
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
    ;;
    "239" | "241" | "263"| "268" | "269" | "270" | "271")
        echo 10 > /sys/class/net/rmnet0/queues/rx-0/rps_cpus
    ;;
esac

case $soc_id in
    "206" | "247" | "248" | "249" | "250" | "233" | "240" | "242")
        setprop ro.min_freq_0 800000
    ;;
    "239" | "241" | "263" | "268" | "269" | "270" | "271")
        setprop ro.min_freq_0 960000
        setprop ro.min_freq_4 800000
    ;;
esac

# Set Memory paremeters.
#
# Set per_process_reclaim tuning parameters
# 2GB 64-bit will have aggressive settings when compared to 1GB 32-bit
# 1GB and less will use vmpressure range 50-70, 2GB will use 10-70
# 1GB and less will use 512 pages swap size, 2GB will use 1024
#
# Set Low memory killer minfree parameters
# 32 bit all memory configurations will use 15K series
# 64 bit all memory configurations will use 18K series
#
# Set ALMK parameters (usually above the highest minfree values)
# 32 bit will have 53K & 64 bit will have 81K
#

# Read adj series and set adj threshold for PPR and ALMK.
# This is required since adj values change from framework to framework.
adj_series=`cat /sys/module/lowmemorykiller/parameters/adj`
adj_1="${adj_series#*,}"
set_almk_ppr_adj="${adj_1%%,*}"

# PPR and ALMK should not act on HOME adj and below.
# Normalized ADJ for HOME is 6. Hence multiply by 6
# ADJ score represented as INT in LMK params, actual score can be in decimal
# Hence add 6 considering a worst case of 0.9 conversion to INT (0.9*6).
set_almk_ppr_adj=$(((set_almk_ppr_adj * 6) + 6))
echo $set_almk_ppr_adj > /sys/module/lowmemorykiller/parameters/adj_max_shift
echo $set_almk_ppr_adj > /sys/module/process_reclaim/parameters/min_score_adj

echo 1 > /sys/module/process_reclaim/parameters/enable_process_reclaim
echo 70 > /sys/module/process_reclaim/parameters/pressure_max
echo 30 > /sys/module/process_reclaim/parameters/swap_opt_eff
echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk

echo 10 > /sys/module/process_reclaim/parameters/pressure_min
echo 1024 > /sys/module/process_reclaim/parameters/per_swap_size
echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
echo 81250 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
