一般领导的上级是空值
从领导开始查询下面所有的员工
select * from emp
start with mgr is null
connect by mgr = prior empno

如果想要查询7566下面所有的人员
select * from emp
start with empno = 7566
connect by mgr = prior empno

/*部门拆分，7566单独成立了一个部门，人员都独立出去了
要查询不包含7566管辖的人员*/
select * from emp
start with mgr is null
connect by mgr = prior empno and empno <> 7566

/*path*/
select empno,ename,substr(sys_connect_by_path(ename,'->'),3) from emp
start with mgr is null
connect by mgr = prior empno

--ltrim(自己查询一下这个函数)

如果这个路径是地址信息，就是住址信息了
--中国--北京--立水桥
树形查询就应该有树形查询的特点
有根，有分支，有叶子
/*root  branch  leaf */
现在需要将根，分支，叶子标记出来
select empno,
       ename,
       substr(sys_connect_by_path(ename,'->'),3) as fullpath,
       connect_by_isleaf,  --伪列,这列为1的时候，就是叶子节点
       rownum,
       level,   --当LEVEL<>1 and connect_by_isleaf<>1的时候就是分支节点  level=1的时候就是根节点
       case when connect_by_isleaf = 1 then 'leaf'
            when level = 1 then 'root'
            else 'branch' end as rbl
   from emp
  start with mgr is null
  connect by mgr = prior empno
 
应用：有时候菜单的一些信息 叶子节点有后续的一个动作，分支节点直接是下拉菜单

如果我们想按路径里面的名称来排序，
select empno,
       ename,
       substr(sys_connect_by_path(ename,'->'),3) as fullpath,
       connect_by_isleaf,  --伪列,这列为1的时候，就是叶子节点
       rownum,
       level,   --当LEVEL<>1 and connect_by_isleaf<>1的时候就是分支节点  level=1的时候就是根节点
       case when connect_by_isleaf = 1 then 'leaf'
            when level = 1 then 'root'
            else 'branch' end as rbl
   from emp
  start with mgr is null
  connect by mgr = prior empno
  --order by ename /*错误*/
  order siblings by ename


想要找某个员工的根节点，应该怎么找呢
select empno,
       ename,
       mgr,
       connect_by_root(ename)
  from emp
  start with mgr is null
  connect by mgr = (prior empno)
  
也可以从经理开始查询

select empno,
       ename,
       mgr,
       job,
       connect_by_root(ename)
  from emp
  start with job = 'MANAGER'
  connect by mgr = (prior empno)
 
想要找地区 棋盘山 是哪个省的
只需要将上面这个语句嵌套一层
select * from (
 select empno,
       ename,
       mgr,
       job,
       connect_by_root(ename)
  from emp
  start with job = 'MANAGER'
  connect by mgr = (prior empno)
)
where ename = '棋盘山'

/*执行顺序*/
1.执行 start with
2.执行 where

--最好不要这样写
1. select empno,
       ename,
       mgr,
       job
  from emp
  where deptno = 20
  start with mgr is null
  connect by mgr = (prior empno)
  
等价于(推荐这样写)
2. 
select * from (
select empno,
       ename,
       mgr,
       job
  from emp
  start with mgr is null
  connect by mgr = (prior empno)
  )
 where deptno = 20
 
 如果想要先过滤数据 就写成
 select empno,
       ename,
       mgr,
       job
  from (select * from emp where deptno = 20)
  start with mgr is null
  connect by mgr = (prior empno)

用with as 模拟树形查询
with E1(EMPNO,
ENAME,
JOB,
MGR,
LV,
P) AS
 (SELECT EMPNO, ENAME, JOB, MGR, 1 LV, ENAME P
    FROM EMP
   WHERE MGR IS NULL
  UNION ALL
  SELECT E.EMPNO,
         E.ENAME,
         E.JOB,
         E.MGR,
         PRIO.LV + 1 LV,
         PRIO.P || '->' || E.ENAME P
    FROM E1 PRIO
    JOIN EMP E
      ON PRIO.EMPNO = E.MGR)
SELECT * FROM E1;


用SQL模拟listagg函数

select a.*,level lv,substr(sys_connect_by_path(ename,','),2) from (
select EMPNO,
       ENAME,
       JOB,
       DEPTNO,
       row_number() over(partition by deptno order by empno) sn
  from emp) a
 where connect_by_isleaf = 1
start with sn = 1 
connect by deptno = prior deptno and sn = prior (sn + 1)

拆分字符串：
create table t_substr as 
select deptno,substr(sys_connect_by_path(ename,','),2) ab from (
select EMPNO,
       ENAME,
       JOB,
       DEPTNO,
       row_number() over(partition by deptno order by empno) sn
  from emp) a
 where connect_by_isleaf = 1
start with sn = 1 
connect by deptno = prior deptno and sn = prior (sn + 1);

select * from t_substr;
下面这种拆分只能是拆分一个部门的，如果是多个部门就会出现问题。
select deptno,regexp_substr(ab,'[^,]+',1,level) 
  from (select * from t_substr where deptno = 10)
 connect by level <= regexp_count(ab,',') + 1
--数据多了，因为循环从各个部门都循环了一遍
select deptno,regexp_substr(ab,'[^,]+',1,level) 
  from t_substr
 connect by level <= regexp_count(ab,',') + 1
 此时 加上一个distinct 就会好了。
 
--正确写法
select deptno,regexp_substr(ab,'[^,]+',1,level) 
  from t_substr
 connect by level <= regexp_count(ab,',') + 1
 and deptno = prior deptno  --在同一个部门内循环,但是会报错，死循环
 and (prior dbms_random.value) is not null;   --防止报错，用数据来告诉ORACLE 这不是死循环
