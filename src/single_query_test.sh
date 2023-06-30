if [ $# -ge 2 ] ; then
    cypher=$1
    graph=$2
elif [ $# -ge 1 ] ; then
    cypher=$1
    graph=default
else
    cypher='match p=(n1)-[e0]->(n)-[e1]->(m)-[e2]->(k:keyword) return COUNT(p);'
    graph=default
fi

cycle=10;
$ : > $WORKSPACE/opt_performance_test/output/single_result.txt

cd $WORKSPACE/opt_performance_test/src/CppRpcClient_no_opt

$WORKSPACE/tugraph-db/build/output/lgraph_server -d start -c $WORKSPACE/opt_performance_test/src/lgraph.json
sleep 1
for (( i = 0; i < $cycle; i++ )) ;
do
    $WORKSPACE/opt_performance_test/src/CppRpcClient_no_opt/build/clientdemo -i 127.0.0.1 -p 9090 -u admin --password 73@TuGraph -g $graph -c "${cypher}" -o false
done
$WORKSPACE/tugraph-db/build/output/lgraph_server -d stop -c $WORKSPACE/opt_performance_test/src/lgraph.json

cd $WORKSPACE/opt_performance_test/src/CppRpcClient_opt
$WORKSPACE/tugraph-db-opt/build/output/lgraph_server -d start -c $WORKSPACE/opt_performance_test/src/lgraph2.json
sleep 1
for (( i = 0; i < $cycle; i++ )) ;
do
    $WORKSPACE/opt_performance_test/src/CppRpcClient_opt/build/clientdemo -i 127.0.0.1 -p 9091 -u admin --password 73@TuGraph -g $graph -c "${cypher}" -o true
done
$WORKSPACE/tugraph-db-opt/build/output/lgraph_server -d stop -c $WORKSPACE/opt_performance_test/src/lgraph2.json

cd $WORKSPACE/opt_performance_test/src
python $WORKSPACE/opt_performance_test/src/calculate_average.py "${cypher}" $graph $cycle 