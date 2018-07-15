select deptno,job,sum(sal) from emp group by deptno,job order by 1,2

select distinct deptno,job from emp

--不会显示数据
select sal from emp where empno = '1111'
--会显示一个空行
select sum(sal) from emp where empno = '1111'

declare 
 v_empno number := 1111;
 v_ename varchar2(30);
begin
  select ename into v_ename from emp where empno= v_empno;
end;

报错，找不到数据

加上一个 MAX()函数就不会报错了。
declare 
 v_empno number := 1111;
 v_ename varchar2(30);
 V_CNT NUMBER;
begin
  select MAX(ename),COUNT(*) into v_ename,V_CNT from emp where empno= v_empno;
  dbms_output.put_line(v_ename);
  dbms_output.put_line(v_cnt);
end;


聚合函数 会自动忽略空值
select deptno,sum(comm),max(comm),min(comm) from emp group by deptno

提成这种数据为空时常当做0处理
select deptno,sum(comm),max(comm),min(nvl(comm,0)) from emp group by deptno
平均值的时候 会存在问题
select deptno,
       sum(comm),
       max(comm),
       min(nvl(comm, 0)),
       avg(comm),   --将没有提成的人忽略了
       avg(nvl(comm, 0))  --先将没有提成的人转换成0，计算该部分人数
  from emp
 group by deptno

--要是查询一共有几个部门，就要从部门表里面选字段
select count(distinct e.deptno),count(distinct d.deptno)
  from dept d
  left join emp e
  on d.deptno = e.deptno
  
--要是查询每个部门有多少个员工，就要从员工表里面选字段
select d.deptno, count(d.deptno) AS 关联后部门的条数, count(e.deptno) AS 人数
  from dept d
  left join emp e
    on d.deptno = e.deptno
 group by d.deptno
