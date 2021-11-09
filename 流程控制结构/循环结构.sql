USE `test_db`;

#============================================= WHILE语句 =============================================#
# 求阶乘
DELIMITER $
CREATE PROCEDURE xh_prd(IN num INT, OUT rnum INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	SET rnum = 1;
	WHILE i < num DO
		SET rnum = rnum * (i+1);
		SET i = i + 1;
	END WHILE;
END$
DELIMITER ;

CALL xh_prd(10, @res);
SELECT @res;


# 批量插入
DROP TABLE IF EXISTS people;
CREATE TABLE people(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(50)
);

DELIMITER $
CREATE PROCEDURE pl_insert(num INT, `name` VARCHAR(50))
BEGIN
	DECLARE i INT DEFAULT 0;
	WHILE i < num DO
		
		INSERT INTO people VALUES(NULL, CONCAT(`name`, i));
		
		SET i = i + 1;
	END WHILE;
END$
DELIMITER ;

CALL pl_insert(100, '杜甫');
SELECT * FROM people;

#============================================= LOOP语句 =============================================#
# 求阶乘
DELIMITER $
CREATE PROCEDURE jc_prd(IN num INT, OUT rnum INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	SET rnum = 1;
	
	a:LOOP
		SET rnum = rnum * (i+1);
		
		SET i = i + 1;
		
		IF i >= num THEN LEAVE a;
		END IF;
	END LOOP;
END$
DELIMITER ;

CALL jc_prd(12, @res);
SELECT @res;

#============================================= REPEAT语句 =============================================#
# 求阶乘
DELIMITER $
CREATE PROCEDURE jc_prd2(IN num INT, OUT rnum INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	SET rnum = 1;
	
	REPEAT
		SET rnum = rnum * (i+1);
		SET i = i + 1;
		
	UNTIL i >= num
	END REPEAT;
END$
DELIMITER ;

CALL jc_prd2(10, @res);
SELECT @res;


#============================================= 循环控制 =============================================#

#================= LEAVE =================#

# 求阶乘(最多不超过10!)
DELIMITER $
CREATE PROCEDURE xh_prd2(IN num INT, OUT rnum INT)
BEGIN
	DECLARE i INT DEFAULT 1;
	SET rnum = 1;
	a:WHILE i < num DO
		IF i > 9 THEN LEAVE a;
		END IF;
		
		SET rnum = rnum * (i+1);
		
		SET i = i + 1;
	END WHILE a;
END$
DELIMITER ;

CALL xh_prd2(66, @res);
SELECT @res;

#================= ITERATE =================#
# 求num以内的偶数之和
DELIMITER $
CREATE PROCEDURE oh_prd(IN num INT, OUT rnum INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	SET rnum = 0;
	a:WHILE i < num DO
		SET i = i + 1; 
		
		IF i % 2 = 1 
		THEN ITERATE a;
		END IF;
		
		SET rnum = rnum + i;
	END WHILE a;
END$
DELIMITER ;

CALL oh_prd(7, @res);
SELECT @res;



SELECT MD5('ass')




