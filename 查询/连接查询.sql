USE `myemployees`;

#================ 笛卡尔乘积现象 ================#
SELECT CONCAT(`first_name`, '.', `last_name`) AS 'name', `department_name` 
FROM `employees` 
JOIN `departments`;

#加上限制条件，避免笛卡尔乘积现象
SELECT CONCAT(`first_name`, '.', `last_name`) AS 'name', `departments`.`department_name` 
FROM `employees` 
JOIN `departments`
ON `employees`.`department_id` = `departments`.`department_id`;

#给查询字段加上表名，提高查询效率
SELECT CONCAT(`employees`.`first_name`, '.', `employees`.`last_name`) AS 'name', `departments`.`department_name` 
FROM `employees` 
JOIN `departments`
ON `employees`.`department_id` = `departments`.`department_id`;

#================ 内连接之等值连接 ================#
# 给表起别名，更简洁
SELECT CONCAT(a.first_name, '.', a.last_name) AS 'name', b.department_name  
FROM `employees` AS a 
INNER JOIN `departments` AS b
ON a.department_id = b.department_id;

SELECT CONCAT(a.first_name, '.', a.last_name) AS 'name', b.department_name  
FROM `employees` AS a 
JOIN `departments` AS b
ON a.department_id = b.department_id 
WHERE a.first_name LIKE '_e%';

#等值连接，加上分组和排序
SELECT COUNT(*), CONCAT(a.first_name, '.', a.last_name) AS 'name', b.department_name  
FROM `employees` AS a 
JOIN `departments` AS b
ON a.department_id = b.department_id 
AND a.first_name LIKE '_e%' 
GROUP BY a.department_id 
ORDER BY COUNT(*);

#三表连接查询
SELECT CONCAT(a.first_name, '.', a.last_name) AS 'name', b.department_name, c.`city`  
FROM `employees` AS a 
JOIN `departments` AS b 
JOIN `locations` AS c
ON a.department_id = b.department_id 
AND b.`location_id` = c.`location_id`

#================ 内连接之非等值连接 ================#
# 不是等值连接的都叫非等值连接
SELECT CONCAT(first_name, '.', last_name) '姓名', `salary` '工资',  `grade_level` '工资等级' 
FROM `employees` e
INNER JOIN `job_grades` j
ON `salary` BETWEEN `lowest_sal` AND `highest_sal`
ORDER BY `salary`

#================ 内连接之自连接 ================#
SELECT e.`first_name` '员工', m.`first_name` '领导'
FROM `employees` AS e 
INNER JOIN `employees` AS m
ON e.`manager_id` = m.`employee_id`

SELECT e.`first_name` '员工', m.`first_name` '领导'
FROM `employees` AS e 
INNER JOIN `employees` AS m
ON e.`manager_id` = m.`employee_id`
WHERE m.`first_name` LIKE 's%' AND e.`first_name` LIKE '%l'

#================ 外连接之左外连接 ================#
USE test_db;
SELECT u.`user_id`, u.`user_name`, l.`location_name`
FROM `user` AS u
LEFT JOIN `location` AS l
ON u.`location_id` = l.`location_id`

#查询哪个用户没有地址
SELECT u.`user_id`, u.`user_name`, l.`location_name`
FROM `user` AS u
LEFT JOIN `location` AS l
ON u.`location_id` = l.`location_id`
WHERE l.`location_id` IS NULL


#================ 外连接之右外连接 ================#
SELECT u.`user_id`, u.`user_name`, l.`location_name`
FROM `user` AS u
RIGHT JOIN `location` AS l
ON u.`location_id` = l.`location_id`


#================ 交叉连接 ================#
#笛卡尔乘积现象的99语法
SELECT u.`user_id`, u.`user_name`, l.`location_name`
FROM `user` AS u
CROSS JOIN `location` AS l




