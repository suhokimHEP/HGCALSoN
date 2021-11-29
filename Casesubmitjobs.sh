#!/bin/bash
doSubmit=true
modes=( \ 
# "eol"       \
# "startup"       \
# "startup_fixedSiPMTileAreasAndSN"       \
 "startup_sn2.0"       \
) 
aversion="Rand40mu"
#level="DIGI"
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
  printf "Arguments = inputFile=GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}.root ${level} ${aversion} ${mode}\n" >> submitfile
 else
  printf "Transfer_Input_Files = ${origindir}/CMSSW_12_1_0_pre4.tar.gz,${origindir}/RECO_13Pt10_Vtx0_flatEta_1p5_1p8_26D41_1.py\n" >> submitfile 
  printf "Arguments = inputFile=GEN_13Pt10_Vtx0_flatEta_1p5_1p8_26D49_${num}_${mode}_step2.root ${level} ${aversion}\n" >> submitfile
 fi
 printf "request_memory = 1GB\n" >> submitfile
 printf "request_disk = 1MB\n" >> submitfile
  printf "Queue\n" >> submitfile


 if [ ${doSubmit} = true ]
 then
  condor_submit submitfile
 fi

 popd > /dev/null



}

#declare -a trouble=(3 6 8 10 15 18 66 96 118 125 130 139 251 252)
declare -a trouble=(255 259 260 287 293 294 299 301 304 323 331 332 338 342 343 350 352 353 354 356 357 462 484 489 494 498 389 390 396)

for mode in ${modes[@]}
do 
 for num in ${trouble[@]}
 do
  makeasubmitdir ${mode} ${num}
 done
done
