#!/bin/bash 

echo "TEST"
voms-proxy-info --all
ls -l
echo "DONE"
outDir="/eos/uscms/store/user/skim2/"
#outDir="/eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/"
#outDir="/afs/cern.ch/work/s/suho/public/CMSSW_12_0_0_pre2/src/haven"
#outDir="root://cmseos.fnal.gov//store/user/suho/"
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
if [[ $3 == "step2" ]]
then
 cmsRun step2_$2_cfg.py $1
else
 cmsRun RECO_13Pt10_Vtx0_flatEta_1p5_1p8_26D41_1.py $1
fi
echo "after run ls"
ls

if [[ $3 == "step2" ]]
then
 for FILE in *step2.root
 do
   echo "xrdcp -f ${FILE} ${outDir}/${FILE}"
  xrdcp -f ${FILE} root://cmseos.fnal.gov//store/user/skim2/
   rm ${FILE}
 done
else
 for FILE in *step3.root
 do
  xrdcp -f ${FILE} root://cmseos.fnal.gov//store/user/skim2/
   rm ${FILE}
 done
fi

