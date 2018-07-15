--随机排序( dbms_random.value)
--随机取出六条数据：
select * from (
select dbms_random.value r,e.* from emp e
order by 1)
where rownum <=6

注意：
--ORDER BY 后面只能接数字，不能接表达式。

select * from emp order by 2;
select * from emp order by 1+1;
两条语句是什么区别？
看下执行计划：

select * from emp order by 2;
 Plan Hash Value  : 150391907 

---------------------------------------------------------------------
| Id | Operation            | Name | Rows | Bytes | Cost | Time     |
---------------------------------------------------------------------
|  0 | SELECT STATEMENT     |      |   18 |  1566 |    4 | 00:00:01 |
|  1 |   SORT ORDER BY      |      |   18 |  1566 |    4 | 00:00:01 |
|  2 |    TABLE ACCESS FULL | EMP  |   18 |  1566 |    3 | 00:00:01 |
---------------------------------------------------------------------

Note
-----
- dynamic sampling used for this statement


select * from emp order by 1+1;

Plan Hash Value  : 3956160932 

--------------------------------------------------------------------
| Id | Operation           | Name | Rows | Bytes | Cost | Time     |
--------------------------------------------------------------------
|  0 | SELECT STATEMENT    |      |   18 |  1566 |    3 | 00:00:01 |
|  1 |   TABLE ACCESS FULL | EMP  |   18 |  1566 |    3 | 00:00:01 |
--------------------------------------------------------------------

Note
-----
- dynamic sampling used for this statement

看执行计划，第二个SQL语句根本就没有排序。
注意：
--ORDER BY 后面只能接数字，不能接表达式。

--随机函数：

select dbms_random.value from dual;

select dbms_random.value r,e.* from emp e order by 1
--返回随机的前六行数据
错误写法：
select dbms_random.value r,e.* from emp e 
where rownum <=6
order by 1 

select 子句的执行顺序
1.from ...
2.where ...
3.select ...
4.order by ...

rownum 在where 条件里面，先执行的是取出六条数据。

正确写法：
select * from (
select dbms_random.value r,e.* from emp e
order by 1)
where rownum <=6
