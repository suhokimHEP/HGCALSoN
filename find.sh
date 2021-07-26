#!/bin/bash
dirs=( \ 
 "sn2p0"       \
 "sn2p5"       \
 "sn3p0"       \
 "sn4p0"       \
 "eol"       \
 "startup"       \
) 
for dir in ${dirs[@]}
do
 for num in {1..500}
 do
  ls /eos/cms/store/group/dpg_hgcal/comm_hgcal/suhokim/${dir}/*_26D49_${num}_* | wc -l
 done
done

