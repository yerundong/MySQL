USE test;

SELECT * FROM `user`;

#****** 方式一：插入全部列

INSERT INTO `user` VALUES(12, '王八', 33, 1003);

INSERT INTO `user` VALUES(13, '刘九', 33, DEFAULT); -- 即使有默认值也需要填DEFAULT

INSERT INTO `user` VALUES(13, '刘九', 33, DEFAULT), (14, '黄仲铭', 133, 1004);-- 多行插入



#****** 方式一：插入特定列

INSERT INTO `user` (`user_name`, `location_id`, `age`) VALUES('刘一勾', DEFAULT, NULL);

INSERT INTO `user` (`user_name`, `location_id`, `age`) VALUES('莫里铿', DEFAULT, NULL), ('莫里锵', 2007, NULL);-- 多行插入

# 子查询插入
INSERT INTO `user` (`user_name`, `location_id`, `age`) SELECT '张俑', 1002, 66;

# 子查询插入多行
INSERT INTO `user` (`user_name`, `location_id`, `age`) 
SELECT '张俑', 1002, 66 
UNION
SELECT '张缚', 1003, 68;

INSERT INTO `user` (`user_name`, `location_id`, `age`)
SELECT `user_name`, NULL, NULL FROM `user` WHERE `user_id` = 10 OR `user_id` = 11;


#****** 方式二：

INSERT INTO `user` SET `user_name` = '黄狗', `location_id` = DEFAULT, `age` = NULL;
