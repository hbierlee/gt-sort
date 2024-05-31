# Finding the optimal sorting order for Generalized Totalizers

MiniZinc with chuffed should be on the user's PATH.

To run, `./run.sh $seed $n $ub $f`, e.g.:

```
chmod +x ./run.sh
./run.sh 5 5 20 0.7
```

Solves the worst, baseline (sort by coefficients in descending order) and best GT sorting order for 5 generated instance of `n=5` variables with coefficients [1,ub=20] and `k` is chosen based on strictness factor `f=0.7`

Outputs:

```
n=5;ub=20;f=0.7
seed 1
obj = 61;
obj = 59;
obj = 55;
seed 2
obj = 61;
obj = 55;
obj = 52;
seed 3
obj = 56;
obj = 51;
obj = 48;
seed 4
obj = 54;
obj = 53;
obj = 47;
seed 5
obj = 58;
obj = 53;
obj = 49;
```

In `./std.1.out` we can see the resulting GT's for the first instance:

```
run = WORST;
n = 5;
ub = 20;
c = [1, 3, 16, 10, 11, 0];
f = 0.7;
u = 41;
k = 29;
x = 
[|                                                          {0,16}, {0,11},      {0,10}, {0,3}, 0..1, 0..0
 |                                                     {0,1,16,17}, {0,11}, {0,3,10,13},  0..0,   {},   {}
 |                      {0,1,3,4,10,11,13,14,16,17,19,20,26,27,29}, {0,11},          {},    {},   {},   {}
 | {0,1,3,4,10,11,12,13,14,15,16,17,19,20,21,22,24,25,26,27,28,29},     {},          {},    {},   {},   {}
 |];
obj = 61;
'y@42.5-55|i=1@36.19|forall@36.12-65.2' = 
[| 1, 5
 | 2, 6
 | 3, 4
 |];
'y@42.5-55|i=2@36.19|forall@36.12-65.2' = 
[| 1, 3
 | 2, 4
 |];
'y@42.5-55|i=3@36.19|forall@36.12-65.2' = 
[| 1, 2
 |];
% time elapsed: 4.13 s
----------
==========
% time elapsed: 4.13 s
% [X_INTRODUCED_1644_ > -62]
run = BASELINE;
n = 5;
ub = 20;
c = [1, 3, 16, 10, 11, 0];
f = 0.7;
u = 41;
k = 29;
x = 
[|                                                          {0,16},      {0,11}, {0,10}, {0,3}, 0..1, 0..0
 |                                                    {0,11,16,27}, {0,3,10,13},   0..1,  0..0,   {},   {}
 |                          {0,3,10,11,13,14,16,19,21,24,26,27,29},        0..1,     {},    {},   {},   {}
 | {0,1,3,4,10,11,12,13,14,15,16,17,19,20,21,22,24,25,26,27,28,29},          {},     {},    {},   {},   {}
 |];
obj = 59;
'y@42.5-55|i=1@36.19|forall@36.12-65.2' = 
[| 1, 2
 | 3, 4
 | 5, 6
 |];
'y@42.5-55|i=2@36.19|forall@36.12-65.2' = 
[| 1, 2
 | 3, 4
 |];
'y@42.5-55|i=3@36.19|forall@36.12-65.2' = 
[| 1, 2
 |];
% time elapsed: 2.39 s
----------
==========
% time elapsed: 2.39 s
% [obj > 58]
run = BEST;
n = 5;
ub = 20;
c = [1, 3, 16, 10, 11, 0];
f = 0.7;
u = 41;
k = 29;
x = 
[|                                                          {0,16},               {0,11},      {0,10}, {0,3}, 0..1, 0..0
 |                                                     {0,3,16,19},               {0,11}, {0,1,10,11},  0..0,   {},   {}
 |                                                     {0,3,16,19}, {0,1,10,11,12,21,22},          {},    {},   {},   {}
 | {0,1,3,4,10,11,12,13,14,15,16,17,19,20,21,22,24,25,26,27,28,29},                   {},          {},    {},   {},   {}
 |];
obj = 55;
'y@42.5-55|i=1@36.19|forall@36.12-65.2' = 
[| 1, 4
 | 2, 6
 | 3, 5
 |];
'y@42.5-55|i=2@36.19|forall@36.12-65.2' = 
[| 1, 4
 | 2, 3
 |];
'y@42.5-55|i=3@36.19|forall@36.12-65.2' = 
[| 1, 2
 |];
% time elapsed: 3.93 s
----------
==========
% time elapsed: 3.93 s
% [obj > 54]
```
