select * from user_tab_cols where table_name = 'EMP1'



select to_char(sysdate,'day') from dual
union all
select to_char(sysdate,'d') from dual
union all
select to_char(sysdate,'dy') from dual;

select to_char(sysdate,'yyyy-mm-dd') from dual;


select to_char(sysdate,'yyyy-mon-dd day hh24:mi:ss') from dual;

select * from emp where hiredate = date '1980-12-17'


�ڽ�����ĩ�Ӽ���ʱ���������������

select add_months(date '2015-03-31', -1) from dual
union all
select add_months(date '2015-03-30', -1) from dual
union all
select add_months(date '2015-03-29', -1) from dual
union all
select add_months(date '2015-03-28', -1) from dual;

��ĩ���⼸���һ���µ�ʱ����2015-02-28 ��һ�졣

������
/*����һ����Ƹʱ����*/
select * from emp order by hiredate
һ�����÷���������д��
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

�÷�������д
select empno,
       ename,
       hiredate,
       lead(hiredate) over(order by hiredate),
       lag(hiredate) over(order by hiredate)
  from emp
  
  


select to_char(sysdate,'yyyy-q') from dual;   --2017-1  2017��һ����
select to_char(sysdate,'mon-dy') from dual;   --3�� -���ڶ�
select to_date('2017-02','yyyy-mm') from dual;  --2017/2/1
select to_date('2017','yyyy') from dual;        --2017/3/1  ע�⵱��һ��

select trunc(sysdate,'yyyy') from dual;
select trunc(sysdate,'mm') from dual;
select trunc(sysdate,'dd'),sysdate from dual; 

/*��ѯ���������*/
select *
  from emp
 where hiredate >= trunc(sysdate, 'dd') - 1
   and hiredate < trunc(sysdate, 'dd')

/*�����ʹ��trunc���Ǵ�ʱ�����ֵ��*/
select sysdate-1,sysdate from dual;

/*��ѯ�ϸ��µ�����*/
select add_months(trunc(sysdate,'mm'),-1),trunc(sysdate,'mm') from dual;


/*������Ҫ���ɱ���������ϸ*/

/*һ��ȡ�����¶�����*/
select to_char(last_day(sysdate),'dd') from dual;
������������1��31��Ȼ�����ñ���һ�Ű��������
select level from dual connect by level <= to_char(last_day(sysdate),'dd');

/*ö��һ����*/
select trunc(sysdate, 'mm') + level - 1
  from dual
connect by level <= to_char(last_day(sysdate), 'dd');

/*ö��һ����*/
select trunc(sysdate, 'd') from dual;
select trunc(sysdate, 'd') + level from dual connect by level <= 7;

/*�ڼ���*/
/*�����µ�һ�����һ�ܵ�һ�����*/
select d,to_char(d,'w') from (
select trunc(sysdate, 'mm') + (level - 1) as d
  from dual
connect by level <= to_char(last_day(sysdate), 'dd')
);

/*�����Ϊ��һ�ܼ��㣬��iw��һ���¿��ܻ���6��*/
select d,to_char(d,'w'),to_char(d,'d'),to_char(d,'iw') from (
select trunc(sysdate, 'mm') + (level - 1) as d
  from dual
connect by level <= to_char(last_day(sysdate), 'dd')
);

/*ͨ���Ӽ���ͨ�ÿ���ö����ĸ*/
select chr(64 + level) from dual connect by level <= 26;

--����
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
