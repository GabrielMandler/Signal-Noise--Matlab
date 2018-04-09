function [noisePoints,BW]=insertNoise(BW,BWbeforeNoise,blockSize,noisePoints,noiseNum,signalNum,rowsNoise,colsNoise,rowsSignal,colsSignal)

    for k=1:noisePoints
        rowB=-1;
        colB=-1;
        rowN=-1;
        colN=-1;
        %get a block from the signal
        while rowB<=0 || colB<=0
            randomIdx = randi(signalNum);
            blockHeight=0;
            while blockHeight<20
               blockHeight = randi(blockSize); 
            end
            blockWidth=0;
            while blockWidth<20
               blockWidth = randi(blockSize); 
            end
            row=rowsSignal(randomIdx);
            col=colsSignal(randomIdx);
            rowB=row-blockHeight;
            colB=col-blockWidth;
        end
        %find a block in the noise area
        while rowN<=0 || colN<=0
            randomIdx = randi(noiseNum);
            row=rowsNoise(randomIdx);
            col=colsNoise(randomIdx);
            if row-blockHeight>0 && col-blockWidth>0      
                rowN=row-blockHeight;
                colN=col-blockWidth;
            end
        end

        %insert the block in the noise area
       for i=0:blockHeight
            for j=0:blockWidth
                if BWbeforeNoise(rowB+i,colB+j)==1 && BW(rowN+i,colN+j)==0
                    if noisePoints<0
                        break;
                    end
                    noisePoints=noisePoints-1;
                    BW(rowN+i,colN+j)=1;
                end
            end
            if noisePoints<0
                break;
            end
       end
    end
end