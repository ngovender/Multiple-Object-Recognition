

function [newImage,previousViewpoints,wantViewsOut,count,failed,nextView] = nextViewConf_20(countin, previousViewpoints, wantViews,hypoobject,object)%,failed)



% need to find the next viewpoint
% where the entropy values for each viewpoint is stored
failed = 0;


switch (hypoobject)
      
         case 1
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\allBran\';
         case 2
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\battery\';
         case 3
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\can1\';
         case 4
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\can2\';
       
         case 5
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\curry1\';
               
         case 6
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\curry2\';
        
         case 7
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\elephant\';
         case 8
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\handbag3\';
      
         case 9
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\jewelryBox1\';
        
         case 10
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\jewelryBox2\';
         case 11
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\lemonBottle\';
         case 12
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\mrMin\';
       
        case 13
         objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\salad\';
        case 14
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sauce1\';
        case 15
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sauce2\';
               
        case 16
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice1\';
        
        case 17
            objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice2\';
       
        case 18
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan1\';
        
        case 19
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan2\';
        case 20
           objectDir = 'E:\PhDWork\code\vocab_tree_v3\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan\';
      
        
end
    
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
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\allBran\\segmented\\%0.5u.bmp', nextView);
    case 2
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\battery\\segmented\\%0.5u.bmp', nextView);
    case 3
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\can1\\segmented\\%0.5u.bmp', nextView);
    case 4
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\can2\\segmented\\%0.5u.bmp', nextView);
  
  
    case 5
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\curry1\\segmented\\%0.5u.bmp', nextView);
  
    case 6
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\curry2\\segmented\\%0.5u.bmp', nextView);
    
    case 7
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\elephant\\segmented\\%0.5u.bmp', nextView);
   
   
    case 8
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\handbag3\\segmented\\%0.5u.bmp', nextView);
   
    case 9
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\jewelryBox1\\segmented\\%0.5u.bmp', nextView);
   
    case 10
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\jewelryBox2\\segmented\\%0.5u.bmp', nextView);
    case 11
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\lemonBottle\\segmented\\%0.5u.bmp', nextView);
   
   
    case 12
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\mrMin\\segmented\\%0.5u.bmp', nextView);
   
    case 13
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\salad\\segmented\\%0.5u.bmp', nextView);
  
    case 14
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\sauce1\\segmented\\%0.5u.bmp', nextView);
    case 15
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\sauce2\\segmented\\%0.5u.bmp', nextView);
  
    case 16
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\spice1\\segmented\\%0.5u.bmp', nextView);
    
    case 17
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\spice2\\segmented\\%0.5u.bmp', nextView);
  
    case 18
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\sprayCan1\\segmented\\%0.5u.bmp', nextView);
   
    case 19
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\sprayCan2\\segmented\\%0.5u.bmp', nextView);
    case 20
        newImage = sprintf('E:\\PhDWork\\Datasets\\NewOccluded\\spraycan\\segmented\\%0.5u.bmp', nextView);
  
end
