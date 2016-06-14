% script to find out which image has the most matches to the input image to
% determine the angle of the input image

function [originalFeatures1 currentNum] = matchDesc(object,inputImage,robotData)

   
num =0;
im1 = imread(inputImage);
im1 = single(rgb2gray(im1));
[loc1 des1] = vl_sift(im1);%descriptors from our test image


trainingNum = ((object * 18) - 17);


% Need to change?!
%while(num==0)

% Locate the pose of the object using training data

for j = 0:17 % for each training image of the object
    disp(trainingNum+j);
    disp('data from robotDat');
    size(robotData(trainingNum+j).frames)
    size(robotData(trainingNum+j).descriptors)
    [matches trainImage1 trainImage2 descriptors1 descriptors2 sizeX sizeY] = match(loc1,des1,robotData(trainingNum+j).frames,robotData(trainingNum+j).descriptors,im1);
    
    % Apply hough to verify geometry
    [originalFeatures1_]= hough1(trainImage1, trainImage2, matches, descriptors1, descriptors2, sizeX, sizeY);

    if (length(originalFeatures1_) > num)
        num = length(originalFeatures1_);    %matches
%         matches_ = matches;      
%         inputRef = trainImage1;
%         inputDes = descriptors1;
%         matchImage = trainImage2;
%         matchDes = descriptors2;
%         mainSizeX = sizeX;
%         mainSizeY = sizeY;
        currentNum =j+1;
        originalFeatures1 = originalFeatures1_;
    end
end       

if (num == 0)
    originalFeatures1 = [];
    currentNum = -1;
end
    
    
%     figure
%     image(im1)
%     colormap(gray(255));
%     hold on
%     for i=1:length(originalFeatures1)
%         plot(originalFeatures1(i).locationY, ...
%             originalFeatures1(i).locationX, '.r');            
%     end   
%    pause(1);



   
  
   