#Smooth the CT data before running NMF.

cat /data/jux/BBL/projects/pncNmf/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;

do

CtPath=`ls -d /data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/t1struct/voxelwiseMaps_antsCt/${b}_CorticalThicknessNormalizedToTemplate2mm.nii.gz`;

CtOutdir=/data/jux/BBL/projects/pncNmf/images/CT_smoothed4mm

CtPathName=$(echo $CtPath|cut -d, -f1)
CtFullFileName=$(basename $CtPath)
CtFileName=$(basename $CtPath | cut -d. -f1)

#Save full filenames to text files for zipping the data later
echo $CtFullFileName >> /data/jux/BBL/projects/pncNmf/subjectData/n1396_CT_FileNames.csv

#NOTE: fslmaths requires smoothing parameters in sigma
#FWHM = 2.355*sigma
#4mm FWHM = 1.70 sigma

echo "Smoothing $CtFileName"

echo " "

sig=1.70

fslmaths $CtPathName -s $sig $CtOutdir/${CtFileName}_smoothed4mm.nii.gz

done
