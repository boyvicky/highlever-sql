����ÿ��������Ϊһ��
����дSQL���͵õ���ÿ����һ�������
select ceil(rn/3),job,sal from(
select rownum rn,job,sal from emp)

����һЩ���ݲ������֣�����ʱ��Ӧ����ô����

create table test_time as 
select sysdate + level/24/60/60 as t from dual connect by level <= 65

/*5��һ��*/
�Ƚ��������ȡ����
select t,ceil(to_char(t,'ss')/5),
       floor(to_char(t,'ss')/5)
  from test_time;

��ceil ��ʱ���������ʱ�򵥶���һ���ˣ�����������������floor 0-4sΪһ������
select t,
       floor(to_char(t,'ss')/5)
  from test_time;
  
  
�и�������˷ֳ����飬���ں����
--������������ֳ�4��
select ntile(4) over(order by empno) as gp, empno, ename, job, deptno
  from emp;
  
--����ֳ�5��
select ntile(5) over(order by dbms_random.value) as gp, empno, ename, job, deptno
  from emp;
