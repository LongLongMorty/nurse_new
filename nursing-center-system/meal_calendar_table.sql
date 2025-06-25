-- 膳食日历表（周菜单）
DROP TABLE IF EXISTS `meal_calendar`;
CREATE TABLE `meal_calendar` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `week_name` varchar(100) NOT NULL COMMENT '周菜单名称，如：第1周菜单',
  `day_of_week` tinyint NOT NULL COMMENT '星期几：1-周一，2-周二...7-周日',
  `breakfast_config_id` bigint COMMENT '早餐配置ID',
  `lunch_config_id` bigint COMMENT '午餐配置ID',
  `dinner_config_id` bigint COMMENT '晚餐配置ID',
  `snack_config_id` bigint COMMENT '加餐配置ID',
  `is_active` tinyint DEFAULT '1' COMMENT '是否启用：0-禁用，1-启用',
  `special_notes` text COMMENT '特殊说明',
  `total_estimated_cost` decimal(10,2) COMMENT '当日总预估成本',
  `creator_id` bigint NOT NULL COMMENT '创建者ID',
  `creator_name` varchar(50) COMMENT '创建者姓名',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint DEFAULT '0' COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_week_day` (`week_name`, `day_of_week`),
  KEY `idx_week_name` (`week_name`),
  KEY `idx_day_of_week` (`day_of_week`),
  KEY `idx_creator_id` (`creator_id`),
  CONSTRAINT `fk_mc_breakfast_config` FOREIGN KEY (`breakfast_config_id`) REFERENCES `meal_config` (`id`),
  CONSTRAINT `fk_mc_lunch_config` FOREIGN KEY (`lunch_config_id`) REFERENCES `meal_config` (`id`),
  CONSTRAINT `fk_mc_dinner_config` FOREIGN KEY (`dinner_config_id`) REFERENCES `meal_config` (`id`),
  CONSTRAINT `fk_mc_snack_config` FOREIGN KEY (`snack_config_id`) REFERENCES `meal_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='膳食日历表（周菜单）';

-- 插入默认的第1周菜单（7天，每天4餐）
INSERT INTO `meal_calendar` (`week_name`, `day_of_week`, `creator_id`, `creator_name`) VALUES
('第1周菜单', 1, 1, '系统管理员'),
('第1周菜单', 2, 1, '系统管理员'),
('第1周菜单', 3, 1, '系统管理员'),
('第1周菜单', 4, 1, '系统管理员'),
('第1周菜单', 5, 1, '系统管理员'),
('第1周菜单', 6, 1, '系统管理员'),
('第1周菜单', 7, 1, '系统管理员');
