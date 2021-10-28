#======================== 创建库 ========================#
CREATE DATABASE `mydb`;

CREATE DATABASE IF NOT EXISTS `mydb`;

#======================== 删除库 ========================#
DROP DATABASE `mydb`;

DROP DATABASE IF EXISTS `mydb`;

#======================== 修改库 ========================#
# 更改数据库字符集
ALTER DATABASE `mydb` CHARACTER SET utf8


#======================== 选中库 ========================#
USE `mydb`;


#======================== 其他 ========================#
SHOW DATABASES;

SELECT DATABASE();