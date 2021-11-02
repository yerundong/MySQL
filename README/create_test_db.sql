DROP DATABASE IF EXISTS `test_db`;

CREATE DATABASE `test_db`;

USE `test_db`;
 
# 创建 location 表
CREATE TABLE `location`(
    `location_id` INT PRIMARY KEY,
    `location_name` VARCHAR(50),
    `postal_code` INT
);

INSERT INTO `location` 
VALUES
(1001, '北京', 355201),
(1002, '上海', 365441),
(1003, '天津', 452210),
(1004, '深圳', 745123),
(1005, '杭州', 999999),
(1006, '台北', 478752);


# 创建 user 表
CREATE TABLE `user`(
    `user_id` INT PRIMARY KEY,
    `user_name` VARCHAR(50),
    `age` INT,
    `location_id` INT
);

INSERT INTO `user` 
VALUES
(1, '张三', 12, 1001),
(2, '李四', 23, 1005),
(3, '王五', 19, 1002),
(4, '阿喵', 26, 1004),
(5, '阿汪', 36, 1003),
(6, '钱二', 18, 1001),
(7, '陈六', 26, 1005),
(8, '张三', 45, 1001),
(9, '刘七', 33, 2002),
(10, '王八', 33, 1003),
(11, '刘九', 133, 1004),
(12, '黄仲铭', 17, 1002);



DESC `user`;

SHOW INDEX FROM `user`;

SELECT * FROM `user`;
