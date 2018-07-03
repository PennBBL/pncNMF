#Reslice the Jacobian images to 2mm isotropic (which also downsamples to 2mm) and smooth 2mm before applying NMF volume weights to it.

cat /data/jux/BBL/projects/pncNmf/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;

do

jacPath=`ls -d  /data/joy/BBL/studies/pnc/processedData/structural/antsCorticalThickness/${a}/*x${b}/SubjectToTemplateLogJacobian.nii.gz`;
resliceOutdir=/data/jux/BBL/projects/pncNmf/images/Jacobian/Jacobian_ReslicedDownsampled
smoothOutdir=/data/jux/BBL/projects/pncNmf/images/Jacobian/Jacobian_ReslicedDownsampledSmoothed2mm
jacPathName=$(echo $jacPath|cut -d, -f1)
jacFullFileName=$(basename $jacPath)
jacFileName=$(basename $jacPath | cut -d. -f1)

echo " "

echo "Reslicing and downsampling ${a} ${b}"

antsApplyTransforms -e 3 -d 3 -i $jacPathName -r /data/joy/BBL/studies/pnc/template/pnc_template_brain_2mm.nii.gz -o $resliceOutdir/${b}_${jacFileName}_isotropic2mm.nii.gz

echo " "

echo "Smoothing ${a} ${b}"

#NOTE: fslmaths requires smoothing parameters in sigma                                                                                               
#FWHM = 2.355*sigma                                                                                                                                  
#2mm FWHM = .85 sigma

sig=.85

fslmaths $resliceOutdir/${b}_${jacFileName}_isotropic2mm.nii.gz -s $sig $smoothOutdir/${b}_${jacFileName}_isotropic2mm_smoothed2mm.nii.gz

done
