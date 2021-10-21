
#分组查询（多个统计成一个值）
SELECT ROUND(AVG(`salary`), 2) AS 平均薪水, `department_id` AS 部门 FROM `employees` GROUP BY `department_id`;

SELECT ROUND(AVG(`salary`), 2) AS 平均薪水, `department_id` AS 部门 FROM `employees` GROUP BY `department_id` 
ORDER BY `department_id` DESC;

SELECT ROUND(AVG(`salary`), 2) AS 平均薪水, `department_id` AS 部门 FROM `employees` WHERE `department_id` IS NOT NULL
GROUP BY `department_id` ORDER BY `department_id` DESC;


#查出部门员工大于2的部门，注意where执行顺序先于GROUP BY
#HAVING用法  
SELECT COUNT(*), `department_id` AS 部门 FROM `employees`
GROUP BY `department_id` HAVING COUNT(*) > 2 ORDER BY `department_id` DESC;

#查出每个工种中有奖金的员工的工资>12000的工种和最高薪资
SELECT MAX(`salary`),`job_id` FROM `employees` WHERE `commission_pct` IS NOT NULL GROUP BY `job_id` 
HAVING MAX(`salary`) > 12000

#GROUP BY和HAVING支持别名
SELECT COUNT(*),LENGTH(`first_name`) AS 'len' FROM `employees` GROUP BY `len` HAVING `len` > 4;

#支持多个字段分组
SELECT AVG(`salary`), `department_id`, `job_id` FROM `employees` GROUP BY `department_id`,`job_id`

