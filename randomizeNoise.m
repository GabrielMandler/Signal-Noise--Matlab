function BW=randomizeNoise(BW,noiseArea,imageSize,blockArr,blockArrSize)
    [rowsBlock,colsBlock]=ind2sub(imageSize,blockArr);
    maxHeight = max(rowsBlock);
    minHeight = min(rowsBlock);
    maxWidth = max(colsBlock);
    minWidth = min(colsBlock);
    height=maxHeight-minHeight;
    width=maxWidth-minWidth;
    maxHW=max([height width]);

    noiseNum=numel(noiseArea-maxHW);
    [rowsNoise,colsNoise]=ind2sub(imageSize,noiseArea);

    flag=0;
    while flag~=2
        flag=0;
        randomNumber=randi(noiseNum-blockArrSize);

        currentRow=rowsNoise(randomNumber);
        currentCol=colsNoise(randomNumber);
        currentRowEnd=rowsNoise(randomNumber+blockArrSize);
        currentColEnd=colsNoise(randomNumber+blockArrSize);

        if abs(currentRow-currentRowEnd)==height||abs(currentCol-currentColEnd)==width
            for i=0:height-1
                for j=0:width-1    
                    if BW(rowsNoise(randomNumber+i),colsNoise(randomNumber+j))==1 
                        flag=1;
                        break;
                    end
                end
                if flag==1
                    break;
                elseif i==height-1
                    flag=2; 
                end
            end
        end
    end

    for i=1:blockArrSize-1
        if rowsBlock(i)>rowsNoise(randomNumber+i-1)
            rowsBlock(i)=rowsBlock(i)-rowsNoise(randomNumber+i-1);
        elseif rowsBlock(i)<rowsNoise(randomNumber+i-1)
            rowsBlock(i)=rowsBlock(i)+rowsNoise(randomNumber+i-1);
        end
        for j=1:blockArrSize-1    
            if colsBlock(j)>colsNoise(randomNumber+j-1)
                colsBlock(j)=colsBlock(j)-colsNoise(randomNumber+j-1);
            elseif rowsBlock(j)<colsNoise(randomNumber+j-1)
                colsBlock(j)=colsBlock(j)+colsNoise(randomNumber+j-1);
            end
                BW(rowsBlock(i),colsBlock(j))=1;
        end
    end 
    