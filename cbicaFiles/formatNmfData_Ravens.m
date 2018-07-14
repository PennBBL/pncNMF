clear all

numBases = 26;

%% read in NMF decomposition
cd(sprintf('/cbica/projects/pncNmf/n1396_t1NMF/results/Ravens/NumBases%d/OPNMF',numBases))

load('ResultsExtractBases.mat')

% transpose so format is Nsub X NumComponents
C_t = C';

% assigning variable names
pre = sprintf('Ravens_Nmf%dC',numBases);

varNames = {};
for k = 1:numBases
    varNames = [varNames; strcat([pre,num2str(k,'%d')])];
end

% convert to table so we can assign variable names
T = array2table(C_t,'VariableNames',varNames)

% writing table to .csv file 
writetable(T,sprintf('NmfResults%dBases_Ravens.csv',numBases),'Delimiter',',')


