USE `test_db`;

CREATE TABLE `star`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(50)
);

SELECT * FROM `star`;

#============================================= 空参列表 =============================================#

DELIMITER $
CREATE PROCEDURE `insert_1`()
BEGIN
	INSERT INTO `star` VALUES(1000, '刘德华'), (NULL, '洪金宝'), (NULL, '成龙');
END $
DELIMITER ;

CALL `insert_1`();-- 调用

#============================================= IN模式 =============================================#

DELIMITER $
CREATE PROCEDURE `insert_2`(IN `name` VARCHAR(50))
BEGIN
	INSERT INTO `star` VALUES(NULL, `name`);
END $
DELIMITER ;

CALL `insert_2`('张国荣');-- 调用


DELIMITER $
CREATE PROCEDURE `judge_user`(IN `user_id` INT, `user_name` VARCHAR(50))
BEGIN
	SELECT * 
	FROM `user`
	WHERE `user`.`user_id` = `user_id`
	AND `user`.`user_name` = `user_name`;
END $
DELIMITER ;

CALL `judge_user`(1, '张三');-- 调用



#============================================= OUT模式 =============================================#
DELIMITER $
CREATE PROCEDURE `sum`(IN `num1` INT, IN `num2` INT, OUT `sum` INT)
BEGIN
	SET `sum` = `num1` + `num2`;
END $
DELIMITER ;

CALL `sum`(1, 2, @`sm`);-- 调用，赋值给用户变量@`sm`接收返回值
SELECT @`sm`;


#============================================= INOUT模式 =============================================#
DELIMITER $
CREATE PROCEDURE `double`(INOUT `num` INT)
BEGIN
	SET `num` = `num` * 2;
END $
DELIMITER ;

SET @db = 20;
CALL `double`(@db);-- 调用，赋值给用户变量@db接收返回值
SELECT @db;

#============================================= 删除 =============================================#

DROP PROCEDURE `test_1`;


#============================================= 查看 =============================================#

SHOW CREATE PROCEDURE `judge_user`;






















