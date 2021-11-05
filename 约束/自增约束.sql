USE `test_db` ;

#============================================= 建表时设置 =============================================#

DROP TABLE IF EXISTS `loser`;
CREATE TABLE `loser` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50)
);

INSERT INTO `loser` VALUES
(DEFAULT, 'lucy'),
(DEFAULT, 'amy'),
(NULL, 'penny'),
(NULL, 'penny');

SELECT * FROM `loser`;


#============================================= 修改表时设置 =============================================#

DROP TABLE IF EXISTS `loser`;
CREATE TABLE `loser` (
  `id` INT PRIMARY KEY,
  `name` VARCHAR(50)
);

ALTER TABLE `loser` MODIFY `id` INT AUTO_INCREMENT;

ALTER TABLE `loser` AUTO_INCREMENT = 100;-- 更改初始值

INSERT INTO `loser` VALUES
(DEFAULT, 'lucy'),
(DEFAULT, 'amy'),
(NULL, 'penny'),
(NULL, 'penny');

SELECT * FROM `loser`;


#============================================= 删除约束 =============================================#

DROP TABLE IF EXISTS `loser`;
CREATE TABLE `loser` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50)
);

ALTER TABLE `loser` MODIFY `id` INT;

INSERT INTO `loser` VALUES
(1, 'lucy'),
(2, 'amy'),
(3, 'penny'),
(4, 'penny');

SELECT * FROM `loser`;















