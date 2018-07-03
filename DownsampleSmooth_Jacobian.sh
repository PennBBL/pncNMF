#Downsample the Jacobian data to 2mm and smooth the data to 2mm before applying NMF volume weights to it.

cat /data/jux/BBL/projects/pncNmf/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;

do

jacPath=`ls -d  /data/joy/BBL/studies/pnc/processedData/structural/antsCorticalThickness/${a}/*x${b}/SubjectToTemplateLogJacobian.nii.gz`;
resampleOutdir=/data/joy/BBL/projects/pncNmf/Jacobian_downsampled2mm
smoothedOutdir=/data/joy/BBL/projects/pncNmf/Jacobian_smoothed2mm
jacPathName=$(echo $jacPath|cut -d, -f1)
jacFullFileName=$(basename $jacPath)
jacFileName=$(basename $jacPath | cut -d. -f1)

echo "Resampling ${a}"

echo " "

fslmaths $jacPathName -subsamp2 $resampleOutdir/${a}_${jacFileName}_resamp2mm.nii.gz

echo "Smoothing ${a}"

echo " "

#NOTE: fslmaths requires smoothing parameters in sigma                                                                                               
#FWHM = 2.355*sigma                                                                                                                                  
#2mm FWHM = .85 sigma

sig=.85

fslmaths $resampleOutdir/${a}_${jacFileName}_resamp2mm.nii.gz -s $sig $smoothedOutdir/${a}_${jacFileName}_smoothed2mm.nii.gz

done
