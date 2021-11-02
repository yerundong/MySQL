USE `test_db` ;

#================= 整数型 =================#
DROP TABLE IF EXISTS `cook`;
CREATE TABLE `cook` (
  `i1` INT UNSIGNED,
  `i2` TINYINT,
  `i3` INT (7) ZEROFILL-- ??????
) ;

INSERT INTO `cook` VALUES(
	2, -10, 123
), (
	2, 10, 12345678
);

SELECT * FROM `cook`;

#================= 小数型 =================#
DROP TABLE IF EXISTS `cook`;
CREATE TABLE `cook`(
	`f1` FLOAT(5, 2),
	`f2` DOUBLE(5, 2),
	`f3` DECIMAL(5, 2),
	`f11` FLOAT,
	`f22` DOUBLE,
	`f33` DECIMAL
);

INSERT INTO `cook` 
VALUES
  (1, 2, 3, 4, 5, 6),
  (1.12, 12.123, 123.125, 12345.12345, 12345.12345, 12345.12345);

SELECT * FROM `cook`;

DESC `cook`;

#================= 日期型 =================#
DROP TABLE IF EXISTS `cook`;
CREATE TABLE `cook` (
  `d1` DATE,
  `d2` TIME,
  `d3` YEAR,
  `d4` DATETIME,
  `d5` TIMESTAMP
) ;

INSERT INTO `cook` 
VALUES
  (
    '2021-10-29',
    '11:24:36',
    '2021',
    '2021-10-29 11:24:36',
    '20211029112436'
  ),
  (
    '2021-10-29',
    '11:24:36',
    2022,
    '2021-10-29 11:24:36',
    20221029112436
  ),
  (
    CURDATE(),
    CURTIME(),
    YEAR(NOW()),
    NOW(),
    CURRENT_TIMESTAMP()
  ) ;

SELECT * FROM `cook`;

DESC `cook`;










