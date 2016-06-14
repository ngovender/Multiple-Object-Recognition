% num = match(image1, image2)
%
% This function reads two images, finds their SIFT features, and
%   displays lines connecting the matched keypoints.  A match is accepted
%   only if its distance is less than distRatio times the distance to the
%   second closest match.
% It returns the number of matches displayed.
%
% Example: match('scene.pgm','book.pgm');

function [num trainImage1 trainImage2 descriptors1 descriptors2 sizeX sizeY]= match(loc1,des1,loc2,des2,im1)



% Find SIFT keypoints for each image
%[im1, des1, loc1] = sift(image1);
%[im2, des2, loc2] = sift(image2);
%im1 = single(rgb2gray(imread(inputImage)));
% im2 = single(rgb2gray(imread(image2)));
% [loc1, des1] = vl_sift(im1);
% [loc2, des2] = vl_sift(im2);

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


[rows, cols] = size(im1);

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

% Create a new image showing the two images side by side.
% im3 = [im1,im2];

% Show a figure with lines joining the accepted matches.
%  figure('Position', [100 100 size(im3,2) size(im3,1)]);
%  colormap('gray');
%  imagesc(im3);
%  hold on;
% cols1 = size(im1,2);
count = 1;
for i = 1: num_of_keypoints
  if (matches(i) > 0)
%     line([loc1(i,2) loc2(match(i),2)+cols1], ...
         % [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
    trainImage1(count,:) = [loc1(i,:)];
    trainImage2(count,:) = [loc2(matches(i),:)];
    %trainImage2(count,:) = [loc2(match(i),:)];
    descriptors1(count,:) = des1c(i,:); % need to save the decsriptors of the matches
    descriptors2(count,:) = des2c(i,:);
    count = count +1;
  end
end
% hold off;

%fprintf('Found %d matches.\n', num);
% for j = 1:size(match)
%    train(i, = radtodeg(train(1,4))
%    orientation2 = radtodeg(train(2,4))
% end    



