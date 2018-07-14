#Get the paths for the CT and Ravens files for the testing sample on CBICA 

cat /cbica/projects/pncNmf/n1396_t1NMF/subjectData/n696_T1_test_bblids_scanids.csv | while IFS="," read -r a b ;

do

#CT
CtPath8mm=`ls -d /cbica/projects/pncNmf/n1396_t1NMF/images/CT_smoothed4mm/${b}_CorticalThicknessNormalizedToTemplate2mm_smoothed4mm.nii.gz`;

echo $CtPath8mm >> /cbica/projects/pncNmf/n1396_t1NMF/subjectData/n696_CtPaths_test.csv

#Ravens
RavensPath8mm=`ls -d /cbica/projects/pncNmf/n1396_t1NMF/images/Ravens_smoothed8mm/${b}_RAVENS_2GM_2mm_smoothed8mm.nii.gz`;

echo $RavensPath8mm >> /cbica/projects/pncNmf/n1396_t1NMF/subjectData/n696_RavensPaths_test.csv


done

