update emp2 e 
  set e.dname = (
    select d.dname
      from dept2 d
     where d.deptno = e.deptno
       and d.loc in ('NEW YORK','DALLAS'))
 where exists (select d.dname 
   from dept3 d
    where d.deptno = e.deptno
      and d.loc in ('NEW YORK','DALLAS'))
      
合并语句：（是内连接）
merge into emp2 e
using (select * from dept2 d where d.loc in ('NEW YORK','DALLAS')) d
on (d.deptno = e.deptno)
when matched then 
   update set e.dname = d.dname;

下面这个语句是外连接：
update emp2 e 
  set e.dname = (
    select d.dname
      from dept2 d
     where d.deptno = e.deptno
       and d.loc in ('NEW YORK','DALLAS'));
       
合并语句改写成外连接 怎么改写？
merge into emp2 e
using (select * from dept2 d where d.loc in ('NEW YORK','DALLAS')) d
on (d.deptno(+) = e.deptno)
when matched then 
   update set e.dname = d.dname;       
只需要添加一个加号
          
   
