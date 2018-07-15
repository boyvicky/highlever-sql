最好加上 where emp.deptno is not null
select * from dept d
where deptno not in (select deptno from emp where emp.deptno is not null)

select * from dept
where not exists (select 1 from emp where dept.deptno = emp.deptno)

使用 IN 的时候会受空值的影响，如果用 exists 就不会受空值影响

select * from dept d
where deptno not in (null)
无值


select d.deptno,d.dname/*,e.deptno,e.ename*/ from dept d
left join emp e on e.deptno = d.deptno
where e.deptno is null


select d.deptno,d.dname,e.deptno,e.ename
 from dept d
 left join emp e
   on d.deptno = e.deptno
 where e.sal > 0 
 
 空行不在了，没有全部返回dept表里面的所有数据。，
 因为过滤了子表的数据，优化器自动选择了内连接
 外连接 只能是主表驱动子表
 
