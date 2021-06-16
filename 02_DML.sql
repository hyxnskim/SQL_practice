
-- 수당이 있는 직원 정보 조회
select * from emp where comm is not null AND comm>0;

-- 직원들의 최대급여, 최소급여, 급여총액, 평균급여, 최대급여-최소급여 차이
select
    to_char(max(sal), 'L999,999') 최대급여, 
    to_char(min(sal), 'L999,999') 최소급여, 
    to_char(sum(sal), 'L999,999') 급여총액, 
    to_char(avg(sal), 'L999,999')  평균급여, 
    to_char(max(sal)-min(sal), 'L999,999') 급여차이
from emp;

-- GROUP 함수를 사용해서 그룹핑 결과를 조회
-- 부서별 평균급여 조회
SELECT DEPTNO 부서번호, to_char(AVG(SAL), 'L999,999') 평균급여
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) > 2000
ORDER BY DEPTNO;

-- 직원들의 직무 조회
SELECT DISTINCT JOB FROM EMP ORDER BY 1;

-- 부서별 직무의 종류를 조회
-- 조회 항목 : 부서번호, 직무
-- 정렬 : 부서번호, 직무 순서대로 조회
SELECT DISTINCT DEPTNO, JOB
FROM EMP
ORDER BY DEPTNO, JOB;

-- 조회에 대한 일련번호(rownum), 저장위치(rowid), 부서번호, 사번, 이름, 급여정보 조회
select rownum, rowid, deptno, empno, ename, sal from emp;

-- 직무별 직원의 인원수 조회
-- 출력형식 : 직무, 인원수
-- 인원수가 많은 순서대로 정렬 조회
select distinct job, count(job)
from emp
group by job
order by count(job) desc;

-- 7499 직원과 같은 직무를 담당하는 직원 조회
SELECT * FROM EMP
WHERE JOB = 'SALESMAN';

-- SUB-QUERY 이용
SELECT * FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO = 7499);


-- 직원중에서 급여를 많이 받는 최상위 3명의 정보를 조회
-- 출력형식 : 순번 사번 이름 급여
-- 힌트 : SELECT 검색순서, ROWNUM, SUB-QUERY
SELECT ROWNUM, EMPNO, ENAME, SAL
FROM (
    SELECT * FROM EMP ORDER BY SAL DESC
)
WHERE ROWNUM <= 3
ORDER BY SAL DESC;

-- 경조회비르르 많이 내는 직원 순서대로 정렬 조회
-- 직원들의 직무에 따라서 경조회비를 차등 계산
-- 출력형식 : 사번, 직무, 급여, 경조회비

-- 경조회비 계산
-- PRESIDENT = 급여 * 30%
-- MANAGER  = 급여 * 25%
-- ANALYST, SALESMAN  = 급여 * 20%
-- 기타직무  = 급여 * 5%

-- 1. 직무, 정렬
SELECT DISTINCT JOB FROM EMP ORDER BY 1;

SELECT EMPNO, ENAME, SAL,
    DECODE (
        JOB,
        'PRESIDENT', SAL * 0.3,
        'MANAGER',  SAL * 0.25,
        'ANALYST', SAL * 0.2,
        'SALESMAN', SAL * 0.2,
        SAL * 0.05
        ) "경조회비"
FROM EMP
ORDER BY 경조회비 DESC;

  
-- 1.
-- 직원 테이블의 사번, 이름, 입사일자 해당 내용만 출력하시오.
-- 단, 입사일자는 년도4자리-월2자리-일2자리 형식으로 조회
SELECT EMPNO 사번, ENAME 이름, to_char(HIREDATE, 'yyyy-mm-dd') 입사일자 FROM EMP;

-- 2.
-- 사원들의 직무명을 중복 제거후, 직무명을 올림차순으로 출력하시오.
 SELECT DISTINCT JOB FROM EMP ORDER BY JOB;

-- 3.
-- 급여가 3000 이상인 사원정보를 출력하시오.
SELECT * FROM EMP WHERE SAL>=3000;

-- 4.
-- 이름이 'SMITH'인 사원의 정보 출력하시오.
 SELECT * FROM EMP WHERE ENAME = 'SMITH';

