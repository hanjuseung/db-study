--연습1번
select * from student;

select name, id, weight from student;

select 
    name || '''s ' || 'ID : ' || id || ', WEIGHT is ' || weight || 'Kg' "ID AND WEIGHT" 
from student;

--연습2번
select ename, ename, ename, ename from emp;
select ename, job from emp;

select ename || '(' || job || ') , ' || ename || '''' || job || '''' "NAME AND JOB" 
from emp;
--연습3번
select * from emp;
select ename, sal from emp;

select ename || '''s sal is $' || sal "Name and Sal" 
from emp;
