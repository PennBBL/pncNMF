% read the data
mask_nii = load_untouch_nii('/cbica/projects/pncNmf/n1396_t1NMF/masks/n1396_ctMask_thr9_2mm.nii.gz');
mask = mask_nii.img ;

data_lst = '/cbica/projects/pncNmf/n1396_t1NMF/subjectData/n1396_CtPaths.csv';
fid=fopen(data_lst,'r');
datafullpath = textscan(fid,'%s %d\n');
fclose(fid);

data.y = datafullpath{1,2} ;
datafullpath = datafullpath{1,1} ;

count = numel(datafullpath);
info = load_untouch_header_only(datafullpath{1});

data.X = zeros(sum(mask(:)>0),count);
for i=1:count
	disp(i/count)
	nii = load_untouch_nii(datafullpath{i});    
data.X(:,i) = nii.img(mask>0) ;
end

% load results and calculate reconstruction error
resultsPath='/cbica/projects/pncNmf/n1396_t1NMF/results/CT/';
numBases=2:2:30;

RecError=zeros(length(numBases),1);
for b=1:length(numBases)
	disp(b/length(numBases))
	load([resultsPath 'NumBases' num2str(numBases(b)) '/OPNMF/ResultsExtractBases.mat'])  
	Est = B(mask>0,:)*C ;
RecError(b) = norm(data.X-Est,'fro') ;    
    clear B C
end

% make figure
    % 1) reconstruction error
    fig = figure;plot(numBases,RecError,'r','LineWidth',2)
    xlabel('Number of components','fontsize',12)
    ylabel('Reconstruction error','fontsize',12)
    set(gca,'fontsize',12)
    saveas(fig,'/cbica/projects/pncNmf/n1396_t1NMF/figures/reconstructionError_CT.png');

    % 2) gradient of reconstruction error
    fig2 = figure;plot(numBases(2:end),diff(RecError),'r','LineWidth',4)
    axis([0 30 -100 0])
    xlabel('Number of components','fontsize',16)
    ylabel('Gradient of reconstruction error','fontsize',16)
    NumTicks = 16;
    L = get(gca,'XLim');
    set(gca,'fontsize',14,'box','off','XTick',linspace(L(1),L(2),NumTicks))
    pbaspect([2 1 1])
    saveas(fig2,'/cbica/projects/pncNmf/n1396_t1NMF/figures/reconstructionErrorGradient_CT.png');

    % 3) Percentage of improvement over range of components used
    fig3 = figure;plot(numBases,abs(RecError-RecError(1))./abs(RecError(1)-RecError(end)),'r','LineWidth',2)
    xlabel('Number of components','fontsize',12)
    ylabel('Percentage of improvement over range of components used','fontsize',12)
    xlim([numBases(1) numBases(end)])
    set(gca,'fontsize',12)
    saveas(fig3,'/cbica/projects/pncNmf/n1396_t1NMF/figures/percentageImprovementRecError_CT.png');
