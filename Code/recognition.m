
function [probability] = recognition(data, ids, nodeCentres, children_ids)

num = size(data.frames,2);

for i = 1: num
    
    %need to go through each fetaure at a time
    desc = data.descriptors(:,i)';
    des1 = nodeCentres{i}(:,:)  % the descriptors of the node centres
      
    % need to find the closest centre in the node structure
    
    % For each descriptor in the first image, select its match to second image.
%      desct = desc';                      % Precompute matrix transpose
%      for k = 1 : size(des1,1)
%          %disp(des1(k,:));
%          dotprods = des1(k,:) * desct;        % Computes vector of dot products
%          [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results         
%      end

    nodes = findPath(desc, ids, nodeCentres, children_ids);
    probability = nodes;
    
    return


end