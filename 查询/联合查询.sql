USE `test`;

# 普通条件查询
SELECT *
FROM `user`
WHERE age = 12
OR age = 36

# 联合查询
SELECT *
FROM `user`
WHERE age = 12
UNION 
SELECT *
FROM `user`
WHERE age = 36

# UNION 将查询结果合并，并消去任何重复行
SELECT *
FROM `user`
WHERE age = 45
UNION 
SELECT *
FROM `user`
WHERE age >= 36

# UNION ALL将查询结果合并，不会消去重复行
SELECT *
FROM `user`
WHERE age = 45
UNION ALL
SELECT *
FROM `user`
WHERE age >= 36




