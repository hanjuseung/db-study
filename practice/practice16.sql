/*
참조 테이블 : panmae, product, gift
출력 데이터 : 상품명, 상품가, 구매수량, 총금액,
적립포인트, 새해2배적립포인트, 사은품명, 포인트 범위

- panmae 테이블을 기준으로 포인트를 보여준다.
- 포인트는 구매한 금액 1원당 100의 포인트를 부여한다.
(단, 01월 01인 경우는 새해 이벤트로 인해 1원당 200의 포인트를 부여한다.)
- 적립포인트와 새해2배적립포인트를 모두 보여준다.
(이 경우, 이벤트 날인 01월 01일을 제외하고는 포인트가 동일 할 것이다.)
- 새해2배적립포인트를 기준으로 해당 포인트 기준으로 받을수 있는 사은품을 보여준다.
- 사은품 명 옆에 해당 사은품을 받을 수 있는 포인트의 범위를 함께 보여준다.

* 출력 양식과 컬럼 헤더에 표기되는 이름 확인!
*/

select * from panmae;
select * from product;
select * from gift;

select
    TO_CHAR(TO_DATE(pa.P_DATE, 'YYYY-MM-DD'),'YYYY-MM-DD') 판매일자,
    pa.P_CODE 상품코드,
    pr.P_NAME 상품명,
    TO_CHAR(pr.P_PRICE, '999,999') 상품가,
    pa.P_QTY 구매수량,
    TO_CHAR(pa.P_TOTAL, '999,999') 총금액,
    TO_CHAR(pa.P_TOTAL*100, '999,999') 적립포인트,
    CASE pa.P_DATE 
        WHEN '20110101' THEN TO_CHAR(pa.P_TOTAL*200, '999,999')
        ELSE TO_CHAR(pa.P_TOTAL*100, '999,999')
    END 새해2배적립포인트,
--    TO_CHAR(DECODE(SUBSTR(pa.p_date, 5,4), '0101',pa.p_total*200,pa.p_total*100), '999,999') 새해2배적립포인트,
    g.gname 사은품명,
    TO_CHAR(g.G_START, '999,999') 포인트START,
    TO_CHAR(g.G_END, '999,999') 포인트END
from panmae pa, product pr, gift g
where pa.P_CODE = pr.P_CODE
AND CASE pa.P_DATE 
        WHEN '20110101' THEN pa.P_TOTAL*200
        ELSE pa.P_TOTAL*100
    END
BETWEEN g.G_START AND g.G_END
order by pa.P_DATE;