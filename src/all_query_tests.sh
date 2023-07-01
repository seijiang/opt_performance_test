if [ $# -ge 1 ] ; then
    WORKSPACE=$1
else
    WORKSPACE=/root
fi
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$WORKSPACE/tugraph-db-opt/include
export LIBRARY_PATH=$LIBRARY_PATH:$WORKSPACE/tugraph-db-opt/build/output
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORKSPACE/tugraph-db-opt/build/output

cd $WORKSPACE/opt_performance_test/src
$ : > ../output/all_query_result.txt

./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1]->(n2)-[e2]->(m:keyword) return COUNT(p); "
./single_query_test.sh "match p=(n0)-[e0:produce]->(n1)-[e1:has_keyword]->(m) return COUNT(p); "
./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1]->(n2)-[e2]->(m:genre) return COUNT(p); "
./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1]->(n2:movie)-[e2]-(m:keyword) return COUNT(p); "
./single_query_test.sh "match p=(n0)<-[e0:produce|write|directed]-(m) return COUNT(p); "
./single_query_test.sh "match p=(n0)-[e0:is_friend]->(n1)-[e1:is_friend]->(m) return COUNT(p); "

./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1]->(n2)-[e2]->(n3)-[e3]->(m:street) return COUNT(p);" CovidDemo
./single_query_test.sh "match p=(n0)-[e0:town_to_street]->(n1)-[e1:street_to_address]->(m) return COUNT(p); " CovidDemo
./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1:street_to_address]->(m:address) return COUNT(p); " CovidDemo
./single_query_test.sh "match p=(n0)-[e0]->(n1)-[e1]->(n2:street)-[e2]-(m:address) return COUNT(p); " CovidDemo
./single_query_test.sh "match p=(n0)-[e0:person_live_with_person]->(n1)-[e1:person_live_with_person]->(m) return COUNT(p); " CovidDemo