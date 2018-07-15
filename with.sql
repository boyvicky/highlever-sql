select e.empno,e.ename,e.sal,mgr.mgr_name
  from emp e
 left join (select empno as mgrno,ename as mgr_name from emp) mgr
   on (mgr.mgrno = e.mgr)
   
with mgr
as (select empno as mgrno,ename as mgr_name from emp)
select e.empno,e.ename,e.sal,mgr.mgr_name
 from emp e
 left join mgr
 on e.empno = mgr.mgrno
 
 --�Ӹ���ʾ ����һ����ʱ�����������õ�ʱ��ͻ����������
with mgr
as (select /*+ materialize*/empno as mgrno,ename as mgr_name from emp)
select e.empno,e.ename,e.sal,mgr.mgr_name
 from emp e
 left join mgr
 on e.empno = mgr.mgrno
 

�� with ģ�����β�ѯ

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
SELECT * FROM E1
