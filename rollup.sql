select deptno,sum(sal) from emp group by deptno
union all
select null,sum(sal) from emp /*group by null*/

一个列汇总的时候，下面这两个汇总函数没什么区别
select deptno,sum(sal) from emp group by rollup(deptno);
select deptno,sum(sal) from emp group by cube(deptno);

两个列汇总的时候
/*级次汇总*/
select deptno,job,sum(sal) from emp group by rollup(deptno,job);

/*枚举所有的组合*/ --1 根据职位 2 根据部门 3 根据部门和职位 4 全部汇总
select deptno,job,sum(sal) from emp group by cube(deptno,job);
相当于下面这个SQL
select deptno,job,sum(sal) from emp group by (deptno,job)
union all
select deptno,null,sum(sal) from emp group by deptno
union all 
select null,null,sum(sal) from emp 


就相当于下面这个SQL
select null,job,sum(sal) from emp group by job
union all
select deptno,null,sum(sal) from emp group by deptno
union all
select deptno,job,sum(sal) from emp group by (deptno,job)
union all 
select null,null,sum(sal) from emp 


select nvl(to_char(deptno),'合计'),
       decode(deptno,null,null,nvl(job,'小计')),
       sum(sal)
  from emp
 group by rollup(deptno,job);
这种写法 如果job明细里面有空值的时候，小计就出现问题了。

用函数grouping
select nvl(to_char(deptno),'合计'),
       decode(deptno,null,null,nvl(job,'小计')),
       grouping(deptno),
       grouping(job),
       sum(sal)
  from emp
 group by rollup(deptno,job);
 

用decode 写出的情况，但是如果列多的话还有一个简便的方法
select decode(grouping(deptno),1,'合计',to_char(deptno)) deptno,
       decode(grouping(deptno),1,null,decode(grouping(job),1,'小计',job)) job,
/*       grouping(deptno),
       grouping(job),*/
       sum(sal)
  from emp
 group by rollup(deptno,job);
 
用grouping_id,grouping(deptno)和grouping(job) 都为1的时候，grouping_id 为二进制11即为3，
              grouping(deptno)为0 grouping(job)为1的时候，grouping_id 为二进制01即为1;
select grouping(deptno),
       grouping(job),
       grouping_id(deptno,job),  --括号里面的两列的grouping的二进制的值
       sum(sal)
  from emp
 group by rollup(deptno,job)
 
 
select decode(grouping(deptno),1,'合计',to_char(deptno)) deptno,
       decode(grouping_id(deptno,job),3,null,1,'小计',0,job) job, 
       sum(sal)
  from emp
 group by rollup(deptno,job)
 
如果只想要一个总计，不想要分别的小计应该怎么处理呢？
只需要在rollup后面再嵌套一层括号即可。
就是级次汇总的时候，将括号里面的当做一列来处理。如果列多了，也可以自由组合，两列两列括在一起，
进行汇总。
select deptno,
       job,
       sum(sal)
   from emp
   group by rollup((deptno,job))
