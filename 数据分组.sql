需求，每三行数据为一组
这样写SQL，就得到了每三行一组的数据
select ceil(rn/3),job,sal from(
select rownum rn,job,sal from emp)

还有一些数据不是数字，例如时间应该怎么分组

create table test_time as 
select sysdate + level/24/60/60 as t from dual connect by level <= 65

/*5秒一组*/
先将里面的秒取出来
select t,ceil(to_char(t,'ss')/5),
       floor(to_char(t,'ss')/5)
  from test_time;

用ceil 的时候在零秒的时候单独是一组了，不符合需求，所以用floor 0-4s为一组数据
select t,
       floor(to_char(t,'ss')/5)
  from test_time;
  
  
有个活动，将人分成三组，不在乎组合
--按照名字排序分成4组
select ntile(4) over(order by empno) as gp, empno, ename, job, deptno
  from emp;
  
--随机分成5组
select ntile(5) over(order by dbms_random.value) as gp, empno, ename, job, deptno
  from emp;
