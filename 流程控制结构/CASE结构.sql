#============================================= 作为表达式使用 =============================================#

#================= 枚举用法 =================#
USE `myemployees`;

SELECT 
  `first_name`,
  CASE
    `salary` 
    WHEN 7000 THEN '柒仟'
    WHEN 8000 THEN '捌仟' 
    WHEN 9000 THEN '玖仟'
    WHEN 10000 THEN '壹万' 
    ELSE `salary` 
  END 
  AS '薪水' 
FROM
  `employees`;


#================= 判断用法 =================#
SELECT
  `first_name`,
  CASE
    WHEN `salary` > 10000 
    THEN '好多钱'
    WHEN `salary` < 3000 
    THEN '好少钱' 
    ELSE `salary` 
  END AS '薪水' 
FROM
  `employees` ;

#============================================= 作为语句使用 =============================================#

#================= 枚举用法 =================#

DELIMITER $
CREATE FUNCTION `lg_100`(num INT) RETURNS VARCHAR(10)
BEGIN
	DECLARE res VARCHAR(10);
	
	CASE num > 100
		WHEN TRUE
		THEN SET res = '大于100';
		ELSE SET res = '小于100';
	END CASE;
	
	RETURN res;
END$
DELIMITER ;

SELECT lg_100(90);

#================= 判断用法 =================#

DELIMITER $
CREATE FUNCTION `judge_100`(num INT) RETURNS VARCHAR(10)
BEGIN
	DECLARE res VARCHAR(10);
	
	CASE 
		WHEN num > 100
		THEN SET res = '大于一百';
		WHEN num = 100
		THEN SET res = '等于一百';
		ELSE SET res = '小于一百';
	END CASE;
	
	RETURN res;
END$
DELIMITER ;

SELECT judge_100(100);






