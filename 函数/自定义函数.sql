
USE `test_db`;

CREATE TABLE `performer`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(50)
);

SELECT * FROM `performer`;

#============================================= 空参列表 =============================================#
SET GLOBAL log_bin_trust_function_creators = TRUE;-- 它控制是否可以信任存储函数创建者，不会创建写入二进制日志引起不安全事件的存储函数。如果设置为0（默认值），用户不得创建或修改存储函数，除非它们具有除CREATE ROUTINE或ALTER ROUTINE特权之外的SUPER权限。

DELIMITER $
CREATE FUNCTION `get_user_count` () RETURNS INT
BEGIN
	DECLARE c INT;
	SELECT COUNT(*) INTO c
	FROM `user`;
	RETURN c;
END $
DELIMITER ; 

SELECT get_user_count();

#============================================= 有参列表 =============================================#

DELIMITER $
CREATE FUNCTION `get_double` (num DOUBLE) RETURNS DOUBLE
BEGIN
	RETURN num * 2;
END $
DELIMITER ; 

SELECT get_double(2.123456);


# 根据id查询用户信息
DELIMITER $
CREATE FUNCTION `get_user_age_by_id` (id INT) RETURNS INT
BEGIN
	DECLARE age_ INT;
	
	SELECT age INTO age_ 
	FROM `user`
	WHERE `user_id` = id;
	
	RETURN age_;
END $
DELIMITER ; 

SELECT `get_user_age_by_id`(3);


#============================================= 删除 =============================================#
DROP FUNCTION IF EXISTS `get_user_age_by_id`;


#============================================= 查看 =============================================#
SHOW CREATE FUNCTION `get_user_age_by_id`;



#============================================= 练习 =============================================#
# 生成随机长度、由任意字母组成的字符串


DELIMITER $
# 获取任意字母函数
CREATE FUNCTION get_random_letter() RETURNS CHAR
BEGIN
	RETURN SUBSTR('abcdefghijklmnopqrstuvwxyz', ROUND(RAND() * 25 + 1), 1);
END $

# 生成随机长度、由任意字母组成的字符串函数（最长100）

CREATE FUNCTION get_random_letters(len INT) RETURNS VARCHAR(100)
BEGIN
	DECLARE i INT DEFAULT 0;
	SET @str = '';
	
	WHILE i < len DO
		SET @str = CONCAT(@str, get_random_letter());
		SET i = i + 1;
	END WHILE;
	
	RETURN @str;
END $

DELIMITER ;


SELECT get_random_letter();

SELECT get_random_letters(100);

