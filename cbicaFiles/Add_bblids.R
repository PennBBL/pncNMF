#Read in bblids_scanids list and NMF output .csv
bblids_scanids <- read.csv("/cbica/projects/pncNmf/n1396_t1NMF/subjectData/n1396_T1_bblids_scanids.csv", header=FALSE, na.strings=".")
NMF_Ravens <- read.csv("/cbica/projects/pncNmf/n1396_t1NMF/results/Ravens/NumBases26/OPNMF/NmfResults26Bases_Ravens.csv", header=TRUE, na.strings=".") 
NMF_CT <- read.csv("/cbica/projects/pncNmf/n1396_t1NMF/results/CT/NumBases18/OPNMF/NmfResults18Bases_CT.csv", header=TRUE, na.strings=".")

#Add header to bblids_scanids
names(bblids_scanids) <- c("bblid", "scanid")

#Combine the bblids, scanids, and NMF output (NOTE: this assumes that the bblids list and the NMF output are in the exact same order)
Ravens_Data <- cbind(bblids_scanids,NMF_Ravens)
CT_Data <- cbind(bblids_scanids,NMF_CT)

#Save file
write.csv(Ravens_Data, file = "/cbica/projects/pncNmf/n1396_t1NMF/subjectData/n1396_Nmf26Bases_Ravens_bblids.csv",row.names=FALSE)
write.csv(CT_Data, file = "/cbica/projects/pncNmf/n1396_t1NMF/subjectData/n1396_Nmf18Bases_CT_bblids.csv",row.names=FALSE)
