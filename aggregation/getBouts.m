function bouts = getBouts(chews)
% getBouts Aggregate audio detections into chewing bouts
%
%   bouts = getBouts(chews) performs the aggregation on chews, as detected from
%   audio. Both chews and bouts are matrices whos rows are time intervals of
%   the form [startTimestamp, stopTimestamp]. Intervals of chews must be
%   non-overlapping and sorted in ascending order.
    
maxDist = 2; % seconds
minDur = 5; % seconds

if isempty(chews)
    bouts = [];
    return
end

bouts = unite(chews, maxDist);

durs = bouts(:, 2) - bouts(:, 1);
bouts(durs < minDur, :) = [];
