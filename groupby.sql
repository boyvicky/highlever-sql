select deptno,job,sum(sal) from emp group by deptno,job order by 1,2

select distinct deptno,job from emp

--������ʾ����
select sal from emp where empno = '1111'
--����ʾһ������
select sum(sal) from emp where empno = '1111'

declare 
 v_empno number := 1111;
 v_ename varchar2(30);
begin
  select ename into v_ename from emp where empno= v_empno;
end;

�����Ҳ�������

����һ�� MAX()�����Ͳ��ᱨ���ˡ�
declare 
 v_empno number := 1111;
 v_ename varchar2(30);
 V_CNT NUMBER;
begin
  select MAX(ename),COUNT(*) into v_ename,V_CNT from emp where empno= v_empno;
  dbms_output.put_line(v_ename);
  dbms_output.put_line(v_cnt);
end;


�ۺϺ��� ���Զ����Կ�ֵ
select deptno,sum(comm),max(comm),min(comm) from emp group by deptno

�����������Ϊ��ʱ������0����
select deptno,sum(comm),max(comm),min(nvl(comm,0)) from emp group by deptno
ƽ��ֵ��ʱ�� ���������
select deptno,
       sum(comm),
       max(comm),
       min(nvl(comm, 0)),
       avg(comm),   --��û����ɵ��˺�����
       avg(nvl(comm, 0))  --�Ƚ�û����ɵ���ת����0������ò�������
  from emp
 group by deptno

--Ҫ�ǲ�ѯһ���м������ţ���Ҫ�Ӳ��ű�����ѡ�ֶ�
select count(distinct e.deptno),count(distinct d.deptno)
  from dept d
  left join emp e
  on d.deptno = e.deptno
  
--Ҫ�ǲ�ѯÿ�������ж��ٸ�Ա������Ҫ��Ա��������ѡ�ֶ�
select d.deptno, count(d.deptno) AS �������ŵ�����, count(e.deptno) AS ����
  from dept d
  left join emp e
    on d.deptno = e.deptno
 group by d.deptno
