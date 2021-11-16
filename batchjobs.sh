#!/bin/bash
doSubmit=true
modes=( \ 
# "eol"       \
# "startup"       \
 "startup_fixedSiPMTileAreasAndSN"       \
) 
num=4
upnum=5
aversion="trial"
makeasubmitdir () {
# write base for submit file
 printf "Making submits for ${aversion}/$3\n"

 # go to the directory
 origindir=$(pwd)
 #remotedir=/eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/GEN
 submitdir=$(pwd)/gitignore/${aversion}/$3/
 mkdir -p ${submitdir}
 pushd    ${submitdir}  > /dev/null
 printf " The directory is %s\n" $(pwd)

 mkdir -p logs



 printf "Universe = vanilla\n" > submitfile
 printf "Executable = ${origindir}/run_job.sh\n" >> submitfile
 printf "Should_Transfer_Files = YES \n" >> submitfile
 printf "WhenToTransferOutput = ON_EXIT\n" >> submitfile
 printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/step2_${mode}_cfg.py\n" >> submitfile 

 printf "notify_user = skim2@cern.ch\n" >> submitfile
 printf "\n" >> submitfile
 printf "Output = logs/SN_\$(Cluster)_\$(Process).stdout\n" >> submitfile
 printf "Error  = logs/SN_\$(Cluster)_\$(Process).stderr\n" >> submitfile
 printf "Log    = logs/SN_\$(Cluster)_\$(Process).log\n" >> submitfile
 printf "\n" >> submitfile
 until [ ${num} -gt ${upnum} ]
 do
 printf "Arguments = inputFile=GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}.root ${mode} step2 ${aversion} ver=${aversion}\n" >> submitfile
 printf "Queue\n" >> submitfile
 num=$(( ${num} + 1 ))
 done
 if [ ${doSubmit} = true ]
 then
  condor_submit submitfile
 fi
 popd > /dev/null



}

#declare -a trouble=(10 13 16 87 88 89 92 93 171 172 177 239 248 258 273 278 283 361 362 363 369 374 390 398 400 423 445 447) #eol
declare -a trouble=(463) #2p5

for mode in ${modes[@]}
do 
 makeasubmitdir ${num} ${upnum} ${mode}
done

