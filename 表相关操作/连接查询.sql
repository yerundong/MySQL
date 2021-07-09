USE `myemployees`;

SELECT * FROM `employees`;

SELECT * FROM `departments`;

#笛卡尔乘积现象
SELECT CONCAT(`first_name`, '.', `last_name`) AS 'name', `department_name` FROM `employees` JOIN `departments`;

#加上限制条件，避免笛卡尔乘积现象
SELECT CONCAT(`first_name`, '.', `last_name`) AS 'name', `departments`.`department_name` FROM `employees` JOIN `departments`
ON `employees`.`department_id` = `departments`.`department_id`;

#给查询字段加上表名，提高查询效率
SELECT CONCAT(`employees`.`first_name`, '.', `employees`.`last_name`) AS 'name', `departments`.`department_name` 
FROM `employees` JOIN `departments`
ON `employees`.`department_id` = `departments`.`department_id`;

#给表起别名，更简洁
SELECT CONCAT(a.first_name, '.', a.last_name) AS 'name', b.department_name  
FROM `employees` AS a JOIN `departments` AS b
ON a.department_id = b.department_id;