
% add the weighting for ach viewpoint for every object
objectNum = 20;
objectWeighting = zeros(1,18);
for m = 1:objectNum
  switch (m)
   case 1 
          objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\allBran\';
       
       case 2
            objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\battery\';        
       case 3
            objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\can1\';        
       case 4
          objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\can2\';
       
       case 5
           objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\curry1\';
       case 6
           objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\curry2\';
       case 7
         objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\elephant\';
       
       
        case 8
            objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\handbag\';
        case 9
            objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\jewelryBox1\';
        case 10
            objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\jewelryBox2\';        
        case 11
            objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\lemonBottle\';        
       
        case 12
           objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\mrMin\';
       
        case 13
         objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\salad\';
        case 14
         objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sauce1\';
        case 15       
           objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sauce2\';
        case 16
           objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice1\';
        case 17
            objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\spice2\';
      
        case 18
           objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan1\';
        case 19
           objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan2\';
        case 20
         objectDir = 'E:\PhDWork\code\vocab_tree_v5\vocab_tree\Deon''s code\Vocabtree2\Vocabtree2\Viewpoint_values_all\sprayCan\';
      
        
        
  end    
  files = ls([objectDir,'*.m'])

  for k = 1: 18
    filename1 = files(k,:);   
    newFilename = strcat(objectDir,filename1);
    data = load (newFilename);% this is the weighting of the viewpoint
    objectWeighting(k) = data + objectWeighting(k);
       
  end
end
[sortedObjects indices] = sort(objectWeighting,'descend');
save('sortedObjects','sortedObjects');
save('indices','indices');