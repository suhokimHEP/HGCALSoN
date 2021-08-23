#!/bin/bash
dirs=( \ 
 "startup_sn2.0"       \
 "startup_sn2.5"       \
 "startup_sn3.0"       \
 "startup_sn4.0"       \
 "eol"       \
 "startup"       \
) 
for dir in ${dirs[@]}
do
 for num in {1..500}
 do
  #ls /eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/${dir}/*_26D49_${num}_* | wc -l
  ls /eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/RECO/${dir}/*_26D49_${num}_* | wc -l
 done
done

