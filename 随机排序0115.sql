--�������( dbms_random.value)
--���ȡ���������ݣ�
select * from (
select dbms_random.value r,e.* from emp e
order by 1)
where rownum <=6

ע�⣺
--ORDER BY ����ֻ�ܽ����֣����ܽӱ��ʽ��

select * from emp order by 2;
select * from emp order by 1+1;
���������ʲô����
����ִ�мƻ���

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

��ִ�мƻ����ڶ���SQL��������û������
ע�⣺
--ORDER BY ����ֻ�ܽ����֣����ܽӱ��ʽ��

--���������

select dbms_random.value from dual;

select dbms_random.value r,e.* from emp e order by 1
--���������ǰ��������
����д����
select dbms_random.value r,e.* from emp e 
where rownum <=6
order by 1 

select �Ӿ��ִ��˳��
1.from ...
2.where ...
3.select ...
4.order by ...

rownum ��where �������棬��ִ�е���ȡ���������ݡ�

��ȷд����
select * from (
select dbms_random.value r,e.* from emp e
order by 1)
where rownum <=6
