##Testing set
#Run the NMF script for a range of components to find the optimal component number.

csvFile=/cbica/projects/pncNmf/n1396_t1NMF/subjectData/n696_CtPaths_test.csv

numComponents="2 4 6 8 10 12 14 16 18 20 22 24 26 28 30"

#Do not place a "/" at the end of the output directory path or it will cause random components to crash in matlab.
outputDirectory=/cbica/projects/pncNmf/n1396_t1NMF/results/CT_test_new

mask=/cbica/projects/pncNmf/n1396_t1NMF/masks/n1396_ctMask_thr9_2mm.nii.gz


for i in $numComponents
do
        echo ""

        echo "Component number is $i"

qsub ./submit_script_extractBasesMT.sh $csvFile $i $outputDirectory $mask
sleep 1s
done
