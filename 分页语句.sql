mysql �ķ�ҳ
ֱ����limit
select * from emp limit 3,10;  ֱ�Ӵӵ����п�ʼ����ʾ10�С�

oracle  ֱ����limit �Ͳ������ˣ����Ƿ�ҳ��������α�� rownum

select rownum rn,cust_id, cust_first_name,cust_last_name,cust_gender
  from sh.customers
 order by cust_id
 
��ҳ��˳��
/*
1 ���� order by ˳��
2 ���� rownum ˳��
*/

ȡ��ǰ20������
select rownum rn,cust_id, cust_first_name,cust_last_name,cust_gender
  from (
select cust_id,cust_first_name,cust_last_name,cust_gender
  from sh.customers
 order by cust_id)
where rownum <= 20

ȡ10�е�20�е�����
select *
from (
select rownum rn,cust_id, cust_first_name,cust_last_name,cust_gender
  from (
select cust_id,cust_first_name,cust_last_name,cust_gender
  from sh.customers
 order by cust_id)
where rownum <= 20)
where rn >= 11;

Ҳ�����÷�������
select * from (
select row_number() over(order by cust_id) as sn,
cust_id,cust_first_name,cust_last_name,cust_gender
  from sh.customers)
where sn >=11
and sn <= 20;

�÷���������Ψһ����������
�ܲ���ʹ�ø�Ч������
