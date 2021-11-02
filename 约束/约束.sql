
#================= 非空约束 =================#
DROP TABLE IF EXISTS `hoby`;
CREATE TABLE `hoby` (
  `name` VARCHAR(50) NOT NULL
);

INSERT INTO `hoby` VALUES(
	NULL
);

SELECT * FROM `hoby`;

SHOW INDEX FROM `user`;



#================= 检查约束 =================#
DROP TABLE IF EXISTS `hoby`;
CREATE TABLE `hoby` (
  `hoby_no` INT CHECK(`hoby_no` > 100 AND `hoby_no` < 1000),
  `std` VARCHAR(50) CHECK(LENGTH(`std`) = 3),
  gender_name  CHAR(1) CHECK(`gender_name` = '男' OR `gender_name` = '女')
);

INSERT INTO `hoby` VALUES(
	200, 'www', '女'
);

SELECT * FROM `hoby`;
DESC `hoby`


#================= 默认约束 =================#
DROP TABLE IF EXISTS `hoby`;
CREATE TABLE `hoby` (
  `isBall` TINYINT(1) DEFAULT 0,
  `nationality` VARCHAR(20) DEFAULT '中国',
  `color` VARCHAR(20)
);

INSERT INTO `hoby` 
VALUES
  (1, DEFAULT, DEFAULT),
  (DEFAULT, '美国', 'red');

SELECT * FROM `hoby`;
