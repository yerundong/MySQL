SELECT * FROM `employees`;

SELECT MAX(`salary`) AS '最高工资' FROM `employees`;

SELECT MIN(`salary`) AS '最低工资' FROM `employees`;

SELECT SUM(`salary`) AS '工资总和' FROM `employees`;

SELECT AVG(`salary`) AS '平均工资' FROM `employees`;

SELECT COUNT(`employee_id`) AS '员工总个数' FROM `employees`;

SELECT COUNT(`manager_id`) AS '普通员工个数' FROM `employees`;