function mtr = getMetrics(tp, fp, tn, fn)
% getMetrics Get some metrics from a confusion matrix
%
%   mtr = getMetrics(tp, fp, tn, fn) returns a row vector
%   containing some metrics based on the confusion matrix defined
%   by the input arguments
%
%   met(1) : precision
%   met(2) : recall
%   met(3) : accuracy
%   met(4) : weighted accuracy (see parameters bellow)
%   met(5) : F-1 score

    % Parameters
    w = 6.9;

    % Calculations
    mtr(1) = tp / (tp + fp);
    mtr(2) = tp / (tp + fn);
    mtr(3) = (tp + tn) / (tp + fp + tn + fn);
    mtr(4) = (w * tp + tn) / (w * tp + fp + tn + w * fn);
    mtr(5) = 2 * tp / (2 * tp + fp + fn);
