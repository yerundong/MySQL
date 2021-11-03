USE test_db;

SELECT * FROM `user`;

SELECT * FROM `location`;


#=============================== 方式一：删除单表记录 ===============================#

DELETE FROM `user` WHERE `user_id` = 24;

DELETE FROM `user` WHERE `user_id` >= 29;

# 或这样写
DELETE `user` FROM `user` WHERE `user_id` >= 29;
DELETE u FROM `user` AS u WHERE `user_id` >= 29;


#=============================== 方式一：删除多表关联记录 ===============================#

# 案例：将所在城市的城市名含“北”，且姓“莫”的所有用户记录删除
DELETE u
FROM `user` AS u
JOIN `location` AS l
ON l.`location_id` = u.`location_id` 
AND l.`location_name` LIKE '%北%'
AND u.`user_name` LIKE '莫%'

# 案例：将没有任何用户所在的城市，且名字含“庆”的城市记录删除
INSERT INTO `location`
VALUES(DEFAULT, '重庆', 643725);-- 先插入一条测试数据

DELETE l
FROM `location` AS l
LEFT JOIN `user` AS u
ON l.`location_id` = u.`location_id` 
WHERE u.`user_id` IS NULL
AND l.`location_name` LIKE '%庆%';

#=============================== 方式二：清空表 ===============================#

TRUNCATE TABLE `pets_copy`;

SELECT * FROM `pets_copy`;
