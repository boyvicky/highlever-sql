select * from emp_bonus

--����Լ����Ҫ�������е�ֵ С�ڵ��ڵ�ǰ��ʱ��
insert into (
select hiredate from emp1 where hiredate <= sysdate
with check option
)
values (sysdate + 1)

--һ������ֻ����������,���˵ľͲ��벻��ȥ

insert into 
(
select a.deptno from emp1 a
where (select count(b.deptno) from emp1 b where b.deptno = a.deptno) <= 5
with check option
)
values(20)


--�п�ʼʱ�䣬����ʱ��
�µ���Ŀʱ���ԭ������Ŀʱ�䲻���ظ�����һ����Ŀ�� 1.1-1.6��
�ڶ�����Ŀֻ���Ǵ�1.7-1.8��

select * from emp2 


