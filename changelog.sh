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

# Update the BUILD_ID based on the actual BUILD_ID.
# This line can be removed once the BUILD_ID can be retrieved from the environment variables.
export BUILD_ID=SQ3A.220705.004

mv $OUT/Changelog.txt $OUT/$BUILD_ID-`date +%Y%m%d`-Changelog.txt

