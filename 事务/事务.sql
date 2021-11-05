USE `test_db`;

SET autocommit = 0;

CREATE TABLE `affair`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(50)
);

#============================================= 提交 =============================================#
TRUNCATE TABLE `affair`;

START TRANSACTION;-- 开启事务

INSERT INTO `affair` VALUES
(NULL, '张三');

INSERT INTO `affair` VALUES
(NULL, '李四');

COMMIT;-- 提交事务

SELECT * FROM `affair`;

#============================================= 回滚 =============================================#

TRUNCATE TABLE `affair`;

INSERT INTO `affair` VALUES
(NULL, '张三');

START TRANSACTION;-- 开启事务

INSERT INTO `affair` VALUES
(NULL, '李四');

ROLLBACK;-- 回滚事务

SELECT * FROM `affair`;

#============================================= 回滚标记点 =============================================#
TRUNCATE TABLE `affair`;

START TRANSACTION;-- 开启事务

INSERT INTO `affair` VALUES
(NULL, '张三');

SAVEPOINT `p_1`;

INSERT INTO `affair` VALUES
(NULL, '李四');

ROLLBACK TO `p_1`;-- 回滚事务

SELECT * FROM `affair`;












