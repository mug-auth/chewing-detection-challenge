function mtr = evalDurationLoso(metadata, detected)
% evalDurationLoso Duration-based LOSO evaluation
%
%   mtr = evalDurationLoso(metadata, detected) performs LOSO
%   evaluation based on duration. Variable 'detected' is a cell-array
%   of equal length with 'metadata'. Each cell contains a two-column
%   matrix. Each row of a table corresponds to a detected snack and
%   is of the form [startTimestamp, stopTimestamp]. Detected snacks
%   must be non-overlapping and sorted (in ascending order).
%
%   It returns a row vector with the following metrics
%   met(1) : precision
%   met(2) : recall
%   met(3) : accuracy
%   met(4) : weighted accuracy (see parameters bellow)
%   met(5) : F-1 score

    % Initialize participant confusion matrices
    ids = unique([metadata.ParticipantID]);
    cm(length(ids)) = struct('tp', 0, 'fp', 0, 'tn', 0, 'fn', 0);
    
    for i = 1:length(metadata)

        % Setup input arguments
        actual = metadata(i).groundtruth.snacks;
        duration = metadata(i).auddur;

        % Evaluate
        [tp, fp, tn, fn] = countDuration(actual, detected{i}, duration);

        % Update confusion matrix of participant
        idx = find(ids == metadata(i).ParticipantID);
        cm(idx).tp = cm(idx).tp + tp;
        cm(idx).fp = cm(idx).fp + fp;
        cm(idx).tn = cm(idx).tn + tn;
        cm(idx).fn = cm(idx).fn + fn;

    end

    % Computer metrics per participant
    for i = 1:length(cm)
        mtr(i, :) = getMetrics(cm(idx).tp, cm(idx).fp, cm(idx).tn, cm(idx).fn);
    end

    % Get average
    mtr = mean(mtr, 1);
