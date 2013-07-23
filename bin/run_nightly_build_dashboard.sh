#! /bin/sh
# shutdown the taskman.
/usr/bin/python /osehra/dashboard/build/VistA/Scripts/VistATaskmanUtil.py -a Shutdown -S 2
# run the nightly build
/usr/bin/ctest -S /home/dashboard/Scripts/amazonec2.kitware.cmake -VV 2>&1 > /tmp/dashboard_nightly_all.log

