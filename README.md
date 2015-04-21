# test_hadoop
After running start-hdf.sh and start-yaml.sh create the output dir in hdfs
> hdfs dfs -mkdir /user_name
> hdfs dfs -mkdir wordcount

Then run the map reduce with streaming lib
> hadoop jar /my_path_to_hadoop/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar -file "mapper.py" -mapper "mapper.py" -file "reducer.py" -reducer "reducer.py" -input "wordcount/data/*" -output "wordcount/pyout
