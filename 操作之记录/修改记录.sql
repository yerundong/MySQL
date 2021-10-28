USE test;

SELECT * FROM `user`;

SELECT * FROM `location`;

#=============================== 修改单表记录 ===============================#

UPDATE `user` SET `age` = 25 WHERE `user_id` = 22;

UPDATE `user` SET `age` = 24, `location_id` = 1002 WHERE `user_id` = 23;

UPDATE `user` SET `location_id` = 1003 WHERE `user_name` LIKE '莫%';



#=============================== 修改多表关联记录 ===============================#
# 案例：将所在城市的城市名含“北”，且姓“莫”的所有用户的年龄修改为1
UPDATE `location` AS l
JOIN `user` AS u
ON l.`location_id` = u.`location_id` 
AND l.`location_name` LIKE '%北%'
AND u.`user_name` LIKE '莫%'
SET age = 1


# mySql 的 UPDATE 不支持相关子查询
UPDATE `user` AS u
SET u.age = 2
WHERE u.`user_id` IN (
	SELECT u.`user_id` 
	FROM`location` AS l
	JOIN `user` AS u
	ON l.`location_id` = u.`location_id` 
	AND l.`location_name` LIKE '%北%'
	AND u.`user_name` LIKE '莫%'
);

# 案例：将没有任何用户所在的城市的邮编改为999999
UPDATE `location` AS l
LEFT JOIN `user` AS u
ON l.`location_id` = u.`location_id` 
SET l.`postal_code` = 999999
WHERE u.`user_id` IS NULL;
