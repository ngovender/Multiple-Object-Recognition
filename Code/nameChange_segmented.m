

%path = 'D:\PhDWork\Datasets\Active Vision
%Database\curry2\segmented\';

files = dir('D:\PhDWork\Datasets\Active Vision Database\Spice6\segmented\*.bmp')
counter =36;
alphabet(1) ='a';
alphabet(2) ='b';
alphabet(3) ='c';
alphabet(4) ='d';
alphabet(5) ='e';
alphabet(6) ='f';
alphabet(7) ='g';
alphabet(8) ='h';
alphabet(9) ='i';
alphabet(10) ='j';
alphabet(11) ='k';
alphabet(12) ='l';
alphabet(13) ='m';
alphabet(14) ='n';
alphabet(15) ='o';
alphabet(16) ='p';
alphabet(17) ='q';
alphabet(18) ='r';

for j = 1:size(files)
    
    filename1 = files(j).name
    name = 'spice6_'
    newfilename = strcat(name,alphabet(j))
    movefile(['D:\PhDWork\Datasets\Active Vision Database\Spice6\segmented\' filename1],['D:\PhDWork\Datasets\Active Vision Database\Spice6\segmented\renamed\' newfilename '.bmp']);
    counter = counter +1;
end
