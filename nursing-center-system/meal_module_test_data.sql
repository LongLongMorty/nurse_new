-- 膳食模块测试数据
-- 作者: system
-- 日期: 2025-06-22

-- 清空现有数据
DELETE FROM ai_recipe_recommendation WHERE id > 0;
DELETE FROM meal_calendar WHERE id > 0;
DELETE FROM meal_config WHERE id > 0;

-- 重置自增ID
ALTER TABLE meal_config AUTO_INCREMENT = 1;
ALTER TABLE meal_calendar AUTO_INCREMENT = 1;
ALTER TABLE ai_recipe_recommendation AUTO_INCREMENT = 1;

-- 插入膳食配置测试数据
INSERT INTO meal_config (meal_name, meal_type, description, ingredients, cooking_method, nutrition_info, 
                        suitable_groups, estimated_cost, estimated_time, difficulty_level, status, 
                        creator_id, creator_name, approval_status, create_time, update_time, deleted) VALUES
-- 早餐
('营养粥套餐', 'BREAKFAST', '小米粥配咸菜和鸡蛋', '小米100g,鸡蛋1个,咸菜50g', '煮粥,水煮蛋', 
 '蛋白质:12g,碳水化合物:45g,脂肪:8g,热量:280kcal', '所有人群', 8.50, 30, 'EASY', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

('豆浆油条', 'BREAKFAST', '传统早餐搭配', '豆浆300ml,油条2根', '现磨豆浆,炸制油条', 
 '蛋白质:10g,碳水化合物:35g,脂肪:15g,热量:320kcal', '一般人群', 6.00, 15, 'EASY', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

('燕麦牛奶', 'BREAKFAST', '高纤维低糖早餐', '燕麦50g,牛奶250ml,蜂蜜10g', '燕麦煮制,加热牛奶', 
 '蛋白质:12g,碳水化合物:40g,脂肪:6g,热量:250kcal', '糖尿病,高血压人群', 12.00, 20, 'EASY', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

-- 午餐
('红烧肉套餐', 'LUNCH', '经典红烧肉配米饭和蔬菜', '五花肉200g,米饭150g,青菜100g', '红烧,蒸煮,炒制', 
 '蛋白质:25g,碳水化合物:60g,脂肪:20g,热量:520kcal', '一般人群', 18.00, 60, 'MEDIUM', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

('清蒸鱼套餐', 'LUNCH', '清淡营养的鱼类套餐', '鲈鱼300g,米饭150g,冬瓜汤200ml', '清蒸,蒸煮,煲汤', 
 '蛋白质:30g,碳水化合物:50g,脂肪:8g,热量:380kcal', '老年人,术后恢复', 22.00, 45, 'MEDIUM', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

('素食套餐', 'LUNCH', '均衡搭配的素食', '豆腐200g,青菜150g,米饭150g,紫菜汤', '炒制,蒸煮,煲汤', 
 '蛋白质:15g,碳水化合物:55g,脂肪:8g,热量:350kcal', '素食者,减肥人群', 15.00, 40, 'EASY', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

-- 晚餐
('小炒肉丝', 'DINNER', '清淡晚餐搭配', '瘦肉丝100g,豆芽菜150g,米饭100g', '炒制,蒸煮', 
 '蛋白质:20g,碳水化合物:40g,脂肪:10g,热量:320kcal', '一般人群', 16.00, 35, 'EASY', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

('蒸蛋羹', 'DINNER', '易消化的蛋羹套餐', '鸡蛋2个,虾仁50g,小馒头2个', '蒸制', 
 '蛋白质:18g,碳水化合物:30g,脂肪:8g,热量:260kcal', '老年人,消化不良', 12.00, 25, 'EASY', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

-- 加餐
('水果拼盘', 'MORNING_SNACK', '季节性水果搭配', '苹果100g,香蕉100g,橙子100g', '切块拼盘', 
 '蛋白质:2g,碳水化合物:25g,脂肪:0.5g,热量:110kcal', '所有人群', 8.00, 10, 'EASY', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0),

('酸奶坚果', 'AFTERNOON_SNACK', '高蛋白下午茶', '酸奶150g,核桃10g,葡萄干10g', '搭配', 
 '蛋白质:8g,碳水化合物:15g,脂肪:12g,热量:180kcal', '学生,上班族', 10.00, 5, 'EASY', 'ACTIVE', 
 1, '营养师李医生', 'APPROVED', NOW(), NOW(), 0);

-- 插入膳食日历测试数据（本周）
INSERT INTO meal_calendar (meal_date, day_of_week, breakfast_config_id, lunch_config_id, dinner_config_id,
                          morning_snack_config_id, afternoon_snack_config_id, special_notes, total_estimated_cost,
                          creator_id, creator_name, approval_status, create_time, update_time, deleted) VALUES
-- 周一
('2025-06-22', 1, 1, 4, 7, 9, 10, '本周开始，注重营养搭配', 62.50, 1, '膳食管理员', 'APPROVED', NOW(), NOW(), 0),

-- 周二  
('2025-06-23', 2, 2, 5, 8, 9, 10, '增加蛋白质摄入', 64.00, 1, '膳食管理员', 'APPROVED', NOW(), NOW(), 0),

-- 周三
('2025-06-24', 3, 3, 6, 7, 9, 10, '清淡饮食日', 61.00, 1, '膳食管理员', 'APPROVED', NOW(), NOW(), 0),

-- 周四
('2025-06-25', 4, 1, 4, 8, 9, 10, '经典搭配重复', 60.50, 1, '膳食管理员', 'PENDING', NOW(), NOW(), 0),

-- 周五
('2025-06-26', 5, 2, 5, 7, 9, 10, '周末前营养补充', 64.00, 1, '膳食管理员', 'DRAFT', NOW(), NOW(), 0);

-- 插入AI食谱推荐测试数据
INSERT INTO ai_recipe_recommendation (session_id, user_id, user_name, user_query, ai_response, 
                                     recommendation_content, adoption_status, feedback_rating, 
                                     feedback_comment, create_time, update_time, deleted) VALUES
-- 会话1：询问糖尿病食谱
('session_001', 1, '营养师李医生', '请推荐适合糖尿病患者的早餐', 
 '根据糖尿病患者的营养需求，我推荐以下早餐方案：\n1. 燕麦牛奶：低升糖指数，富含膳食纤维\n2. 全麦面包配鸡蛋：蛋白质丰富，碳水适量\n3. 绿叶蔬菜搭配：补充维生素和矿物质', 
 '{"meals":[{"name":"燕麦牛奶","reason":"低升糖指数，适合控糖"},{"name":"全麦鸡蛋三明治","reason":"营养均衡，血糖稳定"}]}', 
 'ADOPTED', 5, '非常实用的建议，已采纳燕麦牛奶方案', NOW(), NOW(), 0),

-- 会话2：询问老年人食谱  
('session_002', 1, '营养师李医生', '80岁老人适合什么午餐？', 
 '针对80岁老年人的生理特点，推荐以下午餐：\n1. 清蒸鱼：易消化，优质蛋白\n2. 软烂蔬菜：胡萝卜泥、菠菜泥\n3. 小米粥：养胃易消化\n注意：食物要软烂，少盐少油，营养密度高。', 
 '{"meals":[{"name":"清蒸鱼套餐","reason":"蛋白质丰富，易消化"},{"name":"蒸蛋羹","reason":"质地柔软，营养丰富"}]}', 
 'ADOPTED', 4, '很贴心的建议，老人很喜欢', NOW(), NOW(), 0),

-- 会话3：减肥食谱咨询
('session_003', 2, '健康顾问王医生', '请推荐低热量的晚餐', 
 '为了控制热量摄入，建议晚餐选择：\n1. 蒸蛋羹：低热量高蛋白\n2. 蔬菜沙拉：富含纤维，饱腹感强\n3. 清汤：补充水分，几乎无热量\n总热量控制在300kcal以内。', 
 '{"meals":[{"name":"蒸蛋羹","reason":"260kcal，营养密度高"},{"name":"素食套餐","reason":"350kcal，纤维丰富"}]}', 
 'PENDING', NULL, NULL, NOW(), NOW(), 0),

-- 会话4：营养不良恢复
('session_004', 1, '营养师李医生', '营养不良患者需要什么样的加餐？', 
 '营养不良患者需要高能量密度的食物：\n1. 酸奶坚果：富含蛋白质和健康脂肪\n2. 蛋白粉奶昔：快速补充蛋白质\n3. 能量棒：便携且营养密集\n建议每日3-4次加餐。', 
 '{"meals":[{"name":"酸奶坚果","reason":"高蛋白高热量"},{"name":"营养奶昔","reason":"易吸收，营养全面"}]}', 
 'REJECTED', 2, '成本太高，需要更经济的方案', NOW(), NOW(), 0);

-- 提交事务
COMMIT;

-- 查询验证数据
SELECT '=== 膳食配置数据 ===' as info;
SELECT id, meal_name, meal_type, status, estimated_cost FROM meal_config ORDER BY meal_type, id;

SELECT '=== 膳食日历数据 ===' as info;  
SELECT id, meal_date, day_of_week, approval_status, total_estimated_cost FROM meal_calendar ORDER BY meal_date;

SELECT '=== AI推荐数据 ===' as info;
SELECT id, session_id, user_name, adoption_status, feedback_rating FROM ai_recipe_recommendation ORDER BY id;
