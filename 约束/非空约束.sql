USE `test_db` ;

#============================================= 建表时设置 =============================================#
DROP TABLE IF EXISTS `noodle`;
CREATE TABLE `noodle` (
  `name` VARCHAR(50) NOT NULL
);

INSERT INTO `noodle` VALUES(
	NULL
);


#============================================= 修改表时设置 =============================================#
DROP TABLE IF EXISTS `noodle`;
CREATE TABLE `noodle` (
  `name` VARCHAR(50)
);

ALTER TABLE `noodle` MODIFY `name` VARCHAR(50) NOT NULL;

INSERT INTO `noodle` VALUES(
	NULL
);

#============================================= 删除约束 =============================================#
DROP TABLE IF EXISTS `noodle`;
CREATE TABLE `noodle` (
  `name` VARCHAR(50) NOT NULL
);

ALTER TABLE `noodle` MODIFY `name` VARCHAR(50);

INSERT INTO `noodle` VALUES(
	NULL
);


SELECT * FROM `noodle`;

SHOW INDEX FROM `noodle`;

SELECT DATABASE()