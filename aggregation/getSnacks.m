function snacks = getSnacks(bouts)
% getSnacks Aggregate (PPG) bouts into eating events
%
%   snacks = getSnacks(boots) performs the aggregation on chewing bouts, as
%   detect from PPG, or as produced from getBouts of audio-based
%   detection. Matrices bouts and snacks contain both rows of the form
%   [startTimestamp, stopTimestamp].

% Parameter setup
% Maximum in-snack bout gap
maxDist = 60; % seconds
% Minimum snack duration
minDur = 30; % seconds
% Magic parameter Q
Q = 0.75;

% Main part
snacks = unite(bouts, maxDist);
if isempty(snacks)
    return
end

durs = snacks(:, 2) - snacks(:, 1);
snacks(durs < minDur, :) = [];

del = false(size(snacks, 1), 1);
for i = 1:size(snacks, 1)
    b = snacks(i, 1) <= bouts(:, 1) & bouts(:, 2) <= snacks(i, 2);
    durb = sum(bouts(b, 2) - bouts(b, 1));
    durs = snacks(i, 2) - snacks(i, 1);

    if durb / durs < Q
        del(i) = true;
    end
end

snacks(del, :)=[];
