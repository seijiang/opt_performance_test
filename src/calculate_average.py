import math
import sys

def fun(str_num):
    before_e = float(str_num.split('e')[0])
    sign = str_num.split('e')[1][:1]
    after_e = int(str_num.split('e')[1][1:])

    if sign == '+':
        float_num = before_e * math.pow(10, after_e)
    elif sign == '-':
        float_num = before_e * math.pow(10, -after_e)
    else:
        float_num = None
        print('error: unknown sign')
    return float_num


def calculate(path,cypher,graph,cycle):
    f1=open(path+"single_result.txt",'r')
    after_time=0.0
    before_time=0.0
    for line in f1.readlines():
        line=line.split(":")
        time=line[1]
        if time.endswith("\n"):
            time=time[:-1]
        if "e" in time:
            time=fun(time)
        if "after" in line[0]:
            after_time+=float(time)
        else:
            before_time+=float(time)
                
    f_res=open(path+"all_query_result.txt",'a')
    f_res.write("cypher: "+cypher+"\n")
    f_res.write("graph: "+graph+"\n")
    f_res.write("before optimization time: "+str(before_time/cycle)+"s\n")
    f_res.write("after optimization time: "+str(after_time/cycle)+"s\n\n")
    
if __name__ == "__main__":
    if len(sys.argv)==4:
        cypher=sys.argv[1]
        graph=sys.argv[2]
        cycle=int(sys.argv[3])
        calculate("../output/",cypher,graph,cycle)
