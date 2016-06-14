% script to find out which image has the most matches to the input image to
% determine the angle of the input image

function [desc_match currentNum] = matchDesc(object,im1,loc1,des1,robotDataNew)

   
num =0;

trainingNum = ((object * 18) - 17);

% Need to change?!
%while(num==0)

% Locate the pose of the object using training data

for j = 0:17 % for each training image of the object
    %disp(size(robotDataNew(trainingNum+j).frames));
    %disp(size(robotDataNew(trainingNum+j).descriptors));
    %disp(im1);
    [matches trainImage1 trainImage2 descriptors1 descriptors2 sizeX sizeY] = match(loc1,des1,robotDataNew(trainingNum+j).frames,robotDataNew(trainingNum+j).descriptors,im1);
    disp('number of matches,');
    disp(length(trainImage1));
    if (matches > num)
        
       num = matches;
       %we just need the descriptors
       desc_match = descriptors1;
       currentNum = j+1;
        
    end
    % Apply hough to verify geometry
%     [originalFeatures1_]= hough1(trainImage1, trainImage2, matches, descriptors1, descriptors2, sizeX, sizeY);
% 
%     if (length(trainImage1) > num)
%         num = length(originalFeatures1_);    %matches
% %         matches_ = matches;      
% %         inputRef = trainImage1;
% %         inputDes = descriptors1;
% %         matchImage = trainImage2;
% %         matchDes = descriptors2;
% %         mainSizeX = sizeX;
% %         mainSizeY = sizeY;
%         currentNum =j+1;
%         originalFeatures1 = originalFeatures1_;
%     end
end       

% disp('current num');
% disp(currentNum);
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



   
  
   