#!/bin/bash
doSubmit=true
modes=( \ 
 "eol"       \
# "startup"       \
# "startup_sn2.0"       \
# "startup_sn2.5"       \
# "startup_sn3.0"       \
# "startup_sn4.0"       \
) 
num=51
upnum=500


makeasubmitdir () {
# write base for submit file
 printf "Making submits for $1\n"

 # go to the directory
 origindir=$(pwd)
 submitdir=$(pwd)/gitignore/$1
 HGCP=/eos/uscms/store/user/skim2
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
 until [ ${num} -gt ${upnum} ]
 do
 printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/RECO_13Pt10_Vtx0_flatEta_1p5_1p8_26D41_1.py\n" >> submitfile 
 #printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/RECO_13Pt10_Vtx0_flatEta_1p5_1p8_26D41_1.py,${HGCP}/GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}_${mode}_step2.root\n" >> submitfile 
 #printf "Arguments = inputFile=Closeby_${num}_${mode}_step2.root ${mode} step3\n" >> submitfile
 printf "Arguments = inputFile=GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}_${mode}_step2.root ${mode} step3\n" >> submitfile
 printf "Queue\n" >> submitfile
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
for mode in ${modes[@]}
do 
 makeasubmitdir ${num} ${upnum} ${mode}
done

