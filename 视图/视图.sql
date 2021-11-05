USE `test_db`;

#============================================= 创建视图 =============================================#

CREATE VIEW `view1`
AS
SELECT u.*, l.`location_name`
FROM `user` u
JOIN `location` l
ON u.`location_id` = l.`location_id`;

SELECT * FROM `view1`;


#============================================= 更新视图 =============================================#
#================ 方式一 ================#
CREATE OR REPLACE VIEW `view1`
AS
SELECT u.*, l.`location_name`
FROM `user` u
LEFT JOIN `location` l
ON u.`location_id` = l.`location_id`;

#================ 方式二 ================#
ALTER VIEW `view1`
AS
SELECT *
FROM `location`;

SELECT * FROM `view1`;

#============================================= 修改视图 =============================================#
CREATE VIEW `view2`
AS
SELECT *
FROM `user`;

SELECT * FROM `user`;

INSERT INTO `view2` VALUES
(13, '赵乌', 33, 1005);

DELETE FROM `view2` 
WHERE `user_name` LIKE '赵乌';

ALTER TABLE `view2` RENAME `view2_`;

#============================================= 删除视图 =============================================#

DROP VIEW IF EXISTS `view1`, `view2`;

#============================================= 其他 =============================================#
DESC `view1`;

SHOW CREATE VIEW `view1`;














