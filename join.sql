declare 

begin
  for i in 1..100 loop
insert into t100 values (i);
end loop;

end;

做一个年报表：每个月的数据都应该有
select * from 
(
--1981年十二个月
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

