select ename,
       instr(ename,'EN'),
       instr(ename,'A',1,1),
       instr(ename,'A',1,2)
  from emp;

drop table test1 purge;
create table test1 as 
select listagg(ename,',') within group(order by ename) as enames
from emp
where deptno = '10';
select * from test1;

对字符串进行拆分
select instr(','||enames,',',1,1) from test1

取出第一个字符串的值
select substr(enames,
              instr(enames,',',1,1)+1,
              instr(enames,',',1,2)- (instr(enames,',',1,1)+1))
from (
select ','||enames||',' as enames from test1)

找出字符串的个数
select enames,length(regexp_replace(enames,'[^,]'))+1 from (
select enames as enames from test1)

字符串有多少个，就需要拆分成多少行，用树形查询变成这些行
select level,enames from (
select enames as enames from test1)
connect by level<= length(regexp_replace(enames,'[^,]'))+1

综合上面的，得出结果集
select substr(enames,
              instr(enames,',',1,id)+1,
              instr(enames,',',1,id+1)- (instr(enames,',',1,id)+1))
from (
select level id, ','||enames||',' as enames from test1
connect by level<= length(regexp_replace(enames,'[^,]'))+1)

用正则表达式：
先取出各个字符串，从第一个字符开始，非','开始的第一个字符串
select regexp_substr(enames,'[^,]+',1,1),
       regexp_substr(enames,'[^,]+',1,2),
       regexp_substr(enames,'[^,]+',1,3)
 from test1
 
 select regexp_substr(enames,'[^,]+',2,1),
       regexp_substr(enames,'[^,]+',2,2),
       regexp_substr(enames,'[^,]+',2,3)
 from test1
 --注意上面两个的区别，只有第一个字符串从第二个字符开始算起，后面的都不是。

用正则表达式写出 
 select regexp_substr(enames,'[^,]+',1,level)
 from test1
 connect by level<= length(regexp_replace(enames,'[^,]'))+1

select * from test1
CLARK,EricHu,KING,MILLER,WANGJING,huyong,马蓉
如果要是查上面的数据，上面的数据在一个字段里面，应该怎么查询？
/*拼接 每次都是执行一个全新的语句，造成硬解析*/

先定义一个变量，防止每次都造成硬解析(在命令窗口执行)
var v_emps varchar2(100);
exec :v_emps := 'CLARK,EricHu,KING,MILLER,WANGJING,huyong,马蓉';
select :v_emps from dual;

select regexp_substr(:v_emps,'[^,]+',1,level)
from dual
connect by level<= length(regexp_replace(:v_emps,'[^,]'))+1;

这只是取了一行的数据，如果是多行数据拆分怎么办？
select regexp_substr('CLARK,EricHu,KING,MILLER,WANGJING,huyong,马蓉','[^,]+',1,level)
from dual
connect by level<= length(regexp_replace('CLARK,EricHu,KING,MILLER,WANGJING,huyong,马蓉','[^,]'))+1;

用这个SQL
select deptno,regexp_substr(ab,'[^,]+',1,level) 
  from t_substr
 connect by level <= regexp_count(ab,',') + 1
 and deptno = prior deptno 
 and (prior dbms_random.value) is not null; 





