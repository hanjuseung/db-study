--1.
--emp 테이블에서 20 번 부서에 소속된 직원들의 이름과 3-4 번째
--글자만 '-' 으로 변경해서 출력하세요 .
select 
    ename,
    replace(ename,SUBSTR(ename,3 , 2),'--') 
from emp
where deptno = 20;

--2.
--Student 테이블에서 1전공(deptno1)이 101 번인 학생들의 이름과
--주민등록번호를 출력하되 주민등록번호의 뒤 7자리는 ‘-’ 과 '/' 로 표시되게
--출력하세요.
select
    name,
    replace(jumin,substr(jumin,7,7),'-/-/-/-') 주민뒷자리숨김,
    substr(jumin, 1, 6) || '-/-/-/-'
from student
where deptno1 = 101;

--3,
--Student 테이블에서 아래 그림과 같이 1 전공이 102 번인 학생들의 이름과 전화번호, 전화번호에서 국번 부분만 ‘*’ 처리하여 출력하세요.
--단 모든 국번은 3자리로 간주합니다.
select
    name,
    tel,
    replace(tel, substr(tel,instr(tel,')')+1 , 3) , '***') replace
--    replace(tel, substr(tel,5,3) , '***')
from student
where deptno1 = 102;

--Option
--응용) 가운데 자리 숫자의 자리수에 맞춰서 *로 바꾸기
--      3자리 -> ***
--      4자리 -> ****
select
    name,
    tel,
    replace(tel, substr(tel,instr(tel,')')+1 , 3) , '***') replace
from student
where (instr(tel,'-') - instr(tel,')') -1 = 3)
union all
select
    name,
    tel,
    replace(tel, substr(tel,instr(tel,')')+1 , 4) , '****')
from student
where (instr(tel,'-') - instr(tel,')') -1 = 4);

--옵션 다른 풀이
select 
substr(tel, 1, instr(tel,')')) || LPAD('*',instr(tel,'-') - instr(tel,')') -1,'*') || substr(tel, -5 ,5)
from student;

--4.
--Student 테이블에서 아래와 같이 deptno1 이
--101 번인 학과 학생들의 이름과 전화번호와 전화번호에서
--지역번호와 국번을 제외한 나머지 번호(끝 4자리 번호)를 * 로 표시해서 출력하세요.

select
    name,
    tel,
    replace(tel, substr(tel,instr(tel,'-')+1 , 4) , '****') replace
from student
where deptno1=101;