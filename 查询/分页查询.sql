SELECT *
FROM `employees` 
LIMIT 0, 10;

SELECT *
FROM `employees` 
LIMIT 10;

# 查询奖金最高的人的前10名
SELECT *
FROM `employees` 
ORDER BY `commission_pct` DESC
LIMIT 10;

# 根据页码（pageNumber）和页量（pageSize）来查询数据
# LIMIT (pageNumber - 1), pageSize;
