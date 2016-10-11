cd hw1-snaqTimeTests/log/   #enter the right directory
echo analysis > analysis.csv   #create a csv for the first column
for filename in *.log
do
  echo ${filename%.log} >> analysis.csv    #delete the part ".log"
done
cd ..
mv log/analysis.csv .   #these two lines turn the csv file back to the directory hw1-snaqTimeTests

cd log/
echo h > h.csv   #create a csv for the second column
for filename in *.log
do
  a=$(grep "hmax = " $filename)    #find the target line
  b=$(echo ${a/,/})    #delete the part "," after the number
  echo ${b/hmax = /} >> h.csv    #delete the part "hmax = "
done
cd ..
mv log/h.csv .

cd out/
echo CPUtime > CPUtime.csv   #create a csv for the third column
for filename in *.out
do
  a=$(grep "Elapsed time" $filename)    #find the target line
  b=$(echo ${a/ Elapsed time: /})    #delete the part "Elapsed time:"
  echo ${b/seconds in 10 successful runs/} >> CPUtime.csv    #delete the part "seconds in 10 successful runs"
done
cd ..
mv out/CPUtime.csv .

paste -d, analysis.csv h.csv CPUtime.csv> combined.csv   #combine the three csv into a whole one.
cd ..
mv hw1-snaqTimeTests/combined.csv result
cd hw1-snaqTimeTests
rm -f analysis.csv
rm -f h.csv
rm -f CPUtime.csv
cd ..
