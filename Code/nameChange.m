

files = dir('D:\PhDWork\Datasets\vocabTree_newData\*.jpg')
%counter =36;
% alphabet(1) ='a';
% alphabet(2) ='b';
% alphabet(3) ='k';
% alphabet(4) ='l';
% alphabet(5) ='m';
% alphabet(6) ='n';
% alphabet(7) ='o';
% alphabet(8) ='p';
% alphabet(9) ='q';
% alphabet(10) ='r';
% alphabet(11) ='c';
% alphabet(12) ='d';
% alphabet(13) ='e';
% alphabet(14) ='f';
% alphabet(15) ='g';
% alphabet(16) ='h';
% alphabet(17) ='i';
% alphabet(18) ='j';

% alphabet(1) ='a';
% alphabet(2) ='b';
% alphabet(3) ='c';
% alphabet(4) ='d';
% alphabet(5) ='e';
% alphabet(6) ='f';
% alphabet(7) ='g';
% alphabet(8) ='h';
% alphabet(9) ='i';
% alphabet(10) ='j';
% alphabet(11) ='k';
% alphabet(12) ='l';
% alphabet(13) ='m';
% alphabet(14) ='n';
% alphabet(15) ='o';
% alphabet(16) ='p';
% alphabet(17) ='q';
% alphabet(18) ='r';


for j = 1:size(files)
    
    filename1 = files(j).name
    name = 'zz_'
    newfilename = strcat(name,filename1);
    movefile(['D:\PhDWork\Datasets\vocabTree_newData\' filename1],['D:\PhDWork\Datasets\vocabTree_newData\newData\' newfilename '.jpg']);
    %counter = counter +1;
end
