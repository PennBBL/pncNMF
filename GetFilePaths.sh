#Get the paths for the Jacobian files for input to calculateComponentWeightedAverageNIFTI.m

cat /data/jux/BBL/projects/pncNmf/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;

do

#Jacobian paths
JacobianPath2mm=`ls -d /data/joy/BBL/projects/pncNmf/Jacobian_smoothed2mm/${a}_SubjectToTemplateLogJacobian_smoothed2mm.nii.gz`;

echo $JacobianPath2mm >> /data/jux/BBL/projects/pncNmf/subjectData/n1396_JacobianPaths.csv

done