-- 5. 
-- 10번 부서원중에서 직업이 'MANAGER'인 사원정보를 출력하시오.
 SELECT * FROM EMP WHERE DEPTNO = 10 AND JOB = 'MANAGER';

-- 6.
-- 10번 부서원이 아니면서 직무가 'CLERK' 또는 'MANAGER' 인 사원정보를 출력하시오.
 SELECT * FROM EMP WHERE DEPTNO != 10 AND (JOB = 'CLERK' OR JOB = 'MANAGER');

-- 7.
-- 급여가 1000 ~ 3000 사이인 직원중에서 직무가 'SALESMAN' 인 사원정보를 출력하시오.
SELECT * FROM EMP WHERE SAL>= 1000 AND SAL<=3000 AND JOB = 'SALESMAN';

-- 8.
-- 직무가 'CLERK', 'MANAGER', 'SALESMAN' 인 사원정보를 출력하시오.
 SELECT * FROM EMP WHERE JOB IN ('CLERK', 'MANAGER', 'SALESMAN');

-- 9.
-- 직무가 'CLERK', 'MANAGER', 'SALESMAN' 아닌 사원정보를 출력하시오.
 SELECT * FROM EMP WHERE JOB NOT IN ('CLERK', 'MANAGER', 'SALESMAN');
 
-- 10.
-- 이름이 'A'가 들어가는 사원중에서 급여가 2000을 초과하는 사원정보를 출력하시오.
 SELECT * FROM EMP WHERE ENAME LIKE('%A%') AND SAL>2000;

-- 11.
-- 오늘날짜 제목으로 년도4자리.월2자리.일2자리 형식으로 출력하시오.
SELECT to_char(HIREDATE, 'yyyy,mm,dd') 오늘날짜 FROM EMP;

-- 12.
-- 현재시간 제목으로 오후 12:49 형식으로 출력하시오.
SELECT to_char(SYSDATE, 'AM hh:ss') 현재시간 FROM DUAL;

-- 13.
-- 부서별 부서번호, 인원수, 총급여, 평균급여, 최대급여, 최소급여, 급여차이 제목으로 출력하시오.
-- 급여차이 = 최대급여 - 최소급여
-- 부서번호 순서대로 정렬 조회하시오
SELECT DEPTNO 부서번호,  COUNT(*) 인원수, SUM(SAL) 총급여, to_char(AVG(SAL), '$999,999') 평균급여, MAX(SAL) 최대급여, MIN(SAL) 최소급여, MAX(SAL)-MIN(SAL) 급여차이
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 14.
-- 회사가 경영악화가 개선되어서 최화위 사원 3명에게 급여를 인상하려한다. 
-- 최하위 급여 3명의 정보를 출력하시오.
-- 조회항목 : 순번, 사번, 이름, 현재급여
SELECT ROWNUM 순번, EMPNO 사번, ENAME 이름, SAL 현재급여
FROM (SELECT * FROM EMP ORDER BY SAL)
WHERE ROWNUM<4;

-- 15. 
-- 급여 인상 대상자를 조회하라
-- 단, 직원의 급여가 평균급여 이하이면 대상자여부에 '대상자'를 출력을하고, 아닌 경우에는 '미대상'을 출력조회하라
-- 대상자가 앞에 올 수 있도록 정렬 조회하라
-- 조회항목 : 사번, 현재급여, 급여인상여부
SELECT EMPNO 사번, SAL 현재급여, 
    CASE
        WHEN SAL < (SELECT AVG(SAL) FROM EMP) THEN '대상자'
        ELSE '미대상'
    END "급여인상여부"
FROM EMP
ORDER BY 급여인상여부;

-- 16.
-- 창사기념일을 맞이하여서 장기근속자에게 시상을 하고자한다.
-- 35년 초과 장기근속자 직원의 정보를 출력하시오.
-- 단, 년미만은 버림처리하여 근속년수를 계산하시오
-- 근속년수가 많은 순서대로 정렬 조회
-- 조회항목 : 사번, 이름, 입사일, 근속년수
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)/12) 근속년수 FROM EMP where to_number(근속년수, '999')>30;
SELECT EMPNO 사번, ENAME 이름, HIREDATE 입사일, TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)/12) 근속년수
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE)/12>35
ORDER BY 근속년수 DESC;

