-- 健康管家测试数据
-- 插入健康管家账号
INSERT INTO sys_user (username, password, real_name, phone, role, status, create_time, update_time, deleted) VALUES
('nurse001', '$2a$10$Uld9dKlmTCt8YRBRzpoivuLiX7s.CEYVo.LNew8p.7pIe1R7thSqu', '张护士', '13800001001', 'HEALTH_MANAGER', 1, NOW(), NOW(), 0),
('nurse002', '$2a$10$Uld9dKlmTCt8YRBRzpoivuLiX7s.CEYVo.LNew8p.7pIe1R7thSqu', '李护士', '13800001002', 'HEALTH_MANAGER', 1, NOW(), NOW(), 0);

-- 插入护理等级
INSERT INTO care_level (level_name, level_description, price, create_time, update_time, deleted) VALUES
('一级护理', '日常生活自理能力基本完好的老人', 500.00, NOW(), NOW(), 0),
('二级护理', '日常生活自理能力部分丧失的老人', 800.00, NOW(), NOW(), 0),
('三级护理', '日常生活自理能力严重缺失的老人', 1200.00, NOW(), NOW(), 0);

-- 插入护理项目
INSERT INTO care_item (item_name, item_code, item_type, unit, price, service_duration, create_time, update_time, deleted) VALUES
('日常洗漱', 'DAILY_WASH', 'DAILY', '次', 20.00, 30, NOW(), NOW(), 0),
('服药护理', 'MEDICINE_CARE', 'MEDICAL', '次', 30.00, 15, NOW(), NOW(), 0),
('康复训练', 'REHABILITATION', 'REHABILITATION', '小时', 100.00, 60, NOW(), NOW(), 0),
('血压监测', 'BLOOD_PRESSURE', 'MEDICAL', '次', 25.00, 10, NOW(), NOW(), 0),
('心理疏导', 'PSYCHOLOGICAL', 'PSYCHOLOGICAL', '次', 80.00, 45, NOW(), NOW(), 0);

-- 插入客户数据（由张护士服务）
INSERT INTO customer (customer_name, age, gender, id_card, birth_date, blood_type, guardian_name, guardian_phone, building_id, room_id, bed_id, check_in_date, contract_expire_date, care_level_id, health_manager_id, customer_type, status, create_time, update_time, deleted) VALUES
('王大爷', 75, 'MALE', '110101194812010001', '1948-12-01', 'A', '王小明', '13900001001', 1, 1, 1, '2025-01-15', '2025-12-31', 1, 4, 'SELF_CARE', 1, NOW(), NOW(), 0),
('李奶奶', 82, 'FEMALE', '110101194202150002', '1942-02-15', 'B', '李华', '13900001002', 1, 1, 2, '2025-02-01', '2025-12-31', 2, 4, 'CARE', 1, NOW(), NOW(), 0),
('赵爷爷', 78, 'MALE', '110101194603100003', '1946-03-10', 'O', '赵明', '13900001003', 1, 2, 3, '2025-03-01', '2025-12-31', 2, 4, 'CARE', 1, NOW(), NOW(), 0);

-- 插入客户护理服务配置
INSERT INTO customer_care (customer_id, care_item_id, purchase_date, purchase_quantity, used_quantity, remaining_quantity, expire_date, service_status, create_time, update_time, deleted) VALUES
-- 王大爷的护理项目
(1, 1, '2025-01-15', 30, 8, 22, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),
(1, 2, '2025-01-15', 60, 15, 45, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),
(1, 4, '2025-01-15', 30, 12, 18, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),

-- 李奶奶的护理项目
(2, 1, '2025-02-01', 30, 18, 12, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),
(2, 2, '2025-02-01', 60, 25, 35, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),
(2, 3, '2025-02-01', 20, 5, 15, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),
(2, 5, '2025-02-01', 10, 2, 8, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),

-- 赵爷爷的护理项目
(3, 1, '2025-03-01', 30, 10, 20, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),
(3, 2, '2025-03-01', 60, 20, 40, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),
(3, 3, '2025-03-01', 15, 3, 12, '2025-12-31', 'NORMAL', NOW(), NOW(), 0),
(3, 4, '2025-03-01', 30, 8, 22, '2025-12-31', 'NORMAL', NOW(), NOW(), 0);

-- 插入一些护理记录示例
INSERT INTO care_record (customer_id, care_item_id, health_manager_id, care_time, care_quantity, care_content, remark, create_time, update_time, deleted) VALUES
-- 王大爷的护理记录
(1, 1, 4, '2025-06-17 08:30:00', 1, '协助老人洗脸刷牙', '老人配合度良好', NOW(), NOW(), 0),
(1, 2, 4, '2025-06-17 09:00:00', 1, '按时服用降压药', '血压正常', NOW(), NOW(), 0),
(1, 4, 4, '2025-06-17 10:00:00', 1, '测量血压', '收缩压135，舒张压85', NOW(), NOW(), 0),

-- 李奶奶的护理记录
(2, 1, 4, '2025-06-17 08:00:00', 1, '协助老人洗漱', '需要全程协助', NOW(), NOW(), 0),
(2, 2, 4, '2025-06-17 14:00:00', 1, '服用糖尿病药物', '血糖监测正常', NOW(), NOW(), 0),
(2, 3, 4, '2025-06-16 10:00:00', 1, '下肢康复训练', '训练强度适中', NOW(), NOW(), 0),

-- 赵爷爷的护理记录
(3, 1, 4, '2025-06-17 07:30:00', 1, '协助洗漱', '老人精神状态良好', NOW(), NOW(), 0),
(3, 2, 4, '2025-06-17 08:00:00', 1, '服用心脏病药物', '心率正常', NOW(), NOW(), 0);
