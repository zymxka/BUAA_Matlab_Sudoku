function fimg = projection(bw, vetex, tarsiz)
%PROJECTION 此处显示有关此函数的摘要
%   此处显示详细说明
    
    siz = size(bw);
    bwSiz = [0,0; siz(1),0; siz(1), siz(2); 0,siz(2)];
    af = fitgeotrans(bwSiz, vetex, 'projective');
    fimg = imwarp(bw, af,'Interpolation', 'cubic','OutputView', imref2d(tarsiz));

end

