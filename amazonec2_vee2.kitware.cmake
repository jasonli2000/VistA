# Copyright 2011-2013 The Open Source Electronic Health Record Agent
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#---------------------------------------------------------------------------
# OSEHRA VistA Common Dashboard Script
#
# This script contains basic dashboard driver code common to all
# clients.
#
# Put this script in a directory such as "~/Dashboards/Scripts" or
# "c:/Dashboards/Scripts".  Create a file next to this script, say
# 'my_dashboard.cmake', with code of the following form:
#
   # Client maintainer: jason.li@kitware.com
   set(CTEST_SITE "amazonec2.kitware")
   set(CTEST_BUILD_NAME "VAEnterpriseIncr2-Ubuntu12_64-GTM-6.2")
#
   # GT.M only:
   set(ENV{TERM} "xterm") # set the terminal type to be xterm
   set(vista_db "/home/dashboard/databases")
   set(ENV{gtm_dist} "/usr/lib/fis-gtm/V6.0-002_x86_64")
   set(ENV{gtmroutines} "${vista_db}/o(${vista_db}/r) $ENV{gtm_dist}")
   set(ENV{gtmgbldir} "${vista_db}/g/database.gld")
   set(ENV{gtm_tmp} "/tmp")
   set(ENV{PATH} "$ENV{gtm_dist}:$ENV{PATH}")
   set(TEST_VISTA_FRESH_GTM_ROUTINE_DIR "${vista_db}/r")
   set(TEST_VISTA_FRESH_GTM_GLOBALS_DAT "${vista_db}/g/database.dat")

   set(dashboard_CMakeCache "
   TEST_VISTA_XINDEX_WARNINGS_AS_FAILURES:BOOL=OFF
   TEST_VISTA_COVERAGE:BOOL=OFF
   TEST_VISTA_SETUP:BOOL=ON
   TEST_VISTA_FUNCTIONAL_RAS:BOOL=ON
   TEST_VISTA_MUNIT:BOOL=ON
   TEST_VISTA_SETUP_MUNIT:BOOL=OFF
   TEST_VISTA_FRESH_GLOBALS_IMPORT_TIMEOUT:STRING=14400
   ")
   set(CTEST_TEST_TIMEOUT 1600)
   set(dashboard_do_coverage OFF)
   set(dashboard_M_dir "/osehra/git/VistA-M")
   set(dashboard_model Nightly)
   # Include the common dashboard script.
   set(CTEST_DASHBOARD_ROOT "/osehra/dashboard/build")
   include(${CTEST_SCRIPT_DIRECTORY}/vista_common.cmake)

