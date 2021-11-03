USE `test_db` ;

#============================================= 建表时设置 =============================================#
DROP TABLE IF EXISTS `fish`;
CREATE TABLE `fish` (
  `isBall` TINYINT(1) DEFAULT 0,
  `nationality` VARCHAR(20) DEFAULT '中国',
  `color` VARCHAR(20)
);

INSERT INTO `fish` 
VALUES
  (1, DEFAULT, DEFAULT),
  (DEFAULT, '美国', 'red');

SELECT * FROM `fish`;

SHOW INDEX FROM `fish`;

#============================================= 修改表时设置 =============================================#

#================= 方式一 =================#

DROP TABLE IF EXISTS `fish`;
CREATE TABLE `fish` (
  `isBall` TINYINT(1),
  `nationality` VARCHAR(20),
  `color` VARCHAR(20)
);

ALTER TABLE `fish`  ALTER `nationality` SET DEFAULT '英国';

INSERT INTO `fish` 
VALUES
  (DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM `fish`;

SHOW INDEX FROM `fish`;

#================= 方式二 =================#

DROP TABLE IF EXISTS `fish`;
CREATE TABLE `fish` (
  `isBall` TINYINT(1),
  `nationality` VARCHAR(20),
  `color` VARCHAR(20)
);

ALTER TABLE `fish`  MODIFY `nationality` VARCHAR(20) DEFAULT '法国';

INSERT INTO `fish` 
VALUES
  (DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM `fish`;

SHOW INDEX FROM `fish`;

#============================================= 删除约束 =============================================#
DROP TABLE IF EXISTS `fish`;
CREATE TABLE `fish` (
  `isBall` TINYINT(1) DEFAULT 0,
  `nationality` VARCHAR(20) DEFAULT '中国',
  `color` VARCHAR(20)
);


ALTER TABLE `fish`  MODIFY `nationality` VARCHAR(20) DEFAULT NULL;

INSERT INTO `fish` 
VALUES
  (DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM `fish`;



