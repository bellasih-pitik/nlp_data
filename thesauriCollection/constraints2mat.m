
clear
clc
%{

 synonyms constraints are collected from 

1. https://github.com/nmrksic/LEAR/blob/master/linguistic_constraints/syn-sym.txt

2. https://github.com/nmrksic/attract-repel/blob/master/linguistic_constraints/full-syn-sample.txt

3. https://github.com/nmrksic/counter-fitting/blob/master/linguistic_constraints/ppdb_synonyms.txt





Antonyms:

1. https://raw.githubusercontent.com/nmrksic/LEAR/master/linguistic_constraints/antonyms.txt

2. https://github.com/nmrksic/attract-repel/blob/master/linguistic_constraints/full-ant-sample.txt

3. https://github.com/nmrksic/counter-fitting/blob/master/linguistic_constraints/ppdb_antonyms.txt

4. https://github.com/nmrksic/counter-fitting/blob/master/linguistic_constraints/wordnet_antonyms.txt


%}


%source = 'allsyn.txt';
%source = 'allant.txt';

%source = 'full-syn-sample.txt';

%source = 'ppdb_synonyms.txt';

source = 'ppdb_antonyms.txt';


fid = fopen(source,'rt');

%%
tmp = textscan(fid,'%s','Delimiter',' ');
fclose(fid);

pairsWithprefix = reshape(tmp{1}, [2, length(tmp{1})/2])';


pairsWithSpace = cellfun(@(x) strrep(x,'en_','')  , pairsWithprefix,'UniformOutput',false);

pairs = cellfun(@(s) strrep(s, ' ', ''), pairsWithSpace, 'UniformOutput', false);

%%

dictionary = unique([pairs(:,1);pairs(:,2)]);









word2Index = containers.Map(dictionary, (1:length(dictionary)));
%%




index1stColumn =  cell2mat(cellfun(@(x) getWordIndex( word2Index, x, 0), pairs(:,1), 'UniformOutput', false));

index2ndColumn =  cell2mat(cellfun(@(x) getWordIndex( word2Index, x, 0), pairs(:,2), 'UniformOutput', false));


thesaurus = sparse([index1stColumn; index2ndColumn], [index2ndColumn; index1stColumn], ones(size([index2ndColumn; index1stColumn],1),1));



%%
name = strtok(source,'.');


%%


thesaurus_ppdb_ant = thesaurus;
dictionary_ppdb_ant = dictionary;

%%
save(strcat(name,'.mat'), 'thesaurus_ppdb_ant', 'dictionary_ppdb_ant')
