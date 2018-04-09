function BW=removeSignal(BW,signalPoints,signalNum,blockSize_signal,rowsSignal,colsSignal)
   while signalPoints > 0
            rowB=-1;
            colB=-1;
            %get a block from the signal
            while rowB<=0 || colB<=0
                randomIdx = randi(signalNum);
                blockHeight=0;
                while blockHeight<20
                   blockHeight = randi(blockSize_signal); 
                end
                blockWidth=0;
                while blockWidth<20
                   blockWidth = randi(blockSize_signal); 
                end
                row=rowsSignal(randomIdx);
                col=colsSignal(randomIdx);
                rowB=row-blockHeight;
                colB=col-blockWidth;
            end
           %delete the block
           for i=0:blockHeight
                for j=0:blockWidth
                    if BW(rowB+i,colB+j)==1
                        if signalPoints<0
                            break;
                        end
                        signalPoints=signalPoints-1;
                        BW(rowB+i,colB+j)=0;
                    end
                end
                if signalPoints<0
                    break;
                end
           end
   end
end