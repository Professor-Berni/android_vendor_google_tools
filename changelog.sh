export Changelog=Changelog.txt

if [ -f $Changelog ]; then rm -f $Changelog; fi

touch $Changelog

# Print something to build output
echo "Generating changelog..."

# This setting determines the number of days to look back when searching through commits.
# Note: The higher the number, the longer this process will take!
for i in $(seq 31); do
  export After_Date=`date --date="$i days ago" +%Y-%m-%d`
  k=$(expr $i - 1)
  export Until_Date=`date --date="$k days ago" +%Y-%m-%d`

  # Line with after --- until was too long for a small ListView
  echo '====================' >> $Changelog;
  echo  "     "$Until_Date    >> $Changelog;
  echo '====================' >> $Changelog;
  # Cycle through every repo to find commits between 2 dates
  repo forall -pc 'git log --pretty=format:"%h  %s [%an]" --decorate --after=$After_Date --until=$Until_Date' >> $Changelog
  echo >> $Changelog;
done

sed -i 's/project/   */g' $Changelog

if [ ! -d $OUT ]; then mkdir -p $OUT; fi
if [ ! -d $OUT/system/etc ]; then mkdir -p $OUT/system/etc; fi

cp $Changelog $OUT/system/etc/
cp $Changelog $OUT/
rm $Changelog

mv $OUT/Changelog.txt $OUT/`date +%Y%m%d`-Changelog.txt

