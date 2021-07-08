#《字符函数》

SELECT `job_id` FROM `jobs`;

SELECT * FROM `employees`;

SELECT LOWER(`job_id`) FROM `jobs`;-- 转小写

SELECT UPPER(`first_name`) FROM `employees`;-- 转大写

#SELECT INITCAP(`first_name`) FROM `employees`;-- 首字母转大写，属于Oracle，mysql没有该函数
SELECT `job_id`, CONCAT(UPPER(SUBSTR(`job_id`, 1, 1)), LOWER(SUBSTR(`job_id`, 2, LENGTH(job_id)-1))) AS '首字母大写' FROM `jobs`;

SELECT CONCAT(`first_name`, '.',`last_name`, '-', `salary`) AS 'concat' FROM `employees`;

SELECT `first_name`, SUBSTR(`first_name`, 2, 1) AS 'sub' FROM `employees`;

SELECT `first_name`, SUBSTR(`first_name`, 3) AS 'sub' FROM `employees`;

SELECT `first_name` FROM `employees` WHERE SUBSTRING(`first_name`, 1, 1) = 'A';-- 找出首字母为A的

SELECT INSTR('老鼠爱大米也爱小米', '大米');

SELECT `first_name`, LENGTH(`first_name`) AS 'len' FROM `employees`;-- LENGTH

SELECT LENGTH('哇哈哈wahaha');-- 汉字3个字节，字母一个字节
SHOW VARIABLES LIKE '%char%';

SELECT `first_name`, LPAD(`first_name`, 10, '*') AS 'lpad', RPAD(`first_name`, 10, '#') AS 'rpad' FROM `employees`;

SELECT LPAD('李寻欢', 10, '*#');

SELECT LPAD('李寻欢', 2, '*');

SELECT RPAD('李寻欢', 2, '*');

SELECT TRIM('  s     ') AS 'TRIM' FROM `employees`;

SELECT TRIM('a' FROM 'aaaaaaa李小aaa环aaaaaaa');

SELECT TRIM('aa' FROM 'aaaaaaa李小aaa环aaaaaaa');

SELECT TRIM('a' FROM 'abca李小aaa环abca');

SELECT `first_name`, REPLACE(`first_name`, 'e', '*') AS 'REPLACE' FROM `employees`;


#《数字函数》

SELECT ROUND(12345.123456789);

SELECT ROUND(12345.123456789, 4);

SELECT ROUND(12345.123456789, -1);-- 保留到十位

SELECT CEIL(12345.123456789);

SELECT FLOOR(12345.123456789);

SELECT TRUNCATE(12345.123456789, 4);
#SELECT TRUNC(1.123456789, 4);-- Oracle用法

SELECT TRUNCATE(12345.123456789, -1);-- 保留到十位

SELECT MOD(99, 2);

SELECT RAND() FROM `employees`;

SELECT ROUND(RAND() * 99 + 1) FROM `employees`;-- 1~100随机数

#《日期函数》

SELECT NOW();

SELECT SYSDATE();

SELECT CURDATE();

SELECT CURTIME();

SELECT YEAR(NOW());

SELECT YEAR('1998-01-19');

SELECT YEAR('1998.01.19');

SELECT YEAR('1998/01/19');

SELECT YEAR('1998-01-19 19:23:09');

SELECT MONTH('1998-01-19 19:23:09');

SELECT MONTH('1998/01/19');

SELECT MONTHNAME('1998/01/19');

SELECT DAY(NOW());

SELECT HOUR(NOW());

SELECT MINUTE(NOW());

SELECT SECOND(NOW());

SELECT HOUR('1998/01/19');

SELECT CURRENT_TIMESTAMP, CURRENT_TIMESTAMP(); 

SELECT STR_TO_DATE('09/19 2021', '%m/%d %Y');

SELECT DATE_FORMAT(NOW(), '%Y年%m月%d日');

SELECT DATEDIFF('2021-9-9', NOW());

#《其他函数》

SELECT IFNULL(NULL*100, 0);

SELECT ISNULL(NULL*100);

SELECT NULLIF(1, 2);-- 1

SELECT NULLIF(1, 1);-- null
#SELECT decode(1, 1, 2,);

USE myemployees;
SELECT DATABASE();

SELECT VERSION();

SELECT USER();

#流程函数


SELECT IF(10 > 5, '大', '小');-- if函数

#case第一种用法：充当表达式
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
  
#case第二种用法：
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

