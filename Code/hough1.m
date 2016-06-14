% refines the matches found by sift matching(bbf) by using a hough
% transform voting scheme

function [originalFeatures1,originalFeatures2]= hough1(trainingImage1,trainingImage2, matches, descriptor1,descriptor2,sizeX,sizeY)



% convert the orientation of each match to degree
% reference orientation will be 90 degree
 for j = 1:matches
     trainingImage1(j,4) = abs(trainingImage1(j,4)*(180/pi));
     trainingImage2(j,4) = abs(trainingImage2(j,4)*(180/pi));
     %image1(j,4) = image1(j,4)*(180/pi);
     %image2(j,4) = image2(j,4)*(180/pi);
 end
 
 
%  for i = 1:matches
%      disp('orientation for image 1');
%      disp(image1(i,4));
%      disp('orientation for image 2');
%      disp(image2(i,4));
 %end
% create the 4D arrays for the features to vote on...x,y location, scale
% and orientation
voting = zeros(matches,4); 
% reference ecntre of the object is sizeX and sizeY, orietnation is 90
% degrees
refAngle = 90;

cols = sizeY * 2;

for i = 1:matches
    
%     disp('image1');
%     disp(trainingImage1(i,:));
%     disp('image2');
%     disp(trainingImage2(i,:));
    % calculate the distance from the features in the first image to the
    % centre of the image
    diffDistX = sizeX - trainingImage1(i,1);
    diffDistY = sizeY - trainingImage1(i,2);
    distance = [diffDistX;diffDistY];
    % difference in angles
    angleImage1 = refAngle - trainingImage1(i,4);
    
%     disp('image1');
%     disp(trainingImage1(i,3));
%     disp('image2');
%     disp(trainingImage2(i,3));
    scaleFactor = trainingImage1(i,3)/ trainingImage2(i,3); % use this scale to vote on scale?
     
    % Image 2
    angleImage2 = refAngle - trainingImage2(i,4); % angle used for voting
    diffAngle = angleImage1 - angleImage2;
    diffAngle = mod(diffAngle,360); 
    % rotation matrix
    rot = [cosd(diffAngle),-sind(diffAngle);sind(diffAngle), cosd(diffAngle)];
  
    currentImagePos = [trainingImage2(i,1), trainingImage2(i,2)];
    location = scaleFactor * (rot*distance);
    location(1,1) = location(1,1) + currentImagePos(1,1);
    location(2,1) = location(2,1) + currentImagePos(1,2);
    
    
    % voting for the various bins
    voting(i,1) = location(1,1);
    voting(i,2) = location(2,1);
    voting(i,3) = scaleFactor;
    voting(i,4) = diffAngle;
    
end

% once all the voting is completed. Look at which values have the most
% votes different ranges
% scale and orientation will always have the same number of bins
scale = zeros(5);
orientation = zeros(12);
% need to calculate how big to make the bins for the locations
locRange = 0.25 * cols / 8; % the difference between the ranges
num = cols/locRange; 
locX = zeros(num);
locY = zeros(num);

%voting for location X
for j = 1:matches
    counter = 0;
    for i = 1:num
      if((voting(j,1)>=counter)&(voting(j,1)<=counter+locRange))
             locX(i) = locX(i) + 1;
             break;
      end
      counter = counter+locRange;
      
    end
end



