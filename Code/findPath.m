function nodes = findPath(desc, ids, nodeCentres, children_ids)

curnode = 1;
des1 = nodeCentres{curnode}(:,:)  % the descriptors of the node centres

nodes = [curnode];

done = 0;
while (~done)      
    dists = zeros(size(des1, 1), 1);
    for i=1:size(des1, 1)
        dists(i) = norm(double(des1(i, :)) - double(desc));
    end
    
    [y i] = min(dists);
    
    newid = children_ids{curnode}(i);
    
    [f i] = find(newid == ids);
    
    curnode = i;
    nodes = [nodes; curnode];
    
    if (isempty(i))
        done = 1;
    end
end
    
    
    
    


