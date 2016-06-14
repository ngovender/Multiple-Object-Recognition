

function [newImage,previousViewpoints,wantViewsOut,count,failed] = nextViewpoint(countin, previousViewpoints, poseEstimates, wantViews,object)%,failed)


% need to find the next viewpoint
% where the entropy values for each viewpoint is stored
failed = 0;
data =[];


switch (object)
      
        case 1
            objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\allBran\';
%         case 2
%             objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\battery\';        
%         case 3
%             objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\can1\';        
%         case 4
%           objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\can2\';
        case 2
           objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\curry1\';
        case 3
           objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\curry2\';
        case 4
         objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\elephant\';
        case 5
         objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\salad\';
%         case 8        
%            objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\fisherPrice\';
%         case 9
%            objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\handbag3\';
%         case 10
%             objectDir = 'D:\PhDWork\code\vocab_tree_v2\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\handbag\';
%         
% end



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
    data = load (newFilename);
    angleNum = k -1;
       
    nextStep = mod(previousViewpoints(end) + (angleNum - poseEstimates(end)), 18);
       
    result = find(nextStep==previousViewpoints); %previousViewpoints);
    if (isempty(result))
        if (data> value) 
           % not equal to the current view
     
            value = data;
            wantRes = angleNum;
            nextView= nextStep; %angleNum;
            name = filename1;
        end
    end
end

%Save desired views
wantViewsOut = [wantViews wantRes];
 
 
%randomly select a new view
% x1 = 0;
% x2 = 17;
% next =round((x2-x1)*rand(1,1)+x1)
% 
% nextView = next; %mod(previousViewpoints(end) + (next- poseEstimates(end)), 18)
% 
% result = find(nextView==previousViewpoints);
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
% % 
% % disp('next view');
% % disp(nextView);
% wantViewsOut = [wantViews next];


%%Select the next consecutive view

% nextView = previousViewpoints(countin) + 1;
% 
% if (nextView ==17)
%     nextView = 1;
% end


%  disp(previousViewpoints);
 count = countin + 1;
 previousViewpoints(count) = nextView % viewpoints start from 0 
 
 switch (object)
      
        case 1
            newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\allBran\\segmented\\%0.5u.bmp';
%         case 2
%             newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\battery\\segmented\\%0.5u.bmp';        
%         case 3
%             newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\can1\\segmented\\%0.5u.bmp';        
%         case 4
%            newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\can2\\segmented\\%0.5u.bmp';
        case 2
           newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\curry1\\segmented\\%0.5u.bmp';
        case 3
           newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\curry2\\segmented\\%0.5u.bmp';
        case 4
         newDir ='D:\\PhDWork\\Datasets\\NewOccluded\\elephant\\segmented\\%0.5u.bmp';
        case 5        
           newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\salad\\segmented\\%0.5u.bmp';
%         case 9
%            newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\handbag3\\segmented\\%0.5u.bmp';
%         case 10
%            newDir = 'D:\\PhDWork\\Datasets\\NewOccluded\\handbag\\segmented\\%0.5u.bmp';
        
end
    
% where the actual image is
newImage = sprintf(newDir, nextView);

