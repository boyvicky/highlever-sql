�ۼ�
select trunc(hiredate, 'mm') as ym, sum(sal) as sal
  from emp
 group by trunc(hiredate, 'mm')
 order by 1
 
800
800+2850
800+2850+2975
...

��ͳд��
with a as 
(select trunc(hiredate, 'mm') as ym, sum(sal) as sal
  from emp
 group by trunc(hiredate, 'mm'))
select ym,sal,(select sum(b.sal) from a b where b.ym<=a.ym) from a
order by 1

with v0 as 
(select trunc(hiredate, 'mm') as ym, sum(sal) as sal
  from emp
 group by trunc(hiredate, 'mm'))
select a.*,b.* from v0 a,v0 b where b.ym<a.ym
order by a.ym,b.ym


/*�ۼ� ��������ʡ�Ծ�*/

with v0 as 
(select trunc(hiredate, 'mm') as ym, sum(sal) as sal
  from emp
 group by trunc(hiredate, 'mm'))
select a.*, 
       sum(sal) over(order by ym range between unbounded preceding --��һ��
                                           and current row) --��ǰ��
  from v0 a
  
range ��Χ
����һ�� ��>=��  �� ��<=��

select empno,ename,job,sal,sum(sal) over(order by job) from emp

select (30+30+8+9.5+13+11)*100 from dual

������
1-2�� �ۼ�
1-3�� �ۼ�
1-4�� �ۼ�

select to_char(hiredate, 'yyyy') yy,
       to_char(hiredate, 'yyyymm') mm,
       empno,
       ename,
       sal,
       sum(sal) over(partition by to_char(hiredate, 'yyyy') order by to_char(hiredate, 'yyyymm')) ad
  from emp;
  
select empno,
       ename,
       sal,
       sum(sal) over(order by sal range between unbounded preceding and current row) ad
  from emp;  
ע�⣺���������������������ظ��Ĺ��ʼ���������
ʵ���ϣ��ڵ����У������е�ʱ�� ����ֵ��ȣ�
�����У� sum(sal) where sal between 800 and 1250
�����У� sum(sal) where sal between 800 and 1250

Ϊ�˱������֣�ֻ��Ҫ����һ�����ظ����ֶμ���
select empno,
       ename,
       sal,
       sum(sal) over(order by sal,empno range between unbounded preceding and current row) ad
  from emp;   

��һ�ַ���
�ؼ��� range �滻����������ֵ�����ܣ������� ������
select empno,
       ename,
       sal,
       sum(sal) over(order by sal rows between unbounded preceding and current row) ad
  from emp; 



Ҳ���Բ��� �ؼ��� unbounded  ��һ��
select empno,
       ename,
       sal,
       sum(sal) over(order by sal range between 200 preceding and current row) ad
  from emp; 
������������Ǵ���

sum(sal) where sal between current row - 200 and current row  
���ǵ�ǰ�� - 200 ��ֵ��ʼ�ۼӵ���ǰ��

��Щ�е����Ϳ��ԼӼ��أ�
/*number , date  */

/*ǰ�����е���ǰ��*/
select empno,
       ename,
       sal,
       sum(sal) over(order by sal rows between 3 preceding and current row) ad
  from emp;

3 7876  ADAMS 1100.00 2850
4 7521  WARD  1250.00 4100
5 7654  MARTIN  1250.00 4550
6 7934  MILLER  1300.00 4900
�Ե����о�������ǰ����6 - 3 ���ӵ����п�ʼ�ۼӵ�������

/*���� + ����*/
select empno,
       ename,
       sal,
       hiredate,
       sum(sal) over(order by hiredate range between 1 preceding and current row) ad
  from emp; 
