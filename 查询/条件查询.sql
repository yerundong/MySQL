#条件查询

SELECT * FROM `employees` WHERE `department_id` = 70;

SELECT * FROM `employees` WHERE `department_id` != 70;

SELECT * FROM `employees` WHERE `salary` > 10000;

SELECT * FROM `employees` WHERE `salary` >= 10000;

SELECT * FROM `employees` WHERE `salary` < 10000;

SELECT * FROM `employees` WHERE `salary` <= 10000;

SELECT * FROM `employees` WHERE `salary` BETWEEN 9500 AND 10000;-- BETWEEN AND

SELECT * FROM `employees` WHERE `salary` BETWEEN 9500 AND 10000 OR `salary` > 20000;

SELECT * FROM `employees` WHERE `salary` <= 10000 AND `salary` >= 9500;-- AND

SELECT * FROM `employees` WHERE `salary` < 10000 AND `salary` > 9500;

SELECT * FROM `employees` WHERE `salary` < 10000 && `salary` > 9500;

SELECT * FROM `employees` WHERE `salary` < 10000 || `salary` > 9500;

SELECT * FROM `employees` WHERE `manager_id` IS NULL;-- IS NULL

SELECT * FROM `employees` WHERE `commission_pct` IS NOT NULL;

SELECT * FROM `employees` WHERE `salary` = 12000 AND `commission_pct` = 0.3;

SELECT * FROM `employees` WHERE `salary` = 12000 OR `commission_pct` = 0.3;-- OR

SELECT * FROM `employees` WHERE (`salary` = 12000 OR `commission_pct` = 0.3) AND `manager_id` = 100;

SELECT * FROM `employees` WHERE `salary` IN (10000,11000,12000);-- IN

SELECT * FROM `employees` WHERE `salary` IN (10000,11000,'12%');-- IN，不能使用通配符

SELECT * FROM `employees` WHERE `salary` NOT IN (10000,11000,12000) AND `salary` > 8000;

SELECT * FROM `employees` WHERE `first_name` LIKE 'p%';

SELECT * FROM `employees` WHERE `first_name` LIKE '_e%';

SELECT * FROM `employees` WHERE `first_name` LIKE '% %';

SELECT * FROM `employees` WHERE `job_id` LIKE 'ad\_%';-- 转义

SELECT * FROM `employees` WHERE `job_id` LIKE 'ad$_%' ESCAPE '$';-- 自定义转义符