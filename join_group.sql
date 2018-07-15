员工奖金信息表
select * from emp_bonus 

create table emp_bonus
as 
select '7934' empno,to_date(20050517,'yyyymmdd') received,'1' type from dual
union all
select '7934' empno,to_date(20050215,'yyyymmdd') received,'2' type from dual
union all
select '7839' empno,to_date(20050215,'yyyymmdd') received,'3' type from dual
union all
select '7782' empno,to_date(20050215,'yyyymmdd') received,'1' type from dual

type = 1 sal*10%
type =2 sal *20%
type =3 sal*30%
对应的员工奖金工资是多少

select e.empno,
       e.ename,
       e.sal,
       case
         when b.type = '1' then
          sal * 0.1
         when b.type = '2' then
          sal * 0.2
         when b.type = '3' then
          sal * 0.3
          else sal
       end sal_a
  from emp e
  join emp_bonus b
    on e.empno = b.empno
  
因为 7934 有两个，所以看下所有工资数和奖金数是怎么求和的； 
    
  select sum(sal),sum(sal_a) from (
    select e.empno,
       e.ename,
       e.sal,
       case
         when b.type = '1' then
          sal * 0.1
         when b.type = '2' then
          sal * 0.2
         when b.type = '3' then
          sal * 0.3
          else sal
       end sal_a
  from emp e
  join emp_bonus b
    on e.empno = b.empno)
    
 因为 7934 有两个，所以需要先将粒度搞成一致，都先搞成员工粒度的，然后在求和。   
      select sum(sal),sum(sal_a) from (
    select e.empno,
       e.ename,
       e.sal,
       e.sal* b.comm sal_a
  from emp e
  join  (select empno,sum(case
         when b.type = '1' then
           0.1
         when b.type = '2' then
          0.2
         when b.type = '3' then
           0.3
       end) comm from emp_bonus b group by empno) b
    on e.empno = b.empno)
   
