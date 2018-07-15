select * from emp_bonus

--加入约束，要求插入该列的值 小于等于当前的时间
insert into (
select hiredate from emp1 where hiredate <= sysdate
with check option
)
values (sysdate + 1)

--一个部门只能有两个人,多了的就插入不进去

insert into 
(
select a.deptno from emp1 a
where (select count(b.deptno) from emp1 b where b.deptno = a.deptno) <= 5
with check option
)
values(20)


--有开始时间，结束时间
新的项目时间和原来的项目时间不能重复，第一个项目从 1.1-1.6号
第二个项目只能是从1.7-1.8号

select * from emp2 


