#cd hw1-snaqTimeTests/log/   #enter the right directory
#echo analysis > analysis.csv   #create a csv for the first column
#for filename in *.log
#do
#  echo ${filename%.log} >> analysis.csv    #delete the part ".log"
#done
#cd ..
#mv log/analysis.csv .   #these two lines turn the csv file back to the directory hw1-snaqTimeTests

#cd log/
#echo h > h.csv   #create a csv for the second column
#for filename in *.log
#do
#  a=$(grep "hmax = " $filename)    #find the target line
#  b=$(echo ${a/,/})    #delete the part "," after the number
#  echo ${b/hmax = /} >> h.csv    #delete the part "hmax = "
#done
#cd ..
#mv log/h.csv .

#cd out/
#echo CPUtime > CPUtime.csv   #create a csv for the third column
#for filename in *.out
#do
#  a=$(grep "Elapsed time" $filename)    #find the target line
#  b=$(echo ${a/ Elapsed time: /})    #delete the part "Elapsed time:"
#  echo ${b/seconds in 10 successful runs/} >> CPUtime.csv    #delete the part "seconds in 10 successful runs"
#done
#cd ..
#mv out/CPUtime.csv .

#paste -d, analysis.csv h.csv CPUtime.csv> combined.csv   #combine the three csv into a whole one.
#cd ..
#mv hw1-snaqTimeTests/combined.csv result
#cd hw1-snaqTimeTests
#rm -f analysis.csv
#rm -f h.csv
#rm -f CPUtime.csv
#cd ..

cd hw1-snaqTimeTests/

echo analysis, h > 1.csv
for filename in log/*.log
do
    analysis=`basename -s ".log" "log/$filename"` #command basename to find the filename and delete the suffix at the same time.
    h=`grep hmax $filename | head -n 1 | cut -f 4 -d ' '| cut -f 1 -d ","` #find the target line first, and then find the exact number with ",", at last delete",".
    echo $analysis, $h >> 1.csv #return what we get to 1.csv file.
done


echo CPUtime > 2.csv
for filename in out/*.out
do
    CPUtime=`grep Elapsed ${filename} | cut -f 4 -d ' '` #find the target line first and the use cut to find the exact number.
    echo $CPUtime >> 2.csv #return what we get to 2.csv file.
done


echo Nruns, Nfail, fabs, frel, xabs, xrel, seed, under3460, under3450, under3440 > 3.csv
for filename in log/*.log
do
    Nruns=`grep runs $filename | cut -f 2 -d ':'|sed -E "s/([0-9]+) run.*/\1/"` #find the target line with "runs" first, then cut the target part and lastly use sed to find the number before run.*.
    Nfail=`grep "max number of failed proposals" $filename | sed -E 's/.*= ([0-9]+),.*/\1/'` #find the target part and then use sed to find the number at the middle.
    fabs=`grep ftolAbs $filename | sed -E "s/.*Abs=([0-9]\.[0-9]+.*),/\1/"` #find the target part and then use sed to find the number after "Abs=".
    frel=`grep ftolRel $filename | sed -E "s/.*Rel=([0-9]\.[0-9]+.*), ftol.*/\1/"` #find the target part and then use sed to find the number after "Rel=".
    xabs=`grep xtolAbs $filename | sed -E "s/.*Abs=([0-9]\.[0-9]+),.*/\1/"` #find the target part with critical word "xtolAbs" first and then use sed to find the number after "Abs=".
    xrel=`grep xtolRel $filename | sed -E "s/.*Rel=([0-9]\.[0-9]+)./\1/"` #find the target part with critical word "xtolRel" first and then use sed to find the number after "Rel=".
    seed=`grep seed $filename | head -n 1 | sed -E "s/.*seed ([0-9]+)/\1/"` #find the target part first, then choose the first line, at last find the number after "seed ".
    loglik=`grep "loglik of best" $filename | sed -E "s/.*best ([0-9]+).*/\1/"` #find the target part first, then find the integer after "best ".
    i1=0 #set the initial value
    i2=0 #set the initial value
    i3=0 #set the initial value
    for value in $loglik
    do
	if [ $value -le 3460 ]
	then
	    i1=$((i1+1)) #compare the value with 3460, if value < 3460, we add one to i1.
	fi

	if [ $value -le 3450 ]
	then
	    i2=$((i2+1)) #compare the value with 3450, if value < 3450, we add one to i2.
	fi

	if [ $value -le 3440 ]
	then
	    i3=$((i3+1)) #compare the value with 3440, if value < 3440, we add one to i3.
	fi

    done

    echo $Nruns, $Nfail, $fabs, $frel, $xabs, $xrel, $seed, $i1, $i2, $i3 >> 3.csv #return what we get to 3.csv file.
done

paste -d, 1.csv 2.csv 3.csv> exercise3.csv   #combine the three csv files into a whole file called exercise3.csv.
rm 1.csv #delete the superfluous file 1.csv.
rm 2.csv #delete the superfluous file 2.csv.
rm 3.csv #delete the superfluous file 3.csv.
cd ..
mv hw1-snaqTimeTests/exercise3.csv result/ #move the file to directory result/.
