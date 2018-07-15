select * from emp where ename like '%A%'
上面这个语句，用正则来查询
select * from emp where regexp_like(ename,'A')

替换
select replace(ename,'A','*') from emp
select regexp_replace(ename,'A','*') from emp

select ename,instr(ename,'A') from emp
select ename,regexp_instr(ename,'A') from emp

select ename,substr(ename,2,4) from emp
select ename,regexp_substr(ename,'.',2,2) from emp; --从第二个字符开始匹配，匹配第二个字符

select count(*) from emp;
select ename,regexp_count(ename,'T') FROM EMP  --统计T出现的次数


select level from dual connect by level <= 10

想要得到26个字母
select level from dual connect by level <= 26
将数字转换成字母
select chr(level+64) from dual connect by level <= 26

想要查询哪些值是身份证号？
身份证号特点  18位，前17位是数字，最后一位可能是数字可能是X
select * from dual where regexp_like('sfzh','[0-9]{17}[0-9Xx]')

下面这个语句是什么意思？
select * from emp where regexp_like(ename,'[SCOTT]')
等价于传统的：
select * 
  from emp 
 where ename like '%S%'
    or ename like '%C%'
    or ename like '%O%'
    or ename like '%T%';

并非这个
select * 
  from emp 
 where ename like '%SCOTT%';

正则里面 | 表示什么意思？或者的意思
select * from emp where regexp_like(ename,'[SCOTT]')
等价于
select * from emp where regexp_like(ename,'S|C|O|T|T')

select * from emp where regexp_like(ename,'[^SCOTT]')
^ 这个符号在中括号里面 是什么意思？
上面这个语句 只是没有了 SCOTT 这个人名。
/*错误理解*/
select * from emp where ename not like'%S%' ......

select * from dual where regexp_like('a$bc','[a$bc]')   --有结果

select * from dual where regexp_like('a$bc','[^a$bc]')  --无结果

$括号外面就是结尾，括号里面就是字符
select * from dual where regexp_like('a$bc','a$bc')   --无结果
此时需要用转译字符
select * from dual where regexp_like('a$bc','a\$bc')  --有结果


select ename,
       replace(ename,'S','*') A,         --替换所有字母
       regexp_replace(ename,'S','*') B,  --替换所有字母
       regexp_replace(ename,'^S','*') C,  --替换首个字母
       regexp_replace(ename,'S$','*') D,   --替换最后一个字母
       regexp_replace(ename||'123','[A-Za-z]') E,  --将所有字母替换掉
       regexp_replace(ename||'123','[^0-9]') F,  --将所有非数字的替换掉
       regexp_replace(ename || '123','[!-z]') G  --将常用字符替换掉
  from emp;
  
select level,chr(level) from dual connect by level <= 128;
从这个SQL可以看出 常用字符从!开始到z 

将首字符是S A C 的替换掉
select ename,
       regexp_replace(ename,'^[SACM]') A, --只替换首字母为SACM这几个字符的一个字符
       regexp_replace(ename,'[SACM]') B,  --将所有的SACM字符替换掉
       regexp_replace(ename,'^[SACM]{2}') C --替换首字母开始的两个字符同时是SACM中的两个的
  FROM EMP;

SELECT * FROM EMP WHERE REGEXP_LIKE(ENAME,'[AB]')
相当于传统写法
select * from emp where ename like '%A%' or ename like '%B%'

--表示一个或一个以上多个字符的时候
select ename,
       regexp_replace(ename,'^[SACM]{1,}') C 
  FROM EMP;
或者
select ename,
       regexp_replace(ename,'^[SACM]+') C 
  FROM EMP;
  
--表示零个或零个以上多个字符的时候
select ename,
       regexp_replace(ename,'^[SACM]{0,}') C 
  FROM EMP;
或者
select ename,
       regexp_replace(ename,'^[SACM]*') C 
  FROM EMP;

drop table test1 purge
create table test1 as
select '166' c1 from dual
union all
select '1' c1 from dual
union all
select '155' c1 from dual
union all
select '77' c1 from dual
union all
select null c1 from dual  ;
 
select * from test1

                 
select * from test1 where regexp_like(c1,'16*')  --表示只匹配1 + 0个6或者0个以上的6
                                                 --c1 like '%1%'

select * from test1 where regexp_like(c1,'16+')  --表示匹配 1 + 1个6或者1个以上的6
                                                 --c1 like '%16%'


select * from test1 where regexp_like(c1,'16*$')  --表示只匹配1 + 0个6或者0个以上的6  结尾
                                                  --当匹配0个6的时候 就是以1结尾
                                                  --c1 like '%1' or c1 like '%16' or c1 like '%166'  ...
select * from test1 where regexp_like(c1,'16+$')  --表示匹配 1 + 1个6或者1个以上的6
                                                  --c1 like '%16' or c1 like '%166' ....
                                                  
select * from test1 where regexp_like(c1,'^16*$')     --c1 like '1' or c1 like '16' or ... 

select * from test1 where regexp_like(c1,'^16+$')  --c1 like '16' or c1 like '166' or ...                                             


