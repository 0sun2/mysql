use train_Reservation_db;
-- 역 테이블 생성
CREATE TABLE 역 (
    역ID INT PRIMARY KEY AUTO_INCREMENT,
    역이름 VARCHAR(100) NOT NULL,
    위치 VARCHAR(100) NOT NULL
);
select *
from 역;
-- 노선 테이블 생성
CREATE TABLE 노선 (
    노선ID INT PRIMARY KEY AUTO_INCREMENT,
    노선명 VARCHAR(100) NOT NULL,
    출발역 INT,
    도착역 INT,
    FOREIGN KEY (출발역) REFERENCES 역(역ID),
    FOREIGN KEY (도착역) REFERENCES 역(역ID)
);
select *
from 노선;
-- 열차 테이블 생성
CREATE TABLE 열차 (
    열차ID INT PRIMARY KEY AUTO_INCREMENT,
    노선ID INT,
    출발역 INT,
    도착역 INT,
    열차번호 VARCHAR(50) NOT NULL,
    열차이름 VARCHAR(100) NOT NULL,
    열차종류 VARCHAR(50) NOT NULL,
    출발시간 TIME NOT NULL,
    도착시간 TIME NOT NULL,
    FOREIGN KEY (노선ID) REFERENCES 노선(노선ID),
    FOREIGN KEY (출발역) REFERENCES 역(역ID),
    FOREIGN KEY (도착역) REFERENCES 역(역ID)
);
select *
from 열차;
-- 좌석 테이블 생성
CREATE TABLE 좌석 (
    좌석ID INT PRIMARY KEY AUTO_INCREMENT,
    열차ID INT,
    좌석등급 VARCHAR(20) NOT NULL,
    좌석번호 VARCHAR(10) NOT NULL,
    사용가능여부 BOOLEAN NOT NULL,
    FOREIGN KEY (열차ID) REFERENCES 열차(열차ID)
);
select *
from 좌석;
-- 사용자 테이블 생성
CREATE TABLE 사용자 (
    사용자ID INT PRIMARY KEY AUTO_INCREMENT,
    사용자명 VARCHAR(50) NOT NULL,
    비밀번호 VARCHAR(50) NOT NULL,
    이메일 VARCHAR(100) NOT NULL,
    전화번호 VARCHAR(20) NOT NULL
);
select *
from 사용자;
-- 예약 테이블 생성
CREATE TABLE 예약 (
    예약ID INT PRIMARY KEY AUTO_INCREMENT,
    열차ID INT,
    사용자ID INT,
    좌석ID INT,
    예약날짜 DATE NOT NULL,
    상태 VARCHAR(20) NOT NULL,
    FOREIGN KEY (열차ID) REFERENCES 열차(열차ID),
    FOREIGN KEY (사용자ID) REFERENCES 사용자(사용자ID),
    FOREIGN KEY (좌석ID) REFERENCES 좌석(좌석ID)
);
select *
from 예약;
-- 결제 테이블 생성
CREATE TABLE 결제 (
    결제ID INT PRIMARY KEY AUTO_INCREMENT,
    예약ID INT,
    금액 DECIMAL(10, 2) NOT NULL,
    결제방법 VARCHAR(50) NOT NULL,
    결제상태 VARCHAR(20) NOT NULL,
    FOREIGN KEY (예약ID) REFERENCES 예약(예약ID)
);
select *
from 결제;
-- 환불 테이블 생성
CREATE TABLE 환불 (
    환불ID INT PRIMARY KEY AUTO_INCREMENT,
    예약ID INT,
    환불금액 DECIMAL(10, 2) NOT NULL,
    환불일 DATE NOT NULL,
    사유 VARCHAR(255) NOT NULL,
    FOREIGN KEY (예약ID) REFERENCES 예약(예약ID)
);
select *
from 환불;
-- 환승 테이블 생성
CREATE TABLE 환승 (
    환승ID INT PRIMARY KEY AUTO_INCREMENT,
    예약ID INT,
    열차ID INT,
    환승시간 TIME NOT NULL,
    FOREIGN KEY (예약ID) REFERENCES 예약(예약ID),
    FOREIGN KEY (열차ID) REFERENCES 열차(열차ID)
);
select *
from 환승;
-- 역 테이블 데이터 삽입
INSERT INTO 역 (역이름, 위치) VALUES
('서울역', '서울특별시'),
('부산역', '부산광역시'),
('대전역', '대전광역시'),
('광주역', '광주광역시');

