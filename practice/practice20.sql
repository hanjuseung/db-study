1. professor 테이블과 department 테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의
교수번호화 이름, 학과명을 출력하세요 (입사일 순으로 오름차순 정렬)

--학과별 오래된 입사일
select deptno, MIN(hiredate)
from professor
group by deptno;

--방법 1------------------------------------------------------------
select p.profno, p.name, d.dname
from professor p, department d
where p.deptno = d.deptno 
AND (p.deptno,p.hiredate) IN (select deptno, MIN(hiredate)
                          from professor 
                          group by deptno)
order by hiredate;
         
--방법 2------------------------------------------------------------      
select p1.profno,
        p1.name,
        (select d.dname
            from department d
            where d.deptno = p1.deptno) dname
from professor p1
where p1.hiredate = (select MIN(p2.hiredate)
                    from professor p2
                    where p2. deptno = p1.deptno);

2. emp2 테이블 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하세요 (연봉순으로 오름차순 정렬)

--직급 별 최대 연봉
select position , MAX(pay)
from emp2
group by position;

select name,position, pay
from emp2
where (position,pay) IN (select position,MAX(pay)
                from emp2
                group by position
                having position is not null)
order by pay ;