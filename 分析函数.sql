��ƽ������
��ͨд��
select EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, a.DEPTNO, b.avg_sal
  from emp1 a
 inner join (select deptno, avg(sal) avg_sal from emp1 group by deptno) b
    on a.deptno = b.deptno

�����Ӳ�ѯ��д��
select EMPNO,
       ENAME,
       JOB,
       MGR,
       HIREDATE,
       SAL,
       COMM,
       a.DEPTNO,
       (select avg(sal) from emp1 b where b.deptno = a.deptno)
  from emp1 a
  
����������д��
select EMPNO,
       ENAME,
       JOB,
       MGR,
       HIREDATE,
       SAL,
       COMM,
       a.DEPTNO,
       avg(sal) over(partition by deptno order by deptno) avg_sal
  from emp1 a
  
 
��������  ���

select rownum,empno,ename,deptno from emp order by deptno

select rownum,empno,ename,deptno
from (select empno,ename,deptno from emp order by deptno)

�����ַ��飬�õ����,���÷���������д��

select empno,
       ename,
       deptno,
       (select count(*) from emp b where b.deptno < a.deptno) cn
  from emp a order by deptno 
����20��ʱ��cn �о��ǲ���10������

Ȼ�����������SQL���͵õ��˷������� ��� ��Ч��
select rownum - cn,empno,ename,deptno,cn
  from (select empno,
       ename,
       deptno,
       (select count(*) from emp b where b.deptno < a.deptno) cn
  from emp a order by deptno)
û�з������� �Ϳ��������SQL 

select row_number() over(order by hirdate) as rm,
       empno,
       ename,
       sal,
       hiredate
   from emp
   order by sal

select rownum, empno, ename, sal, hiredate
  from (select empno, ename, sal, hiredate from emp order by hiredate)

  
select row_number() over(partition by deptno order by sal) as rm,
       rank() over(partition by deptno order by sal) as rk,
       dense_rank() over(partition by deptno order by sal) as drk,
       empno,
       ename,
       sal,
       hiredate
   from emp
   
��������  ����ռ��,
����������ŵĹ������ܹ��ʵ�ռ�����
select deptno,s_sal,ratio_to_report(s_sal) over() from 
(select deptno,sum(sal) s_sal from emp group by deptno) 

���൱������������
select deptno,s_sal,s_sum, s_sal/s_sum from
(
select deptno,s_sal,sum(s_sal) over() s_sum from 
(select deptno,sum(sal) s_sal from emp group by deptno)
)

���������䣬
select deptno,job,sum(sal)
from emp
group by rollup(deptno,job)

5500/35250   ������/���ŵ�����
35250/ȫ��˾������

��һ�� �Ƚ��ϼ�����������ֿ�
select case
         when grouping(job) = 0 then
          deptno
         when grouping(job) = 1 then
          1
       end gp,
       deptno,
       job,
       sum(sal) s_sum
  from emp
 group by deptno,rollup(job)

�ڶ���,��ռ�ȷ����������м���

select deptno,job,s_sum,ratio_to_report(s_sum) over(partition by gp)
from 
(
select case
         when grouping(job) = 0 then
          deptno
         when grouping(job) = 1 then
          1
       end gp,
       deptno,
       job,
       sum(sal) s_sum
  from emp
 group by deptno,rollup(job)
)
