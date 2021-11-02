USE test_db;

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`(
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `age` INT,
    `location_id` INT DEFAULT(1001)
);

SELECT * FROM `student`;

#=============================== 方式一 ===============================#

#============== 插入全部列 =============#

INSERT INTO `student` VALUES(1, '王八', 33, 1003);

INSERT INTO `student` VALUES(2, '刘九', 33, DEFAULT); -- 即使有默认值也需要填DEFAULT

INSERT INTO `student` VALUES(3, '刘九', 33, DEFAULT), (14, '黄仲铭', 133, 1004);-- 多行插入


#============== 插入特定列 =============#
INSERT INTO `student` (`name`, `location_id`, `age`) VALUES('刘一勾', DEFAULT, NULL);

INSERT INTO `student` (`name`, `location_id`, `age`) VALUES('莫里铿', DEFAULT, NULL), ('莫里锵', 2007, NULL);-- 多行插入


#============== 子查询插入 =============#
INSERT INTO `student` (`name`, `location_id`, `age`) SELECT '张俑', 1002, 66;

# 子查询插入多行
INSERT INTO `student` (`name`, `location_id`, `age`) 
SELECT '张俑', 1003, 66 
UNION
SELECT '张缚', 1004, 68;

INSERT INTO `student` (`name`, `location_id`, `age`)
SELECT `user_name`, NULL, NULL 
FROM `user` 
WHERE `user_id` = 10 OR `user_id` = 11;


#=============================== 方式二 ===============================#

INSERT INTO `student` SET `name` = '黄狗', `location_id` = DEFAULT, `age` = NULL;
