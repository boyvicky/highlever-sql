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

���ַ������в��
select instr(','||enames,',',1,1) from test1

ȡ����һ���ַ�����ֵ
select substr(enames,
              instr(enames,',',1,1)+1,
              instr(enames,',',1,2)- (instr(enames,',',1,1)+1))
from (
select ','||enames||',' as enames from test1)

�ҳ��ַ����ĸ���
select enames,length(regexp_replace(enames,'[^,]'))+1 from (
select enames as enames from test1)

�ַ����ж��ٸ�������Ҫ��ֳɶ����У������β�ѯ�����Щ��
select level,enames from (
select enames as enames from test1)
connect by level<= length(regexp_replace(enames,'[^,]'))+1

�ۺ�����ģ��ó������
select substr(enames,
              instr(enames,',',1,id)+1,
              instr(enames,',',1,id+1)- (instr(enames,',',1,id)+1))
from (
select level id, ','||enames||',' as enames from test1
connect by level<= length(regexp_replace(enames,'[^,]'))+1)

��������ʽ��
��ȡ�������ַ������ӵ�һ���ַ���ʼ����','��ʼ�ĵ�һ���ַ���
select regexp_substr(enames,'[^,]+',1,1),
       regexp_substr(enames,'[^,]+',1,2),
       regexp_substr(enames,'[^,]+',1,3)
 from test1
 
 select regexp_substr(enames,'[^,]+',2,1),
       regexp_substr(enames,'[^,]+',2,2),
       regexp_substr(enames,'[^,]+',2,3)
 from test1
 --ע����������������ֻ�е�һ���ַ����ӵڶ����ַ���ʼ���𣬺���Ķ����ǡ�

��������ʽд�� 
 select regexp_substr(enames,'[^,]+',1,level)
 from test1
 connect by level<= length(regexp_replace(enames,'[^,]'))+1

select * from test1
CLARK,EricHu,KING,MILLER,WANGJING,huyong,����
���Ҫ�ǲ���������ݣ������������һ���ֶ����棬Ӧ����ô��ѯ��
/*ƴ�� ÿ�ζ���ִ��һ��ȫ�µ���䣬���Ӳ����*/

�ȶ���һ����������ֹÿ�ζ����Ӳ����(�������ִ��)
var v_emps varchar2(100);
exec :v_emps := 'CLARK,EricHu,KING,MILLER,WANGJING,huyong,����';
select :v_emps from dual;

select regexp_substr(:v_emps,'[^,]+',1,level)
from dual
connect by level<= length(regexp_replace(:v_emps,'[^,]'))+1;

��ֻ��ȡ��һ�е����ݣ�����Ƕ������ݲ����ô�죿
select regexp_substr('CLARK,EricHu,KING,MILLER,WANGJING,huyong,����','[^,]+',1,level)
from dual
connect by level<= length(regexp_replace('CLARK,EricHu,KING,MILLER,WANGJING,huyong,����','[^,]'))+1;

�����SQL
select deptno,regexp_substr(ab,'[^,]+',1,level) 
  from t_substr
 connect by level <= regexp_count(ab,',') + 1
 and deptno = prior deptno 
 and (prior dbms_random.value) is not null; 





