#!/usr/bin/env sh

seeds=10
solver=chuffed

n=12
ub=10

echo "n=$n;ub=$ub"

rm -f std.*.out
for (( i = 1; i <= $seeds; i++ )); do
  echo "seed ${i}"
  minizinc card.mzn -r $i --solver $solver --output-time -D "n=$n;ub=$ub;run=WORST" | tee >> std.$i.out
  minizinc card.mzn -r $i --solver $solver --output-time -D "n=$n;ub=$ub;run=BASELINE" | tee >> std.$i.out
  minizinc card.mzn -r $i --solver $solver --output-time -D "n=$n;ub=$ub;run=BEST" | tee >> std.$i.out
  grep "obj =" std.$i.out
done


