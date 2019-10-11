#Execute code with "spark-submit --master spark://master:7077 <path to this python code>"
from pyspark import SparkContext, SparkConf
conf = SparkConf().setAppName("word_count")
sc = SparkContext(conf=conf)

text_file = sc.textFile("hdfs://master:9000/user/app/sports_news.txt")  #Input file to spark read
counts = text_file.flatMap(lambda line: line.split(" ")) \
             .map(lambda word: (word, 1)) \
             .reduceByKey(lambda a, b: a + b)
counts.saveAsTextFile("hdfs://master:9000/user/app/sports_count.txt") #Output directory to save results
