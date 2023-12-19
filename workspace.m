clear all;
close all;

I0 = imread("imagedata/train_0039.png");


I1 = imbinarize(I0);

figure; imshow(I1);

I2 = bwmorph(I1, "close", 1);
figure; imshow(I2);

I3 = medfilt2(I2, [5 5]);
figure; imshow(I3);




zeroTopLeft = [81, 83]';
zeroBotRight = [114, 129]';

zeroMask = I3(zeroTopLeft(2):zeroBotRight(2), zeroTopLeft(1):zeroBotRight(1));

oneTopLeft = [130, 85]';
oneBotRight = [158, 137]';

oneMask = I3(oneTopLeft(2):oneBotRight(2), oneTopLeft(1):oneBotRight(1));

twoTopLeft = [163, 82]';
twoBotRight = [197, 127]';
twoMask = I3(twoTopLeft(2):twoBotRight(2), twoTopLeft(1):twoBotRight(1));


figure; imshow(zeroMask);
figure; imshow(oneMask);
figure; imshow(twoMask);


zeroCorr = normxcorr2(zeroMask, I3);
oneCorr = normxcorr2(oneMask, I3);
twoCorr = normxcorr2(twoMask, I3);

zerosMax = max(zeroCorr);
onesMax = max(oneCorr);
twoMax = max(twoCorr);

maxes = [zerosMax, onesMax, twoMax];


%%
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
    end
    if indexes(nr) < length(zerosMax)
        nrs(nr) = 0;
    end
end

i

