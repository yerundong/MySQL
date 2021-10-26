USE test;

#*************** WHERE后面的子查询
#案例：查询年龄比张三大的用户
SELECT * 
FROM `user`
WHERE `age` > (
	SELECT `age`
	FROM `user`
	WHERE `user_name` = '张三'
) 

# 再加一个条件：查询年龄比张三大的用户，且比阿喵年龄小的的用户
SELECT * 
FROM `user`
WHERE `age` > (
	SELECT `age`
	FROM `user`
	WHERE `user_name` = '张三'
) 
AND `age` < (
	SELECT `age`
	FROM `user`
	WHERE `user_name` = '阿喵'
);

#案例：查出年龄最大的所有用户（可能有多个）
SELECT * 
FROM `user`
WHERE `age` = (
	SELECT MAX(`age`)
	FROM `user`
);

#********** HAVING后面的子查询以及FROM后面的子查询
#案例：查询员工数大于平均员工数的地区
SELECT `location_id`, COUNT(*) '员工数'  
FROM `user`
GROUP BY `location_id`
HAVING COUNT(*) > (
	SELECT AVG(ct) FROM (
		SELECT COUNT(*) AS ct
		FROM `user`
		GROUP BY `location_id`
	) AS ctable
);

#*********** LEFT JOIN后面的子查询
#案例：查询每个区域的人数，以及查询出区域的所有字段
SELECT l.*, c.`人数`
FROM `location` AS l
LEFT JOIN (
	SELECT COUNT(*) AS '人数', `location_id`
	FROM `user`
	GROUP BY `location_id`
) 
AS c
ON l.`location_id` = c.`location_id`

#********** select后面的子查询
#案例：查询每个区域的人数，以及查询出区域的所有字段（即以上的例子也可以这样实现）
# 关联子查询：先查询父查询，再查询子查询，父查询出n条数据，则会再查询n次子查询
SELECT *, (
	SELECT COUNT(*)
	FROM `user` AS u
	WHERE u.`location_id` = l.`location_id`
) AS '人数'
FROM `location` AS l

#案例：查询id=5的用户的区域名称(不使用连接查询)
SELECT `location_name`
FROM (
	SELECT l.`location_name`, (
		SELECT u.`user_id` 
		FROM `user` AS u
		WHERE u.`user_id` = 5
		AND u.`location_id` = l.`location_id`
	) AS 'user_id'
	FROM `location` AS l
) AS t

WHERE `user_id` IS NOT NULL;

# 使用内连接查询实现，更简单易懂
SELECT `location_name`
FROM `location` AS l
INNER JOIN `user` AS u
ON u.`user_id` = 5
AND u.`location_id` = l.`location_id`


#*************** exists后的子查询
# 检查是否子查询的结果集有值，有值返回1, 没值返回0
SELECT EXISTS(
	SELECT *
	FROM `user`
);

SELECT EXISTS(
	SELECT *
	FROM `user`
	WHERE `user_id` = 9999999
) AS '是否有值';

#案例：查询所有有用户的区域
SELECT * 
FROM `location` AS l
WHERE EXISTS(
	SELECT *
	FROM `user` AS u
	WHERE l.`location_id` = u.`location_id`
)

# 使用内连接也可以实现
SELECT DISTINCT l.*
FROM `location` AS l 
JOIN `USER` AS u
ON l.`location_id` = u.`location_id`
	

#********* 标量子查询（结果集为单行单列）
SELECT * 
FROM `user`
WHERE `age` > (
	SELECT `age`
	FROM `user`
	WHERE `user_name` = '张三'
) 

#********** 列子查询（结果集为一列多行）
# 搭配 in 操作符
SELECT * 
FROM `user`
WHERE `age` IN (
	SELECT `age`
	FROM `user`
	WHERE `age` BETWEEN 15 AND 30
) 

