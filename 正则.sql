select * from emp where ename like '%A%'
���������䣬����������ѯ
select * from emp where regexp_like(ename,'A')

�滻
select replace(ename,'A','*') from emp
select regexp_replace(ename,'A','*') from emp

select ename,instr(ename,'A') from emp
select ename,regexp_instr(ename,'A') from emp

select ename,substr(ename,2,4) from emp
select ename,regexp_substr(ename,'.',2,2) from emp; --�ӵڶ����ַ���ʼƥ�䣬ƥ��ڶ����ַ�

select count(*) from emp;
select ename,regexp_count(ename,'T') FROM EMP  --ͳ��T���ֵĴ���


select level from dual connect by level <= 10

��Ҫ�õ�26����ĸ
select level from dual connect by level <= 26
������ת������ĸ
select chr(level+64) from dual connect by level <= 26

��Ҫ��ѯ��Щֵ�����֤�ţ�
���֤���ص�  18λ��ǰ17λ�����֣����һλ���������ֿ�����X
select * from dual where regexp_like('sfzh','[0-9]{17}[0-9Xx]')

������������ʲô��˼��
select * from emp where regexp_like(ename,'[SCOTT]')
�ȼ��ڴ�ͳ�ģ�
select * 
  from emp 
 where ename like '%S%'
    or ename like '%C%'
    or ename like '%O%'
    or ename like '%T%';

�������
select * 
  from emp 
 where ename like '%SCOTT%';

�������� | ��ʾʲô��˼�����ߵ���˼
select * from emp where regexp_like(ename,'[SCOTT]')
�ȼ���
select * from emp where regexp_like(ename,'S|C|O|T|T')

select * from emp where regexp_like(ename,'[^SCOTT]')
^ ������������������� ��ʲô��˼��
���������� ֻ��û���� SCOTT ���������
/*�������*/
select * from emp where ename not like'%S%' ......

select * from dual where regexp_like('a$bc','[a$bc]')   --�н��

select * from dual where regexp_like('a$bc','[^a$bc]')  --�޽��

$����������ǽ�β��������������ַ�
select * from dual where regexp_like('a$bc','a$bc')   --�޽��
��ʱ��Ҫ��ת���ַ�
select * from dual where regexp_like('a$bc','a\$bc')  --�н��


select ename,
       replace(ename,'S','*') A,         --�滻������ĸ
       regexp_replace(ename,'S','*') B,  --�滻������ĸ
       regexp_replace(ename,'^S','*') C,  --�滻�׸���ĸ
       regexp_replace(ename,'S$','*') D,   --�滻���һ����ĸ
       regexp_replace(ename||'123','[A-Za-z]') E,  --��������ĸ�滻��
       regexp_replace(ename||'123','[^0-9]') F,  --�����з����ֵ��滻��
       regexp_replace(ename || '123','[!-z]') G  --�������ַ��滻��
  from emp;
  
select level,chr(level) from dual connect by level <= 128;
�����SQL���Կ��� �����ַ���!��ʼ��z 

�����ַ���S A C ���滻��
select ename,
       regexp_replace(ename,'^[SACM]') A, --ֻ�滻����ĸΪSACM�⼸���ַ���һ���ַ�
       regexp_replace(ename,'[SACM]') B,  --�����е�SACM�ַ��滻��
       regexp_replace(ename,'^[SACM]{2}') C --�滻����ĸ��ʼ�������ַ�ͬʱ��SACM�е�������
  FROM EMP;

SELECT * FROM EMP WHERE REGEXP_LIKE(ENAME,'[AB]')
�൱�ڴ�ͳд��
select * from emp where ename like '%A%' or ename like '%B%'

--��ʾһ����һ�����϶���ַ���ʱ��
select ename,
       regexp_replace(ename,'^[SACM]{1,}') C 
  FROM EMP;
����
select ename,
       regexp_replace(ename,'^[SACM]+') C 
  FROM EMP;
  
--��ʾ�����������϶���ַ���ʱ��
select ename,
       regexp_replace(ename,'^[SACM]{0,}') C 
  FROM EMP;
����
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

                 
select * from test1 where regexp_like(c1,'16*')  --��ʾֻƥ��1 + 0��6����0�����ϵ�6
                                                 --c1 like '%1%'

select * from test1 where regexp_like(c1,'16+')  --��ʾƥ�� 1 + 1��6����1�����ϵ�6
                                                 --c1 like '%16%'


select * from test1 where regexp_like(c1,'16*$')  --��ʾֻƥ��1 + 0��6����0�����ϵ�6  ��β
                                                  --��ƥ��0��6��ʱ�� ������1��β
                                                  --c1 like '%1' or c1 like '%16' or c1 like '%166'  ...
select * from test1 where regexp_like(c1,'16+$')  --��ʾƥ�� 1 + 1��6����1�����ϵ�6
                                                  --c1 like '%16' or c1 like '%166' ....
                                                  
select * from test1 where regexp_like(c1,'^16*$')     --c1 like '1' or c1 like '16' or ... 

select * from test1 where regexp_like(c1,'^16+$')  --c1 like '16' or c1 like '166' or ...                                             


