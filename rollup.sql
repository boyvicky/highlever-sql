select deptno,sum(sal) from emp group by deptno
union all
select null,sum(sal) from emp /*group by null*/

һ���л��ܵ�ʱ���������������ܺ���ûʲô����
select deptno,sum(sal) from emp group by rollup(deptno);
select deptno,sum(sal) from emp group by cube(deptno);

�����л��ܵ�ʱ��
/*���λ���*/
select deptno,job,sum(sal) from emp group by rollup(deptno,job);

/*ö�����е����*/ --1 ����ְλ 2 ���ݲ��� 3 ���ݲ��ź�ְλ 4 ȫ������
select deptno,job,sum(sal) from emp group by cube(deptno,job);
�൱���������SQL
select deptno,job,sum(sal) from emp group by (deptno,job)
union all
select deptno,null,sum(sal) from emp group by deptno
union all 
select null,null,sum(sal) from emp 


���൱���������SQL
select null,job,sum(sal) from emp group by job
union all
select deptno,null,sum(sal) from emp group by deptno
union all
select deptno,job,sum(sal) from emp group by (deptno,job)
union all 
select null,null,sum(sal) from emp 


select nvl(to_char(deptno),'�ϼ�'),
       decode(deptno,null,null,nvl(job,'С��')),
       sum(sal)
  from emp
 group by rollup(deptno,job);
����д�� ���job��ϸ�����п�ֵ��ʱ��С�ƾͳ��������ˡ�

�ú���grouping
select nvl(to_char(deptno),'�ϼ�'),
       decode(deptno,null,null,nvl(job,'С��')),
       grouping(deptno),
       grouping(job),
       sum(sal)
  from emp
 group by rollup(deptno,job);
 

��decode д�����������������ж�Ļ�����һ�����ķ���
select decode(grouping(deptno),1,'�ϼ�',to_char(deptno)) deptno,
       decode(grouping(deptno),1,null,decode(grouping(job),1,'С��',job)) job,
/*       grouping(deptno),
       grouping(job),*/
       sum(sal)
  from emp
 group by rollup(deptno,job);
 
��grouping_id,grouping(deptno)��grouping(job) ��Ϊ1��ʱ��grouping_id Ϊ������11��Ϊ3��
              grouping(deptno)Ϊ0 grouping(job)Ϊ1��ʱ��grouping_id Ϊ������01��Ϊ1;
select grouping(deptno),
       grouping(job),
       grouping_id(deptno,job),  --������������е�grouping�Ķ����Ƶ�ֵ
       sum(sal)
  from emp
 group by rollup(deptno,job)
 
 
select decode(grouping(deptno),1,'�ϼ�',to_char(deptno)) deptno,
       decode(grouping_id(deptno,job),3,null,1,'С��',0,job) job, 
       sum(sal)
  from emp
 group by rollup(deptno,job)
 
���ֻ��Ҫһ���ܼƣ�����Ҫ�ֱ��С��Ӧ����ô�����أ�
ֻ��Ҫ��rollup������Ƕ��һ�����ż��ɡ�
���Ǽ��λ��ܵ�ʱ�򣬽���������ĵ���һ������������ж��ˣ�Ҳ����������ϣ�������������һ��
���л��ܡ�
select deptno,
       job,
       sum(sal)
   from emp
   group by rollup((deptno,job))
