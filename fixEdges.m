function BW=fixEdges(BW,dots,arrSignal,noiseAdded)
    for k=1:dots
        dots=k;
        for i=1:length(arrSignal)
            x=arrSignal(i,1);
            y=arrSignal(i,2);
            if ~(ismember([x y+dots],arrSignal, 'rows')) && BW(x,y+dots)==1
                BW(x,y+dots)=0;
                noiseAdded=noiseAdded-1;
            end
            if ~(ismember([x y-dots],arrSignal, 'rows')) && BW(x,y-dots)==1
                BW(x,y-dots)=0;
                noiseAdded=noiseAdded-1;
            end
            if ~(ismember([x+dots y],arrSignal, 'rows')) && BW(x+dots,y)==1
                BW(x+dots,y)=0;
                noiseAdded=noiseAdded-1;
            end
            if ~(ismember([x-dots y],arrSignal, 'rows')) && BW(x-dots,y)==1
                BW(x-dots,y)=0;
                noiseAdded=noiseAdded-1;
            end
        end
    end
end