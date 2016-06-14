

function [newImage,previousViewpoints,wantViewsOut,count,failed,nextView] = nextViewConf(countin, previousViewpoints, wantViews,object)%,failed)


% need to find the next viewpoint
% where the entropy values for each viewpoint is stored
failed = 0;


switch (object)
      
         case 1
            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\allBran\';
             
%         case 2
%           objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\banff\';
%         case 3
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\battery\';
%         case 4
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\can1\';
%         case 5
%          objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\can2\';
%         case 6
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\cup\';
        case 2
            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\curry1\';
               
        case 3
            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\curry2\';
        
        case 4
            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\elephant\';
%         case 10
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\fisherPrice\';
%         case 11
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\handbag2\';
%         case 12
%          objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\handbag3\';
%         case 13        
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\handbag\';
%         case 14
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\jewelryBox1\';
%         
%         case 15
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\jewelryBox2';
%         case 16
%             objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\lemonBottle\';
%              
%         case 17
%           objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\lensBox\';
%         case 18
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\mrMin\';
%         case 19
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\robocop\';
         case 5
         objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\salad\';
%         case 21
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sauce1\';
%         case 22
%             objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sauce2\';
%                
%         case 23
%             objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice1\';
%         
%         case 24
%             objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice2\';
%         case 25
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice3\';
%         case 26
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice4\';
%         case 27
%          objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice5\';
%         case 28        
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice6\';
%         case 29
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan1\';
%         
%         case 30
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan2\';
%         case 31
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan\';
%         case 32
%          objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\teddyBear\';
%         case 33        
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\toy\';
%         case 34
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\wallE\';
%         
%         case 35
%            objectDir = 'D:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\zanzibar\';
      
      
        
        
end
disp('object dir');
disp(objectDir);
files = ls([objectDir,'*.m']);
% 
% 
% % get the next viewpoint
 value = 0;
 nextView =0;
 name ='';


for k = 1: 18
    filename1 = files(k,:);   
    newFilename = strcat(objectDir,filename1);
    data = load (newFilename);% this is the weighting of the viewpoint
    angleNum = k -1;
       
    %nextStep = mod(previousViewpoints(end) + (angleNum - poseEstimates(end)), 18)
    % we want to go through all the viewpoints and select the viewpoint with the highest value and hasn't
    % been selected before
    result = find(k==previousViewpoints); %previousViewpoints);
    if (isempty(result))
        if (data> value) 
           % not equal to the current view
            value = data;
            wantRes = angleNum;
            nextView= k; 
            name = filename1;
       end
    end
end
% 
%Save desired views
wantViewsOut = [wantViews wantRes];
 

%randomly select a new view
%  x1 = 1;
%  x2 = 18;
%  next =round((x2-x1)*rand(1,1)+x1);
%  result = find(next==previousViewpoints);
%  while (~(isempty(result)))
%       next =round((x2-x1)*rand(1,1)+x1); % continue until a unique viewpoint is found
%       result = find(next==previousViewpoints);
%  end
%  nextView = next; %mod(previousViewpoints(end) + (next- poseEstimates(end)), 18)
% 
% % result = find(nextView==previousViewpoints);
% num = 1;
% disp('in view slelection');
% while (~isempty(result)) && (num ~=18)% there is a match
%     
%     next =round((x2-x1)*rand(1,1)+x1);
%     nextView = mod(previousViewpoints(end) + (next - poseEstimates(end)), 18);
%     result = find(nextView==previousViewpoints);
%     num = num+1;
% end
% if num ==18 % then it's been to all 18 images
%    failed = 1
%    return;
% end
% 
% disp('next view');
% disp(nextView);
%wantViewsOut = [wantViews next];
%

%%Select the next consecutive view

% nextView = previousViewpoints(countin) + 1;
% 
% if (nextView ==17)
%     nextView = 1;
% end


%  disp(previousViewpoints);
 count = countin + 1; % save the next view
 previousViewpoints(count) = nextView; % viewpoints start from 0 
 disp('nextView');
 disp(nextView);

% where the actual image is
switch (object)
     case 1
        newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\allBran\\segmented\\%0.5u.bmp', nextView);
   
%     case 2
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\banff\\segmented\\%0.5u.bmp', nextView);
%     case 3
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\battery\\segmented\\%0.5u.bmp', nextView);
%     case 4
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\can1\\segmented\\%0.5u.bmp', nextView);
%     case 5
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\can2\\segmented\\%0.5u.bmp', nextView);
%   
%     case 6
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\cup\\segmented\\%0.5u.bmp', nextView);
    case 2
        newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\curry1\\segmented\\%0.5u.bmp', nextView);
  
    case 3
        newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\curry2\\segmented\\%0.5u.bmp', nextView);
    
    case 4
        newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\elephant\\segmented\\%0.5u.bmp', nextView);
%     case 10
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\fisherPrice\\segmented\\%0.5u.bmp', nextView);
%     case 11
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\handbag2\\segmented\\%0.5u.bmp', nextView);
%     case 12
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\handbag3\\segmented\\%0.5u.bmp', nextView);
%     case 13
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\handbag\\segmented\\%0.5u.bmp', nextView);
%     case 14
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\jewelryBox1\\segmented\\%0.5u.bmp', nextView);
%    
%     case 15
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\jewelryBox2\\segmented\\%0.5u.bmp', nextView);
%     case 16
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\lemonBottle\\segmented\\%0.5u.bmp', nextView);
%    
%     case 17
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\lensBox\\segmented\\%0.5u.bmp', nextView);
%     case 18
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\mrMin\\segmented\\%0.5u.bmp', nextView);
%     case 19
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\robocop\\segmented\\%0.5u.bmp', nextView);
    case 5
        newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\salad\\segmented\\%0.5u.bmp', nextView);
  
%     case 21
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\sauce1\\segmented\\%0.5u.bmp', nextView);
%     case 22
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\sauce2\\segmented\\%0.5u.bmp', nextView);
%   
%     case 23
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\spice1\\segmented\\%0.5u.bmp', nextView);
%     
%     case 24
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\spice2\\segmented\\%0.5u.bmp', nextView);
%     case 25
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\spice3\\segmented\\%0.5u.bmp', nextView);
%     case 26
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\spice4\\segmented\\%0.5u.bmp', nextView);
%     case 27
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\spice5\\segmented\\%0.5u.bmp', nextView);
%     case 28
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\spice6\\segmented\\%0.5u.bmp', nextView);
%     case 29
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\sprayCan1\\segmented\\%0.5u.bmp', nextView);
%    
%     case 30
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\sprayCan2\\segmented\\%0.5u.bmp', nextView);
%     case 31
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\spraycan\\segmented\\%0.5u.bmp', nextView);
%     case 32
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\teddyBear\\segmented\\%0.5u.bmp', nextView);
%     case 33
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\Toy\\segmented\\%0.5u.bmp', nextView);
%     case 34
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\wallE\\segmented\\%0.5u.bmp', nextView);
%    
%     case 35
%         newImage = sprintf('D:\\PhDWork\\Datasets\\NewOccluded\\zanzibar\\segmented\\%0.5u.bmp', nextView);
   
   
   
   
end
