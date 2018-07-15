累加
select trunc(hiredate, 'mm') as ym, sum(sal) as sal
  from emp
 group by trunc(hiredate, 'mm')
 order by 1
 
800
800+2850
800+2850+2975
...

传统写法
with a as 
(select trunc(hiredate, 'mm') as ym, sum(sal) as sal
  from emp
 group by trunc(hiredate, 'mm'))
select ym,sal,(select sum(b.sal) from a b where b.ym<=a.ym) from a
order by 1

with v0 as 
(select trunc(hiredate, 'mm') as ym, sum(sal) as sal
  from emp
 group by trunc(hiredate, 'mm'))
select a.*,b.* from v0 a,v0 b where b.ym<a.ym
order by a.ym,b.ym


/*累加 分析函数省略句*/

with v0 as 
(select trunc(hiredate, 'mm') as ym, sum(sal) as sal
  from emp
 group by trunc(hiredate, 'mm'))
select a.*, 
       sum(sal) over(order by ym range between unbounded preceding --第一行
                                           and current row) --当前行
  from v0 a
  
range 范围
就有一个 “>=”  和 “<=”

select empno,ename,job,sal,sum(sal) over(order by job) from emp

select (30+30+8+9.5+13+11)*100 from dual

有需求：
1-2月 累计
1-3月 累计
1-4月 累计

select to_char(hiredate, 'yyyy') yy,
       to_char(hiredate, 'yyyymm') mm,
       empno,
       ename,
       sal,
       sum(sal) over(partition by to_char(hiredate, 'yyyy') order by to_char(hiredate, 'yyyymm')) ad
  from emp;
  
select empno,
       ename,
       sal,
       sum(sal) over(order by sal range between unbounded preceding and current row) ad
  from emp;  
注意：上面这个这个按工资排序，重复的工资计算了两次
实际上，在第四行，第五行的时候 工资值相等，
第四行： sum(sal) where sal between 800 and 1250
第五行： sum(sal) where sal between 800 and 1250

为了避免这种，只需要增加一个不重复的字段即可
select empno,
       ename,
       sal,
       sum(sal) over(order by sal,empno range between unbounded preceding and current row) ad
  from emp;   

另一种方法
关键字 range 替换掉，不根据值来汇总，根据行 来汇总
select empno,
       ename,
       sal,
       sum(sal) over(order by sal rows between unbounded preceding and current row) ad
  from emp; 



也可以不用 关键字 unbounded  第一行
select empno,
       ename,
       sal,
       sum(sal) over(order by sal range between 200 preceding and current row) ad
  from emp; 
上面这个语句就是代表

sum(sal) where sal between current row - 200 and current row  
就是当前行 - 200 的值开始累加到当前行

哪些列的类型可以加减呢？
/*number , date  */

/*前面三行到当前行*/
select empno,
       ename,
       sal,
       sum(sal) over(order by sal rows between 3 preceding and current row) ad
  from emp;

3 7876  ADAMS 1100.00 2850
4 7521  WARD  1250.00 4100
5 7654  MARTIN  1250.00 4550
6 7934  MILLER  1300.00 4900
以第六行举例，当前行是6 - 3 即从第三行开始累加到第六行

/*昨天 + 今天*/
select empno,
       ename,
       sal,
       hiredate,
       sum(sal) over(order by hiredate range between 1 preceding and current row) ad
  from emp; 
