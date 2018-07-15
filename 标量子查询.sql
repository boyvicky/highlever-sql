--标量子查询

select b.deptno,
(select a.dname from dept a where a.deptno = b.deptno )
from emp b

有的写成这种
select (select b.ename from emp b where a.deptno = b.deptno) from dept a
报错
我们改写下
随机显示一个名字的改写法：
select (select b.ename from emp b where a.deptno = b.deptno and rownum < 2) from dept a
也可以改写
select (select wm_concat(b.ename) from emp b where a.deptno = b.deptno) from dept a

select (select listagg(b.ename, ',') within group(order by null)
          from emp b
         where a.deptno = b.deptno)
  from dept a

listagg within group()

写法：
select * from emp e
  where (select dname from dept d where d.deptno = e.deptno) in 
  ('RESEARCH','SALES')
  
写法

select e.*--,(select dname from dept d where d.deptno = e.deptno) 
from emp1 e
 order by (select dname from dept1 d where d.deptno = e.deptno)
 
 改写：
 select e.*,d.dname from emp1 e left join dept1 d on d.deptno = e.deptno
 
 
 
 
 
