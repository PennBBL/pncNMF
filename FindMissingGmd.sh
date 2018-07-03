#Create lists of those missing a GMD nii.gz file on chead.

#!/bin/bash

cat /data/jux/BBL/projects/pncNmf/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;
do

if [ ! -f /data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/t1struct/voxelwiseMaps_gmd/${b}_atropos3class_prob02SubjToTemp2mm.nii.gz ]; then

    echo $a,$b >> /data/jux/BBL/projects/pncNmf/subjectData/n1396_MissingGmd.csv
   
fi

done
