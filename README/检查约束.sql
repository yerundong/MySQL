USE `test_db` ;

#============================================= 建表时设置 =============================================#
#================= 方式一 =================#

DROP TABLE IF EXISTS `typhoon`;
CREATE TABLE `typhoon` (
  `no` INT CHECK(`no` > 100 AND `no` < 1000),
  `std` VARCHAR(50) CHECK(LENGTH(`std`) = 3),
  gender_name  CHAR(1) CHECK(`gender_name` = '男' OR `gender_name` = '女')
);

INSERT INTO `typhoon` VALUES(
	200, 'www', '女'
);

SELECT * FROM `typhoon`;
SHOW INDEX FROM `typhoon`;


#================= 方式二 =================#
DROP TABLE IF EXISTS `typhoon` ;

CREATE TABLE `typhoon` (
  `no` INT,
  `std` VARCHAR(50),
  gender_name  CHAR(1),
  CONSTRAINT `ck_` CHECK(
	(`no` > 100 AND `no` < 1000) 
	AND (LENGTH(`std`) = 3) 
	AND (`gender_name` = '男' OR `gender_name` = '女')
	)
);

INSERT INTO `typhoon` VALUES(
	200, 'www', '女'
);

SELECT * FROM `typhoon`;
SHOW INDEX FROM `typhoon`;

#============================================= 修改表时设置 =============================================#
DROP TABLE IF EXISTS `typhoon` ;

CREATE TABLE `typhoon` (
  `no` INT,
  `std` VARCHAR(50),
  gender_name  CHAR(1)
);

ALTER TABLE `typhoon` 
  ADD CONSTRAINT `ck_` CHECK ((`no` > 100 AND `no` < 1000) 
	AND (LENGTH(`std`) = 3) 
	AND (`gender_name` = '男' OR `gender_name` = '女'));
 

INSERT INTO `typhoon` 
VALUES
  (200, 'www', '女') ;

SELECT * FROM `typhoon`;


#============================================= 删除约束 =============================================#
#================= 方式一 =================#
ALTER TABLE `typhoon` DROP CHECK `ck_`;

INSERT INTO `typhoon` 
VALUES
  (2000, 'wwtw', 'yy') ;
  
  
#================= 方式二 =================#  
ALTER TABLE `typhoon` DROP CONSTRAINT `ck_`;

INSERT INTO `typhoon` 
VALUES
  (2000, 'wwtw', 'yy') ;










