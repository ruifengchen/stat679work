for filename in stat679work/hw1/hw1-snaqTimeTests/log/timetest[123456789]_snaq.log
do
  mv ${filename} ${filename/timetest/timetest0} # in file x, replace timetest by timetest0
done

for filename in stat679work/hw1/hw1-snaqTimeTests/out/timetest[123456789]_snaq.out
do
  mv ${filename} ${filename/timetest/timetest0} # in file x, replace timetest by timetest0
done
