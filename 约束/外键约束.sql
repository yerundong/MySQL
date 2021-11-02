USE `test_db` ;

#============================================= 建表时设置 =============================================#

#================= 方式一 =================#
# MySQL不支持此写法    
DROP TABLE IF EXISTS `worker`;
DROP TABLE IF EXISTS `like`;

CREATE TABLE `like` (
  `like_id` INT,
  `like_name` VARCHAR(50),
  CONSTRAINT `pk_` PRIMARY KEY (`like_id`)
);

CREATE TABLE `worker` (
  `worker_id` BIGINT PRIMARY KEY,
  `worker_name` VARCHAR(50),
  `like_id` INT FOREIGN KEY REFERENCES `like`(`like_id`)
);

INSERT INTO `like` 
VALUES
  (1001, '篮球'),
  (1002, '足球') ;
  
INSERT INTO `worker` 
VALUES
  (100001, '张三', 1002);
  
SELECT * FROM `worker`;
  
SHOW INDEX FROM `worker`;

#================= 方式二 =================#
DROP TABLE IF EXISTS `worker`;
DROP TABLE IF EXISTS `like`;

CREATE TABLE `like` (
  `like_id` INT UNIQUE,
  `like_name` VARCHAR(50),
  CONSTRAINT `pk_` PRIMARY KEY (`like_id`, `like_name`)
);

CREATE TABLE `worker` (
  `worker_id` BIGINT PRIMARY KEY,
  `worker_name` VARCHAR(50),
  `like_name` VARCHAR(50),
  `like_id` INT,
  CONSTRAINT `fk_` FOREIGN KEY(`like_id`, `like_name`) REFERENCES `like`(`like_id`, `like_name`)
);

INSERT INTO `like` 
VALUES
  (1001, '篮球'),
  (1002, '足球') ;
  
INSERT INTO `worker` 
VALUES
  (100001, '张三', '足球', 1002);
  
SELECT * FROM `worker`;
  
SHOW INDEX FROM `worker`;


#============================================= 修改表时设置 =============================================#
DROP TABLE IF EXISTS `worker`;
DROP TABLE IF EXISTS `like`;

CREATE TABLE `like` (
  `like_id` INT UNIQUE,
  `like_name` VARCHAR(50),
  CONSTRAINT `pk_` PRIMARY KEY (`like_id`, `like_name`)
);

CREATE TABLE `worker` (
  `worker_id` BIGINT PRIMARY KEY,
  `worker_name` VARCHAR(50),
  `like_name` VARCHAR(50),
  `like_id` INT
);


ALTER TABLE `worker` ADD CONSTRAINT `fk_` FOREIGN KEY (`like_id`, `like_name`) REFERENCES `like`(`like_id`, `like_name`);

INSERT INTO `like` 
VALUES
  (1001, '篮球'),
  (1002, '足球') ;
  
INSERT INTO `worker` 
VALUES
  (100001, '张三', '足球', 1002);

SELECT * FROM `worker`;
  
SHOW INDEX FROM `worker`;


#============================================= 删除约束 =============================================#

#================= MySQL =================#

ALTER TABLE `worker` DROP FOREIGN KEY `fk_`;

SHOW INDEX FROM `worker`;

INSERT INTO `worker` 
VALUES
  (100002, '张三2', '足球2', 1003);

#================= 通用语法 =================#
ALTER TABLE `worker` DROP CONSTRAINT `fk_`;

SHOW INDEX FROM `worker`;

INSERT INTO `worker` 
VALUES
  (100002, '张三2', '足球2', 1003);

















