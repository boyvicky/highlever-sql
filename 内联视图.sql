������ͼ

create table subtest as 
select 'A' flag,'1' num from dual
union all
select 'B' flag,'2B' num from dual
union all
select 'C' flag,'3' num from dual

ֱ��������ͻᱨ��ԭ������Ӳ�ѯ�����ϲ�
select * from 
(
select flag,to_number(num) n from subtest where flag in ('A','C')
)
where n > 1;

��ʱ����ֻ��Ҫ���һ��α�оͿ��Ա���
select * from 
(
select rownum as rn,flag,to_number(num) n from subtest where flag in ('A','C')
)
where n > 1;
������with as

with v as (
select /*+ materialize */ flag,to_number(num) as n from subtest where flag in ('A','C'))
select * from v where n > 1;


�п��ܻ�ı���������£�oracle ����ϲ�
select * from 
(
select rownum as rn,flag,to_number(num) n from subtest where flag in ('A','C')
)
where n > 1;  --������rn = 2


select rownum as rn,flag,to_number(num) n from subtest where flag in ('A','C')
and num>'1' --������rn = 1
�п��ܻ�ı���������£�oracle ����ϲ�
