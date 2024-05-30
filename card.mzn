include "globals.mzn";

enum Run = { BASELINE, BEST, WORST};

Run: run::output;

% BASELINE = false;

% 2*x1 + 3*x2 + 2*x3 + 5*x4 <= k
% array[int] of set of int: s = [{0,2},{0,3},{0,2},{0,5}];

% generate instance of n variables with coefficients [1,ub]
int: n;
int: ub;

array[int] of int: c::output = reverse(sort([ uniform(1,ub) | i in 1..n ]));
array[int] of set of int: s = [ {0, ci} | ci in c ];

int: u::output = sum([ max(si) | si in s]);
int: k::output = round(0.5 * u);

% number of layers
set of int: L = 1..(floor(1+log2(max(index_set(s)))));

% x[i,j] = values of node j at layer i
array[L,index_set(s)] of var set of min(si in s, a in si)(a)..k: x;

constraint x[1,..] = s; % first layer is fixed

constraint forall(i in L diff {max(L)})( % for layer i, constrain parents in layer i+1
  let {
    int: pairs = 2^(max(L) -1 -i);

    % y[j,1] is the index of the left child of parent node (i+1,j)
    array[1..pairs,1..2] of var 1..(2*pairs): y::output;
    constraint alldifferent(y);
    constraint if run = BASELINE then y = array2d(1..pairs, 1..2, [ z | z in 1..(pairs*2) ]) endif ;
  } in
  forall(j in index_set(s))(
  if j <= pairs then % pair j
    let {
      var int: ja = y[j,1];
      var int: jb = y[j,2];
      constraint ja < jb; % symmetry

      var set of int: a = x[i,ja];
      var set of int: b = x[i,jb];
    } in
      % parent contains the all possible sums of child nodes
    (x[i+1,j] = { ai + bi | ai in a, bi in b where ai+bi <= k })
    % alternative which performs way worse: (x[i+1,j] = { min(ai + bi, k+1) | ai in a, bi in b })
  else % unused nodes are fixed to empty
    x[i+1,j] = {}
  endif
));

% minimize sum of values in all nodes (includes first layer)
var int: obj ::output =  sum(xi in x)(card(xi));
solve minimize if run = WORST then -obj else obj endif;
