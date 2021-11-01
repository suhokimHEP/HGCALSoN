#!/bin/bash 

echo "TEST"
voms-proxy-info --all
ls -l
echo "DONE"
outDir="/eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/GEN/"
echo output directory, $outDir
export PATH=${PATH}:/cvmfs/cms.cern.ch/common
export CMS_PATH=/cvmfs/cms.cern.ch

source /cvmfs/cms.cern.ch/cmsset_default.sh
tar -xzf CMSSW_12_1_0_pre4.tar.gz
rm -fv CMSSW_12_1_0_pre4.tar.gz
export SCRAM_ARCH=slc7_amd64_gcc900
cd CMSSW_12_1_0_pre4/
scramv1 b ProjectRename
eval `scram runtime -sh`
cd ../

echo "doing pwd"
pwd
echo "doing ls"
ls
echo "now run"
echo cmsRun
cmsRun GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_1.py 'Tag'=$1


for FILE in GEN*.root
do
  xrdcp -f ${FILE} ${outDir}
  rm ${FILE}
done

