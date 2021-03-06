#!/usr/bin/env python

import sys, os, subprocess, functools, shutil, glob, re
scramArch = None
cmsswBase = None
cmsswVersion = None
try:
    scramArch = os.environ["SCRAM_ARCH"]
    cmsswBase = os.environ["CMSSW_BASE"]
    cmsswVersion = os.environ["CMSSW_VERSION"]
except KeyError:
    raise RuntimeError ("CMSSW environment not configured. Please run cmsenv first.")

cwd = os.getcwd ()
subprocess.call ("tar --exclude-caches-all --exclude-vcs -zcf " + cmsswVersion + ".tar.gz -C " + cmsswBase + "/.. " + cmsswVersion+ " --exclude='*root' --exclude='*/*root' --exclude='*/*tar.gz'    " , shell = True)


