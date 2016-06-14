 %Create a new image showing the two images side by side.
 
 im1 = 'D:\PhDWork\Datasets\Active Vision Database\display1.bmp';
 im2 = 'D:\PhDWork\Datasets\Active Vision Database\display2.bmp';
 
 im1 = imread(im1);
 im2 = imread(im2);
 
 rows1 = size(im1,1);
rows2 = size(im2,1);

if (rows1 < rows2)
     im1(rows2,1) = 0;
else
     im2(rows1,1) = 0;
end
 im3 = [im1 im2];  
%im3 = appendimages(im1,im2);

% Show a figure with lines joining the accepted matches.
figure('Position', [100 100 size(im3,2) size(im3,1)]);
colormap('gray');
%imshow(im3)
imagesc(im3);
hold on;
