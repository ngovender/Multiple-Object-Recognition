% Write the SIFT feature descriptors out to a binary file
function [] = SIFT2Text(features)

%disp(size(features));

for idx = 1:size(features,2)
    fprintf(['Creating feature file for image ' num2str(idx) ' of ' num2str(size(features)), ' ... ']);
    
    fileName = sprintf('%05u', idx);
    fileName1 = ['E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Feature Files\' fileName '.dat']
    %write the frames values to 
    fileName2 = ['E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Feature Files\' fileName '.da2']
    fd = fopen(fileName1, 'wb');
    fd1 = fopen(fileName2,'wb');
    N = size(features(idx).descriptors, 2)
    fwrite(fd, uint16(N), 'uint16');
    for fid = 1:N
        fwrite(fd, features(idx).descriptors(:,fid), 'uint8');
    end
    
    % frames are equivalent to the number of matches
    for fid = 1:size((features(idx).frames),2)
      fwrite(fd1, features(idx).frames(:,fid), 'float64');
    end
    fclose(fd);
    fclose(fd1);
    
    fprintf('DONE!\n');
    
   
    
end


