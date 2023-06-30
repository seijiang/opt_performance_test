import math
import sys

def opt_unavailable(path):
    f1=open(path,'r')
    lines=f1.readlines()
    for i in range(0,len(lines)):
        if "Gate()" in lines[i]:
            lines[i]="    bool Gate() override { return false; }\n"
    f2=open(path,'w')
    f2.writelines(lines)
    f2.close()
        
    
if __name__ == "__main__":
    path=sys.argv[1]
    opt_unavailable(path)
