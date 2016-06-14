
close all

% Load all the data
load robotDataNew;
%load dataset1.mat;
load nodeCounts;
load loadingVocab20;



% Constants
%c = ['y' 'c' 'b' 'r' 'k' 'm'];
num_frames=[];
plotall = 0;
depth = 6;
numViews = 4;
objectNum = 20;
startFrame = 1;

results =[];

confmat = [];

for object = 1:1%objectNum
    object;
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
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\Curry1\\segmented\\00001.bmp';
        case 6
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\Curry2\\segmented\\00001.bmp';
        case 7
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\Elephant\\segmented\\00001.bmp';
       
        case 8
            inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\handbag3\\segmented\\00001.bmp';
        
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
           inputImage ='E:\\PhDWork\\Datasets\\NewOccluded\\spice2\\segmented\\00001.bmp';
       
        case 18
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\sprayCan1\\segmented\\00001.bmp';
        case 19
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\sprayCan2\\segmented\\00001.bmp';
        case 20
           inputImage = 'E:\\PhDWork\\Datasets\\NewOccluded\\sprayCan\\segmented\\00001.bmp';
       
    
    end    
    
    POs = [];
    disp('object');
    disp(object);
    for hypoobject = 1:objectNum
        disp('hypo object');
        disp(hypoobject);
        %startFrame = startFrame +1;
       % inputImage = sprintf('D:\\PhDWork\\Datasets\\occlusions\\Full_Battery\\segmented\\%0.5u.bmp', startFrame);
        % Previously visited views, used to eliminate repeats
        previousViews =startFrame;
        poseEstimates = [];
        frameCount = 1;
        wantViews = [];
        %for kkk = 1:1 % object we are looking for

        % Unbiased prior
        PO = log(ones(1, objectNum) /objectNum);   

        count = 1;
        viewNumber = 1;
        % Continue until we are certain/uncertain.
      while ((viewNumber<=18) && (exp(PO(hypoobject)) <0.8))
      %for k = 1:numViews
            
            % want to match the input image to all training images of that
            % object
            if (count==1)
                [originalFeatures1 currentNum ] = matchDesc4(hypoobject,inputImage,robotDataNew);             
                disp('current angle is');
                disp(currentNum);
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

                [originalFeatures1] = matchDesc2(hypoobject,newImage,robotDataNew,nextView);
                % disp('current angle is');
                 %disp(currentNum);
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

            if (currentNum ~= -1)

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
                num = size(originalFeatures1,2);
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

                       
                    end

                    if (length(nodes) == depth)        
                        for jj=depth:depth
                            %disp(log(nodeCounts(nodes(jj), :)));
                            PO = (log(nodeCounts(nodes(jj), :))) + PO;            
                            PO = PO - log(sum(exp(PO)));                    
                        end

                      
                    end
   
                end

          
            end

            %end
            % get next viewpoint if threshold < 0.9
            failed = 0;
            if (viewNumber<18)
                [newImage previousViews wantViews count failed nextView]= nextViewConf_20(count, previousViews, wantViews, hypoobject, object);
            end
                                                                                            
            if failed
                break;
            end
            %frameCount = frameCount +1;

            %count = count +1 
             viewNumber = viewNumber +1 % keep a track of the number of view needed for each object
      end   
        
        objectViews(object,hypoobject) = viewNumber-1;
        POs = [POs PO(object)];
       
        %disp('frame count');
        %disp(frameCount);
        % need to save the frame count for this try
        %num_frames(m) = frameCount;
    end
    
    confmat = [confmat; POs];    
end

%file = 'battery.m';









