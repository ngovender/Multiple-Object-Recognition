fileout
for i = 1:74
    i
    eval(sprintf('fileout%d', i));
end

save loadingVocab20