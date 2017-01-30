function [tp, fp, tn, fn] = countDuration(actual, detected, duration)
% coutnDuration Confusion matrix for duration evaluation
%
%   [tp, fp, tn, fn] = countDuration(actual, detected, duration)

% Symbols
%   +1: actual snack starts
%   -1: actual snack ends
%   +2: detected snack starts
%   -2: detected snack ends

    n = size(actual, 1);
    m = size(detected, 1);

    t = [0; ...
         actual(:, 1); ...
         actual(:, 2); ...
         detected(:, 1); ...
         detected(:, 2); ...
         duration];
    d = [0; ...
         ones([n 1]); ...
         -ones([n 1]); ...
         2 * ones([m 1]); ...
         -2 * ones([m 1]); ...
         0];
    [t, idx] = sort(t);
    d = d(idx);
    x = cumsum(d);

    tp = 0;
    fp = 0;
    tn = 0;
    fn = 0;

    for i = 1:length(x) - 1
        dt = t(i + 1) - t(i);
        switch x(i)
          case 0
            tn = tn + dt;
          case 1
            fn = fn + dt;
          case 2
            fp = fp + dt;
          case 3
            tp = tp + dt;
          otherwise
            error('There is a bug')
        end
    end

end
