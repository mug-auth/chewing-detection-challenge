function [tp, fp, tn, fn] = matchSnacks(actual, detected)
% evalSnacks Confusion matrix for snacking evaluation
%
%   [tp, fp, tn, fn] = evalSnacks2(actual, detected) performs an evaluation

    % Parameter setup
    overlapPerc = 0.75;

    if isempty(actual) && isempty(detected)
        % Dummy case
        tp = 0;
        fp = 0;
        tn = 0;
        fn = 0;
        return
    end

    if isempty(actual)
        % No-positives set, so assign all as false-positives and return
        tp = 0;
        fp = size(detected, 1);
        tn = 0;
        fn = 0;
        return
    end

    if isempty(detected)
        % No detections, so assign all as false-negatives and return
        tp = 0;
        fp = 0;
        tn = 0;
        fn = size(actual, 1);
        return
    end

    n = size(actual, 1);
    m = size(detected, 1);

    % Overlap ratio matrix
    p = zeros(n, m);
    for i = 1:n
        for j = 1:m
            p(i, j) = overlaprat(actual(i, :), detected(j, :));
        end
    end

    map = zeros(0, 2);

    while true
        [~, idx] = max(p(:));
        [i, j] = ind2sub(size(p), idx);
        % [i, j] = maxMat(p);
        
        b1 = sum(i == map(:, 1)) > 0;
        b2 = sum(j == map(:, 2)) > 0;
        b3 = p(i, j) <= overlapPerc;
        if b1 || b2 || b3
            break
        end
        
        map = [map; i j];
        p(i, :) = -Inf;
        p(:, j) = -Inf;
    end

    tp = size(map, 1);
    fn = n - tp;
    fp = m - tp;
    tn = 0;
end

function r = overlaprat(x, y)
% overlaprat Overlap ratio
%
%   r = overlaprat(x, y) returns the overlap ratio r for two intervals x and
%   y if the overlap, zero if the don't. Intervals x and y are each a vector
%   of the form [startTimestamp, stopTimestamp]. The overlap ratio is the
%   overalping duration divided by the duration of the union of x and y.

    t1 = max([x(1) y(1)]);
    t2 = min([x(2) y(2)]);
    r1 = t2 - t1;

    if r1 < 0
        r = 0;
        return
    end

    t1 = min([x(1) y(1)]);
    t2 = max([x(2) y(2)]);
    r2 = t2 - t1;
    
    r = r1 / r2;
end
