function mtr = evalDurationCumulative(metadata, detected)
% evalDurationLoso Duration-based cumulative evaluation
%
%   mtr = evalDurationCumulative(metadata, detected) performs
%   cumulative evaluation based on duration. Variable 'detected' is a
%   cell-array of equal length with 'metadata'. Each cell contains a
%   two-column matrix. Each row of a table corresponds to a detected
%   snack and is of the form [startTimestamp, stopTimestamp]. Detected
%   snacks must be non-overlapping and sorted (in ascending order).
%
%   It returns a row vector with the following metrics
%   met(1) : precision
%   met(2) : recall
%   met(3) : accuracy
%   met(4) : weighted accuracy (see parameters bellow)
%   met(5) : F-1 score

    % Initialize cumulative confusion matrices
    ids = unique([metadata.ParticipantID]);
    ctp = 0;
    cfp = 0;
    ctn = 0;
    cfn = 0;
    
    for i = 1:length(metadata)

        % Setup input arguments
        actual = metadata(i).groundtruth.snacks;
        duration = metadata(i).auddur;

        % Evaluate
        [tp, fp, tn, fn] = countDuration(actual, detected{i}, duration);

        % Update cumulative confusion matrix
        ctp = ctp + tp;
        cfp = cfp + fp;
        ctn = ctn + tn;
        cfn = cfn + fn;

    end

    mtr = getMetrics(ctp, cfp, ctn, cfn);
