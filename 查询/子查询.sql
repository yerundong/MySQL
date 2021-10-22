USE test;

### WHERE后面的子查询
# 案例一：查询年龄比张三大的用户
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

# 案例二：查出年龄最大的所有用户（可能有多个）
SELECT * 
FROM `user`
WHERE `age` = (
	SELECT MAX(`age`)
	FROM `user`
);

### HAVING后面的子查询
# ???
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

INSERT INTO `test`.`user` (`user_name`, `age`, `location_id`) VALUES ('陈六', 26, 1001);
