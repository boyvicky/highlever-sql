select a.lv,nvl(b.s_sal,0) from (
select level lv from dual
connect by level <= 
(select max(to_number(to_char(hiredate,'mm'))) from emp where to_char(hiredate,'yyyy') = '1981')
) a
left join (
select --to_char(hiredate,'yyyymm'),
       to_number(to_char(hiredate,'mm')) mm,
       sum(sal) s_sal
  from emp 
where to_char(hiredate,'yyyy') = '1981'  
group by to_number(to_char(hiredate,'mm'))
) b
on a.lv = b.mm
order by 1
