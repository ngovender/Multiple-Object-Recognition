% num = match(image1, image2)
%
% This function reads two images, finds their SIFT features, and
%   displays lines connecting the matched keypoints.  A match is accepted
%   only if its distance is less than distRatio times the distance to the
%   second closest match.
% It returns the number of matches displayed.
%
% Example: match('scene.pgm','book.pgm');

%function [num trainImage1 trainImage2 descriptors1 descriptors2 sizeX sizeY]= match(loc1,des1,loc2,des2,im1)



% Find SIFT keypoints for each image
%[im1, des1, loc1] = sift(image1);
%[im2, des2, loc2] = sift(image2);
image1 = 'C:\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\elephant2.bmp';
image2 = 'C:\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\elephant2.bmp';
im1 = single(rgb2gray(imread(image1)));
im2 = single(rgb2gray(imread(image2)));
[loc1, des1] = vl_sift(im1);
[loc2, des2] = vl_sift(im2);

des1 = double(des1');
loc1 = double(loc1');
des2 = double(des2');
loc2 = double(loc2');

des1c = des1;
des2c = des2;

for i=1:size(des1, 1)
    des1(i, :) = des1(i, :) / norm(des1(i, :));
end

for i=1:size(des2, 1)
    des2(i, :) = des2(i, :) / norm(des2(i, :));
end


[rows, cols] = size(im1)

sizeX = rows/2;
sizeY = cols/2;
matches = [];


% For efficiency in Matlab, it is cheaper to compute dot products between
%  unit vectors rather than Euclidean distances.  Note that the ratio of 
%  angles (acos of dot products of unit vectors) is a close approximation
%  to the ratio of Euclidean distances for small angles.
%
% distRatio: Only keep matches in which the ratio of vector angles from the
%   nearest to second nearest neighbor is less than distRatio.
distRatio = 0.6;   

% For each descriptor in the first image, select its match to second image.
des2t = des2';                          % Precompute matrix transpose
if (size(des1,1)) < (size(des2,1))
    num_of_keypoints = size(des1,1);
else
    num_of_keypoints = size(des2,1);
end
for i = 1 : num_of_keypoints
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      matches(i) = indx(1);
   else
      matches(i) = 0;
   end
end
num = sum(matches > 0);
trainImage1 = zeros(num,4);
trainImage2 = zeros(num,4);
descriptors1 = zeros(num,128);
descriptors2 = zeros(num,128);


count = 0;


for i = 1: num_of_keypoints
  if (matches(i) > 0)
%     line([loc1(i,2) loc2(match(i),2)+cols1], ...
         % [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
     count = count +1;
    trainImage1(count,:) = [loc1(i,:)];
    trainImage2(count,:) = [loc2(matches(i),:)];
    %trainImage2(count,:) = [loc2(match(i),:)];
    descriptors1(count,:) = des1c(i,:); % need to save the decsriptors of the matches
    descriptors2(count,:) = des2c(i,:);
   
  end
end

size(trainImage1)
% Create a new image showing the two images side by side.
im3 = [imread(image1),imread(image2)];

h = figure('Position', [100 100 size(im3,2) size(im3,1)]);
%h is a handle to a figure you wish to draw on: i.e h = figure is performed outside this function,
%img1 and img2 are the images to be compared,
%setP1 contains the locations of features extracted from img1,
%setP2 contains the locations of features extracted from img2,

%Precondition: Features in img1 and img2 have been matched,
%							 setP1 and/or setP2 have been reorganiosed such that the feature at setP1(n, :) 
%							 corresponds to the feature at setP2(n, :) for all valid values

fig = get(h, 'Position');
W = fig(3);
H = fig(4);

% [R1, C1] = size(imread(image1(:, :, 1)))
% [R2, C2] = size(imread(image2(:, :, 1)))

R1 = 481;
R2 = 481;
C1 = 691;
C2 = 691;

h1 = subplot(1, 2, 1);
image(imread(image1));
hold on
plot(h1, trainImage1(:,1), trainImage1(:,2), 'r.');

h2 = subplot(1, 2, 2);
image(imread(image2));
hold on
plot(h2, trainImage2(:,1), trainImage2(:,2), 'r.');

%All measurements must be of the same type.
set(h, 'Units', 'pixels');
set(h1, 'Units', 'pixels');
set(h2, 'Units', 'pixels');

%Find the position of the subplots in the figure
sub1 = get(h1, 'Position');
x_1  = sub1(1);
y_1  = sub1(2);
w_1  = sub1(3);
h_1  = sub1(4);
sub2 = get(h2, 'Position');
x_2  = sub2(1);
y_2  = sub2(2);
w_2  = sub2(3);
h_2  = sub2(4);

%Transform the position of the input point so they sit within the
%appropriate subplot.
%First set
trainImage1(:,1) = x_1 + trainImage1(:,1)*w_1/C1;
trainImage1(:,1) = trainImage1(:,1)/W;

trainImage1(:,2) = y_1 + h_1 - trainImage1(:,2)*h_1/R1;
trainImage1(:,2) = trainImage1(:,2)/H;


%Second set
trainImage2(:,1) = x_2 + trainImage2(:,1)*w_2/C2;
trainImage2(:,1) = trainImage2(:,1)/W;

trainImage2(:,2) = y_2 + h_1 - trainImage2(:,2)*h_2/R2;
trainImage2(:,2) = trainImage2(:,2)/H;

figure(h)
hold on

for i=1:length(trainImage1(:,1)) 
    annotation('line', [trainImage1(i,1), trainImage2(i,1)], [trainImage1(i,2), trainImage2(i,2)]);   
end
hold off
('count')
(count)
% Hough clustering
[originalFeatures1,originalFeatures2]= hough(trainImage1,trainImage2, count, descriptors1,descriptors2,sizeX,sizeY);
size(originalFeatures1)
trainImage3= [originalFeatures1(:).locationX;originalFeatures1(:).locationY;originalFeatures1(:).scale;originalFeatures1(:).orientation];
trainImage4 = [originalFeatures2(:).locationX;originalFeatures2(:).locationY;originalFeatures2(:).scale;originalFeatures2(:).orientation];
('training imae')
size(trainImage3)
im4 = [imread(image1),imread(image2)];

h = figure('Position', [100 100 size(im4,2) size(im4,1)]);
fig = get(h, 'Position');
W = fig(3);
H = fig(4);

% [R1, C1] = size(imread(image1(:, :, 1)))
% [R2, C2] = size(imread(image2(:, :, 1)))

R1 = 481;
R2 = 481;
C1 = 691;
C2 = 691;

h1 = subplot(1, 2, 1);
image(imread(image1));
hold on
plot(h1, trainImage3(:,1), trainImage3(:,2), 'r.');

h2 = subplot(1, 2, 2);
image(imread(image2));
hold on
plot(h2, trainImage4(:,1), trainImage4(:,2), 'r.');

%All measurements must be of the same type.
set(h, 'Units', 'pixels');
set(h1, 'Units', 'pixels');
set(h2, 'Units', 'pixels');

%Find the position of the subplots in the figure
sub1 = get(h1, 'Position');
x_1  = sub1(1);
y_1  = sub1(2);
w_1  = sub1(3);
h_1  = sub1(4);
sub2 = get(h2, 'Position');
x_2  = sub2(1);
y_2  = sub2(2);
w_2  = sub2(3);
h_2  = sub2(4);

%Transform the position of the input point so they sit within the
%appropriate subplot.
%First set
trainImage3(:,1) = x_1 + trainImage3(:,1)*w_1/C1;
trainImage3(:,1) = trainImage3(:,1)/W;

trainImage3(:,2) = y_1 + h_1 - trainImage3(:,2)*h_1/R1;
trainImage3(:,2) = trainImage3(:,2)/H;


%Second set
trainImage4(:,1) = x_2 + trainImage4(:,1)*w_2/C2;
trainImage4(:,1) = trainImage4(:,1)/W;

trainImage4(:,2) = y_2 + h_1 - trainImage4(:,2)*h_2/R2;
trainImage4(:,2) = trainImage4(:,2)/H;

figure(h)
hold on

for i=1:length(trainImage3(:,1)) 
    annotation('line', [trainImage3(i,1), trainImage4(i,1)], [trainImage3(i,2), trainImage4(i,2)]);   
end
hold off
