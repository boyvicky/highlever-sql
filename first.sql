--ȡ�����������������һ��
/*first/last
keep ���淵��һ�����������ļ��ϣ�Ȼ����� keep ǰ��ľۺϺ��� ͨ���ۺϺ����������������*/

select * from (
select max(sal) over(partition by deptno) as max_sal,
       deptno,
       empno,
       ename,
       sal,
       hiredate
  from emp
)
where sal = max_sal
�����Ϊ����20���������Ĺ��ʣ���Ϊ3000�����Բ���20�������������ݣ�
��ֻ��Ҫһ��������ô�죿
select max(ename) keep(dense_rank first order by sal desc),  --���ݹ�������
       sum(sal) keep(dense_rank first order by sal desc),   --20���ŵĹ��� �������˵ĺϼƹ���
       max(sal) keep(dense_rank first order by sal desc),   --20���ŵĹ���ȡ��һ������
       to_char(wm_concat(ename) keep(dense_rank first order by sal desc)),
       deptno
  from emp
 group by deptno;

������� row_number Ҳ����ʵ�֣�����rank ��ʵ�ֲ���
select * from 
(
select rank() over(partition by deptno order by sal desc) rnk,
       row_number() over(partition by deptno order by sal desc) rn,
       deptno,
       empno,
       ename,
       sal,
       hiredate
  from emp
)
where rn = 1;--rnk = 1;


���������⼸��������
select max(ename) keep(dense_rank first order by sal desc),  --ֻȡ�������Ź������ģ�������������һ���˵�����
       to_char(wm_concat(ename) keep(dense_rank first order by sal desc)), --ֻȡ�������Ź��������˵�����,�м����˲��о�ȡ������
       to_char(wm_concat(ename)),--ȡ�����ŵ�ȫ���˵�����
       listagg(ename,',') within group(order by sal),  --ȡ�����ŵ�ȫ���˵�����
       deptno
  from emp
  group by deptno
  
Ҳ���Բ����ܣ������OVER
ȡ���������Ź�����ߵ��˵�������
SELECT MAX(ENAME) keep(dense_rank first order by sal desc) OVER(PARTITION BY DEPTNO) MM,
       ename,
       DEPTNO,
       EMPNO,
       SAL,
       HIREDATE
  FROM EMP;
