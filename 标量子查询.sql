--�����Ӳ�ѯ

select b.deptno,
(select a.dname from dept a where a.deptno = b.deptno )
from emp b

�е�д������
select (select b.ename from emp b where a.deptno = b.deptno) from dept a
����
���Ǹ�д��
�����ʾһ�����ֵĸ�д����
select (select b.ename from emp b where a.deptno = b.deptno and rownum < 2) from dept a
Ҳ���Ը�д
select (select wm_concat(b.ename) from emp b where a.deptno = b.deptno) from dept a

select (select listagg(b.ename, ',') within group(order by null)
          from emp b
         where a.deptno = b.deptno)
  from dept a

listagg within group()

д����
select * from emp e
  where (select dname from dept d where d.deptno = e.deptno) in 
  ('RESEARCH','SALES')
  
д��

select e.*--,(select dname from dept d where d.deptno = e.deptno) 
from emp1 e
 order by (select dname from dept1 d where d.deptno = e.deptno)
 
 ��д��
 select e.*,d.dname from emp1 e left join dept1 d on d.deptno = e.deptno
 
 
 
 
 
