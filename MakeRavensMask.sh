#Create a cortical and subcortical mask for Ravens.

#See TemplateCreation wiki (https://github.com/PennBBL/pncReproc2015Scripts/wiki/TemplateCreation) for documentation of how the priors were made.

#prior image (cortical grey matter) 
prior002=/data/joy/BBL/studies/pnc/template/priors/prior_002_2mm.nii.gz

#prior image (subcortical grey matter)
prior004=/data/joy/BBL/studies/pnc/template/priors/prior_004_2mm.nii.gz

#This is where the output mask goes
outdir=/data/jux/BBL/projects/pncNmf/masks/ravensMask

echo "outdir is $outdir"

echo ""

#Combine the priors
priordir=/data/jux/BBL/projects/pncNmf/masks/priors

fslmaths $prior002 -add $prior004 ${priordir}/prior_002_004_2mm_cortSubcort.nii.gz

#Threshold and binarize
#NOTE: A threshold of .01 was needed for continuous coverage with few holes.
fslmaths ${priordir}/prior_002_004_2mm_cortSubcort.nii.gz -thr .01 -bin ${outdir}/n1396_ravensMask_thr01_2mm.nii.gz

