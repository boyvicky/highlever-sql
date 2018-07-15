wm_concat 不是一个公开的函数
select deptno,to_char(wm_concat(ename)) from emp group by deptno 

10G varchar
11G clob
12C

select deptno, listagg(ename,',') within group(order by ename) dd
  from emp
 group by deptno


select deptno,ename, listagg(ename,',') within group(order by ename) over(partition by deptno) dd
  from emp