-- 17.
-- 입사년도가 1981년 입사자 명단을 출력하시오.
SELECT * FROM EMP WHERE to_char(HIREDATE, 'yyyy') = '1981';

-- 18.
-- 입사월이 1월인 직원의 숫자를 조회하시오.
-- 1월이라는 별명을 사용하여 출력하시오.
-- 1월 입사자의 숫자뒤에는 '명'을 함께 표기하시오.
SELECT CONCAT(to_char(COUNT(*)), '명') "1월" FROM EMP WHERE to_char(HIREDATE, 'mm') = '01';
SELECT * FROM EMP;

-- 19.
-- 월별 입사 인원현황 직원정보를 출력하시오.
-- 출력형식 : 
-- 1월	2월	...	12월
--  2    2       4  
-- 힌트참고 : select count(hiredate) "1월" from emp where to_char(hiredate, 'mm') = '01';
select count(decode(to_char(hiredate,'mm'), '01', 1)) "1월",
        count(decode(to_char(hiredate,'mm'), '02', 1)) "2월",
        count(decode(to_char(hiredate,'mm'), '03', 1)) "3월",
        count(decode(to_char(hiredate,'mm'), '04', 1)) "4월",
        count(decode(to_char(hiredate,'mm'), '05', 1)) "5월",
        count(decode(to_char(hiredate,'mm'), '06', 1)) "6월",
        count(decode(to_char(hiredate,'mm'), '07', 1)) "7월",
        count(decode(to_char(hiredate,'mm'), '08', 1)) "8월",
        count(decode(to_char(hiredate,'mm'), '09', 1)) "9월",
        count(decode(to_char(hiredate,'mm'), '10', 1)) "10월",
        count(decode(to_char(hiredate,'mm'), '11', 1)) "11월",
        count(decode(to_char(hiredate,'mm'), '12', 1)) "12월"
from emp;

-- 20.
-- 특별 상여금을 지급하기로 했다.
-- 수당이 있는 직원의 특별상여금 = 급여 + (급여 + 수당) * 50%
-- 수당이 없는 직원의 특별상여금 = 급여 * 50%
SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM, SAL + (SAL + COMM) * 0.5, SAL * 0.5)  특별상여금 FROM EMP;

SELECT EMPNO, ENAME, SAL, NVL(COMM, 0) 수당, 
     CASE
        WHEN COMM > 0 THEN  SAL + (SAL + COMM) * 0.5
        ELSE SAL * 0.5
    END "특별상여금"
FROM EMP;

-- 21. 
-- 부서별 부서번호, 평균급여, 인원수 정보를 조회하시오.
-- 단, 평균급여는 10단위 버림처리
-- 평균급여는 천단위마다 컴마표기
-- 평균급여가 높은 순서대로 조회
SELECT DEPTNO 부서번호, to_char(TRUNC(AVG(SAL), -2), '999,999') 평균급여, COUNT(*) 인원수
FROM EMP
GROUP BY DEPTNO
ORDER BY AVG(SAL) DESC;

-- 22. 
-- 부서별 부서번호, 평균급여, 인원수 정보를 조회하시오.
-- 단, 평균급여는 10단위 버림처리
-- 평균급여는 천단위마다 컴마표기
-- 평균급여가 높은 순서대로 조회 
-- 단, 부서별 평균급여가 2000 초과한 부서에 대해서만 변경 조회하시오.
SELECT DEPTNO 부서번호, to_char(TRUNC(AVG(SAL), -2), '999,999') 평균급여, COUNT(*) 인원수
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>2000
ORDER BY AVG(SAL) DESC;

