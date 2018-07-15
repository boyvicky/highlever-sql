内联视图

create table subtest as 
select 'A' flag,'1' num from dual
union all
select 'B' flag,'2B' num from dual
union all
select 'C' flag,'3' num from dual

直接这样查就会报错，原因就是子查询发生合并
select * from 
(
select flag,to_number(num) n from subtest where flag in ('A','C')
)
where n > 1;

这时我们只需要添加一个伪列就可以避免
select * from 
(
select rownum as rn,flag,to_number(num) n from subtest where flag in ('A','C')
)
where n > 1;
或者用with as

with v as (
select /*+ materialize */ flag,to_number(num) as n from subtest where flag in ('A','C'))
select * from v where n > 1;


有可能会改变结果的情况下，oracle 不会合并
select * from 
(
select rownum as rn,flag,to_number(num) n from subtest where flag in ('A','C')
)
where n > 1;  --这里面rn = 2


select rownum as rn,flag,to_number(num) n from subtest where flag in ('A','C')
and num>'1' --这里面rn = 1
有可能会改变结果的情况下，oracle 不会合并
