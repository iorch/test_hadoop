# test_hadoop
After running start-hdf.sh and start-yarn.sh create the output dir in hdfs
> hdfs dfs -mkdir wordcount

It is also necessary to create a data dir in wordcount/data, and copy there some files to count their word content.
> hdfs dfs -mkdir wordcount/data

> hdfs dfs -copyFromLocal some_files*.txt wordcount/data/

Then run the map reduce with streaming lib
> hadoop jar /my_path_to_hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar -file "mapper.py" -mapper "mapper.py" -file "reducer.py" -reducer "reducer.py" -input "wordcount/data/*" -output "wordcount/pyout"
