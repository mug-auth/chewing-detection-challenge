# Chewing detection challenge

This repository contains MATLAB code for post-processing and
evaluation of chewing/eating detection algorithms, for the chewing
detection dataset of [link coming soon]().

## 1 Aggregation functions

Two aggregation functions are provided in `getBouts.m` and
`getSnacks.m`. The first, `getBouts`, aggregates the audio-based
chewing detections (that correspond to individual chews in [1]) into
chewing bouts. The second function, `getSnacks`, aggregates these
chewing bouts into eating-events/snacks. It also aggregates the
chewing detections of PPG (which correspond directly to chewing bouts
in [1]) into eating-events/snacks.

## 2 Evaluation functions

Three evaluation functions are provided, correspoding to the three
evaluation tables of [2]. Each function computes the same five metrics
also presented in [2]: precision, recall, accuracy, weighted accuracy,
and F1-score. Weighted accuracy is computed using a weight of 6.9, but
this can be configured in `getMetrics.m`.

The first function, `evalDurationAverage`, computes these metrics for
each participant, based on duration. In particular, it creates a
confusion matrix for each participant (by summing the confusion
matrices of all sessions of that participant). These confusion
matrices units are seconds. The five metrics are computed for each
participant, and then are averaged across the participants.

The second function, `evalDurationCumulative`, works similarly to
`evalDurationLoso`, however it sums all confusion matrices into a
single one, and then computes the metrics.

Finally, the `evalEvents` function uses the matching method presented
in [1], also creating a single confusion matrix.

## 3 References

[1] V. Papapanagiotou, C. Diou, L. Zhou, J. van den Boer, M. Mars and A. Delopoulos, "The SPLENDID chewing detection challenge," 2017 39th Annual International Conference of the IEEE Engineering in Medicine and Biology Society (EMBC), Jeju Island, South Korea, 2017, pp. 817-820.
doi: 10.1109/EMBC.2017.8036949
URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8036949&isnumber=8036736

[2] V. Papapanagiotou, C. Diou, L. Zhou, J. van den Boer, M. Mars and A. Delopoulos, "A Novel Chewing Detection System Based on PPG, Audio, and Accelerometry," in IEEE Journal of Biomedical and Health Informatics, vol. 21, no. 3, pp. 607-618, May 2017.
doi: 10.1109/JBHI.2016.2625271
URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7736096&isnumber=7920455
