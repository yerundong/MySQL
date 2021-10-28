USE `mydb`;

#================= 整数型 =================#
DROP TABLE IF EXISTS `hoby`;
CREATE TABLE `hoby`(
	`hoby_id` INT UNSIGNED,
	`count` TINYINT,
	`number` INT(7) ZEROFILL,
	`hoby_name` VARCHAR(20)
);

INSERT INTO `hoby` VALUES(
	1001, -1, 123, '足球'
), (
	1001, 12, 12345678,'篮球'
);

SELECT * FROM `hoby`;

#================= 小数型 =================#
