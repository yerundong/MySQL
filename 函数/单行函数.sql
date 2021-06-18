#《字符函数》

SELECT `job_id` FROM `jobs`;

SELECT * FROM `employees`;

SELECT LOWER(`job_id`) FROM `jobs`;-- 转小写

SELECT UPPER(`first_name`) FROM `employees`;-- 转大写

#SELECT INITCAP(`first_name`) FROM `employees`;-- 首字母转大写，属于Oracle，mysql没有该函数
SELECT `job_id`, CONCAT(UPPER(SUBSTR(`job_id`, 1, 1)), LOWER(SUBSTR(`job_id`, 2, LENGTH(job_id)-1))) AS '首字母大写' FROM `jobs`;

SELECT CONCAT(`first_name`, '.',`last_name`, '-', `salary`) AS 'concat' FROM `employees`;

SELECT `first_name`, SUBSTR(`first_name`, 2, 1) AS 'sub' FROM `employees`;

SELECT `first_name` FROM `employees` WHERE SUBSTR(`first_name`, 1, 1) = 'A';-- 找出首字母为A的

SELECT `first_name`, LENGTH(`first_name`) AS 'len' FROM `employees`;

SELECT `first_name`, LPAD(`first_name`, 10, '*') AS 'lpad', RPAD(`first_name`, 10, '#') AS 'rpad' FROM `employees`;

SELECT TRIM('  s     ') AS 'TRIM' FROM `employees`;

SELECT `first_name`, TRIM('en' FROM `first_name`) AS 'TRIM' FROM `employees`;

SELECT `first_name`, REPLACE(`first_name`, 'e', '*') AS 'REPLACE' FROM `employees`;

#《数字函数》

SELECT ROUND(12345.123456789);

SELECT ROUND(12345.123456789, 4);

SELECT ROUND(12345.123456789, -1);-- 保留到十位

SELECT TRUNCATE(12345.123456789, 4);
#SELECT TRUNC(1.123456789, 4);-- Oracle用法

SELECT TRUNCATE(12345.123456789, -1);-- 保留到十位

SELECT MOD(99, 2);

SELECT RAND() FROM `employees`;

SELECT ROUND(RAND() * 99 + 1) FROM `employees`;-- 1~100随机数


#《通用函数》

SELECT IFNULL(NULL*100, 0);

SELECT ISNULL(NULL*100);

SELECT NULLIF(1, 2);-- 1

SELECT NULLIF(1, 1);-- null
#SELECT decode(1, 1, 2,);

#case第一种用法：
SELECT 
  `first_name`,
  CASE
    `salary` 
    WHEN 7000 
    THEN '柒仟'
    WHEN 8000 
    THEN '捌仟' 
    WHEN 9000 
    THEN '玖仟' 
    WHEN 10000 
    THEN '壹万' 
    ELSE `salary` 
  END AS '薪水' 
FROM
  `employees` ;
  
  
#case第二种用法：
SELECT 
  CASE
    WHEN `salary` > 10000 
    THEN '好多钱'
    WHEN `salary` < 3000 
    THEN '好少钱' 
    ELSE `salary` 
  END AS '薪水' 
FROM
  `employees` ;

