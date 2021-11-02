USE `myemployees`;

#数据排序（将查询结果进行数据排序）
SELECT * FROM `employees` ORDER BY `first_name` ASC;-- 升序

SELECT * FROM `employees` ORDER BY `first_name`;-- 默认升序

SELECT * FROM `employees` ORDER BY `first_name` DESC;-- 降序

SELECT * FROM `employees` ORDER BY `salary` DESC;-- 工资降序

SELECT * FROM `employees` ORDER BY `salary` DESC, `first_name`;-- 工资降序，名字升序

SELECT * FROM `employees` ORDER BY `hiredate` DESC;-- 日期降序

SELECT `salary`*12 FROM `employees` ORDER BY `salary`*12 DESC;-- 按表达式排序

SELECT `first_name`, LENGTH(`first_name`) AS '姓名长度' FROM `employees` ORDER BY LENGTH(`first_name`) DESC;-- 按名字长度排序

SELECT `salary`*12 + IFNULL(`commission_pct`*`salary`, 0) AS '年薪' FROM `employees` ORDER BY '年薪' DESC;-- 按别名排序，年薪=月薪+奖金

SELECT * FROM `employees` ORDER BY 2;-- 按列序数排序，第二列升序

#条件查询+排序
SELECT * FROM `employees` WHERE salary BETWEEN 9600 AND 12000 ORDER BY first_name;