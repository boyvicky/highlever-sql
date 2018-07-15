--取并列两条数据里面的一条
/*first/last
keep 后面返回一个符合条件的集合，然后根据 keep 前面的聚合函数 通过聚合函数来处理这个集合*/

select * from (
select max(sal) over(partition by deptno) as max_sal,
       deptno,
       empno,
       ename,
       sal,
       hiredate
  from emp
)
where sal = max_sal
这个因为部门20有两个最大的工资，都为3000，所以部门20里面有两条数据，
我只想要一条数据怎么办？
select max(ename) keep(dense_rank first order by sal desc),  --根据工资排序
       sum(sal) keep(dense_rank first order by sal desc),   --20部门的工资 是两个人的合计工资
       max(sal) keep(dense_rank first order by sal desc),   --20部门的工资取了一个工资
       to_char(wm_concat(ename) keep(dense_rank first order by sal desc)),
       deptno
  from emp
 group by deptno;

下面这个 row_number 也可以实现，但是rank 就实现不了
select * from 
(
select rank() over(partition by deptno order by sal desc) rnk,
       row_number() over(partition by deptno order by sal desc) rn,
       deptno,
       empno,
       ename,
       sal,
       hiredate
  from emp
)
where rn = 1;--rnk = 1;


看看下面这几个的区别：
select max(ename) keep(dense_rank first order by sal desc),  --只取各个部门工资最大的，并且名字最大的一个人的姓名
       to_char(wm_concat(ename) keep(dense_rank first order by sal desc)), --只取各个部门工资最大的人的姓名,有几个人并列就取几个人
       to_char(wm_concat(ename)),--取出部门的全部人的名字
       listagg(ename,',') within group(order by sal),  --取出部门的全部人的名字
       deptno
  from emp
  group by deptno
  
也可以不汇总，后面加OVER
取出各个部门工资最高的人的姓名，
SELECT MAX(ENAME) keep(dense_rank first order by sal desc) OVER(PARTITION BY DEPTNO) MM,
       ename,
       DEPTNO,
       EMPNO,
       SAL,
       HIREDATE
  FROM EMP;
