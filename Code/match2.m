% num = match(image1, image2)
%
% This function reads two images, finds their SIFT features, and
%   displays lines connecting the matched keypoints.  A match is accepted
%   only if its distance is less than distRatio times the distance to the
%   second closest match.
% It returns the number of matches displayed.
%
% Example: match('scene.pgm','book.pgm');

function [num trainImage1 trainImage2 descriptors1 descriptors2]= match2(descriptor1,loc1,clusters,j)


% For efficiency in Matlab, it is cheaper to compute dot products between
%  unit vectors rather than Euclidean distances.  Note that the ratio of 
%  angles (acos of dot products of unit vectors) is a close approximation
%  to the ratio of Euclidean distances for small angles.
%
% distRatio: Only keep matches in which the ratio of vector angles from the
%   nearest to second nearest neighbor is less than distRatio.
distRatio = 0.6;   


% For each descriptor in the first image, select its match to second image.

% need the cluster to be the reference image
des1 = clusters(j).descriptor;
des2 = descriptor1;    % Precompute matrix transpose
des2t = descriptor1';    % Precompute matrix transpose

if (size(descriptor1,1)) < (size(clusters(j).descriptor,1))
    num_of_keypoints = size(descriptor1,1)
else
    num_of_keypoints = size(clusters(j).descriptor,1)
end

for i = 1 : num_of_keypoints % the number of interest points found

   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
   else
      match(i) = 0;
   end
end
num = sum(match > 0);
trainImage1 = zeros(num,4);
trainImage2 = zeros(num,4);
descriptors1 = zeros(num,128);
descriptors2 = zeros(num,128);

% Create a new image showing the two images side by side.
% im3 = appendimages(im1,im2);
% 
% % Show a figure with lines joining the accepted matches.
% figure('Position', [100 100 size(im3,2) size(im3,1)]);
% colormap('gray');
% imagesc(im3);
% hold on;
% cols1 = size(im1,2);
count = 1;
for i = 1: num_of_keypoints
  if (match(i) > 0)
%     line([loc1(i,2) loc2(match(i),2)+cols1], ...
%          [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
    trainImage1(count,1) = [clusters(j).locationX(i)];
    trainImage1(count,2) = [clusters(j).locationY(i)];
    trainImage1(count,3) = [clusters(j).scale(i)];
    trainImage1(count,4) = [clusters(j).orientation(i)];
    descriptors1(count,:) = des1(i,:); % need to save the descriptors of the matches
    
    trainImage2(count,:) = [loc1(match(i),:)];
    trainImage2(count,:) = [loc1(match(i),:)];

    descriptors2(count,:) = des2(i,:);
    count = count +1;
  end
end
%hold off;

fprintf('Found %d matches.\n', num);
  



