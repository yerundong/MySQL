DELIMITER $
CREATE PROCEDURE `test_2`()
BEGIN
	DECLARE `name` VARCHAR(50);
	DECLARE `lname` VARCHAR(50);
	
	SET `name` = '李四';
	
	SELECT l.`location_name` 
	INTO `lname`
	FROM `user` AS u
	JOIN `location` AS l
	ON u.`location_id` = l.`location_id`
	WHERE u.`user_name` = '李四';
	
	SELECT `name`, `lname`;
END $
DELIMITER ;

CALL `test_1`();