%voting for location Y
for j = 1:matches
    counter = 0;
    for i = 1:num
      if((voting(j,2)>=counter)&(voting(j,2)<=counter+locRange))
             locY(i) = locY(i) + 1;
             break;
      end
      counter = counter+locRange;
    end
    
    %voting for scale
    if (voting(j,3)<=2)
        scale(1) = scale(1) + 1;
     elseif((voting(j,3)>2)&(voting(j,3)<=4))
        scale(2) = scale(2) + 1;
     elseif((voting(j,3)>4)&(voting(j,3)<=6))
        scale(3) = scale(3) + 1;
     elseif((voting(j,3)>6)&(voting(j,3)<=8))
        scale(4) = scale(4) + 1;
     elseif((voting(j,3)>8)&(voting(j,3)<=10))
        scale(5) = scale(5) + 1;
    end
    
    % vote for orientation
     if(voting(j,4)<=30)
            orientation(1) = orientation(1) + 1;
      elseif((voting(j,4)>30)&(voting(j,4)<=60))
            orientation(2) = orientation(2) + 1;
      elseif((voting(j,4)>60)&(voting(j,4)<=90))
            orientation(3) = orientation(3) + 1;
      elseif((voting(j,4)>90)&(voting(j,4)<=120))
            orientation(4) = orientation(4) + 1;
      elseif((voting(j,4)>120)&(voting(j,4)<=150))
            orientation(5) = orientation(5) + 1;
      elseif((voting(j,4)>150)&(voting(j,4)<=180))
            orientation(6) = orientation(6) + 1;
      elseif((voting(j,4)>180)&(voting(j,4)<=210))
            orientation(7) = orientation(7) + 1;
      elseif((voting(j,4)>210)&(voting(j,4)<=240))
            orientation(8) = orientation(8) + 1;
      elseif((voting(j,4)>240)&(voting(j,4)<=270))
            orientation(9) = orientation(9) + 1;      
      elseif((voting(j,4)>270)&(voting(j,4)<=300))
            orientation(10) = orientation(10) + 1;
      elseif((voting(j,4)>300)&(voting(j,4)<=330))
            orientation(11) = orientation(11) + 1;
      elseif((voting(j,4)>330)&(voting(j,4)<=360))
            orientation(12) = orientation(12) + 1;
   end
end

% disp('number of ranges');
% disp(num);
% disp(locRange);



% figure out which bins have the most votes 
maxX = locX(1); % value
numX = 1;  % which bin
maxY = locY(1);
numY = 1; % which bin contains the highest votes
maxScale = scale(1);
numScale = 1;
maxOri = orientation(1);
numOri = 1;

for j = 2:num
    if locX(j)> maxX
       maxX = locX(j); % how many voted for this bin
       % which bin
       numX = j ;
    end
    if locY(j)> maxY
       maxY = locY(j); 
       numY = j;
    end
end

for d = 1:5 
    if scale(d)>maxScale
       maxScale = scale(d);
       numScale = d;
    end
end

for n = 1:12
    if orientation(n)>maxOri
       maxOri = orientation(n);
       numOri = n;
    end
end

% we know which bins contain the highest number of votes - find the
% features which votes for all 4 highest bins
% Need to know the range for the highest bin
% for location - just multiply the number by 50 (this will give the max
% values of the bin) - have to look at the closest bin as well

maxRangeX = numX * locRange;
maxRangeY = numY * locRange;
scaleRange = numScale * 2;
orientRange = numOri * 30;
count = 1;
des1 = zeros(matches,128);
des2 = zeros(matches,128);
feature= struct('locationX',{},'locationY',{},'scale',{},'orientation',{});
originalFeatures1= struct('locationX',{},'locationY',{},'scale',{},'orientation',{},'descriptor',{});
originalFeatures2= struct('locationX',{},'locationY',{},'scale',{},'orientation',{},'descriptor',{});
% save the features which voted for these ranges
for i = 1:matches
    if ((voting(i,1)>=(maxRangeX-locRange)) & (voting(i,1)<(maxRangeX))) % fulfills the locX
        %disp('in X');
     if ((voting(i,2)>=(maxRangeY-locRange)) & (voting(i,2)<(maxRangeY)))%fulfills the locY
         %disp('in Y');
          if ((voting(i,3)>=(scaleRange-2)) & (voting(i,3)<scaleRange))% scale
              %disp('in scale');
              if ((voting(i,4)>=(numOri-60)) & (voting(i,3)<(numOri+30))) % orientation  %features satifies all criteria, should save it
               
                  feature(count).locationX = voting(i,1);
                  feature(count).locationY = voting(i,2);
                  feature(count).scale = voting(i,3);
                  feature(count).orientation = voting(i,4);
                  
                  originalFeatures1(count).locationX = trainingImage1(i,1);
                  
                  
                  originalFeatures1(count).locationY = trainingImage1(i,2);
                  originalFeatures1(count).scale = trainingImage1(i,3);
                  originalFeatures1(count).orientation = trainingImage1(i,4);
                  originalFeatures1(count).descriptor = descriptor1(i,:);
                  
              
                  
                  originalFeatures2(count).locationX = trainingImage2(i,1);
                  originalFeatures2(count).locationY = trainingImage2(i,2);
                  originalFeatures2(count).scale = trainingImage2(i,3);
                  originalFeatures2(count).orientation = trainingImage2(i,4);
                  originalFeatures2(count).descriptor = descriptor2(i,:);
                 
                  count = count +1;
              end
              
          end    
      end
    end
end
disp('new matches');
disp(count);

count = count - 1;







