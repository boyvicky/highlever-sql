��ü��� where emp.deptno is not null
select * from dept d
where deptno not in (select deptno from emp where emp.deptno is not null)

select * from dept
where not exists (select 1 from emp where dept.deptno = emp.deptno)

ʹ�� IN ��ʱ����ܿ�ֵ��Ӱ�죬����� exists �Ͳ����ܿ�ֵӰ��

select * from dept d
where deptno not in (null)
��ֵ


select d.deptno,d.dname/*,e.deptno,e.ename*/ from dept d
left join emp e on e.deptno = d.deptno
where e.deptno is null


select d.deptno,d.dname,e.deptno,e.ename
 from dept d
 left join emp e
   on d.deptno = e.deptno
 where e.sal > 0 
 
 ���в����ˣ�û��ȫ������dept��������������ݡ���
 ��Ϊ�������ӱ�����ݣ��Ż����Զ�ѡ����������
 ������ ֻ�������������ӱ�
 
