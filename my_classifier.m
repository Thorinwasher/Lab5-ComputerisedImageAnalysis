function S = my_classifier(im, parameters)
%This classifier is not state of the art... but should give you an idea of
%the format we expect to make it easy to keep track of your scores. Input
%is the image and different parameters. Output is a 1 x 3 vector of the 
%three numbers in the image
%
%This baseline classifier tries to guess... so should score about (3^3)^-1
%on average, approx. a 4% chance of guessing the correct answer. 
%

I1 = imbinarize(im);
I2 = bwmorph(I1, "close", 1);
I3 = medfilt2(I2, [5 5]);
S = template_matching(I3, parameters);

end

