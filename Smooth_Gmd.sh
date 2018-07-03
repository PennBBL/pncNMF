#Smooth the GMD data before running NMF.

cat /data/jux/BBL/projects/pncNmf/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;

do

GmdPath=`ls -d /data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/t1struct/voxelwiseMaps_gmd/${b}_atropos3class_prob02SubjToTemp2mm.nii.gz`;

GmdOutdir=/data/jux/BBL/projects/pncNmf/images/GMD_smoothed8mm

GmdPathName=$(echo $GmdPath|cut -d, -f1)
GmdFullFileName=$(basename $GmdPath)
GmdFileName=$(basename $GmdPath | cut -d. -f1)

#Save full filenames to text files for zipping the data later
echo $GmdFullFileName >> /data/jux/BBL/projects/pncNmf/subjectData/n1396_GMD_FileNames.csv

#NOTE: fslmaths requires smoothing parameters in sigma
#FWHM = 2.355*sigma
#8mm FWHM = 3.40 sigma

echo "Smoothing $GmdFileName"

echo " "

sig=3.40

fslmaths $GmdPathName -s $sig $GmdOutdir/${GmdFileName}_smoothed8mm.nii.gz

done
