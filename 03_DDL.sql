-- drop table
DROP TABLE MEMBER CASCADE CONSTRAINTS;

-- CREATE TABLE : 식별키 member_id 단일컬럼
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(30) PRIMARY KEY,
    MEMBER_PW VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    MOBILE VARCHAR2(13) NOT NULL,
    EMAIL VARCHAR2(30) NOT NULL,
    ENTRY_DATE VARCHAR2(10) NOT NULL,
    GRADE VARCHAR2(1) NOT NULL,
    MILEAGE NUMBER(6),
    MANAGER VARCHAR2(10)
);

-- CREATE TABLE : 식별키 member_id, name 다중컬럼

-- 컬럼 레벨로 다중 PK 지정시 오류 - ORA-02260: table can have only one primary key
-- 컬럼 레벨로 PRIMARY KEY는 단일컬럼에만 적용 가능

-- 테이블레벨 다중컬럼에 대한 식별키 제약 지정
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(30),
    MEMBER_PW VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(20),
    MOBILE VARCHAR2(13) NOT NULL,
    EMAIL VARCHAR2(30) NOT NULL,
    ENTRY_DATE VARCHAR2(10) NOT NULL,
    GRADE VARCHAR2(1) NOT NULL,
    MILEAGE NUMBER(6),
    MANAGER VARCHAR2(10),
    
    CONSTRAINT PK_MEMBER_ID_NAME PRIMARY KEY (MEMBER_ID, NAME)
);

-- 제약조건 추가
ALTER TABLE MEMBER ADD CONSTRAINT UK_MOBILE UNIQUE(MOBILE);

-- 제약조건 조회
SELECT CONSTRAINT_NAME, COLUMN_NAME FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'MEMBER';

-- 제약조건 삭제
ALTER TABLE MEMBER DROP CONSTRAINT SYS_C007053;

-- 제약 관련 data dictionary
DESC USER_CONSTRAINTS;
DESC USER_CONS_COLUMNS;

-- member 테이블에 대한 제약 조회
select table_name, constraint_name, constraint_type
from user_constraints
where table_name in('MEMBER');

-- user_cons_columns 테이블 이용해서 MEMBER 테이블의 PK_MEMBER_ID_NAME 제약에 대한 컬럼 조회
select table_name, constraint_name, column_name
from user_cons_columns
where table_name in('MEMBER') AND constraint_name in('PK_MEMBER_ID_NAME');

DROP TABLE NOTICE;

-- CREATE TABLE
CREATE TABLE NOTICE(
    NOTICE_NO NUMBER(6),
    TITLE VARCHAR2(30) NOT NULL,
    CONTENT VARCHAR2(100),
    MEMBER_ID VARCHAR2(30) NOT NULL,
    NOTICE_DATE DATE NOT NULL,
    HITS NUMBER(6)
);
ALTER TABLE NOTICE ADD CONSTRAINT PK_NOTICE_NO PRIMARY KEY(NOTICE_NO);
ALTER TABLE NOTICE ADD CONSTRAINT FK_MEMBER_ID FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID);

DESC NOTICE;

-- 회원 테이블 레코드 추가 : 컬럼 지정
INSERT INTO MEMBER(MEMBER_ID, MEMBER_PW, NAME, MOBILE, EMAIL, ENTRY_DATE, GRADE, MILEAGE)
VALUES('user01', 'password01', '홍길동', '010-1234-1111', 'user01@work.com', '2017.05.05', 'G', 75000);

-- 회원 테이블 레코드 추가 : 컬럼 미지정
INSERT INTO MEMBER
VALUES('user02', 'password02', '강감찬', '010-1234-1112', 'user02@work.com', '2017.05.06', 'G', 95000, NULL);

INSERT INTO MEMBER VALUES('user03', 'password03', '이순신', '010-1234-1113', 'user03@work.com', '2017.05.07', 'G', 3000, NULL);
INSERT INTO MEMBER VALUES('user04', 'password04', '김유신', '010-1234-1114', 'user04@work.com', '2017.05.08', 'S', NULL, '송중기');
INSERT INTO MEMBER VALUES('user05', 'password05', '유관순', '010-1234-1115', 'user05@work.com', '2017.05.09', 'A', NULL, NULL);

-- 부서 테이블에 부서번호 점검에 사용하기 위한 시퀀스 객체 생성
-- 현재 부서테이블에 추가로 부서를 등록시킬때 사용하기 위한 시퀀스 객체
-- 시퀀스 시작번호, 종결값, 최대값, 반복 여부?

-- 현재 최소부서번호, 최대부서번호 조회
-- 현재 부서번호만 정렬조회
-- 부서테이블 구조 조회, 부서번호 어떤 구조인지 확인
SELECT * FROM DEPT;
CREATE SEQUENCE SEQ_DEPT_DEPTNO
	START WITH 50
	INCREMENT BY 10
    MAXVALUE 90
    NOCYCLE
;

INSERT INTO DEPT VALUES(SEQ_DEPT_DEPTNO.NEXTVAL, '개발1팀', '제주시');
INSERT INTO DEPT VALUES(SEQ_DEPT_DEPTNO.NEXTVAL, '개발2팀', '부산');

-- 트랜잭션 원상 복구 : 부서 테이블 레코드 추가 취소
ROLLBACK;

-- 테이블 생성해서, 직원테이블 10번 부서원들의 이름, 직무 정보를 레코드 추가
-- 1. TEST 테이블
--    >> USER_NAME => ENAME VARCHAR2(10)
--    >> USER JOB => JOB VARCHAR2(9)

CREATE TABLE TEST(
    USER_NAME VARCHAR2(10),
    USER_JOB VARCHAR2(9)
);

-- 2. 직원 테이블의 레코드를 참조해서 TEST 테이블에 다중 레코드 추가
INSERT INTO TEST(USER_NAME, USER_JOB)
SELECT ENAME, JOB FROM EMP WHERE DEPTNO = 10;


DROP TABLE EMP_10;
-- 10번 부서원들의 정보 및 구조를 갖는 테이블 생성 : EMP_10
CREATE TABLE EMP_10
AS SELECT DEPTNO 부서번호, EMPNO, ENAME, SAL FROM EMP WHERE DEPTNO = 10;

SELECT * FROM EMP_10;

-- 직원 테이블의 구조만을 참조해서 테이블 생성
-- WHERE 절에 일부러 거짓 조건을 넣는다.
CREATE TABLE NEW_EMP
AS SELECT * FROM EMP
WHERE 1=2;

SELECT * FROM NEW_EMP;
