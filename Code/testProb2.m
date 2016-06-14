
close all

% Load all the data
load robotData
load loadingVocab
load nodeCounts;
%load dataset1

% Constants
c = ['y' 'c' 'b' 'r' 'k' 'm'];
num_frames=[];
plotall = 0;
depth = 6;

% Object hypothesis
%object = 2;
startFrame = 1;
% dump1 = {};
% dump2 = {};
% dpos = 1;

figure
results =[];
inputImage = 'D:\PhDWork\Datasets\NewOccluded\allBran\segmented\00001.bmp';

for object = 1:5
     
    %startFrame = startFrame +1;
   % inputImage = sprintf('D:\\PhDWork\\Datasets\\occlusions\\Full_Battery\\segmented\\%0.5u.bmp', startFrame);
    % Previously visited views, used to eliminate repeats
    previousViews =[startFrame];
    poseEstimates = [];
    frameCount = 1;
    wantViews = [];
    %for kkk = 1:1 % object we are looking for
    
    % Unbiased prior
    PO = log(ones(1, 5) / 5);   

    count = 1;
  
    % Continue until we are certain/uncertain.
  % while (exp(PO(object)) < 0.99)
  for k = 1:4
 
        % want to match the input image to all training images of that
        % object
        
      
        
        if (count==1)
            [originalFeatures1 currentNum ] = matchDesc(object,inputImage,robotData);             
            
            if (plotall)
                disp('input Images');
                disp(inputImage);
                image(imread(inputImage));
                hold on
                for i=1:length(originalFeatures1)
                    plot(originalFeatures1(i).locationX, ...
                        originalFeatures1(i).locationY, '.r');            
                end
                hold off
            end
                        
           % dump1{dpos} = inputImage;            
        else
                    
            [originalFeatures1 currentNum ] = matchDesc(object,newImage,robotData);
            
            if (plotall)
                image(imread(inputImage));
                hold on
                for i=1:length(originalFeatures1)
                    plot(originalFeatures1(i).locationX, ...
                        originalFeatures1(i).locationY, '.r');            
                end
                hold off
            end

           % dump1{dpos} = newImage;
            %return
        end
        
        
        %dump2{dpos} = currentNum;
        %dpos = dpos + 1;
            
        % current viewpoint
        %if count == 1
            %previousViews(count) = currentNum;
            poseEstimates(count) = currentNum;
            
        %end % only need to match the first input image - after that we know the angle of the input image
      
        % we only match to one training of the object in the database
        %matches = vl_ubcmatch(data(1).descriptors, robotData(trainingImage).descriptors);
        %descs = data(1).descriptors(:, matches(1, :))';
      
        %num = size(data(inum).frames,2);
        num = size(originalFeatures1,2)
        for i = 1:num
            %need to go through each feature at a time    
            desc = originalFeatures1(i).descriptor;
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
                for i=1:size(des1, 1)
                    dists(i) = norm(double(des1(i, :)) - double(desc));
                end

                [y i] = min(dists);       

                newid = children_ids{curnode}(i);
                [f i] = find(newid == ids);

                curnode = i;
                nodes = [nodes; curnode];

                %if (length(nodes) > 3 && length(nodes) < 5)
                    %PO = nodeCounts(curnode, :) .* PO;
                    %PO = log(nodeCounts(curnode, :)) + PO;
                    %PO = PO / sum(PO);
                    %PO = PO - log(sum(exp(PO)));
                    %PO = PO + nodeCounts(curnode, :) * 1/12;
                %end
                %
            end

            if (length(nodes) == depth)        
                for jj=depth:depth
                    PO = log(nodeCounts(nodes(jj), :)) + PO;            
                    PO = PO - log(sum(exp(PO)));                    
                end
                
                % nodeCounts(nodes(5), :)
            end
            %nodes'
        end
        
        %return
        
          results(m,k) = exp(PO(object));
       % figure
      % disp(exp(PO));
        plot(exp(PO), 'r');        
        pause(0.5);
        
        
        %end
        % get next viewpoint if threshold < 0.9
        failed = 0;
        [newImage previousViews wantViews count failed]= nextViewpoint(count, previousViews, poseEstimates, wantViews);
        
        if failed
            break;
        end
        frameCount = frameCount +1;
        %count = count +1 
     
 end   
 
    disp('frame count');
    disp(frameCount);
    % need to save the frame count for this try
    num_frames(m) = frameCount;
end

%file = 'battery.m';
