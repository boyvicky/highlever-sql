select * from user_tab_cols where table_name = 'EMP1'



select to_char(sysdate,'day') from dual
union all
select to_char(sysdate,'d') from dual
union all
select to_char(sysdate,'dy') from dual;

select to_char(sysdate,'yyyy-mm-dd') from dual;


select to_char(sysdate,'yyyy-mon-dd day hh24:mi:ss') from dual;

select * from emp where hiredate = date '1980-12-17'


在进行月末加减的时候会遇到以下问题

select add_months(date '2015-03-31', -1) from dual
union all
select add_months(date '2015-03-30', -1) from dual
union all
select add_months(date '2015-03-29', -1) from dual
union all
select add_months(date '2015-03-28', -1) from dual;

月末的这几天减一个月的时候都是2015-02-28 这一天。

案例：
/*计算一下招聘时间间隔*/
select * from emp order by hiredate
一、不用分析函数的写法
with v as
 (select rownum rn, EMPNO, ENAME, HIREDATE
    from (select e.* from emp e order by hiredate))
select a.rn,
       a.EMPNO,
       a.ENAME,
       a.HIREDATE,
       b.rn,
       b.EMPNO,
       b.ENAME,
       b.HIREDATE,
       a.hiredate - b.hiredate hir
       from v a,v b where a.rn = b.rn + 1

用分析函数写
select empno,
       ename,
       hiredate,
       lead(hiredate) over(order by hiredate),
       lag(hiredate) over(order by hiredate)
  from emp
  
  


select to_char(sysdate,'yyyy-q') from dual;   --2017-1  2017年一季度
select to_char(sysdate,'mon-dy') from dual;   --3月 -星期二
select to_date('2017-02','yyyy-mm') from dual;  --2017/2/1
select to_date('2017','yyyy') from dual;        --2017/3/1  注意当月一号

select trunc(sysdate,'yyyy') from dual;
select trunc(sysdate,'mm') from dual;
select trunc(sysdate,'dd'),sysdate from dual; 

/*查询今天的数据*/
select *
  from emp
 where hiredate >= trunc(sysdate, 'dd') - 1
   and hiredate < trunc(sysdate, 'dd')

/*如果不使用trunc就是带时分秒的值了*/
select sysdate-1,sysdate from dual;

/*查询上个月的数据*/
select add_months(trunc(sysdate,'mm'),-1),trunc(sysdate,'mm') from dual;


/*假设需要生成本月日期明细*/

/*一、取出本月多少天*/
select to_char(last_day(sysdate),'dd') from dual;
生成天数，从1到31，然后在用本月一号按天加日期
select level from dual connect by level <= to_char(last_day(sysdate),'dd');

/*枚举一个月*/
select trunc(sysdate, 'mm') + level - 1
  from dual
connect by level <= to_char(last_day(sysdate), 'dd');

/*枚举一个周*/
select trunc(sysdate, 'd') from dual;
select trunc(sysdate, 'd') + level from dual connect by level <= 7;

/*第几周*/
/*按当月第一天算第一周第一天计算*/
select d,to_char(d,'w') from (
select trunc(sysdate, 'mm') + (level - 1) as d
  from dual
connect by level <= to_char(last_day(sysdate), 'dd')
);

/*按年初为第一周计算，用iw，一个月可能会有6周*/
select d,to_char(d,'w'),to_char(d,'d'),to_char(d,'iw') from (
select trunc(sysdate, 'mm') + (level - 1) as d
  from dual
connect by level <= to_char(last_day(sysdate), 'dd')
);

/*通过加减，通用可以枚举字母*/
select chr(64 + level) from dual connect by level <= 26;

--日历
with v1 as (
select trunc(sysdate, 'mm') + (level - 1) as d
  from dual
connect by level <= to_char(last_day(sysdate), 'dd')
),v2 as (
select to_char(d,'iw') iw,to_char(d,'d') wd,d from v1
)
select iw,
      max(decode(wd,2,d)) as w1,
      max(decode(wd,3,d)) as w2,
      max(decode(wd,4,d)) as w3,
      max(decode(wd,5,d)) as w4,
      max(decode(wd,6,d)) as w5,
      max(decode(wd,7,d)) as w6,
      max(decode(wd,1,d)) as w7
 from v2
 group by iw
 order by iw
