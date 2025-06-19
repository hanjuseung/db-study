/***************************************************************/
Join

select * from emp;

select * from dept;

--JOIN 기준 deptno 가 같은 !!

select e.empno, e.ename, d.dname, d.loc, d.deptno
from emp e, dept d
where e.deptno = d.deptno;

select e.empno, e.ename, d.dname, d.loc, d.deptno
from emp e INNER JOIN dept d
ON e.deptno = d.deptno;

select *
from emp e, dept d; --join 조건 누락 -> 카티션 곱
--where e.deptno = d.deptno;

select * from student;
select * from professor;
-- student <- join(profno) -> professor

--select *
select
    s.name, p.name, s.studno, p.profno,p.email
from student s, professor p
where s.profno = p.profno;

select
    s.name, p.name, s.studno, p.profno,p.email
from student s INNER JOIN professor p
ON s.profno = p.profno;

/***************************************************************/
INNER JOIN , OUTER JOIN

select COUNT(*) from student;
select * from student;

select *
from student s, professor p
--where s.profno = p.profno(+);
--where p.profno = s.profno(+);
where p.profno(+) = s.profno;

select *
from student s LEFT OUTER JOIN professor p
--from student s RIGHT OUTER JOIN professor p
--from professor p RIGHT OUTER JOIN student s
--from professor p LEFT OUTER JOIN student s
ON s.profno = p.profno;

-- professor 테이블 기준
select COUNT(*) from professor;  --16명

select
    s.name, p.name, s.studno, p.profno,p.email
from professor p ,student s
where p.profno = s.profno(+);

select s.name 학생이름, p.profno 교수번호, p.name 교수이름
from student s, professor p
where s.profno = p.profno;

select s.name 학생이름, p.profno 교수번호, p.name 교수이름
from student s, professor p
where s.profno = p.profno;

select * from department;

select s.name 학생이름, d.dname 학과이름, p.name 교수이름
from student s, professor p, department d
where s.profno = p.profno
AND s.deptno1 = d.deptno;

select s.name 학생이름, d.dname 학과이름, p.name 교수이름
from student s
    INNER JOIN professor p
    ON s.profno = p.profno
    INNER JOIN department d
    ON s.deptno1 = d.deptno;
    
select s.name, p.profno, p.name
from student s, professor p
where s.deptno1 = 101
AND s.profno = p.profno;

--1) 학생명, 학생학과번호, 학생의 학과명, 교수명, 교수학과번호
select s.name 학생명, s.deptno1 학생학과번호, d.dname 학생의학과명, p.name 교수명, p.deptno 교수학과번호
from student s, professor p, department d
where s.profno = p.profno
AND s.deptno1 = d.deptno;

--2) 학생명, 학생학과번호, 교수의 학과명, 교수명, 교수학과번호
select s.name 학생명, s.deptno1 학생학과번호, d.dname 교수의학과명, p.name 교수명, p.deptno 교수학과번호
from student s, professor p, department d
where s.profno = p.profno
AND p.deptno = d.deptno;

--3) 학생명, 학생학과번호, 학생의 학과명, 교수명, 교수학과번호, 교수의 학과명
select s.name 학생명, s.deptno1 학생학과번호, ds.dname 학생의학과명, p.name 교수명, p.deptno 교수학과번호,dp.dname 교수의학과명
from student s, professor p, department ds ,department dp
where s.profno = p.profno
AND ds.deptno = s.deptno1  --학과 <-> 학생
AND dp.deptno = p.deptno --학과 <-> 교수
;

/***************************************************************/
비등가 Join

select * from customer;
select * from gift;

select *
from customer c, gift g
where c.point BETWEEN g.g_start AND g.g_end;

select * from hakjum;


Self Join

select * from emp;

select *
from emp e1, emp e2
where e1.mgr = e2.empno;

select * from emp2;

select A.empno 내사번, A.name 내이름, A.pempno 상사사번, B.name 상사이름
from emp2 A, emp2 B
where A.pempno = B.empno;