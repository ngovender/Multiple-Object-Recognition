
close all

% Load all the data
load robotDataNew;
%load dataset1.mat;
load nodeCounts;
load loadingVocab20;
load sortedObjects;
load indices;

objectNum = 20;
poseNum = 18;
startFrame = 1;
depth = 6;
newMat = [];
poseEstimates = [];
allOffsets = [];
%PO=zeros(1,objectNum)
%count =1;
weightingMap = getWeightingMap;

%nodeCounts = nodeCounts(:,1:objectNum);

for object = 1:1%objectNum
    confmat = [];
    view = 1;
    hypoobject =1;

    %PO=zeros(1,objectNum);

    %initialProb = log(ones(1, objectNum) /objectNum);
    %PO(:)  = initialProb(1); % it's the same for all objects
    PO = log(ones(1, objectNum) / objectNum);
    cOffset = 1;
    visited = zeros(1,poseNum);
    visited(1) = 1;    
    
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
       
    
       
    
    end    
    disp('object');
    disp(object);
    result =[];

    % selecting highest viewpoint until 80% is reached
    while  (((exp(PO(:,:)))<0.8) & (view<=18))
        disp('Im here');
%         disp('exp');
%         disp(exp(PO(:,:)));
        % get test image for current offset
        inputImage = getNewImage(object,cOffset);
        disp(inputImage);
        im1 = imread(inputImage);
        im1 = single(rgb2gray(im1));
        [locTest desTest] = vl_sift(im1);
        disp('for test obect');
        disp(size(locTest));
        disp(size(desTest));
        % get pose estimate for each hypo object

        for hypoobject = 1:objectNum
            disp('hypo object');
            disp(hypoobject);
            [desc_match currentNum ] = matchDesc(hypoobject,im1,locTest,desTest,robotDataNew);
            disp('best pose estimate');
            disp(currentNum);
            viewEstimates(hypoobject,view) =currentNum;
            poseEstimates(object,view,hypoobject) = currentNum;
        end
        allOffsets(view) = cOffset;
        
        % align weightmaps
        cWeightingMap = zeros(objectNum,poseNum);
        max0 = viewEstimates(:,view);
        for o = 1:1%objectNum
            if max0(o)==-1
                continue;
            end
            vec = weightingMap(o,:);
            vec = [vec(max0(o):end) vec(1:max0(o)-1)];
            vec = [vec(poseNum-cOffset+2:end) vec(1:poseNum-cOffset+1)];
            cWeightingMap(o,:) = vec;
        end
        cWeightingMap = sum(cWeightingMap);
        cWeightingMap(visited==1) = -inf;
        
        % want to update all the object priors with the features
        % extracted from the input image
       
        num = size(desc_match,1);
        for ii = 1:num
            %need to go through each feature at a time
            desc = desc_match(ii,:);
%             des1 = nodeCenters{ii}(:,:);  % the descriptors of the node centres
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
                
                dists = zeros(size(desc_match, 1), 1);
                for i=1:size(desc, 1)
                    dists(i) = norm(double(des1(i, :)) - double(desc));
                end
                
                [y ii] = min(dists);
                
                newid = children_ids{curnode}(i);
                [f ii] = find(newid == ids);
                
                curnode = ii;
                nodes = [nodes; curnode];
            end
            
            if (length(nodes) == depth)
                for jj=depth:depth
                    PO = (log(nodeCounts(nodes(jj), :))) + PO;
                    PO = PO - log(sum(exp(PO)));
%                     log(nodeCounts(nodes(jj), :))
                end
            end
            
        end

        % need to select the next best viewpoint over all the objects
        
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
        
        [dum cOffset] = max(cWeightingMap);
        visited(cOffset) = 1;
        view = view + 1;
        
        exp(PO)
        
%         result = find(diag(exp(PO(:,:))>=0.8));
        
    end
    objectViews(object) = view;
    confmat = PO;
    pause(1);
    newMat(object,:) = confmat;
end

save('newMat_n','newMat');
