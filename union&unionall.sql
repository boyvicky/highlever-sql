union �� union all
�����������û���ظ����ݣ��õ��Ľ������һ���ġ�

select empno,ename from emp
union all
select deptno,dname from dept

select empno,ename from emp
union
select deptno,dname from dept

�ڿ���ִ�мƻ���
��UNION �Ὣ�����Ƚ���һ�����򣬶�union allû�����������
union �Ὣ���ݽ���ȥ�ش���

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


select mgr,job from emp  --�������ظ�����
union
select deptno,dname from dept

select mgr,job from emp  --�������ظ�����
union all
select deptno,dname from dept


ȡ����������Ľ���
select mgr,job from emp
intersect
select deptno,dname from dept


����������SQL�ȼ� ���൱��
select mgr,job from emp  --�������ظ�����
union
select deptno,dname from dept

select distinct * from 
(
select mgr,job from emp  --�������ظ�����
union
select deptno,dname from dept
)
order by 1,2

union �ǽ�����������Ⱥϲ���Ȼ������ȥ�صĲ�����

select mgr,job from emp  --�������ظ�����  18������
minus
select deptno,dname from dept   --4������

����û�н��������Ӧ����22�����ݣ�������������õ�11������
ԭ����minus ����Ҳ��
