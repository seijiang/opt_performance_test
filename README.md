# 测试Schema重写优化和未优化的性能对比
在最新的docker镜像tugraph/tugraph-compile-centos7上运行
## 测试环境搭建
* 如果该文件夹保存在/root/opt_performance_test，则opt_performance_test文件夹所在路径为/root，运行以下命令
```
./src/environment.sh <opt_performance_test文件夹所在路径>
```

## 运行测试Cypher
```
./src/all_query_tests.sh <opt_performance_test文件夹所在路径>
```