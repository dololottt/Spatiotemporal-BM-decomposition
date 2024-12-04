%% convert to 0-255 pixel range
function img = covt(X)
    img = uint8(255 * mat2gray(X));
end