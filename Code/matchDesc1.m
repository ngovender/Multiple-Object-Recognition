% script to find out which image has the most matches to the input image to
% determine the angle of the input image

function [originalFeatures1] = matchDesc1(inputImage,newImage)

  
      [num trainImage1 trainImage2 descriptors1 descriptors2 sizeX sizeY]= match(inputImage, newImage);
      [originalFeatures1]= hough(trainImage1, trainImage2, num, descriptors1,descriptors2,sizeX,sizeY);
      
      


%    
%     num =0;
%    trainingNum = (number * 18) - 17;
%    for j = 0: 17 % for each training image of the object
%        matches = vl_ubcmatch(input,training(trainingNum+j).descriptors);
%        disp(size(matches,2));
%        if size(matches,2) > num
%           num = size(matches,2);
%           currentAngle = j;
%        end
%        
%    end       
%    trainImage = trainingNum + currentAngle; % need to know which training image to match to
%    currentNum = currentAngle;
%    currentAngle = currentAngle * 20;


   
  
   