clear;
clear all;
NP=100;
runs=25;
global initial_flag;
global k;
global c;
k=15;
c=0.1;
%myfunc = 1:25;
myfunc=1:14;
dim=30*ones(1,size(myfunc,2));
MAX_FES=10000*dim;
Gen=MAX_FES./NP;
addpath('benchmark')
fbias=load('fbias_data.mat');
% heheda   
%for fun=9:9%
for fun=1:size(myfunc,2)
    func_num = myfunc(fun);
    D = dim(func_num);
    Max_Gen = Gen(func_num);
    bestval = [];

    filename_result = sprintf('result_two/selectFromTwo_bestf%02d.txt', func_num);
    fid_result = fopen(filename_result, 'w');

    for runindex=1:runs
  %  for runindex=1:1
        rand('seed',runindex);
        randn('seed',runindex);
        filename = sprintf('trace_two/selectFromTwo_tracef_fit_%02d_%02d.txt', func_num, runindex);
        fid = fopen(filename, 'w');
        initial_flag = 0;
        val = Copy_of_runcompe('benchmark_func', func_num, D, NP, Max_Gen, runindex, fid);
        bestval = [bestval; val];
	
	fprintf(fid_result, 'bestVal:%e,	cha:%e\n', val,val-fbias.f_bias(func_num));
        fclose(fid);
	fprintf('func_num:%d,runindex:%d\n',func_num,runindex);
    end
    
    
    fclose(fid_result); 
    filename = sprintf('result_two/selectFromTwo_meanf%02d.txt', func_num);
    fid = fopen(filename, 'w');
    fprintf(fid, 'mean:%e,	cha:%e\n', mean(bestval),mean(bestval)-fbias.f_bias(func_num));
    fclose(fid);
    filename = sprintf('result_two/selectFromTwo_stdf%02d.txt', func_num);
    fid = fopen(filename, 'w');
    fprintf(fid, 'std:%e\n', std(bestval));
    fclose(fid);
end

