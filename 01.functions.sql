-- 직원의 사번, 이름, 급여 정보를 제목으로 조회
select empno "사번", ename "이름", sal "급여" from emp;

--  직원의 사번, 이름, 급여 정보를 제목으로 급여가 높은 순서대로 정렬 조회
select empno "사번", ename "이름", sal "급여" from emp order by sal desc;

--  직원의 사번, 이름, 급여 정보를 제목으로 급여가 높은 순서대로 정렬 조회 : 컬럼명이 아닌 컬럼 인덱스로도 지정 가능
select empno "사번", ename "이름", sal "급여" from emp order by 3 desc;

-- 조건검색
-- 직원의 모든 정보 조회, 급여가 2000 미만인 직원의 정보 조회, 급여 낮은 순으로 정렬
select * from emp where sal<2000 order by sal asc;

-- 직원의 모든 정보 조회, 급여가 2000~3000인 직원의 정보 조회, 급여 낮은 순으로 정렬
select * from emp where sal>=2000 and sal<=3000 order by sal asc;
select * from emp where sal between 2000 and 3000 order by sal asc;                                                                                                                                                                                                 

-- 직원 사번, 급여, 수당 조회
select empno, sal, comm from emp;

select empno, sal, comm from emp where comm is not null;
select empno, sal, comm from emp where comm is null;

-- 수당을 받지 않는 직원의 정보 조회
select * from emp where comm is null or comm = 0;

-- 수당을 받는 직원의 정보 조회 : null 검사할 필요 없음
select * from emp where comm>0;

-- NVL(컬럼명, n) : 컬럼 안의 값이 null이면 n으로 치환
-- NVL(컬럼명, n1, n2) : 컬럼 안의 값이 null이 아니면 n1, null이면 n2로 치환
select  empno "사번", ename "이름", sal "급여", comm "수당", (sal+nvl(comm,0))*0.3 "특별수당"
from emp
order by 특별수당 desc;

-- null 컬럼 정렬 조회
-- 1. 직원정보 조회 : 수당 기준, 수당이 많은 사람 순서대로 정렬 조회
-- 2. 직원정보 조회 : 수당 기준, 수당이 적은 사람 순서대로 정렬 조회
-- null 데이터가 어느 위치에 출력되는지 확인

select * from emp order by comm desc;
select * from emp order by comm;

-- 내림차순 정렬시 null - 큰값 - 작은값 순서로 정렬됨
-- 오름차순 정렬시 작은값 - 큰값 - null 순서로 정렬됨

-- 직원 이름 조회
select ename from emp order by ename;

-- 이름에 A가 들어간 직원 조회
select ename from emp where ename like('%A%') order by ename;

-- 이름이 J로 시작하는 직원 조회
select ename from emp where ename like ('J%');
                                                                                                                                                                                                                                                                                                     
-- 이름이 R로 끝나는 직원 조회
select ename from emp where ename like ('%R');
                                                                                                                                                                                                                                                                                                    
-- 이름의 두번째 철자가 L인 직원 조회
select ename from emp where ename like ('_L%');

-- 이름이 네글자인 직원 조회
select ename from emp where ename like ('____');
select ename from emp where length(ename)=4;

-- '가', 'a', '1'의 길이를 조회
select length('가'), lengthb('가'), length('a'), lengthb('a'), length('1'), lengthb('1') from dual;

--LENGTH('가') LENGTHB('가') LENGTH('A') LENGTHB('A') LENGTH('1') LENGTHB('1')                                                                                                                                                                                                                                
------------ ------------- ----------- ------------ ----------- ------------                                                                                                                                                                                                                                
--          1             3           1            1           1            1                                                                                                                                                                                                                                

-- in / not in
-- 10번, 20번 부서원의 정보 저회
select * from emp where deptno in(10, 20);

-- 30번이 아닌 부서원의 정보 조회
select * from emp where deptno not in(30);

-- 10번 20번 부서원이 아닌 직원 정보 조회
select * from emp where deptno not in(10, 20);


-- 직원 이름, 직무 정보를 조회
-- 출력 형식 : 000 사원님의 직무는 000 입니다.
select ename || ' 사원님의 직무는 '  || job || ' 입니다.' from emp;
select concat(concat(ename, ' 사원님의 직무는 '), concat(job, ' 입니다.')) from emp;

-- 사원의 이름의 전체 길이를 15자리로 하고 빈자리는 * 문자로 대체
select lpad(ename, 15, '*') from emp;
select rpad(ename, 15, '*') from emp;

-- 사원의 이름 앞 두자리만 출력하고 나머지는 * 문자로 대체
select rpad(substr(ename, 1, 2), length(ename) , '*') from emp;

-- 숫자 함수 이용해서 처리 : 1234.45678
-- 1. 소수 이하 올림처리
select ceil(1234.45678) from dual;

-- 2. 100 이하 버림처리
select trunc(1234.45678, -2) from dual;

-- 3. 소수 이하 2자리 버림 처리
select trunc(1234.45678, 2) from dual;

-- 4. 소수 이하 1자리 올림처리
select ceil(1234.45678 * 10) / 10 from dual;

-- 5. 숫자 5를 2로 나눈 나머지
select mod(5,2) from dual;


-- 날짜 : sysdate 현재날짜
select sysdate from dual;
                                                                                                                                                                                                                                                                                                  
-- sysdate의 달의 마지막 일 (ex. 2021년 6월의 마지막 일은 30일)
select last_day(sysdate) from dual;

-- next_day(date, num) : date의 num일 후
select next_day(sysdate, 6) from dual;

-- add_months(date, num) : date의 num달 후
select add_months(sysdate, 6) from dual;
                                                                                                                                                                                                                                                                                                  
-- months_between(date_after, date_before) : date_after - date_before
-- 반대로 적으면 음수값으로 나옴
 select months_between(sysdate, '21/11/05') from dual;
                                                                                                                                                                                                                                                                       
-- 내가 살아온 개월수를 정수로 조회
select round(months_between(sysdate, '1997/06/20')) from dual;

-- 오늘 날짜, 2주 후, 2주 전
select sysdate, sysdate+14, sysdate-14 from dual;

-- 경과일수 : sysdate - 기준일
select floor(sysdate - to_date('21/05/17', 'yy/mm/dd')) from  dual;                                                                                                                                                                                                                                                                                          

-- 직원정보 조회
-- 조회 항목 : 사번, 급여, 수당, 입사일
-- 급여, 수당은 천단위마다 컴마 표기, 통화 단위는 기본로케일
-- 입사일 : 년도4자리-월2자리-일2자리 형식으로 조회
-- 최근 입사자 순서대로 정렬 조회
select empno 사번, to_char(sal, 'L999,999') 급여, to_char(nvl(comm, 0), 'L999,999') 수당, to_date(hiredate, 'yyyy-mm-dd') 입사일 from emp order by hiredate desc;

-- 직원정보 조회
-- 조회 항목 : 사번, 급여, 수당, 입사일
-- 급여, 수당은 천단위마다 컴마 표기, 통화 단위는 기본로케일
-- 입사일 : 년도4자리-월2자리-일2자리 형식으로 조회
-- 최근 입사자 순서대로 정렬 조회
select empno 사번, to_char(sal, 'L999,999') 급여, to_char(nvl(comm, 0), 'L999,999') 수당, to_date(hiredate, 'yyyy-mm-dd') 입사일 from emp order by hiredate desc;

----------------------------------------

