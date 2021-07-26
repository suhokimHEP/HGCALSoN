#!/bin/bash
doSubmit=true
modes=( \ 
# "eol"       \
# "startup"       \
# "startup_sn2.0"       \
 "startup_sn2.5"       \
# "startup_sn3.0"       \
# "startup_sn4.0"       \
) 


makeasubmitdir () {
# write base for submit file
 printf "Making submits for $1\n"

 # go to the directory
 origindir=$(pwd)
 submitdir=$(pwd)/gitignore/$1
 HGCP=/eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim
 mkdir -p ${submitdir}
 pushd    ${submitdir}  > /dev/null
 printf " The directory is %s\n" $(pwd)

 mkdir -p logs



 printf "Universe = vanilla\n" > submitfile
 printf "Executable = ${origindir}/run_job.sh\n" >> submitfile
 printf "Should_Transfer_Files = YES \n" >> submitfile
 printf "WhenToTransferOutput = ON_EXIT\n" >> submitfile
 printf "Transfer_Input_Files = ${origindir}/CMSSW_12_0_0_pre3.tar.gz,${origindir}/RECO_13Pt10_Vtx0_flatEta_1p5_1p8_26D41_1.py,${HGCP}/${mode}/GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}_${mode}_step2.root\n" >> submitfile 
 printf "notify_user = skim2@cern.ch\n" >> submitfile
 printf "\n" >> submitfile
 printf "Output = logs/SN_\$(Cluster)_\$(Process).stdout\n" >> submitfile
 printf "Error  = logs/SN_\$(Cluster)_\$(Process).stderr\n" >> submitfile
 printf "Log    = logs/SN_\$(Cluster)_\$(Process).log\n" >> submitfile
 printf "\n" >> submitfile
 printf "Arguments = inputFile=GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}_${mode}_step2.root ${mode} step3\n" >> submitfile
 printf "Queue\n" >> submitfile
 printf "\n" >> submitfile
 printf "\n" >> submitfile
 printf "\n" >> submitfile
 if [ ${doSubmit} = true ]
 then
  condor_submit submitfile
 fi

 popd > /dev/null



}
declare -a trouble=(61 62 68) #2p0

for mode in ${modes[@]}
do 
 for num in {1..300}
 do
  makeasubmitdir ${num} ${mode}
 done
done

