function bestval = DECRC(fname, fun, D, Lbound, Ubound, NP, itermax, runindex, fid)
%DE Combines Rand and Current-to-best
fbias=load('fbias_data.mat');

f_name=sprintf('para/selectFromThree_f_%2d_%2d.txt',fun,runindex);
fid_f=fopen(f_name,'w');

cr_name=sprintf('para/selectFromThree_cr_%2d_%2d.txt',fun,runindex);
fid_cr=fopen(cr_name,'w');

pop_name=sprintf('para/selectFromThree_pop_%2d_%2d.txt',fun,runindex);
fid_pop=fopen(pop_name,'w');

%%初始化种群
pop = Lbound + rand(NP, D) .* (Ubound-Lbound);
vals=feval(fname,pop,fun);%计算适应度。
[bestVal,ibest]=min(vals);%当前最优值与其下标

iter=1;
fprintf(fid,'iter:%d. 最优值为：%e\n',iter,bestVal);

%关于cr的参数初始化
cr_i=ones(NP,D)*0.6;%初始化cr

%关于变异操作的初始化。
w=1;
f1=rand(NP,1)*2;
f2=rand(NP,1)*2;

upop=zeros(NP,D);

rot=0:1:NP-1;
itermax=itermax/2;
while iter<itermax   
    ind = randperm(4);              % index pointer array
    a1  = randperm(NP);             % shuffle locations of vectors
    rt = rem(rot+ind(1),NP);        % rotate indices by ind(1) positions
    a2  = a1(rt+1);
    rt = rem(rot+ind(2),NP);
    a3  = a2(rt+1);
    rt = rem(rot+ind(1),NP);        % rotate indices by ind(1) positions
    a4  = a3(rt+1);
    rt = rem(rot+ind(2),NP);
    a5  = a4(rt+1);
    
    f_rec=zeros(NP,1);
    %变异操作 
    w=1-sigmf(iter,[5/itermax,itermax/2]);
    v1=pop(a1,:)+repmat(f1,1,D).*(pop(a2,:)-pop(a3,:));
    v2=pop+repmat(f2,1,D).*(repmat(pop(ibest,:),NP,1)-pop)+repmat(f2,1,D).*(pop(a4,:)-pop(a5,:));
    vpop=w*v1+(1-w)*v2; 
    %f1=f1+rand(NP,1).*(f1(ibest)-f1);
    %f2=f2+rand(NP,1).*(f2(ibest)-f2);
    %越界处理
    if fun~=7
        index=find(vpop<Lbound);
        vpop(index)=(Lbound(index)+pop(index))/2;
        index=find(vpop>Ubound);
        vpop(index)=(Ubound(index)+pop(index))/2;
    end
    %交叉操作
    all_rec=zeros(NP,D);%
    all_suc_rec=zeros(NP,D);

    U=rand(NP,D);
    jrand=randi(D,NP,1);
    upop=pop;
    upop(U<cr_i)=vpop(U<cr_i);
    temp=(1:NP)';
    tempindex=sub2ind(size(upop),temp,jrand);
    upop(tempindex)=vpop(tempindex);
    all_rec(U<cr_i)=1;%记录交叉时选自变异向量的列
    %有问题
    all_rec(tempindex)=1;
    all_suc_rec=all_rec;%记录选择后第j列选自变异向量且成功进入下一代的个体
    upopVal = feval(fname, upop, fun);
    vpopVal = feval(fname, vpop, fun);
    %选择
    for i=1:NP       
       if min([vpopVal(i),vals(i),upopVal(i)])==vpopVal(i)
            pop(i,:)=upop(i,:);
            vals(i)=vpopVal(i); 
            all_suc_rec(i,:)=0;
            if vpopVal(i)<vals(i)
                f_rec(i)=1;
            end
       elseif min([upopVal(i),vals(i),vpopVal(i)])==upopVal(i)
            pop(i,:)=upop(i,:);
            vals(i)=vpopVal(i);
            if upopVal(i)<vals(i)
                f_rec(i)=1;
            end
       else
           all_suc_rec(i,:)=0;
           
       end
    end
    tempindex=find(f_rec~=0);
    f1(tempindex)=f1(tempindex)+rand()*(mean(f1(tempindex))-f1(tempindex));
    f2(tempindex)=f2(tempindex)+rand()*(mean(f2(tempindex))-f2(tempindex));
    tempindex=find(f_rec==0);
    tempf1=rand(NP,1)*2;
    tempf2=rand(NP,2)*2;
    f1(tempindex)=tempf1(tempindex);
    f2(tempindex)=tempf2(tempindex);
    
    
    cr_rec=sum(all_rec,1);
    suc_rec=sum(all_suc_rec,1);
    tempidex=find(cr_rec ~=0);
    rate=zeros(1,D);
    rate(tempidex)=suc_rec(tempidex)./cr_rec(tempidex);
    meanRate=mean(rate(tempidex));
    rate(tempidex)=rate(tempidex)-meanRate;
   
    cr_i=cr_i+repmat(rate,NP,1);
    cr_i(cr_i>=0.9)=0.9;
    cr_i(cr_i<0.4)=0.4;  
    fprintf(fid_f,'\niter:%d, w:%f \n',iter,w);
     for i=1:NP
         fprintf(fid_f,'%f ',f1(i));
     end
     fprintf(fid_f,'\n');
     for i=1:NP
         fprintf(fid_f,'%f ',f2(i));
     end
     for i=1:D
         fprintf(fid_cr,'%f ',cr_i(1,i));
     end
    %记录参数信息
    fprintf(fid_f,'\n');
    fprintf(fid_cr,'\n');
    fprintf(fid_pop,'\n iter:%d\n',iter);
    for i=1:NP
        fprintf(fid_pop,'适应度为：%e，cha：%e---',vals(i),vals(i)-fbias.f_bias(fun));
        for j=1:D
            fprintf(fid_pop,'%f ',pop(i,j));
        end
        fprintf(fid_pop,'\n');
    end
   
    [bestVal,ibest]=min(vals);
    fprintf(fid,'fun:%4d, iter:%d, 最优值为：%e.最优值id：%d.差为：%e\n',fun,iter,bestVal,ibest,bestVal-fbias.f_bias(fun));
    iter=iter+1;
    fprintf('fun:%d,iter：%d,最优值为：%e.最优值id：%d.差为:%e\n',fun,iter,bestVal,ibest,bestVal-fbias.f_bias(fun));
end  
fclose(fid_f);
fclose(fid_cr);
bestval=bestVal;



