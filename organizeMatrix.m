function arr=organizeMatrix( BW )
CC = bwconncomp(BW);

cell = cellfun(@numel,CC.PixelIdxList);
cellNum=numel(cell);

totalCellNum=0;
for i=1:cellNum
    totalCellNum=totalCellNum+cell(i);
end

arr = zeros(totalCellNum,1);
j=1;
for i=1:cellNum
    arr(j:(j+cell(i)-1),:) = CC.PixelIdxList{i};
    j=j+cell(i);
end

end

