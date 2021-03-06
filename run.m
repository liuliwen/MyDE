
clear;
clear all;
NP=100;
runs=50;
global initial_flag;
global k;
global c;
k=15;
c=0.1;
myfunc = 1:25;
dim=30*ones(1,size(myfunc,2));
MAX_FES=10000*dim;
Gen=MAX_FES./NP;

addpath('benchmark');
%for fun=9:9%
for fun=2:size(myfunc,2)
    func_num = myfunc(fun);
    D = dim(func_num);
    Max_Gen = Gen(func_num);
    bestval = [];
    %for runindex=1:runs
    for runindex=1:1%
        rand('seed',runindex);
        randn('seed',runindex);
     
        filename = sprintf('trace/selectFromThree_tracef_fit_%02d_%02d.txt', func_num, runindex);
        fid = fopen(filename, 'w');
        initial_flag = 0;
        
        val = runcompe('benchmark_func', func_num, D, NP, Max_Gen, runindex, fid);
        bestval = [bestval; val];
        fclose(fid);
    end
    
    filename = sprintf('result/selectFromThree_bestf%02d.txt', func_num);
    fid = fopen(filename, 'w');
    fprintf(fid, '%g\n', bestval);
    fclose(fid);
    
    filename = sprintf('result/selectFromThree_meanf%02d.txt', func_num);
    fid = fopen(filename, 'w');
    fprintf(fid, '%g\n', mean(bestval));
    fclose(fid);
    
    filename = sprintf('result/selectFromThree_stdf%02d.txt', func_num);
    fid = fopen(filename, 'w');
    fprintf(fid, '%g\n', std(bestval));
    fclose(fid);
end

