-- 膳食日历测试数据
-- 插入测试的第1周菜单数据（假设 meal_config 表中已有数据）

-- 清空现有数据
DELETE FROM meal_calendar WHERE week_name = '第1周菜单';

-- 插入第1周菜单的7天数据
INSERT INTO meal_calendar (week_name, day_of_week, breakfast_config_id, lunch_config_id, dinner_config_id, snack_config_id, is_active, special_notes, total_estimated_cost, creator_id, creator_name) VALUES
('第1周菜单', 1, 1, 2, 3, 4, 1, '周一菜单', 50.00, 1, '管理员'),
('第1周菜单', 2, 2, 3, 4, 5, 1, '周二菜单', 52.00, 1, '管理员'),
('第1周菜单', 3, 3, 4, 5, 6, 1, '周三菜单', 48.00, 1, '管理员'),
('第1周菜单', 4, 4, 5, 6, 7, 1, '周四菜单', 51.00, 1, '管理员'),
('第1周菜单', 5, 5, 6, 7, 8, 1, '周五菜单', 53.00, 1, '管理员'),
('第1周菜单', 6, 6, 7, 8, 9, 1, '周六菜单', 55.00, 1, '管理员'),
('第1周菜单', 7, 7, 8, 9, 10, 1, '周日菜单', 49.00, 1, '管理员');

-- 如果 meal_config 表为空，先插入一些测试菜品配置
INSERT IGNORE INTO meal_config (id, meal_name, meal_type, description, estimated_cost, creator_id, creator_name) VALUES
(1, '小米粥+咸菜', 'BREAKFAST', '营养早餐', 8.00, 1, '管理员'),
(2, '豆浆+包子', 'BREAKFAST', '经典早餐', 10.00, 1, '管理员'),
(3, '牛奶+面包', 'BREAKFAST', '西式早餐', 12.00, 1, '管理员'),
(4, '蛋花汤+花卷', 'BREAKFAST', '清淡早餐', 9.00, 1, '管理员'),
(5, '燕麦粥+水果', 'BREAKFAST', '健康早餐', 11.00, 1, '管理员'),
(6, '稀饭+咸菜', 'BREAKFAST', '简单早餐', 7.00, 1, '管理员'),
(7, '八宝粥+馒头', 'BREAKFAST', '营养早餐', 10.00, 1, '管理员'),
(8, '红烧肉+米饭', 'LUNCH', '经典午餐', 18.00, 1, '管理员'),
(9, '清蒸鱼+蔬菜', 'LUNCH', '清淡午餐', 16.00, 1, '管理员'),
(10, '宫保鸡丁+米饭', 'LUNCH', '川菜午餐', 15.00, 1, '管理员');
