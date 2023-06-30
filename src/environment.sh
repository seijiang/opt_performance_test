if [ $# -ge 1 ] ; then
    WORKSPACE=$1
else
    WORKSPACE=/root
fi
# 获取源代码
cd $WORKSPACE
git clone -b opt_rewrite_with_schema_inference https://github.com/seijiang/tugraph-db.git
cp -r $WORKSPACE/tugraph-db/ $WORKSPACE/tugraph-db-opt/

python $WORKSPACE/opt_performance_test/src/opt_unavailable.py $WORKSPACE/tugraph-db/src/cypher/execution_plan/optimization/opt_rewrite_with_schema_inference.h

# 编译未优化和优化的版本
cd $WORKSPACE/tugraph-db/deps
git clone https://github.com/TuGraph-family/fma-common.git
git clone https://github.com/TuGraph-family/tugraph-web.git
./build_deps.sh --fix
\cp -r $WORKSPACE/tugraph-db/deps/ $WORKSPACE/tugraph-db-opt/

mkdir $WORKSPACE/tugraph-db/build
mkdir $WORKSPACE/tugraph-db-opt/build
cd $WORKSPACE/tugraph-db/build
cmake ..
make -j8
cd $WORKSPACE/tugraph-db-opt/build
cmake ..
make -j8

# 导入MovieDemo和CovidDemo
cp $WORKSPACE/opt_performance_test/src/import_moviedemo.json $WORKSPACE/tugraph-db/demo/movie
cd $WORKSPACE/tugraph-db/demo/movie
mkdir -p /var/lib/lgraph/
$WORKSPACE/tugraph-db/build/output/lgraph_import --dir /var/lib/lgraph/ --verbose 2 -c import_moviedemo.json  --continue_on_error 1 --overwrite 1 --online false
# lgraph_import --dir /var/lib/lgraph/ --verbose 2 -c import_moviedemo.json  --continue_on_error 1 --overwrite 1 --online false
rm -rf import_tmp

# 构建CppRpcClientDemo
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$WORKSPACE/tugraph-db/include
export LIBRARY_PATH=$LIBRARY_PATH:$WORKSPACE/tugraph-db/build/output
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORKSPACE/tugraph-db/build/output
cd $WORKSPACE/opt_performance_test/src/CppRpcClient
mkdir build && cd build && cmake .. && make
