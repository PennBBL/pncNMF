#Get the paths for the Jacobian files for input to calculateComponentWeightedAverageNIFTI.m

cat /cbica/projects/pncNmf/n1396_t1NMF/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;

do

#Jacobian paths                                                                                                                                       
JacobianPath=`ls -d /cbica/projects/pncNmf/n1396_t1NMF/images/Jacobian_ReslicedDownsampledSmoothed2mm/${b}_SubjectToTemplateLogJacobian_isotropic2mm_smoothed2mm.nii.gz`;

echo $JacobianPath

#echo $JacobianPath >> /cbica/projects/pncNmf/n1396_t1NMF/subjectData/n1396_JacobianPaths.csv

done

