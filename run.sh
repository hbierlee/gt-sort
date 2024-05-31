#!/usr/bin/env sh

seeds=$1
solver=chuffed

n=$2
ub=$3
f=$4

echo "n=$n;ub=$ub;f=$f"

rm -f std.*.out
for (( i = 1; i <= $seeds; i++ )); do
  echo "seed ${i}"
  minizinc gt-sort.mzn -r $i --solver $solver --output-time -D "n=$n;ub=$ub;f=$f;run=WORST" | tee >> std.$i.out
  minizinc gt-sort.mzn -r $i --solver $solver --output-time -D "n=$n;ub=$ub;f=$f;run=BASELINE" | tee >> std.$i.out
  minizinc gt-sort.mzn -r $i --solver $solver --output-time -D "n=$n;ub=$ub;f=$f;run=BEST" | tee >> std.$i.out
  grep "obj =" std.$i.out
done


