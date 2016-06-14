% script to find out which image has the most matches to the input image to
% determine the angle of the input image

function [originalFeatures1] = matchDesc2(object,inputImage,robotData,nextView)

   

point = ((object * 18 )-18) + nextView
im1 = imread(inputImage);
im1 = single(rgb2gray(im1));
[loc1 des1] = vl_sift(im1);%descriptors from our test image
[matches trainImage1 trainImage2 descriptors1 descriptors2 sizeX sizeY] = match(loc1,des1,robotData(point).frames,robotData(point).descriptors,im1);
[originalFeatures1]= hough(trainImage1, trainImage2, matches, descriptors1,descriptors2,sizeX,sizeY);

   
  
   