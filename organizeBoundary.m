function arr=organizeBoundary(BW)
B = bwboundaries(BW);

cell = cellfun(@length,B);
cellNum=numel(cell);

totalCellNum=0;
for i=1:cellNum
    totalCellNum=totalCellNum+cell(i);
end
 
arr = zeros(totalCellNum,2);
j=1;
for i=1:cellNum
    arr(j:(j+cell(i)-1),:) = B{i};
    j=j+cell(i);
end
    sort(arr);
end