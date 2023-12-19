function invalidClasifications = test(measuredNumbers)

    correctNumbers = readmatrix("labels.txt");
    invalidClasifications = [];

    for i = 1:size(measuredNumbers,1)
        if(correctNumbers(i,:) ~= measuredNumbers(i,:))
            invalidClasifications = [invalidClasifications, i];
        end
    end
end