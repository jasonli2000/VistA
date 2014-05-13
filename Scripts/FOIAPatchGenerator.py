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

import logging
import os, sys

# add the current to sys.path
SCRIPTS_DIR = os.path.dirname(os.path.abspath(__file__))
if SCRIPTS_DIR not in sys.path:
  sys.path.append(SCRIPTS_DIR)

from GitUtils import getFileChangeStatusByRevision
from GitUtils import getFileByRevision, getCommitHashes
from LoggerManager import initConsoleLogging
from ConvertToExternalData import isValidPatchRelatedFiles
from ConvertToExternalData import generateSha1Sum
from FOIAExcel2Csv import convertExcelToCsv

def isFOIAExcelSpreadSheet(fileName):
  return fileName.endswith("xls")

class FOIAPatchGenerator(object):
  """
    Generate FOIA Patch based on FOIA mirror
  """
  def __init__(self, foiaGitRepo, patchRepo, outputDir, revRange):
    self._foiaGitRepo = foiaGitRepo
    self._patchRepo = patchRepo
    self._outDir = outputDir
    self._revRange = revRange

  def generatePatch(self):
    self._getFOIARepoHist()

  def _getFOIARepoHist(self):
    """
      return a list of commit hash, assume FOIA mirror repo is all linear
    """
    revList = getCommitHashes(self._revRange, self._foiaGitRepo)
    logging.debug(revList)
    if not revList:
      return
    for rev in revList:
      self._checkoutChangedFile(rev)

  def _checkoutChangedFile(self, rev):
    fileChangeLst = getFileChangeStatusByRevision(rev, self._foiaGitRepo)
    logging.debug(fileChangeLst)
    sha1sumDict = {}
    for status, filePath in fileChangeLst:
      absFileName = os.path.join(self._foiaGitRepo, filePath)
      if (not isValidPatchRelatedFiles(absFileName, checkLink=False)) and
         (not isFOIAExcelSpreadSheet(absFileName)) :
        logging.warn("ignore %s" % absFileName)
        continue
      if status.strip(' ') == 'D':
        logging.debug("Ignore deleted file: %s" % filePath)
        continue
      """ copy files to directory """
      result =  getFileByRevision(filePath, self._outDir,
                                  rev, self._foiaGitRepo)
      if not result:
        logging.warn("Could not copy file %s" % result)
      dstFile = os.path.join(self._outDir, filePath)
      """ check for duplicate patches """
      sha1sum = generateSha1Sum(dstFile)
      if sha1sum in sha1sumDict:
        logging.warn("Duplicate file: %s and %s" % (dstFile,
                                                    sha1sumDict[sha1sum]))
        os.unlink(dstFile)
        logging.warn("Removing file: %s" % dstFile)
        continue
      else:
        sha1sumDict[sha1sum] = filePath
      if dstFile.endswith(".xls"):
        """ convert to csv file first and copy to dst """
        csvFile = dstFile[0:dstFile.rindex(".xls")] + ".csv"
        convertExcelToCsv(dstFile, csvFile)
        os.unlink(dstFile)

def main():
  import argparse
  parser = argparse.ArgumentParser("Generate FOIA Patch based on FOIA mirror")
  parser.add_argument('foiaRepo', help='FOIA Mirror Git Repository')
  parser.add_argument('patchRepo', help='VistA Patch Git Repository')
  parser.add_argument('outDir', help='outDir')
  parser.add_argument('revRange', help='revision range')
  result = parser.parse_args()
  print (result)
  initConsoleLogging()
  patchGen = FOIAPatchGenerator(result.foiaRepo, result.patchRepo,
                                result.outDir, result.revRange)
  patchGen.generatePatch()

if __name__ == '__main__':
  main()
