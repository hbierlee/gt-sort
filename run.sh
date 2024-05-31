#!/usr/bin/env sh

seeds=$1
solver=chuffed # ! sometimes causes a bug with nosets.mzn for chuffed (I think if constraint is unsatisfiable)

n=$2
ub=$3
f=$4

echo "n=$n;ub=$ub;f=$f"

rm -f std.*.out
for (( i = 1; i <= $seeds; i++ )); do
  echo "seed ${i}"

  for run in WORST BASELINE BEST; do
    minizinc gt-sort.mzn -r $i --solver $solver --output-time -D "n=$n;ub=$ub;f=$f;run=$run" | tee >> std.$i.out
  done
  grep "obj =" std.$i.out
done


