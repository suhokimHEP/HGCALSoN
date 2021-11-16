#!/bin/bash 

echo "TEST"
voms-proxy-info --all
ls -l
echo "DONE"
outDir="/eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/"
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
if [[ $2 == "DIGI" ]]
then
 cmsRun step2_$4_cfg.py $1 'ver='$3
else
 cmsRun RECO_13Pt10_Vtx0_flatEta_1p5_1p8_26D41_1.py $1 'ver='$3
fi
echo "after run ls"
ls

if [[ $2 == "DIGI" ]]
then
 for FILE in *step2.root
 do
  echo "xrdcping"
  xrdcp -f ${FILE} /eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/$3/DIGI/
  #xrdcp -f ${FILE} root://cms-xrd-global.cern.ch//store/group/dpg_hgcal/comm_hgcal/suhokim/
  #xrdcp -f ${FILE} root://cmseos.fnal.gov//store/user/skim2/
   rm ${FILE}
 done
else
 for FILE in *step3.root
 do
  echo "xrdcping"
  xrdcp -f ${FILE} /eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/$3/RECO/
   rm ${FILE}
 done
fi

