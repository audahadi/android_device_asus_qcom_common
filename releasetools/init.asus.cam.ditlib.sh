#!/sbin/sh

cpu_id_file=/sys/devices/soc0/soc_id
cpu_id=`cat /sys/devices/soc0/soc_id`

mkdir /system/lib/DataSet/ISP

if [ -f "$cpu_id_file" ]; then
    case "$cpu_id" in
        "206")
        ln -fs /system/lib/DataSet/ISP_lib_set/8916/libxditk_isp.bin /system/lib/DataSet/ISP/libxditk_isp.bin
        echo "8916"
        ;;
        "268")
        ln -fs /system/lib/DataSet/ISP_lib_set/8929/libxditk_isp.bin /system/lib/DataSet/ISP/libxditk_isp.bin
        echo "8929"
        ;;
        "239")
        ln -fs /system/lib/DataSet/ISP_lib_set/8939/libxditk_isp.bin /system/lib/DataSet/ISP/libxditk_isp.bin
        echo "8939"
        ;;
    esac
fi

exit 0
