function mtr = evalEvent(metadata, detected)
% evalEvent Event-based evaluation
%
%   mtr = evalEvent(metadata, detected) evaluation based on
%   events. Variable 'detected' is a cell-array of equal length with
%   'metadata'. Each cell contains a two-column matrix. Each row of a
%   table corresponds to a detected snack and is of the form
%   [startTimestamp, stopTimestamp]. Detected snacks must be
%   non-overlapping and sorted (in ascending order).
%
%   It returns a row vector with the following metrics
%   met(1) : precision
%   met(2) : recall
%   met(3) : accuracy
%   met(4) : weighted accuracy (see parameters bellow)
%   met(5) : F-1 score

    for i = 1:length(metadata)

        % Setup input arguments
        actual = metadata(i).groundtruth.snacks;

        % Evaluate
        [tp(i), fp(i), tn(i), fn(i)] = matchSnacks(actual, detected{i})
        mtr(i, :) = getMetrics(tp, fp, tn, fn);

    end
    
    tp = sum(tp);
    fp = sum(fp);
    tn = sum(tn);
    fn = sum(fn);

    mtr = getMetrics(tp, fp, tn, fn);
