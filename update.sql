��һ������������ݸ�����һ�������������

alter table emp2 add dname varchar2(32);

����д����û������Ա����
update emp2 e
   set e.dname =
       (select dname
          from dept
         where e.deptno = dept.deptno
           and loc in ('NEW YORK', 'DALLAS'))

--��ȷд��
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
           
   
 �����������ܲ���ִ�У�
 ����ִ��   select ename from dept �������أ�      
   select * from emp e
  where e.ename in (select ename from dept where dept.deptno = e.deptno)
  
  дSQLʱ�򣬶��������ȫ�����ϱ�����ֵĶ�Ӧ���� emp.dname
  
  �����Ӳ�ѯҲ����������⡣
  
  
