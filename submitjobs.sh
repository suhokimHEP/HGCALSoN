#!/bin/bash
doSubmit=true
modes=( \ 
# "eol"       \
# "startup"       \
# "startup_fixedSiPMTileAreasAndSN"       \
 "startup_sn2.0"       \
) 
num=1
upnum=50
aversion="fixed40mu"
level="RECO"
makeasubmitdir () {
# write base for submit file
 # go to the directory
 origindir=$(pwd)
if [[ ${level} == "DIGI" ]]
then
 printf "Making submits for ${aversion}/$3\n"
 submitdir=$(pwd)/gitignore/${aversion}/$3/
else
 printf "Making submits for ${aversion}/RECO/$3\n"
 submitdir=$(pwd)/gitignore/${aversion}/RECO/$3/
fi
 mkdir -p ${submitdir}
 pushd    ${submitdir}  > /dev/null
 printf " The directory is %s\n" $(pwd)

 mkdir -p logs



 printf "Universe = vanilla\n" > submitfile
 printf "Executable = ${origindir}/run_job.sh\n" >> submitfile
 printf "Should_Transfer_Files = YES \n" >> submitfile
 printf "WhenToTransferOutput = ON_EXIT\n" >> submitfile
 printf "notify_user = skim2@cern.ch\n" >> submitfile
 printf "\n" >> submitfile
 printf "Output = logs/SN_\$(Cluster)_\$(Process).stdout\n" >> submitfile
 printf "Error  = logs/SN_\$(Cluster)_\$(Process).stderr\n" >> submitfile
 printf "Log    = logs/SN_\$(Cluster)_\$(Process).log\n" >> submitfile
 printf "\n" >> submitfile
 if [[ ${level} == "DIGI" ]]
 then
  printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/step2_${mode}_cfg.py\n" >> submitfile 
 else
  printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/RECO_13Pt10_Vtx0_flatEta_1p5_1p8_26D41_1.py\n" >> submitfile 
 fi

  until [ ${num} -gt ${upnum} ]
  do
 if [[ ${level} == "DIGI" ]]
 then
  printf "Arguments = inputFile=GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}.root ${level} ${aversion} ${mode}\n" >> submitfile
 else
  printf "Arguments = inputFile=GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}_${mode}_step2.root ${level} ${aversion}\n" >> submitfile
 fi
  printf "Queue\n" >> submitfile
  num=$(( ${num} + 1 ))
  done


 if [ ${doSubmit} = true ]
 then
  condor_submit submitfile
 fi

 popd > /dev/null



}
for mode in ${modes[@]}
do 
 makeasubmitdir ${num} ${upnum} ${mode}
done

