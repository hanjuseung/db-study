--1.
--학생 테이블 (student) 과 학과 테이블 (department) 테이블을 사용하여
--학생이름, 1전공학과번호(deptno1) , 1전공 학과 이름을 출력하세요.
select 
    s.name 학생이름,
    s.deptno1 전공번호,
    d.dname 학과이름
from student s, department d
where s.deptno1 = d.deptno
order by deptno;
--2. emp2 테이블과 p_grade 테이블을 조회하여
--현재 직급이 있는 사원의 이름과 직급, 현재 연봉,
--해당 직급의 연봉의 하한금액과
--상한 금액을 아래 결과 화면과 같이 출력하세요.
select 
    e.name,
    e.position,
    TO_CHAR(e.pay,'999,999,999') PAY,
    TO_CHAR(g.S_PAY,'999,999,999') LOWPAY,
    TO_CHAR(g.E_PAY, '999,999,999') HIGHPAY
from emp2 e, p_grade g
where e.position = g.position(+)
AND e.position is not null;

select 
    e.name,
    e.position,
    TO_CHAR(e.pay,'999,999,999') PAY,
    TO_CHAR(g.S_PAY,'999,999,999') LOWPAY,
    TO_CHAR(g.E_PAY, '999,999,999') HIGHPAY
from emp2 e, p_grade g
where e.position = g.position
UNION ALL
select
    name,
    position,
    TO_CHAR(pay,'999,999,999'),
    null,
    null
from emp2
where position = 'Boss'
order by pay ;
--3. Emp2 테이블과 p_grade 테이블을 조회하여
--사원들의 이름과 나이, 현재 직급 , 예상 직급 을 출력하세요.
--예상 직급은 나이로 계산하며 해당 나이가 받아야 하는 직급을 의미합니다.
--나이는 '2010-05-30'을 기준으로 하되 가능하면 trunc 로 소수점 이하는 절삭해서 계산하세요.
select 
    e.name,
    trunc(MONTHS_BETWEEN('2010-05-30',TO_CHAR(e.birthday, 'YYYY-MM-DD'))/12+1) 한국나이,
    e.position 지금포지션,
    g.position 나이에맞는포지션
from emp2 e, p_grade g
where trunc(MONTHS_BETWEEN('2010-05-30',TO_CHAR(e.birthday, 'YYYY-MM-DD'))/12+1) BETWEEN g.S_AGE AND g.E_AGE;

select 
    e.name,
    '2010'-TO_CHAR(e.birthday, 'YYYY')+1 한국나이,
    e.position 지금포지션,
    g.position 나이에맞는포지션
from emp2 e, p_grade g
where '2010'-TO_CHAR(e.birthday, 'YYYY')+1 BETWEEN g.S_AGE AND g.E_AGE;
--4 . customer 테이블과 gift 테이블을 Join하여 고객이 자기 포인트보다 낮은
--포인트의 상품 중 한가지를 선택할 수 있다고 할 때 Notebook 을 선택할 수 있는 
--고객명과 포인트, 상품명을 출력하세요.
select * from customer;
select * from gift;

select
    c.gname 이름,
    c.point 포인트,
    CASE
        WHEN point >= 600000 THEN 'Notebook'
    END 상품
from customer c, gift g
where c.point BETWEEN G_START AND G_END
AND c.point >ANY (select point
                  from customer
                  where c.point > 600000);
--방법1
select gname, point, 'Notebook' gname_1
from customer
where point >= (select g_start
                from gift
                where Gname = 'Notebook');
--방법2
select c.gname, c.point, 'Notebook' GNAME_1
from customer c, gift g
where c.point BETWEEN g.g_start AND g.g_end
AND g.gno >= 7;
--방법3
select c.gname, c.point, g.gname
from customer c, gift g
where c.point >= g.g_start
AND g.gname = 'Notebook';

--5. professor 테이블에서 교수의 번호, 교수이름, 입사일, 자신보다 입사일 
--빠른 사람 인원수를 출력하세요. 단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.
select 
    profno,
    name,
    hiredate,
    RANK() OVER (order by hiredate )-1 count
from professor;

--서브쿼리버전
select
    p1.profno,
    p1.name,
    p1.hiredate,
    (select COUNT(*)
    from professor p2
    where p2.hiredate < p1.hiredate) COUNT
from professor p1
order by COUNT;

--join + 집계
select p1.profno,p1.name,p1.hiredate, COUNT(p2.profno) count
from professor p1, professor p2
where p1.hiredate > p2.hiredate(+)
GROUP by p1.profno, p1.name, p1.hiredate
order by p1.hiredate;
--6. emp 테이블에서 사원번호, 사원이름, 입사일, 자신보다 먼저 입사한 사람 인원수를 출력하세요.
--단 자신보다 입사일이 빠른 사람수를 오름차순으로 출력하세요.
select 
    empno,
    ename,
    hiredate,
    RANK() OVER (order by hiredate )-1 count
from emp
order by hiredate;