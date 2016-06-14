 

function [PO] = nextViewall(nextView,object)
load feature
objectNum = 28;


for hypoobject = 1: objectNum
    inputImage = getNewImage(hypoobject,nextView);
    [originalFeatures1 currentNum ] = matchDesc(hypoobject,inputImage,robotData);             
    disp('initial pose');
    disp(currentNum);
    if (currentNum ~= -1)
        poseEstimates(object,hypoobject) = currentNum % initial pose over all the objects
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
                    PO = (log(nodeCounts(nodes(jj), :))) + PO;
                    PO = PO - log(sum(exp(PO)));
                end
            end
            
        end
    end
    
    
    POs = [POs PO(object)];
    
end