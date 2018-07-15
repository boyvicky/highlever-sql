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
      
�ϲ���䣺���������ӣ�
merge into emp2 e
using (select * from dept2 d where d.loc in ('NEW YORK','DALLAS')) d
on (d.deptno = e.deptno)
when matched then 
   update set e.dname = d.dname;

�����������������ӣ�
update emp2 e 
  set e.dname = (
    select d.dname
      from dept2 d
     where d.deptno = e.deptno
       and d.loc in ('NEW YORK','DALLAS'));
       
�ϲ�����д�������� ��ô��д��
merge into emp2 e
using (select * from dept2 d where d.loc in ('NEW YORK','DALLAS')) d
on (d.deptno(+) = e.deptno)
when matched then 
   update set e.dname = d.dname;       
ֻ��Ҫ���һ���Ӻ�
          
   