-- 23. 직원들 직무에 따라 차등 적용하여 직원 경조회비를 조회하고자 한다.
-- decode 함수를 사용한다.
-- 조회항목 : 사번, 이름, 경조비율, 급여, 수당, 경조회비 제목으로 출력한다.
-- 급여, 수당, 경조회비는 천단위마다 컴마표기한다.
-- 경조회비가 높은 순서대로 정렬조회한다.
-- 단, 직원경조회비는 100원 미만은 버림 처리한다.
-- 직원경조회비 = (급여 + 수당) * 직무별해당회비율
-- 직무별 회비율
-- PRESIDENT : 15%
-- ANALYST   : 10%
-- MANAGER   : 10%
-- 나머지 직무는 기본 3% (SALESMAN, CLERK 등)
SELECT EMPNO 사번, ENAME 이름, 
    DECODE (JOB,
        'PRESIDENT', '15%',
        'MANAGER',  '10%',
        'ANALYST', '10%',
        'SALESMAN', '3%',
        'CLERK','3%'
    ) 경조비율, to_char(SAL, '999,999') 급여, to_char(NVL(COMM,0), '999,999') 수당,
    to_char(TRUNC(DECODE (JOB,
        'PRESIDENT', (SAL+NVL(COMM, 0)) * 0.15,
        'MANAGER',  (SAL+NVL(COMM, 0)) * 0.1,
        'ANALYST', (SAL+NVL(COMM, 0)) * 0.1,
        'SALESMAN', (SAL+NVL(COMM, 0)) * 0.03,
        'CLERK', (SAL+NVL(COMM, 0)) * 0.03,
         (SAL+NVL(COMM, 0)) * 0.03
        ), -2), '999,999') "경조회비"
FROM EMP
ORDER BY 경조회비 DESC;


-- 24. 
-- 직원들 직무에 따라 차등 적용하여 직원 경조회비를 조회하고자 한다.
-- case 함수를 사용하여 변경 조회한다.
-- 조회항목 : 사번, 이름, 경조비율, 급여, 수당, 경조회비 제목으로 출력한다.
-- 급여, 수당, 경조회비는 천단위마다 컴마표기한다.
-- 경조회비가 높은 순서대로 정렬조회한다.
-- 단, 직원경조회비는 100원 미만은 버림 처리한다.
-- 직원경조회비 = (급여 + 수당) * 직무별해당회비율
-- 직무별 회비율
-- PRESIDENT : 15%
-- ANALYST   : 10%
-- MANAGER   : 10%
-- 나머지 직무는 기본 3% (SALESMAN, CLERK 등)
 SELECT EMPNO 사번, ENAME 이름,
    CASE
        WHEN JOB = 'PRESIDENT' THEN '15%'
        WHEN JOB = 'ANALYST' THEN '10%'
        WHEN JOB = 'MANAGER' THEN '10%'
        ELSE '3%'
    END "경조비율", to_char(SAL, '999,999') 급여, to_char(NVL(COMM, 0), '999,999') 수당,
    to_char(TRUNC(CASE
        WHEN JOB = 'PRESIDENT' THEN (SAL+NVL(COMM, 0)) * 0.15
        WHEN JOB = 'ANALYST' THEN (SAL+NVL(COMM, 0)) * 0.1
        WHEN JOB = 'MANAGER' THEN (SAL+NVL(COMM, 0)) * 0.1
        ELSE (SAL+NVL(COMM, 0)) * 0.03
    END, -2), '999,999') "경조회비"
    FROM EMP
    ORDER BY 경조회비 DESC;       

-- 25. 
-- 사번이 7788인 사원과 같은 부서원들의 정보를 조회하시오. - 7788 없어서 7782로 함
SELECT * FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE EMPNO = 7782);

-- 26. 
-- 대소문자를 구분하지 않고 직무가 'salesman', 'analyst' 인 직원들의 정보 조회하시오.
-- 단, 직무별 정렬조회
SELECT * FROM EMP WHERE UPPER(JOB) IN ('SALESMAN', 'ANALYST') ORDER BY JOB;

-- 27. 
-- 사번이 7369, 7499 직원과 같은 직무를 담당하는 직원의 정보 조회하시오.
SELECT * FROM EMP WHERE JOB IN (SELECT JOB FROM EMP WHERE EMPNO IN (7369, 7499));