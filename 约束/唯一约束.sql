USE `mydb` ;

#============================================= 建表时设置 =============================================#

#================= 方式一 =================#

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `no` INT UNIQUE,
  `std` VARCHAR(50) UNIQUE
);

INSERT INTO `project` 
VALUES 
  (1, '123'),
  (2, '234') ;

SELECT * FROM `project`;

SHOW INDEX FROM `project`;

#================= 方式二 =================#

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `no` INT(50),
  `std` VARCHAR(50),
  CONSTRAINT uq_1 UNIQUE (`no`),
  CONSTRAINT uq_2 UNIQUE (`std`)
);

INSERT INTO `project` 
VALUES 
  (1, '123'),
  (2, '23') ;

SELECT * FROM `project`;

SHOW INDEX FROM `project`;


#============================================= 修改表时设置 =============================================#

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `no` INT(50),
  `std` VARCHAR(50)
);

ALTER TABLE `project` 
ADD CONSTRAINT `uq_1` UNIQUE(`no`), 
ADD CONSTRAINT `uq_2` UNIQUE( `std`);

INSERT INTO `project` 
VALUES 
  (1, '123'),
  (2, '23') ;

SELECT * FROM `project`;

SHOW INDEX FROM `project`;

#============================================= 删除约束 =============================================#

#================= MySQL =================#

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `no` INT(50),
  `std` VARCHAR(50)
);

ALTER TABLE `project` 
ADD CONSTRAINT `uq_1` UNIQUE(`no`), 
ADD CONSTRAINT `uq_2` UNIQUE( `std`);

ALTER TABLE `project` DROP INDEX `uq_1`, DROP INDEX `uq_2`;

SHOW INDEX FROM `project`;


#================= 通用 =================#

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `no` INT(50),
  `std` VARCHAR(50)
);

ALTER TABLE `project` 
ADD CONSTRAINT `uq_1` UNIQUE(`no`), 
ADD CONSTRAINT `uq_2` UNIQUE( `std`);

ALTER TABLE `project` DROP CONSTRAINT `uq_1`, DROP CONSTRAINT `uq_2`;

SHOW INDEX FROM `project`;


#============================================= 联合唯一约束 =============================================#

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `no` INT(50),
  `std` VARCHAR(50)
);

ALTER TABLE `project` 
ADD CONSTRAINT `uq_` UNIQUE(`no`, `std`);

INSERT INTO `project` 
VALUES 
  (2, '123'),
  (2, '23') ;

SELECT * FROM `project`;

SHOW INDEX FROM `project`;