-- 노선 테이블 데이터 삽입
INSERT INTO 노선 (노선명, 출발역, 도착역) VALUES
('서울-부산', 1, 2),
('서울-대전', 1, 3),
('서울-광주', 1, 4);

-- 열차 테이블 데이터 삽입
INSERT INTO 열차 (노선ID, 출발역, 도착역, 열차번호, 열차이름, 열차종류, 출발시간, 도착시간) VALUES
(1, 1, 2, 'KTX123', 'KTX 123', 'KTX', '09:00:00', '12:00:00'),
(2, 1, 3, 'SRT456', 'SRT 456', 'SRT', '10:00:00', '11:30:00'),
(3, 1, 4, 'ITX789', 'ITX 789', 'ITX', '08:00:00', '10:00:00');

-- 좌석 테이블 데이터 삽입
INSERT INTO 좌석 (열차ID, 좌석등급, 좌석번호, 사용가능여부) VALUES
(1, '일반석', 'A1', TRUE),
(1, '일반석', 'A2', TRUE),
(2, '특실', 'B1', TRUE),
(2, '특실', 'B2', TRUE),
(3, '일반석', 'C1', TRUE),
(3, '일반석', 'C2', TRUE);

-- 사용자 테이블 데이터 삽입
INSERT INTO 사용자 (사용자명, 비밀번호, 이메일, 전화번호) VALUES
('홍길동', 'password1', 'hong@example.com', '010-1234-5678'),
('김영희', 'password2', 'kim@example.com', '010-8765-4321');

-- 예약 테이블 데이터 삽입
INSERT INTO 예약 (열차ID, 사용자ID, 좌석ID, 예약날짜, 상태) VALUES
(1, 1, 1, '2024-06-01', '확정'),
(2, 2, 3, '2024-06-02', '확정');

-- 결제 테이블 데이터 삽입
INSERT INTO 결제 (예약ID, 금액, 결제방법, 결제상태) VALUES
(1, 50000, '카드', '완료'),
(2, 70000, '카드', '완료');

-- 환불 테이블 데이터 삽입
INSERT INTO 환불 (예약ID, 환불금액, 환불일, 사유) VALUES
(1, 50000, '2024-06-05', '여행 취소'),
(2, 70000, '2024-06-06', '여행 취소');

-- 환승 테이블 데이터 삽입
INSERT INTO 환승 (예약ID, 열차ID, 환승시간) VALUES
(1, 1, '01:30:00'),
(2, 2, '02:00:00');

-- 사용자 ID가 1인 사용자의 전화번호 수정
UPDATE 사용자
SET 전화번호 = '010-9999-9999'
WHERE 사용자ID = 1;

select 전화번호
from 사용자
where 사용자ID =1;

-- 좌석 테이블에 '가격' 열을 추가
ALTER TABLE 좌석
ADD COLUMN 가격 DECIMAL(10, 2);

SELECT *
FROM 좌석;

-- 좌석 테이블에서 '가격' 열을 삭제
ALTER TABLE 좌석
DROP COLUMN 가격;

SELECT *
FROM 좌석;

-- 역 조회
SELECT *
FROM 역;

-- GROUP BY,HAVING을 이용해 노선별로 열차의 수를 그룹화, 열차가 1대 이상인 노선 조회
SELECT 노선ID, COUNT(*) AS 열차수
FROM 열차
GROUP BY 노선ID
HAVING COUNT(*) >= 1;

-- 서울역에서 출발하는 열차 조회
SELECT * FROM 열차
WHERE 출발역 = (SELECT 역ID FROM 역 WHERE 역이름 = '서울역');

-- 사용자명에 '홍'이 포함된 사용자 조회
SELECT * FROM 사용자
WHERE 사용자명 LIKE '%홍%';