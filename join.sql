declare 

begin
  for i in 1..100 loop
insert into t100 values (i);
end loop;

end;

��һ���걨��ÿ���µ����ݶ�Ӧ����
select * from 
(
--1981��ʮ������
select to_char(add_months(to_date(19810101,'yyyymmdd'),id - 1),'yyyymm') as ym
from t100
where id<=12
) a left join 
(
select to_char(hiredate,'yyyymm') as ym,sum(sal) as sal
from emp e
where e.hiredate >= to_date(19810101,'yyyymmdd')
  and e.hiredate < to_date(19820101,'yyyymmdd')
  group by to_char(hiredate,'yyyymm')
) b
on a.ym = b.ym
order by 1

