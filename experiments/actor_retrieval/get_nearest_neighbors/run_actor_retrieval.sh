if [ $# -lt 3 ]
then
  echo "Usage: `basename $0` <dbname> <dbuser> <dbpwd>"
  exit 1
fi

db=localhost/$1
dbuser=$2
dbpwd=$3

rootdir=../../..
srcdir=$rootdir/src/java
classpath="$srcdir:$rootdir/lib/mysql.jar:$rootdir/lib/guava.jar"
javalibs="-Djava.library.path=$rootdir/lib:"                                 
javaoptions="-XX:-UseGCOverheadLimit -Xmx6G $javalibs"

# Select the one you want:
tetfile=tet.genre
#tetfile=tet.business

trainfile=data.train
testfile=data.test
id2namesfile=id2names.txt


class="experiments.ActorRetrieval"
options="-b 5 -w 1 -n 3 -k 10 -M -C -S 30 -D 12"
suffix=`echo $options | tr ' ' '_'`
startemd=$SECONDS
echo "java -classpath $classpath $javaoptions $class $options $db $dbuser $dbpwd $tetfile $trainfile $testfile $id2namesfile $class.output.$suffix"
java -classpath $classpath $javaoptions $class $options $db $dbuser $dbpwd $tetfile $trainfile $testfile $id2namesfile $class.output.$suffix > log.$suffix
echo "time retrieval: $((SECONDS - startemd))"



