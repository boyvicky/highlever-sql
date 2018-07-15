用一个表里面的数据更新另一个表里面的数据

alter table emp2 add dname varchar2(32);

错误写法，没有限制员工表
update emp2 e
   set e.dname =
       (select dname
          from dept
         where e.deptno = dept.deptno
           and loc in ('NEW YORK', 'DALLAS'))

--正确写法
update emp2 e
   set e.dname =
       (select dname
          from dept
         where e.deptno = dept.deptno
           and loc in ('NEW YORK', 'DALLAS'))
 where exists (select dname
          from dept
         where e.deptno = dept.deptno
           and loc in ('NEW YORK', 'DALLAS'))                      
           
   
 下面这个语句能不能执行？
 单独执行   select ename from dept 这个语句呢？      
   select * from emp e
  where e.ename in (select ename from dept where dept.deptno = e.deptno)
  
  写SQL时候，多表关联最好全部加上表的名字的对应的列 emp.dname
  
  标量子查询也存在这个问题。
  
  
