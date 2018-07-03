#Smooth the Ravens data before running NMF.

cat /data/jux/BBL/projects/pncNmf/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;

do

RavensPath=`ls -d /data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/t1struct/voxelwiseMaps_ravens/${b}_RAVENS_2GM_2mm.nii.gz`;

RavensOutdir=/data/jux/BBL/projects/pncNmf/images/Ravens_smoothed8mm

RavensPathName=$(echo $RavensPath|cut -d, -f1)
RavensFullFileName=$(basename $RavensPath)
RavensFileName=$(basename $RavensPath | cut -d. -f1)

#Save full filenames to text files for zipping the data later
echo $RavensFullFileName >> /data/jux/BBL/projects/pncNmf/subjectData/n1396_Ravens_FileNames.csv

#NOTE: fslmaths requires smoothing parameters in sigma
#FWHM = 2.355*sigma
#8mm FWHM = 3.40 sigma

echo "Smoothing $RavensFileName"

echo " "

sig=3.40

fslmaths $RavensPathName -s $sig $RavensOutdir/${RavensFileName}_smoothed8mm.nii.gz

done
