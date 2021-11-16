#!/bin/bash
doSubmit=true

num=1
upnum=10
aversion="trial"
makeasubmitdir () {
# write base for submit file
 printf "Making submits for ${aversion}\n"

 # go to the directory
 origindir=$(pwd)
 submitdir=$(pwd)/gitignore/${aversion}/GEN/
 mkdir -p ${submitdir}
 pushd    ${submitdir}  > /dev/null
 printf " The directory is %s\n" $(pwd)

 mkdir -p logs



 printf "Universe = vanilla\n" > submitfile
 printf "Executable = ${origindir}/gen_job.sh\n" >> submitfile
 printf "Should_Transfer_Files = YES \n" >> submitfile
 printf "WhenToTransferOutput = ON_EXIT\n" >> submitfile
 #printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/Closeby.py\n" >> submitfile 
 printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_1.py\n" >> submitfile 
 printf "notify_user = skim2@cern.ch\n" >> submitfile
 printf "\n" >> submitfile
 printf "Output = logs/SN_\$(Cluster)_\$(Process).stdout\n" >> submitfile
 printf "Error  = logs/SN_\$(Cluster)_\$(Process).stderr\n" >> submitfile
 printf "Log    = logs/SN_\$(Cluster)_\$(Process).log\n" >> submitfile
 printf "\n" >> submitfile
 until [ ${num} -gt ${upnum} ]
 do
 printf "Arguments = ${num} ${aversion}\n" >> submitfile
 printf "Queue\n" >> submitfile
# printf "request_memory = 1GB\n" >> submitfile
# printf "request_disk = 1MB\n" >> submitfile
 printf "\n" >> submitfile
 printf "\n" >> submitfile
 printf "\n" >> submitfile
 num=$(( ${num} + 1 ))
 done
 if [ ${doSubmit} = true ]
 then
  condor_submit submitfile
 fi

 popd > /dev/null



}

 makeasubmitdir ${num} ${upnum}
