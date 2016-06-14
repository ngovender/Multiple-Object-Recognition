totals = zeros(1, size(nodeCounts, 2));

for i=1:size(nodeCounts, 1)
    [a j] = max(nodeCounts(i, :));
    
    totals(j) = totals(j) + 1;
end