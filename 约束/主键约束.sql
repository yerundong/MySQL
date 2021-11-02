USE `mydb` ;

#============================================= 建表时设置 =============================================#

#================= 方式一 =================#
DROP TABLE IF EXISTS `clothing`;

CREATE TABLE `clothing` (
  `id` INT PRIMARY KEY
);

INSERT INTO `clothing` 
VALUES
  (1),
  (2) ;

SELECT * FROM `clothing`;

SHOW INDEX FROM `clothing`;


#================= 方式二 =================#
DROP TABLE IF EXISTS `clothing`;

CREATE TABLE `clothing` (
  `id` INT,
  CONSTRAINT `pk_` PRIMARY KEY (`id`)
);

INSERT INTO `clothing` 
VALUES
  (1),
  (2) ;

SELECT * FROM `clothing`;

SHOW INDEX FROM `clothing`;


#============================================= 修改表时设置 =============================================#
DROP TABLE IF EXISTS `clothing`;
CREATE TABLE `clothing` (
  `id` INT,
  `name` VARCHAR(50)
);

ALTER TABLE `clothing` ADD CONSTRAINT `pk_` PRIMARY KEY(`id`);

ALTER TABLE `clothing` CHANGE `id` `id` INT PRIMARY KEY;


INSERT INTO `clothing` 
VALUES
  (1, '李白'),
  (2, '杜甫') ;

SELECT * FROM `clothing`;

SHOW INDEX FROM `clothing`;

#============================================= 删除约束 =============================================#

#================= MySQL =================#

ALTER TABLE `clothing` DROP PRIMARY KEY;  

SHOW INDEX FROM `clothing`;  

#================= 通用语法 =================#

ALTER TABLE `clothing` DROP CONSTRAINT `PRIMARY`;

SHOW INDEX FROM `clothing`;  


#============================================= 复合主键 =============================================#
DROP TABLE IF EXISTS `clothing`;

CREATE TABLE `clothing` (
  `id` INT,
  `name` VARCHAR(50),
  CONSTRAINT `pk_` PRIMARY KEY (`id`, `name`)
);

INSERT INTO `clothing` 
VALUES
  (2, '李白'),
  (2, '杜甫') ;

SELECT * FROM `clothing`;

SHOW INDEX FROM `clothing`;







































