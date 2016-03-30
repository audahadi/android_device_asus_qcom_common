#!/sbin/sh

# With this tree we support whole msm8916 family
# Let's symlink correct ditlib based on soc_id
cpu_id_file=/sys/devices/soc0/soc_id
cpu_id=`cat /sys/devices/soc0/soc_id`

mkdir /system/lib/DataSet/ISP

if [ -f "$cpu_id_file" ]; then
    case "$cpu_id" in
        "206" | "247" | "248" | "249" | "250")
            # msm8916
            ln -fs /system/lib/DataSet/ISP_lib_set/8916/libxditk_isp.bin /system/lib/DataSet/ISP/libxditk_isp.bin
            ;;
        "268")
            # msm8929
            ln -fs /system/lib/DataSet/ISP_lib_set/8929/libxditk_isp.bin /system/lib/DataSet/ISP/libxditk_isp.bin
            ;;
        "239" | "241" | "263" | "268" | "269" | "270" | "271")
            # msm8939
            ln -fs /system/lib/DataSet/ISP_lib_set/8939/libxditk_isp.bin /system/lib/DataSet/ISP/libxditk_isp.bin
            ;;
    esac
fi

# OpenGLES AEP is supported only by msm8939
# Remove it for the other targets
if [ -f "$cpu_id_file" ]; then
    case "$cpu_id" in
        "239" | "241" | "263" | "268" | "269" | "270" | "271")
            # Stub
            ;;
        *)
            rm -f /system/etc/permissions/android.hardware.opengles.aep.xml
            ;;
    esac
fi

# ZE600/601KL needs dual speaker paths
# Let's move replace mixer_paths.xml with it's own file
# and remove /system/etc/mixer_paths_mtp_dual.xml on rest of zf2 family
APID=`cat /proc/apid`
if [ $APID -eq "1" ]; then
    mv /system/etc/mixer_paths_mtp_dual.xml /system/etc/mixer_paths_mtp.xml
else
    rm -f /system/etc/mixer_paths_mtp_dual.xml
fi

# Use proper media_codecs by SOC
if [ -f "$cpu_id_file" ]; then
    case "$cpu_id" in
        "239" | "241" | "263" | "268" | "269" | "270" | "271")
            mv /system/etc/media_codecs_8939.xml /system/etc/media_codecs.xml
            mv /system/etc/media_codecs_performance_8939.xml /system/etc/media_codecs_performance.xml
            ;;
        *)
            rm -f /system/etc/media_codecs_8939.xml
            rm -f /system/etc/media_codecs_performance_8939.xml
            ;;
    esac
fi

exit 0
