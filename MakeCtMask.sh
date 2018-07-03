#Create a mask that will remove images with too many 0 or <.1 values using Phil Cook's suggested method.
#NOTE: need a qlogin with 50G of memory to run this, else, will say "core dumped" (qlogin -l h_vmem=50.5G,s_vmem=50.0G)

#Read list of subject IDs that pass QA
cat /data/jux/BBL/projects/pncNmf/subjectData/n1396_T1_bblids_scanids.csv | while IFS="," read -r a b ;

do 

#Define output directory
outdir=/data/jux/BBL/projects/pncNmf/masks/ctMask

#Define the list of input image paths
imgList=`ls -d /data/joy/BBL/studies/pnc/n1601_dataFreeze/neuroimaging/t1struct/voxelwiseMaps_antsCt/${b}_CorticalThicknessNormalizedToTemplate2mm.nii.gz`;

#Create mask
for i in $imgList; do 

#get scanid: first echo the path (echo $i), then cut the path up by delimiter "/" (-d'/'), then take the 10th field (-f11) which is "2632_CorticalThicknessNormalizedToTemplate2mm.nii.gz", then cut up the file name by delimiter "." and just keep the first field (which will be the file name without ".nii.gz").                                                                                                                                                              
        fileName=$(echo $i | cut -d'/' -f11  | cut -d'.' -f1)
        echo "file name is $fileName"

	ThresholdImage 3 $i ${outdir}/${fileName}_mask.nii.gz 0.1 Inf
done

done

#Average the masks together and binarize/threshold the final mask.
outdir=/data/jux/BBL/projects/pncNmf/masks/ctMask

AverageImages 3 ${outdir}/coverageMask.nii.gz 0 ${outdir}/*mask.nii.gz

fslmaths ${outdir}/coverageMask.nii.gz -thr .9 -bin ${outdir}/n1396_ctMask_thr9_2mm.nii.gz

