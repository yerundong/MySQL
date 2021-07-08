SELECT * FROM `employees` ORDER BY `first_name`;

SELECT MAX(`salary`) AS '最高工资' FROM `employees`;

SELECT MAX(`hiredate`) AS '最大日期' FROM `employees`;

SELECT MAX(`first_name`) AS '最后名字' FROM `employees`;

SELECT MIN(`first_name`) AS '最前名字' FROM `employees`;

SELECT MIN(`salary`) AS '最低工资' FROM `employees`;

SELECT SUM(`salary`) AS '工资总和' FROM `employees`;

SELECT AVG(`salary`) AS '平均工资' FROM `employees`;

SELECT COUNT(`employee_id`) AS '员工总个数' FROM `employees`;

SELECT COUNT(`manager_id`) AS '普通员工个数' FROM `employees`;

SELECT COUNT(*) AS '员工总个数', COUNT(`commission_pct`) AS '有奖金的员工总个数' FROM `employees`;

SELECT COUNT(1) AS '员工总个数', COUNT(`commission_pct`) AS '有奖金的员工总个数' FROM `employees`;


# 配合DISTINCT
SELECT SUM(`salary`) AS '工资总和', SUM(DISTINCT `salary`) AS '去重后的工资总和' FROM `employees`;

SELECT COUNT(`salary`) AS '工资类型个数', COUNT(DISTINCT `salary`) AS '去重后的工资类型个数' FROM `employees`;

