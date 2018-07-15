求平均工资
普通写法
select EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, a.DEPTNO, b.avg_sal
  from emp1 a
 inner join (select deptno, avg(sal) avg_sal from emp1 group by deptno) b
    on a.deptno = b.deptno

标量子查询的写法
select EMPNO,
       ENAME,
       JOB,
       MGR,
       HIREDATE,
       SAL,
       COMM,
       a.DEPTNO,
       (select avg(sal) from emp1 b where b.deptno = a.deptno)
  from emp1 a
  
分析函数的写法
select EMPNO,
       ENAME,
       JOB,
       MGR,
       HIREDATE,
       SAL,
       COMM,
       a.DEPTNO,
       avg(sal) over(partition by deptno order by deptno) avg_sal
  from emp1 a
  
 
分析函数  序号

select rownum,empno,ename,deptno from emp order by deptno

select rownum,empno,ename,deptno
from (select empno,ename,deptno from emp order by deptno)

按部分分组，得到序号,不用分析函数的写法

select empno,
       ename,
       deptno,
       (select count(*) from emp b where b.deptno < a.deptno) cn
  from emp a order by deptno 
部门20的时候，cn 列就是部门10的人数

然后再用下面的SQL，就得到了分析函数 序号 的效果
select rownum - cn,empno,ename,deptno,cn
  from (select empno,
       ename,
       deptno,
       (select count(*) from emp b where b.deptno < a.deptno) cn
  from emp a order by deptno)
没有分析函数 就可以用这个SQL 

select row_number() over(order by hirdate) as rm,
       empno,
       ename,
       sal,
       hiredate
   from emp
   order by sal

select rownum, empno, ename, sal, hiredate
  from (select empno, ename, sal, hiredate from emp order by hiredate)

  
select row_number() over(partition by deptno order by sal) as rm,
       rank() over(partition by deptno order by sal) as rk,
       dense_rank() over(partition by deptno order by sal) as drk,
       empno,
       ename,
       sal,
       hiredate
   from emp
   
分析函数  计算占比,
计算各个部门的工资在总工资的占比情况
select deptno,s_sal,ratio_to_report(s_sal) over() from 
(select deptno,sum(sal) s_sal from emp group by deptno) 

就相当于下面这个语句
select deptno,s_sal,s_sum, s_sal/s_sum from
(
select deptno,s_sal,sum(s_sal) over() s_sum from 
(select deptno,sum(sal) s_sal from emp group by deptno)
)

下面这个语句，
select deptno,job,sum(sal)
from emp
group by rollup(deptno,job)

5500/35250   单个人/部门的总数
35250/全公司的总数

第一步 先将合计与各个人区分开
select case
         when grouping(job) = 0 then
          deptno
         when grouping(job) = 1 then
          1
       end gp,
       deptno,
       job,
       sum(sal) s_sum
  from emp
 group by deptno,rollup(job)

第二步,用占比分析函数进行计算

select deptno,job,s_sum,ratio_to_report(s_sum) over(partition by gp)
from 
(
select case
         when grouping(job) = 0 then
          deptno
         when grouping(job) = 1 then
          1
       end gp,
       deptno,
       job,
       sum(sal) s_sum
  from emp
 group by deptno,rollup(job)
)
