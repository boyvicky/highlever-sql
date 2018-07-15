mysql 的分页
直接用limit
select * from emp limit 3,10;  直接从第三行开始，显示10行。

oracle  直接用limit 就不可以了，但是分页利用特性伪列 rownum

select rownum rn,cust_id, cust_first_name,cust_last_name,cust_gender
  from sh.customers
 order by cust_id
 
分页的顺序
/*
1 按照 order by 顺序
2 按照 rownum 顺序
*/

取出前20行数据
select rownum rn,cust_id, cust_first_name,cust_last_name,cust_gender
  from (
select cust_id,cust_first_name,cust_last_name,cust_gender
  from sh.customers
 order by cust_id)
where rownum <= 20

取10行到20行的数据
select *
from (
select rownum rn,cust_id, cust_first_name,cust_last_name,cust_gender
  from (
select cust_id,cust_first_name,cust_last_name,cust_gender
  from sh.customers
 order by cust_id)
where rownum <= 20)
where rn >= 11;

也可以用分析函数
select * from (
select row_number() over(order by cust_id) as sn,
cust_id,cust_first_name,cust_last_name,cust_gender
  from sh.customers)
where sn >=11
and sn <= 20;

用分析函数，唯一的问题在于
能不能使用高效的索引
