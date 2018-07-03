#Threshold the images output from NMF analyses (Basis_*.nii) by .004 and binarize them (needs to be done separately). 

numComponents="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26"

indir=/data/jux/BBL/projects/pncNmf/results/Ravens

thrOutdir=/data/jux/BBL/projects/pncNmf/results/Ravens/Threshold004

binOutdir=/data/jux/BBL/projects/pncNmf/results/Ravens/Threshold004Bin

for i in $numComponents
do
        echo ""

        echo "Component number is $i"

fslmaths $indir/Basis_${i}.nii -thr .004 $thrOutdir/Basis_${i}_thr004.nii.gz

fslmaths $thrOutdir/Basis_${i}_thr004.nii.gz -bin $binOutdir/Basis_${i}_thr004Bin.nii.gz

done
