function sorted_nrs = template_matching(Im, parameters)
    
zeroCorr = normxcorr2(parameters{1}, Im);
    oneCorr = normxcorr2(parameters{2}, Im);
    twoCorr = normxcorr2(parameters{3}, Im);
    
    zerosMax = max(zeroCorr);
    onesMax = max(oneCorr);
    twoMax = max(twoCorr);
    
    maxes = [zerosMax, onesMax, twoMax];
    
    topCount = 3;
    indexes = zeros(topCount,1);
    values = zeros(topCount,1);
    
    step = 20;
    step_small = 2;
    
    lMax = length(maxes);
    p = 1;
    while p <= lMax
        pVal = maxes(p);
        if pVal > values(3)
            if pVal > values(2)
                if pVal > values(1)
                    values(3) = values(2);
                    values(2) = values(1);
                    values(1) = pVal;
                    indexes(3) = indexes(2);
                    indexes(2) = indexes(1);
                    indexes(1) = p;
                    
                    p = p + step;
                else
                    values(3) = values(2);
                    values(2) = pVal;
                    indexes(3) = indexes(2);
                    indexes(2) = p;
    
                    p = p + step;
                end
            else
                values(3) = pVal;
                indexes(3) = p;
    
                p = p + step;
            end
        end
        p = p + step_small;
    end
    
    
    nrs = zeros(3,1);
    index_scaled = zeros(3,1);
    
    for nr=1:length(nrs)
        if indexes(nr) < length(zerosMax) + length(onesMax) + length(twoMax)
            nrs(nr) = 2;
            index_scaled(nr) = indexes(nr) - length(zerosMax) - length(onesMax);
        end
        if indexes(nr) < length(zerosMax) + length(onesMax)
            nrs(nr) = 1;
            index_scaled(nr) = indexes(nr) - length(zerosMax);
        end
        if indexes(nr) < length(zerosMax)
            nrs(nr) = 0;
            index_scaled(nr) = indexes(nr);
        end
    end
    
    sorted_nrs = zeros(3,1);
    
    [B, Ind] = sort(index_scaled);
    
    sorted_nrs(1) = nrs(Ind(1));
    sorted_nrs(2) = nrs(Ind(2));
    sorted_nrs(3) = nrs(Ind(3));
end

