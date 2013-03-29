#---------------------------------------------------------------------------
# Copyright 2013 The Open Source Electronic Health Record Agent
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
import argparse
from VistATestClient import VistATestClientFactory, createTestClientArgParser
from LoggerManager import initConsoleLogging

def inputMumpsSystem(testClient):
  connection = testClient.getConnection()
  if testClient.isCache(): # this is the Cache
    connection.send("CACHE\r")
  elif testClient.isGTM(): # this is GT.M(UNIX)
    connection.send("GT.M(UNIX)\r")
  else:
    pass

def initFileMan(testClient, siteName, siteNumber, zuSet=True):
  connection = testClient.getConnection()
  testClient.waitForPrompt()
  connection.send("D ^DINIT\r")
  connection.expect("Initialize VA FileMan now?")
  connection.send("YES\r")
  connection.expect("SITE NAME:")
  if siteName and len(siteName) > 0:
    connection.send(siteName+"\r")
  else:
    connection.send("\r") # just use the default
  connection.expect("SITE NUMBER")
  if siteNumber and int(siteNumber) != 0:
    connection.send(str(siteNumber)+"\r")
  else:
    connection.send("\r")
  connection.expect("Do you want to change the MUMPS OPERATING SYSTEM File?")
  connection.send("YES\r") # we want to change MUMPS OPERATING SYSTEM File
  connection.expect("TYPE OF MUMPS SYSTEM YOU ARE USING:")
  inputMumpsSystem(testClient)
  testClient.waitForPrompt()
  if zuSet:
    connection.send("D ^ZUSET\r")
    connection.expect("Rename")
    connection.send("YES\r")
    testClient.waitForPrompt()
  connection.send("HALT\r")

DEFAULT_OUTPUT_LOG_FILE_NAME = "InitTaskMan.log"
import tempfile
def getTempLogFile():
    return os.path.join(tempfile.gettempdir(), DEFAULT_OUTPUT_LOG_FILE_NAME)

def main():
  testClientParser = createTestClientArgParser()
  parser = argparse.ArgumentParser(description='VistA Initialize FileMan Utilities',
                                   parents=[testClientParser])
  parser.add_argument('-s', ='siteName',
                      help='setup the site name')
  parser.add_argument('-n', required=True, dest="stationNumber", type=int,
                      help="setup the station number")
  result = parser.parse_args();
  print (result)
  """ create the VistATestClient"""
  testClient = VistATestClientFactory.createVistATestClientWithArgs(result)
  assert testClient
  with testClient as vistAClient:
    logFilename = getTempLogFile()
    print "Log File is %s" % logFilename
    vistAClient.setLogFile(logFilename)
    initFileMan(vistAClient, siteName, siteNumber)

if __name__ == '__main__':
  main()
