#Create nifti images: 1) with all NMF components on one brain and 2) with only FDR-significant NMF components

###############################
### LOAD DATA AND LIBRARIES ###
###############################
data.NMF <- readRDS("/data/jux/BBL/projects/pncT1AcrossDisorder/subjectData/n1394_T1_subjData.rds")

#Load libraries
library(mgcv)
library(ANTsR)

#####################################################
### CREATE IMAGE WITH ALL COMPONENTS ON ONE BRAIN ###
#####################################################
#Load the 4d set of merged component images (NOTE: each component needs to be merged in the correct order 1-26 for this script to work).
img<-antsImageRead('/data/jux/BBL/projects/pncNmf/results/Ravens/n1394_26RavensNmfComponentsMerged.nii.gz',4)

#Load the prior grey matter mask (warped to MNI space and binarized)
mask<-antsImageRead('/data/jux/BBL/projects/pncNmf/masks/prior_grey_thr01_2mm_MNI_bin.nii.gz',3)

#Create matrix: rows are components, columns are voxels
seed.mat<-timeseries2matrix(img, mask)

#Find, for each voxel, which component has highest loading
whichCompStr <-apply(seed.mat,2,which.max) # however, some of those are all zeros, need to remove
foo <-apply(seed.mat,2,sum) 		   # this is sum of loadings across column; if 0, entire column is 0
whichCompStr[which(foo==0)]<-0 		   # assign 0-columns to 0

#Write image with all components on one brain (every voxel is assigned to one component)
newImg<-antsImageClone(mask)               # prep for writing out image
newImg[mask==1]<-as.matrix(whichCompStr)   # put assigned values back in the image
antsImageWrite(newImg,"/data/jux/BBL/projects/pncNmf/tablesFigures/RavensNmf26Components.nii.gz")

##################################################################
### CREATE IMAGE WITH ONLY SIGNIFICANT COMPONENTS ON ONE BRAIN ###
##################################################################
#Assign values for components where gestational age is FDR-significantly associated with volume (see GamAnalyses.R for which components survive fdr correction) 
#Create a vector that assigns each voxel a component number
tvalMap<-antsImageClone(mask)
tvalVoxVector<-whichCompStr

#Assign all components that did not survive fdr correction to 0 (this is not necessary since all Ravens NMF components survived FDR correction).
#tvalVoxVector[which(tvalVoxVector %in% c(4,6,8,15,17))]<-0

#OPTIONAL: For the remaining components, assign the respective t-value for that component
#However, this makes it difficult to make custom color palettes in Caret later.
tvalVoxVector[which(tvalVoxVector==1)] <- 3.24
tvalVoxVector[which(tvalVoxVector==2)] <- 4.89
tvalVoxVector[which(tvalVoxVector==3)] <- 3.38
tvalVoxVector[which(tvalVoxVector==4)] <- 4.01
tvalVoxVector[which(tvalVoxVector==5)] <- 4.66
tvalVoxVector[which(tvalVoxVector==6)] <- 2.93
tvalVoxVector[which(tvalVoxVector==7)] <- 2.17
tvalVoxVector[which(tvalVoxVector==8)] <- 4.23
tvalVoxVector[which(tvalVoxVector==9)] <- 4.98
tvalVoxVector[which(tvalVoxVector==10)] <- 4.75
tvalVoxVector[which(tvalVoxVector==11)] <- 4.14
tvalVoxVector[which(tvalVoxVector==12)] <- 3.47
tvalVoxVector[which(tvalVoxVector==13)] <- 2.25
tvalVoxVector[which(tvalVoxVector==14)] <- 4.22
tvalVoxVector[which(tvalVoxVector==15)] <- 3.41
tvalVoxVector[which(tvalVoxVector==16)] <- 3.68
tvalVoxVector[which(tvalVoxVector==17)] <- 2.35
tvalVoxVector[which(tvalVoxVector==18)] <- 3.00

#Essentially this is a replaced image with 0s and surviving component numbers or t-values
tvalMap[mask==1]<-as.matrix(tvalVoxVector)
antsImageWrite(tvalMap,"/data/jux/BBL/projects/pncNmf/tablesFigures/RavensNmfSignificantComponents.nii.gz")