# 搭配 not in 操作符
SELECT * 
FROM `user`
WHERE `age` NOT IN (
	SELECT `age`
	FROM `user`
	WHERE `age` BETWEEN 15 AND 30
) 

# 搭配 any 操作符
# 大于任意一个即真
SELECT * 
FROM `user`
WHERE `age` > ANY(
	SELECT `age`
	FROM `user`
	WHERE `user_id` = 9
	OR `user_id` = 2
	OR `user_id` = 3
)

# 可用min代替
SELECT * 
FROM `user`
WHERE `age` > (
	SELECT MIN(`age`)
	FROM `user`
	WHERE `user_id` = 9
	OR `user_id` = 2
	OR `user_id` = 3
)

# 搭配 all 操作符
# 大于所有值即真
SELECT * 
FROM `user`
WHERE `age` > ALL(
	SELECT `age`
	FROM `user`
	WHERE `user_id` = 9
	OR `user_id` = 2
	OR `user_id` = 3
)

# 可用max代替
SELECT * 
FROM `user`
WHERE `age` > (
	SELECT MAX(`age`)
	FROM `user`
	WHERE `user_id` = 9
	OR `user_id` = 2
	OR `user_id` = 3
)

#********* 行子查询(结果集为一行多列或多行多列)
# 这种写法很少用，限制条件苛刻
SELECT *
FROM `user`
WHERE (`user_id`, `location_id`) =
(
	SELECT MIN(`user_id`), MIN(`location_id`)
	FROM `user`
);

# 可用列子查询实现同等效果
SELECT *
FROM `user`
WHERE `user_id` = (
	SELECT MIN(`user_id`)
	FROM `user`
)
AND `location_id` = (
	SELECT MIN(`location_id`)
	FROM `user`
);

#********** 练习：查询没有区域的用户信息
# 使用外连接实现
SELECT u.*
FROM `user` AS u
LEFT JOIN `location` AS l
ON u.`location_id` = l.`location_id`
WHERE l.`location_id` IS NULL;

# 使用WHERE子查询实现
SELECT *
FROM `user` AS u
WHERE u.`location_id` NOT IN(
	SELECT location_id
	FROM `location`
)

# 或
SELECT *
FROM `user` AS u
WHERE NOT EXISTS(
	SELECT *
	FROM `location` AS l
	WHERE u.`location_id` = l.`location_id`
);


# 使用SELECT子查询实现
SELECT * 
FROM (
	SELECT *, EXISTS(
		SELECT *
		FROM `location` AS l
		WHERE u.`location_id` = l.`location_id`
	) AS e
	FROM `user` AS u
) AS a
WHERE a.`e` = 0;

#********** 练习：查询各部门中比本部门工资高的员工信息
USE `myemployees`;
 
# 使用内连接+子查询实现
SELECT e.*
FROM `employees` AS e
INNER JOIN (
	SELECT AVG(`salary`) AS 'avg_salary', `department_id`
	FROM `employees`
	GROUP BY `department_id`
) AS n
ON e.`department_id` = n.`department_id`
AND e.`salary` > n.`avg_salary`

# 使用where后的子查询实现
SELECT *
FROM `employees` AS e
WHERE e.`salary` > (
	SELECT `avg_salary`
	FROM (
		SELECT AVG(`salary`) AS 'avg_salary', `department_id`
		FROM `employees`
		GROUP BY `department_id`
	)AS n
	WHERE e.`department_id` = n.`department_id`
)


#********** 练习：假如任意名字（first_name或last_name）含“u”员工称为“u员工”，否则称为“非u员工”，存在u员工的部门称为“u部门”，
#请查询所有u部门的非u员工信息
SELECT *
FROM `employees` AS e
WHERE e.`department_id` IN (
	SELECT `department_id` 
	FROM `employees`
	WHERE CONCAT(`first_name`, `last_name`) LIKE '%u%'
	GROUP BY `department_id`
) 
AND CONCAT(`first_name`, `last_name`) NOT LIKE '%u%'
ORDER BY `department_id`
