cd $WORKSPACE/opt_performance_test/src
$ : > ../output/result.txt

./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1]->(n2)-[e2]->(m:keyword) return COUNT(p); "
./single_query_test.sh "match p=(n0)-[e0:produce]->(n1)-[e1:has_keyword]->(m) return COUNT(p); "
./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1:has_genre]->(m:genre) return COUNT(p); "
./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1]->(n2:movie)-[e2]-(m:keyword) return COUNT(p); "
./single_query_test.sh "match p=(n0)<-[e0:produce|write|directed]-(m) return COUNT(p); "
./single_query_test.sh "match p=(n0)-[e0:is_friend]->(n1)-[e1:is_friend]->(m) return COUNT(p); "
