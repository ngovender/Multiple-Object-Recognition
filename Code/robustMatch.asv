function [robustFeatures] = robustMatch(features)

% Thought:
%
% Over a number of frames the descriptors of one feature will evolve.  You
% could capture the evolution statistically.  Look for mohalanhobis distance.
%


m = {};

sideLen = 1;

counter = 1;
for k = 2: 2%length(features)
      disp(k);
      pos = 1;
      sframe = max([k-sideLen, 1]);
      eframe = min([k+sideLen, length(features)]);

      for i = sframe:(eframe-1)
          % get the matches between two consecutive frames
          [matches scores] = vl_ubcmatch(features(i).descriptors, features(i + 1).descriptors);   
         
          %m{pos} = matches;
          pos = pos + 1;
      end
      % check which matches are common
     
      
%       num =size(m{1}, 2);
%       % find out which image has the most matches
%       for j = 2:size(m{1}, 1)
%           if size(m{j},2) > num
%              num = size(m{j},2);
%           end
%       end
%       for p = 1:size(m{1}, 2)
%           firstMatch = m{p}(2,p);
%           for q = 2:length(m)
%               idx = find(m{q}(1, :) == firstMatch); % gives me the idx where they match
%               if (isempty(idx))
%                break;
%               end
%           end
%       end
     
      for i = 1:size(m{1}, 2) % number of matches 
           curidx = m{1}(2, i);
        for j = 2:length(m)
           idx = find(m{j}(1, :) == curidx);
           if (isempty(idx))
             break;
           end
           curidx = m{1}(2, idx);
          % disp(curidx(1,1));
           if (j == length(m))                        
            robustFeatures(counter).frame = m{1}(2, idx);
            robustFeatures(counter).descriptor = features(k).descriptors(:, i);
            robustFeatures(counter).filename = features(k).fileName;
            counter = counter+ 1;
           end
        end
     end
end
