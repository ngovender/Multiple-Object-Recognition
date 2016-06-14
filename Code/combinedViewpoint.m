
close all

% Load all the data
load robotDataNew;
%load dataset1.mat;
load nodeCounts;
load loadingVocab20;
load sortedObjects;
load indices;

objectNum = 20;
startFrame = 1;
depth = 6;
newMat = [];
poseEstimates = [];
%count =1;

for object = 1:objectNum
    confmat = [];
    view = 1;
    hypoobject =1;

   % PO=zeros(1,objectNum);
    con = zeros(objectNum,objectNum);
 

    count = 0; % to check if any new view have been found
    PO = log(ones(1, objectNum) / objectNum);   
    %initialProb = log(ones(1, objectNum) /objectNum);
    %PO(:,:)  = initialProb(1); % it's the same for all objects
    % where the actual image is
    switch (object)
        
        
        case 1
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\allBran\\segmented\\00001.bmp';
      
        case 2
          inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\battery\\segmented\\00001.bmp';        
        case 3
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\can1\\segmented\\00001.bmp';        
        case 4
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\can2\\segmented\\00001.bmp';
       
        case 5
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\curry1\\segmented\\00001.bmp';
        case 6
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\curry2\\segmented\\00001.bmp';
        case 7
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\elephant\\segmented\\00001.bmp';
     
        case 8
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\handbag\\segmented\\00001.bmp';
       
        case 9
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\jewelryBox1\\segmented\\00001.bmp';        
        case 10
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\jewelryBox2\\segmented\\00001.bmp';        
        case 11
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\lemonBottle\\segmented\\00001.bmp';
       
        case 12
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\mrMin\\segmented\\00001.bmp';
        
        case 13
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\salad\\segmented\\00001.bmp';
        case 14
         inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\sauce1\\segmented\\00001.bmp';
        case 15        
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\sauce2\\segmented\\00001.bmp';
        case 16
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\spice1\\segmented\\00001.bmp';
        case 17
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\spice2\\segmented\\00001.bmp';
       
        case 18
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\sprayCan1\\segmented\\00001.bmp';
        case 19
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\sprayCan2\\segmented\\00001.bmp';
        case 20
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\sprayCan\\segmented\\00001.bmp';
       
       
%         case 1
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\allBran\\segmented\\00001.bmp';
%         case 2
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\battery\\segmented\\00001.bmp';        
%         case 3
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\can1\\segmented\\00001.bmp';        
%         case 4
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\can2\\segmented\\00001.bmp';
%         case 2
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\Curry1\\segmented\\00001.bmp';
%         case 3
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\Curry2\\segmented\\00001.bmp';
%         case 4
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\Elephant\\segmented\\00001.bmp';
       
%         case 8
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\handbag3\\segmented\\00001.bmp';
%        
%         case 9
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\jewelryBox1\\segmented\\00001.bmp';        
%         case 1
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\jewelryBox2\\segmented\\00001.bmp';        
%         case 11
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\lemonBottle\\segmented\\00001.bmp';
%         
%         case 12
%             inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\mrMin\\segmented\\00001.bmp';
%     
%         case 5
%            inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\salad\\segmented\\00001.bmp';
%         case 2
%          inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\sauce1\\segmented\\00001.bmp';
%         case 15        
%            inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\sauce2\\segmented\\00001.bmp';
%         case 16
%            inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\spice1\\segmented\\00001.bmp';
%         case 17
%            inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\spice2\\segmented\\00001.bmp';
%        
%         case 18
%            inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\sprayCan1\\segmented\\00001.bmp';
%         case 19
%            inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\sprayCan2\\segmented\\00001.bmp';
%         case 3
%            inputImage = 'D:\\PhDWork\\Datasets\\NewOccluded\\sprayCan\\segmented\\00001.bmp';
    
