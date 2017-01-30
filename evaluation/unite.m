function x = unite(x, d)
% unite Aggregate nearby intervals
%
%   x = unite(x, d) modifies x so that intervals that their in-between gap is
%   less than d seconds are united into one. Matrix x contains intervals as
%   rows of the form [startTimestamp, stopTimestamp]; intervals of x must be
%   non-overlapping and sorted in ascending order.

for i = size(x, 1):-1:2
    if x(i, 1) - x(i - 1, 2) < d
        x(i - 1, 2) = x(i, 2);
        x(i, :) = [];
    end
end
