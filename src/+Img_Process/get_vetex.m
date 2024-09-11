function vetex = get_vetex(mask)
    edgeMap = edge(mask);
    
    %计算二值图像标准霍夫变换,trans为霍夫变换矩阵
    [trans, theta, rho] = hough(edgeMap,'RhoResolution', 0.5,'Theta', -90:0.5:90-0.5);
    %获取霍夫变换峰值的行列坐标
    peaks  = houghpeaks(trans, 4,'Threshold', 0.05*max(trans(:)));
                        ...'Theta', -90:0.5:90-0.5);

    %识别边缘的线                    
    lines = [rho(peaks(:, 1))', pi/180*theta(peaks(:, 2))'];

    %计算出所有的交点
    linecnt = size(lines, 1);
    crossdots = zeros(((linecnt-1)*linecnt)/2, 2);
    count = 1;
    for i = 1:(linecnt - 1)
        for j = (i + 1):linecnt
            line1 = lines(i, :);
            line2 = lines(j, :);
            Mat = [cos(line1(2)), sin(line1(2));cos(line2(2)), sin(line2(2))];
            b = [line1(1);  line2(1)];
            intersection = (Mat\b)';
            if any(isinf(intersection))
                crossdots(count, :) = [NaN, NaN];
            else
                crossdots(count, :) = intersection;
            end    
            count = count + 1;
        end
    end

    %取出四个边缘点
    %去除正无穷，负数和距离中心过远的点
    nans = sum(isnan(crossdots), 2) > 0;
    negs = min(crossdots, [], 2) < 0;
    crossdots(negs | nans, :) = [];
    d = sqrt(sum((crossdots - median(crossdots)).^2, 2));
    med = median(d);
    far = d > 2*med;
    crossdots(far, :) = [];

    %对剩下的边缘点按照角度排序
    middots = mean(crossdots);
    selected = crossdots - middots;
    angles = atan2(selected(:,2), selected(:,1)) + (selected(:,1) < 0).*pi;
    [~, idx] = sort(angles);
    vetex = crossdots(idx, :);
    

end