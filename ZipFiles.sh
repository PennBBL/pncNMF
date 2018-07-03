##Zip the files so they can be moved to CBICA for NMF analyses.

#CT
cd /data/jux/BBL/projects/pncNmf/images/CT_smoothed4mm
tar -cvf /data/joy/BBL/projects/pncNmf/images/n1396_CtData_smoothed4mm.tar.gz *

#Ravens
cd /data/jux/BBL/projects/pncNmf/images/Ravens_smoothed8mm
tar -cvf /data/joy/BBL/projects/pncNmf/images/n1396_RavensData_smoothed8mm.tar.gz *

#GMD 
cd /data/jux/BBL/projects/pncNmf/images/GMD_smoothed8mm
tar -cvf /data/joy/BBL/projects/pncNmf/images/n1396_GmdData_smoothed8mm.tar.gz *
