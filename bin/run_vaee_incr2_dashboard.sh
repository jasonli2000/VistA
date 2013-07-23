#! /bin/sh
# Incremental Modules seperated by '|'
INCLUDE_MODULES="Asists|Engineering|Functional Independence|General Medical Record - Generator|General Medical Record - IO|General Medical Record - Vitals|Hospital Based Home Care|Incomplete Records Tracking|Library|Medicine|Mental Health|Oncology|Quality Assurance Integration|Surgery"
# Convert space to underscore
INCLUDE_MODULES=`echo ${INCLUDE_MODULES} | tr ' ' '_'`
echo $INCLUDE_MODULES

# Exclude patterns
EXCLUDE_MODULES="Communications Service Library|Radiology Nuclear Medicine|Run Time Library"
# Convert space to underscore
EXCLUDE_MODULES=`echo ${EXCLUDE_MODULES} | tr ' ' '_'`
echo "/usr/bin/ctest -R ${INCLUDE_MODULES} -N -E ${EXCLUDE_MODULES}"

#/usr/bin/ctest -R ${INCLUDE_MODULES} -N -E ${EXCLUDE_MODULES}
# shutdown the taskman.
/usr/bin/python /osehra/dashboard/build/VistA/Scripts/VistATaskmanUtil.py -a Shutdown -S 2
# Run the VA Enterprise Product Incremental 2 Night build
/usr/bin/ctest -S /home/dashboard/Scripts/amazonec2_vee2.kitware.cmake -R ${INCLUDE_MODULES} -E ${EXCLUDE_MODULES} -VV 2>&1 > /tmp/dashboard_vaee2.log

