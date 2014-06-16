#---------------------------------------------------------------------------
# Copyright 2014 The Open Source Electronic Health Record Agent
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

from __future__ import with_statement
import sys
import os
import re
import argparse
# append this module in the sys.path at run time
curDir = os.path.dirname(os.path.abspath(__file__))
if curDir not in sys.path:
  sys.path.append(curDir)
from VistATestClient import VistATestClientFactory, createTestClientArgParser
from LoggerManager import getTempLogFile

VISTA_ALL_ROUTINES_TIME_OUT = 300 # 5 Minutes
class VistAXindex(object):
  """ regular expression constants """
  def __init__(self):
    pass
  def _runXindexForRoutines(self, vistATestClient, outputFileName,
                            routineList, excludeList=None,
                            isAllRoutines = False):
    vistATestClient.waitForPrompt()
    connection = vistATestClient.getConnection()
    connection.send('K ^XUTL("XQ",$J)\n')
    vistATestClient.waitForPrompt()
    connection.send("D ^XINDEX\r")
    connection.expect("All Routines?")
    if isAllRoutines:
      connection.send("YES\r");
    else:
      connection.send("NO\r")
    if not isAllRoutines:
      for routine in routineList:
        connection.expect("Routine")
        connection.send("%s\r" % routine)
      if excludeList:
        for routine in excludeList:
          connection.expect("Routine")
          connection.send("'%s\r" % routine)
      connection.expect("Routine", VISTA_ALL_ROUTINES_TIME_OUT)
      connection.send("\r")

    selectionList = ['Select BUILD NAME:',
                     'Select INSTALL NAME:',
                     'Select PACKAGE NAME:']
    while True:
      index = connection.expect(selectionList)
      connection.send('\r')
      if index == len(selectionList) - 1:
        break

    connection.expect("Print more than compiled errors and warnings\?")
    connection.send("YES\r")
    connection.expect("Print summary only\?")
    connection.send("NO\r")
    connection.expect("Print routines\?")
    connection.send("NO\r")
    connection.expect("Print errors and warnings with each routine\?")
    connection.send("YES\r")
    connection.expect("Save parameters in ROUTINE file\?")
    connection.send("NO\r")
    connection.expect("Index all called routines?")
    connection.send("NO\r")
    connection.expect("DEVICE")
    connection.send(";132;99999\r")
    while True:
        index = connection.expect(["Press return to continue:",
                                      "--- END ---"])
        if index == 0:
          connection.send("\r")
          continue
        else:
          break
    return True

  def runXindexForRoutines(self, vistATestClient,
                     outputFileName, routineList, excludeList=None):
    if not routineList:
      return True
    return self._runXindexForRoutines(vistATestClient,
                                      outputFileName,
                                      routineList,
                                      excludeList)

  def runXindexForRoutinesIndividually(self, vistATestClient,
                     outputFileName, routineList, excludeList=None):
    if not routineList:
      return True
    for routine in routineList:
      print routine
      ret = self._runXindexForRoutines(vistATestClient,
                                       outputFileName,
                                       [routine], excludeList)
      if not ret:
        return ret
    return True

  def runXindexForAllRoutines(self, vistATestClient, outputFileName,
                              excludeList=None):
    return self._runXindexForRoutines(vistATestClient,
                                      outputFileName,
                                      None,
                                      None,
                                      True)

  def runXindexForVistAMRepo(self, vistATestClient, outputFileName,
                             mrepo, excludeList=None):
    routineList = [];
    """ find all the routine files under VistA-M repository """
    for (root, dirs, files) in os.walk(mrepo):
      for fileName in files:
        if fileName.endswith('.m'):
          routineList.append(fileName[:-2])
    return self._runXindexForRoutines(vistATestClient,
                                      outputFileName,
                                      routineList,
                                      excludeList)

DEFAULT_OUTPUT_LOG_FILE_NAME = "VistARoutineXindex.log"
def main():
  testClientParser = createTestClientArgParser()
  parser = argparse.ArgumentParser(description='VistA XINDEX Tool',
                                   parents=[testClientParser])
  parser.add_argument('-o', '--outputFile',
                    help='Output File Name to store XINDEX result')
  parser.add_argument('-m', '--mrepo',
                    help='Path to the top level of VistA-M Repository')
  parser.add_argument('-a', '--allRoutines', action="store_true", default=False,
                      help='Run XINIDEX for all routines')
  parser.add_argument('-r', '--routines', nargs='*',
                      help='only specified routine names')
  parser.add_argument('-e', '--exclude', nargs='*', default=None,
                      help='exclude specified routine names')
  result = parser.parse_args();
  print (result)
  outputFilename = result.outputFile
  outputDir = os.path.dirname(outputFilename)
  assert os.path.exists(outputDir)
  """ create the VistATestClient"""
  testClient = VistATestClientFactory.createVistATestClientWithArgs(result)
  assert testClient
  with testClient as vistAClient:
    vistAClient.setLogFile(outputFilename)
    isAllRoutines = result.allRoutines
    vistAXindex = VistAXindex()
    if result.mrepo and os.path.exists(result.mrepo):
      vistAXindex.runXindexForVistAMRepo(vistAClient, outputFilename,
                                         result.mrepo, result.exclude)
    elif isAllRoutines:
      vistAXindex.runXindexForAllRoutines(vistAClient, outputFilename,
                                           result.exclude)
    else:
      vistAXindex.runXindexForRoutines(vistAClient, outputFilename,
                                        result.routines,
                                        result.exclude)
if __name__ == '__main__':
  main()
