%path = 'D:\PhDWork\Datasets\Active Vision Database\Curry2\segmented\';

files1 = dir('D:\PhDWork\code\vocab_tree\Deon''s code\add_database\*.dat');
files2 = dir('D:\PhDWork\code\vocab_tree\Deon''s code\add_database\*.da2');

num = 417;
for j = 1:8
    
    filename1 = files1(j).name;
    filename2 = files2(j).name;
    name = '00';
    newfilename = strcat(name,int2Str(num));
    movefile(['D:\PhDWork\code\vocab_tree\Deon''s code\add_database\' filename1],['D:\PhDWork\code\vocab_tree\Deon''s code\Feature Files\' newfilename '.dat']);
    movefile(['D:\PhDWork\code\vocab_tree\Deon''s code\add_database\' filename2],['D:\PhDWork\code\vocab_tree\Deon''s code\Feature Files\' newfilename '.da2']);
    num = num +1;
end
