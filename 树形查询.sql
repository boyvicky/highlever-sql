һ���쵼���ϼ��ǿ�ֵ
���쵼��ʼ��ѯ�������е�Ա��
select * from emp
start with mgr is null
connect by mgr = prior empno

�����Ҫ��ѯ7566�������е���Ա
select * from emp
start with empno = 7566
connect by mgr = prior empno

/*���Ų�֣�7566����������һ�����ţ���Ա��������ȥ��
Ҫ��ѯ������7566��Ͻ����Ա*/
select * from emp
start with mgr is null
connect by mgr = prior empno and empno <> 7566

/*path*/
select empno,ename,substr(sys_connect_by_path(ename,'->'),3) from emp
start with mgr is null
connect by mgr = prior empno

--ltrim(�Լ���ѯһ���������)

������·���ǵ�ַ��Ϣ������סַ��Ϣ��
--�й�--����--��ˮ��
���β�ѯ��Ӧ�������β�ѯ���ص�
�и����з�֧����Ҷ��
/*root  branch  leaf */
������Ҫ��������֧��Ҷ�ӱ�ǳ���
select empno,
       ename,
       substr(sys_connect_by_path(ename,'->'),3) as fullpath,
       connect_by_isleaf,  --α��,����Ϊ1��ʱ�򣬾���Ҷ�ӽڵ�
       rownum,
       level,   --��LEVEL<>1 and connect_by_isleaf<>1��ʱ����Ƿ�֧�ڵ�  level=1��ʱ����Ǹ��ڵ�
       case when connect_by_isleaf = 1 then 'leaf'
            when level = 1 then 'root'
            else 'branch' end as rbl
   from emp
  start with mgr is null
  connect by mgr = prior empno
 
Ӧ�ã���ʱ��˵���һЩ��Ϣ Ҷ�ӽڵ��к�����һ����������֧�ڵ�ֱ���������˵�

��������밴·�����������������
select empno,
       ename,
       substr(sys_connect_by_path(ename,'->'),3) as fullpath,
       connect_by_isleaf,  --α��,����Ϊ1��ʱ�򣬾���Ҷ�ӽڵ�
       rownum,
       level,   --��LEVEL<>1 and connect_by_isleaf<>1��ʱ����Ƿ�֧�ڵ�  level=1��ʱ����Ǹ��ڵ�
       case when connect_by_isleaf = 1 then 'leaf'
            when level = 1 then 'root'
            else 'branch' end as rbl
   from emp
  start with mgr is null
  connect by mgr = prior empno
  --order by ename /*����*/
  order siblings by ename


��Ҫ��ĳ��Ա���ĸ��ڵ㣬Ӧ����ô����
select empno,
       ename,
       mgr,
       connect_by_root(ename)
  from emp
  start with mgr is null
  connect by mgr = (prior empno)
  
Ҳ���ԴӾ���ʼ��ѯ

select empno,
       ename,
       mgr,
       job,
       connect_by_root(ename)
  from emp
  start with job = 'MANAGER'
  connect by mgr = (prior empno)
 
��Ҫ�ҵ��� ����ɽ ���ĸ�ʡ��
ֻ��Ҫ������������Ƕ��һ��
select * from (
 select empno,
       ename,
       mgr,
       job,
       connect_by_root(ename)
  from emp
  start with job = 'MANAGER'
  connect by mgr = (prior empno)
)
where ename = '����ɽ'

/*ִ��˳��*/
1.ִ�� start with
2.ִ�� where

--��ò�Ҫ����д
1. select empno,
       ename,
       mgr,
       job
  from emp
  where deptno = 20
  start with mgr is null
  connect by mgr = (prior empno)
  
�ȼ���(�Ƽ�����д)
2. 
select * from (
select empno,
       ename,
       mgr,
       job
  from emp
  start with mgr is null
  connect by mgr = (prior empno)
  )
 where deptno = 20
 
 �����Ҫ�ȹ������� ��д��
 select empno,
       ename,
       mgr,
       job
  from (select * from emp where deptno = 20)
  start with mgr is null
  connect by mgr = (prior empno)

��with as ģ�����β�ѯ
with E1(EMPNO,
ENAME,
JOB,
MGR,
LV,
P) AS
 (SELECT EMPNO, ENAME, JOB, MGR, 1 LV, ENAME P
    FROM EMP
   WHERE MGR IS NULL
  UNION ALL
  SELECT E.EMPNO,
         E.ENAME,
         E.JOB,
         E.MGR,
         PRIO.LV + 1 LV,
         PRIO.P || '->' || E.ENAME P
    FROM E1 PRIO
    JOIN EMP E
      ON PRIO.EMPNO = E.MGR)
SELECT * FROM E1;


��SQLģ��listagg����

select a.*,level lv,substr(sys_connect_by_path(ename,','),2) from (
select EMPNO,
       ENAME,
       JOB,
       DEPTNO,
       row_number() over(partition by deptno order by empno) sn
  from emp) a
 where connect_by_isleaf = 1
start with sn = 1 
connect by deptno = prior deptno and sn = prior (sn + 1)

����ַ�����
create table t_substr as 
select deptno,substr(sys_connect_by_path(ename,','),2) ab from (
select EMPNO,
       ENAME,
       JOB,
       DEPTNO,
       row_number() over(partition by deptno order by empno) sn
  from emp) a
 where connect_by_isleaf = 1
start with sn = 1 
connect by deptno = prior deptno and sn = prior (sn + 1);

select * from t_substr;
�������ֲ��ֻ���ǲ��һ�����ŵģ�����Ƕ�����žͻ�������⡣
select deptno,regexp_substr(ab,'[^,]+',1,level) 
  from (select * from t_substr where deptno = 10)
 connect by level <= regexp_count(ab,',') + 1
--���ݶ��ˣ���Ϊѭ���Ӹ������Ŷ�ѭ����һ��
select deptno,regexp_substr(ab,'[^,]+',1,level) 
  from t_substr
 connect by level <= regexp_count(ab,',') + 1
 ��ʱ ����һ��distinct �ͻ���ˡ�
 
--��ȷд��
select deptno,regexp_substr(ab,'[^,]+',1,level) 
  from t_substr
 connect by level <= regexp_count(ab,',') + 1
 and deptno = prior deptno  --��ͬһ��������ѭ��,���ǻᱨ����ѭ��
 and (prior dbms_random.value) is not null;   --��ֹ����������������ORACLE �ⲻ����ѭ��
