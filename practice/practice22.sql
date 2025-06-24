emp2 dept2 테이블을 참고하여, 'AL Pacino'와 "같은 지역"에서
근무하는 직원들의 평균 연봉보다 많이 받는 
직원들의 사번, 이름, 부서번호, 부서이름, 근무지역, 급여 를 출력하세요.

select 
    e.empno,
    e.name,
    e.deptno,
    d.dname,
    d.area,
    e.pay
from emp2 e, dept2 d
where e.deptno = d.dcode
AND pay > (select AVG(pay)
            from emp2 e, dept2 d
            where d.area = (select d.area
                            from emp2 e, dept2 d
                            where name = 'AL Pacino'
                            AND e.deptno = d.dcode)
AND e.deptno = d.dcode);

--파치노 근무지역의 평균 연봉
select AVG(pay)
from emp2 e, dept2 d
where d.area = (select d.area
        from emp2 e, dept2 d
        where name = 'AL Pacino'
        AND e.deptno = d.dcode)
AND e.deptno = d.dcode;

--파치노 근무지역
select d.area
from emp2 e, dept2 d
where name = 'AL Pacino'
AND e.deptno = d.dcode;