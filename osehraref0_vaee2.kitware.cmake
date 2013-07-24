#---------------------------------------------------------------------------
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
   set(CTEST_SITE "osehraref0.kitware")
   set(CTEST_BUILD_NAME "VAEnterpriseIncr2-CentOs-Cache")
#
#   # GT.M only:
#   set(TEST_VISTA_FRESH_GTM_ROUTINE_DIR "/path/to/database/r")
#   set(TEST_VISTA_FRESH_GTM_GLOBALS_DAT "/path/to/database/g.dat")
#
   # Cache only:
   set(VISTA_CACHE_NAMESPACE "VISTA")
   set(VISTA_CACHE_INSTANCE "DASHBOARD")
   set(TEST_VISTA_FRESH_CACHE_DAT_EMPTY "/opt/cachesys/dashboard/mgr/VISTA/empty/CACHE.DAT")
   set(TEST_VISTA_FRESH_CACHE_DAT_VISTA "/opt/cachesys/dashboard/mgr/VISTA/CACHE.DAT")

   # (Copy an empty cache.dat to create empty.dat)

   set(dashboard_CMakeCache "
   TEST_VISTA_XINDEX_WARNINGS_AS_FAILURES:BOOL=OFF
   TEST_VISTA_COVERAGE:BOOL=OFF
   TEST_VISTA_SETUP:BOOL=ON
   TEST_VISTA_FUNCTIONAL_RAS:BOOL=ON
   TEST_VISTA_MUNIT:BOOL=OFF
   TEST_VISTA_SETUP_MUNIT:BOOL=OFF
   ")
   set(dashboard_do_coverage OFF)
   set(dashboard_M_dir "/home/dashboard/git/VistA-M")
   set(dashboard_model Nightly)
   # Include the common dashboard script.
   set(CTEST_DASHBOARD_ROOT "/home/dashboard/Dashboard")
   include(${CTEST_SCRIPT_DIRECTORY}/vista_common.cmake)

# Then run a scheduled task (cron job) with a command line such as
#
#   ctest -S ~/Dashboards/Scripts/my_dashboard.cmake -V
#
# By default the source and build trees will be placed in the path
# "../MyTests/" relative to your script location.
#
# The following variables may be set before including this script
# to configure it:
#
#   dashboard_model       = Nightly | Experimental | Continuous
#   dashboard_root_name   = Change name of "My Tests" directory
#   dashboard_source_name = Name of source directory (VistA)
#   dashboard_binary_name = Name of binary directory (VistA-build)
#   dashboard_do_coverage = True to enable coverage (ex: gcov)
#   dashboard_do_memcheck = True to enable memcheck (ex: valgrind)
#   CTEST_GIT_COMMAND     = path to git command-line client
#   CTEST_BUILD_FLAGS     = build tool arguments (ex: -j2)
#   CTEST_DASHBOARD_ROOT  = Where to put source and build trees
#   CTEST_TEST_TIMEOUT    = Per-test timeout length
#   CTEST_TEST_ARGS       = ctest_test args (ex: PARALLEL_LEVEL 4)
#   CMAKE_MAKE_PROGRAM    = Path to "make" tool to use
#
# Options to configure Git:
#   dashboard_git_url      = Custom git clone url
#   dashboard_git_branch   = Custom remote branch to track
#   dashboard_git_crlf     = Value of core.autocrlf for repository
#   dashboard_git_M_url    = Custom git clone url for M reference repo
#   dashboard_git_M_branch = Custom remote M branch to track
#
# For GT.M, run the dashboard script in an environment with variables
# gtm_dist, gtmroutines, gtmgbldir, gtm_icu_version, and gtm_tmp.