%         
       
    
    end    
    disp('object');
    disp(object);
    result =[];
    im1 = imread(inputImage);
    im1 = single(rgb2gray(im1));
    %want to extract the features from the input image
    [testLocation testDescriptor] = vl_sift(im1);%descriptors from our test image
    
    %use the extracted features to get the initial pose estimate for each hypo object
    for hypoobject = 1:objectNum
            disp('hypo object');
            disp(hypoobject);
            [originalFeatures1 currentNum ] = matchDesc(hypoobject,im1,testLocation,testDescriptor,robotDataNew);
            viewEstimates(hypoobject,1) =currentNum; 
            poseEstimates(object,view,hypoobject) = currentNum; % initial pose over all the objects
%                disp('initial pose');
%                disp(currentNum);
    end
    
    % selecting highest viewpoint until 80% is reached
    while  (((exp(PO(:,:)))<0.8) & (count~=18))
        %((count~=18)&&((exp(PO(:,:)))>0.8) )
        
        %for hypoobject = 1:objectNum
           
            % want to update all the object priors with the features
            % extracted from the input image
            if(currentNum~=-1)
                num = size(testLocation,2);
                for i = 1:num
                    %need to go through each feature at a time
                    desc = testDescriptor(:,i);
                    des1 = nodeCenters{i}(:,:);  % the descriptors of the node centres
                    % need to find the closest centre in the node structure
                    curnode = 1;
                    nodes = 1;%curnode;
                    while (1)
                        if (length(children_ids) < curnode)
                            break
                        end
                        % HACK, WHAT ACTUALLY IS THE PROBLEM!!!!!
                        if (isempty(curnode))
                            break
                        end
                        
                        if (isempty(children_ids{curnode}))
                            break;
                        end
                        
                        des1 = nodeCenters{curnode}(:,:);  % the descriptors of the node centres
                        
                        dists = zeros(size(des1, 1), 1);
                        for j=1:size(des1, 1)
                            dists(j) = norm(double(des1(j, :)) - double(desc'));
                        end
                        
                        [y i] = min(dists);
                        
                        newid = children_ids{curnode}(i);
                        [f i] = find(newid == ids);
                        
                        curnode = i;
                        nodes = [nodes; curnode];
                    end
                   
                    if (length(nodes) == depth)
                          for jj=depth:depth
                            PO = (log(nodeCounts(nodes(jj), :))) + PO;
                            PO = PO - log(sum(exp(PO)));
                          end
                    end
                    
                end
            end
        %end
        % need to select the next best viewpoint over all the objects
       
       % for p = 1: 18
        %    result = find(poseEstimates(object,:,:)==indices(1,p));
         %   if (isempty(result)) % if the result is empty, then we found a viewpoint that doesn't belong to the initial views)
          count = count +1
          nextView = indices(count)
       
               
                %break;
            %end
            
       % end
        
%randomly select the next view
%         x1 = 1;
%         x2 = 18;
%         count= 1;
%         next =round((x2-x1)*rand(1,1)+x1); 
%         result = find(next==poseEstimates(object,:,:));
%         while ((~(isempty(result))) && (count~=18))
%             next =round((x2-x1)*rand(1,1)+x1); % continue until a unique viewpoint is found
%             result = find(next==poseEstimates(object,:,:));
%             count = count+1;
%         end
%         nextView = next; %mod(previousViewpoints(end) + (next- poseEstimates(end)), 18)
%         

        view = view +1
        % update the pose estimates
       % if (count~=1)
        % poseEstimates(object,view,:) = nextView; % when this system uses the arm - a conversion needs to take place considering the intial viewpoint;
        %end
        
        %if (count~=1)
          poseEstimates(object,view,:) = nextView; % when this system uses the arm - a conversion needs to take place considering the intial viewpoint;
        %end
        % for l = 1:28
          %pose = poseEstimates(object,view,l); % initial pose for each object
          %nextPose = abs(pose - (nextView*20))/20; % view number
    % end
        % get the inputImage
         result = find(diag(exp(PO(:,:))>=0.8))
     
    end
    objectViews(object) = view;
    for p = 1: objectNum
        confmat(p)= PO(1,p);    
    end
    newMat(object,:) = confmat;
end


