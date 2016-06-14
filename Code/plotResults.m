

path1 = 'D:\PhDWork\code\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\results\';
path2 = 'D:\PhDWork\Datasets\Active Vision Database\vocabTree\';

files = ls([path1,'*.m'])

for j= 1:size(files)
    filename = files(j,:)
    file = strcat(path1,filename);
    data = load(file);
    xValues = data(:,1);
    yValues = data(:,2);
    
    imageName = substr(filename,0,-1);
    imageName = strcat(imageName,'bmp')
    imageName = strcat(path2,imageName);
    im = imread(imageName);
    figure,imshow(im);
    hold on;
    plot(xValues,yValues,'ro');
end


 

