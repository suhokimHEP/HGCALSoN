#!/bin/bash
doSubmit=true


makeasubmitdir () {
# write base for submit file
 printf "Making submits for $1\n"

 # go to the directory
 origindir=$(pwd)
 submitdir=$(pwd)/gitignore/GEN/$1
 mkdir -p ${submitdir}
 pushd    ${submitdir}  > /dev/null
 printf " The directory is %s\n" $(pwd)

 mkdir -p logs



 printf "Universe = vanilla\n" > submitfile
 printf "Executable = ${origindir}/gen_job.sh\n" >> submitfile
 printf "Should_Transfer_Files = YES \n" >> submitfile
 printf "WhenToTransferOutput = ON_EXIT\n" >> submitfile
 printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_1.py\n" >> submitfile 
 printf "notify_user = skim2@cern.ch\n" >> submitfile
 printf "\n" >> submitfile
 printf "Output = logs/SN_\$(Cluster)_\$(Process).stdout\n" >> submitfile
 printf "Error  = logs/SN_\$(Cluster)_\$(Process).stderr\n" >> submitfile
 printf "Log    = logs/SN_\$(Cluster)_\$(Process).log\n" >> submitfile
 printf "\n" >> submitfile
 printf "Arguments = ${num}\n" >> submitfile
 printf "Queue\n" >> submitfile
# printf "request_memory = 1GB\n" >> submitfile
# printf "request_disk = 1MB\n" >> submitfile
 printf "\n" >> submitfile
 printf "\n" >> submitfile
 printf "\n" >> submitfile
 if [ ${doSubmit} = true ]
 then
  condor_submit submitfile
 fi

 popd > /dev/null



}

declare -a trouble=(463) #2p5

#for num in ${trouble[@]}
#do
# makeasubmitdir ${num} ${mode}
#done
for num in {501..600}
do
 makeasubmitdir ${num} ${mode}
done

