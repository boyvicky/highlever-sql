union 与 union all
结果集中两个没有重复数据，得到的结果集是一样的。

select empno,ename from emp
union all
select deptno,dname from dept

select empno,ename from emp
union
select deptno,dname from dept

在看下执行计划：
用UNION 会将数据先进行一下排序，而union all没有这个操作。
union 会将数据进行去重处理。

select empno,ename from emp
union all
select deptno,dname from dept

 Plan Hash Value  : 135391165 

---------------------------------------------------------------------
| Id | Operation            | Name | Rows | Bytes | Cost | Time     |
---------------------------------------------------------------------
|  0 | SELECT STATEMENT     |      |   22 |   448 |    6 | 00:00:01 |
|  1 |   UNION-ALL          |      |      |       |      |          |
|  2 |    TABLE ACCESS FULL | EMP  |   18 |   360 |    3 | 00:00:01 |
|  3 |    TABLE ACCESS FULL | DEPT |    4 |    88 |    3 | 00:00:01 |
---------------------------------------------------------------------

Note
-----
- dynamic sampling used for this statement


select empno,ename from emp
union
select deptno,dname from dept

 Plan Hash Value  : 2375100902 

----------------------------------------------------------------------
| Id | Operation             | Name | Rows | Bytes | Cost | Time     |
----------------------------------------------------------------------
|  0 | SELECT STATEMENT      |      |   22 |   448 |    8 | 00:00:01 |
|  1 |   SORT UNIQUE         |      |   22 |   448 |    8 | 00:00:01 |
|  2 |    UNION-ALL          |      |      |       |      |          |
|  3 |     TABLE ACCESS FULL | EMP  |   18 |   360 |    3 | 00:00:01 |
|  4 |     TABLE ACCESS FULL | DEPT |    4 |    88 |    3 | 00:00:01 |
----------------------------------------------------------------------

Note
-----
- dynamic sampling used for this statement


select mgr,job from emp  --里面有重复数据
union
select deptno,dname from dept

select mgr,job from emp  --里面有重复数据
union all
select deptno,dname from dept


取两个结果集的交集
select mgr,job from emp
intersect
select deptno,dname from dept


下面这两个SQL等价 就相当于
select mgr,job from emp  --里面有重复数据
union
select deptno,dname from dept

select distinct * from 
(
select mgr,job from emp  --里面有重复数据
union
select deptno,dname from dept
)
order by 1,2

union 是将两个结果集先合并，然后排序去重的操作。

select mgr,job from emp  --里面有重复数据  18行数据
minus
select deptno,dname from dept   --4行数据

两个没有交集，相减应该是22条数据，但是现在相减得到11条数据
原因是minus 操作也是
