#================= 创建表 =================#
USE `mydb`

#================= 表的创建 =================#
CREATE TABLE `pets`(
	`pet_id` INT,
	`name` VARCHAR(20),
	`age` INT,
	`master_id` INT
);

CREATE TABLE `masters`(
	`master_id` INT,
	`master_name` VARCHAR(20),
	`age` INT
);

#================= 表的删除 =================#
DROP TABLE `masters`;

DROP TABLE IF EXISTS `masters`;


#================= 表的修改 =================#

# 修改表名
ALTER TABLE `pets` RENAME `pets2`; 

RENAME TABLE `pets2` TO `pets`;

RENAME TABLE `pets2` TO `pets`, `masters2` TO `masters`;-- 多表


# 修改列名
ALTER TABLE `pets` CHANGE `name` `pet_name` CHAR(20);


# 修改列类型
ALTER TABLE `pets` MODIFY `pet_name` VARCHAR(15);

# 增加列
ALTER TABLE `masters` ADD `hoby` VARCHAR(50);

# 删除列
ALTER TABLE `masters` DROP `hoby`;

ALTER TABLE pets

#================= 表的复制 =================#
# 先给pet表插入些数据，用于对比
INSERT INTO `pets` VALUES(
	1001, '旺财', 3, 2001
),(
	1002, '小强', 1, 2003
);


# CREATE TABLE LIKE
CREATE TABLE `pets_copy` LIKE `pets`; -- 先复制表结构
INSERT INTO `pets_copy` SELECT * FROM `pets`; -- 再复制数据


# CREATE TABLE AS
CREATE TABLE `pets_copy2` AS SELECT * FROM `pets`; -- 复制表结构 + 数据

CREATE TABLE `pets_copy3` 
SELECT `pet_id`, `pet_name` 
FROM `pets`
WHERE FALSE; -- 设置恒假，来实现只复制表结构



#================= 测试用 =================#
SELECT * FROM `pets`
SELECT * FROM `pets_copy`
SELECT * FROM `pets_copy2`
SELECT * FROM `pets_copy3`

DROP TABLE `pets_copy2`;
DROP TABLE `pets_copy3`;

DESC pets;

SHOW TABLES;




