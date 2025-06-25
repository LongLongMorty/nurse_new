-- 健康管家端测试数据
-- 注意：这些数据应该在有基础数据（如护理级别、护理项目等）之后插入

-- 1. 先确保有护理级别数据
INSERT IGNORE INTO `care_level` (`id`, `level_name`, `level_code`, `description`, `status`, `create_time`) VALUES
(1, '一级护理', 'LEVEL_1', '完全自理，基础护理', 1, NOW()),
(2, '二级护理', 'LEVEL_2', '半自理，日常协助', 1, NOW()),
(3, '三级护理', 'LEVEL_3', '需要护理，专业照护', 1, NOW());

-- 2. 确保有护理项目数据
INSERT IGNORE INTO `care_item` (`id`, `item_name`, `item_code`, `item_type`, `unit`, `price`, `description`, `status`, `create_time`) VALUES
(1, '日常洗漱', 'DAILY_WASH', 'DAILY', '次', 10.00, '协助老人进行日常洗漱', 1, NOW()),
(2, '服药提醒', 'MEDICINE_REMIND', 'MEDICAL', '次', 5.00, '提醒和协助老人按时服药', 1, NOW()),
(3, '康复训练', 'REHAB_TRAINING', 'REHABILITATION', '小时', 50.00, '专业的康复训练指导', 1, NOW()),
(4, '心理疏导', 'PSYCHOLOGY_GUIDE', 'PSYCHOLOGICAL', '次', 80.00, '心理健康疏导和陪伴', 1, NOW()),
(5, '生活照料', 'LIFE_CARE', 'DAILY', '次', 15.00, '日常生活起居照料', 1, NOW());

-- 3. 更新健康管家信息（确保有健康管家ID=4的记录）
UPDATE `sys_user` SET 
    `real_name` = '张护士',
    `phone` = '13800001001',
    `role` = 'HEALTH_MANAGER',
    `status` = 1
WHERE `username` = 'nurse001';

-- 4. 插入客户数据（由健康管家服务）
INSERT IGNORE INTO `customer` (`id`, `customer_name`, `age`, `gender`, `id_card`, `birth_date`, `blood_type`, `guardian_name`, `guardian_phone`, `building_id`, `room_id`, `bed_id`, `check_in_date`, `contract_expire_date`, `care_level_id`, `health_manager_id`, `customer_type`, `status`, `create_time`) VALUES
(1, '王大爷', 75, 'MALE', '110101194901011111', '1949-01-01', 'A', '王小明', '13900001111', 1, 1, 1, '2025-01-01', '2025-12-31', 2, 4, 'CARE', 1, NOW()),
(2, '李奶奶', 68, 'FEMALE', '110101195603152222', '1956-03-15', 'B', '李小红', '13900002222', 1, 2, 3, '2025-02-01', '2025-12-31', 1, 4, 'SELF_CARE', 1, NOW()),
(3, '张大妈', 72, 'FEMALE', '110101195205203333', '1952-05-20', 'O', '张小华', '13900003333', 2, 3, 5, '2025-03-01', '2025-12-31', 3, 4, 'CARE', 1, NOW());

-- 5. 为客户配置护理服务项目
INSERT IGNORE INTO `customer_care` (`id`, `customer_id`, `care_item_id`, `purchase_date`, `purchase_quantity`, `used_quantity`, `remaining_quantity`, `expire_date`, `service_status`, `create_time`) VALUES
-- 王大爷的护理服务
(1, 1, 1, '2025-06-01', 30, 8, 22, '2025-07-01', 'NORMAL', NOW()),
(2, 1, 2, '2025-06-01', 60, 15, 45, '2025-07-01', 'NORMAL', NOW()),
(3, 1, 5, '2025-06-01', 30, 10, 20, '2025-07-01', 'NORMAL', NOW()),

-- 李奶奶的护理服务
(4, 2, 1, '2025-06-01', 20, 5, 15, '2025-07-01', 'NORMAL', NOW()),
(5, 2, 2, '2025-06-01', 30, 8, 22, '2025-07-01', 'NORMAL', NOW()),
(6, 2, 4, '2025-06-01', 10, 2, 8, '2025-07-01', 'NORMAL', NOW()),

-- 张大妈的护理服务
(7, 3, 1, '2025-06-01', 30, 12, 18, '2025-07-01', 'NORMAL', NOW()),
(8, 3, 2, '2025-06-01', 60, 20, 40, '2025-07-01', 'NORMAL', NOW()),
(9, 3, 3, '2025-06-01', 20, 3, 17, '2025-07-01', 'NORMAL', NOW()),
(10, 3, 5, '2025-06-01', 40, 15, 25, '2025-07-01', 'NORMAL', NOW());

-- 6. 插入一些护理记录
INSERT IGNORE INTO `care_record` (`id`, `customer_id`, `care_item_id`, `health_manager_id`, `care_time`, `care_quantity`, `care_content`, `remark`, `create_time`) VALUES
(1, 1, 1, 4, '2025-06-17 08:30:00', 1, '协助王大爷进行晨间洗漱', '老人配合度很好', NOW()),
(2, 1, 2, 4, '2025-06-17 09:00:00', 1, '提醒王大爷服用降压药', '按时服药', NOW()),
(3, 2, 1, 4, '2025-06-17 08:45:00', 1, '协助李奶奶洗漱', '身体状况良好', NOW()),
(4, 3, 5, 4, '2025-06-17 07:30:00', 1, '协助张大妈起床穿衣', '需要较多帮助', NOW()),
(5, 3, 1, 4, '2025-06-17 08:00:00', 1, '协助张大妈洗漱', '精神状态不错', NOW());

-- 7. 确保房间和床位数据存在（如果不存在的话）
INSERT IGNORE INTO `building` (`id`, `building_name`, `building_code`, `description`, `status`, `create_time`) VALUES
(1, 'A栋', 'BUILDING_A', '主楼', 1, NOW()),
(2, 'B栋', 'BUILDING_B', '副楼', 1, NOW());

INSERT IGNORE INTO `room` (`id`, `room_number`, `room_type`, `bed_count`, `building_id`, `status`, `create_time`) VALUES
(1, '101', 'DOUBLE', 2, 1, 1, NOW()),
(2, '102', 'DOUBLE', 2, 1, 1, NOW()),
(3, '201', 'SINGLE', 1, 2, 1, NOW());

INSERT IGNORE INTO `bed` (`id`, `bed_number`, `room_id`, `bed_type`, `bed_status`, `create_time`) VALUES
(1, 'A101-1', 1, 'STANDARD', 'OCCUPIED', NOW()),
(2, 'A101-2', 1, 'STANDARD', 'AVAILABLE', NOW()),
(3, 'A102-1', 2, 'STANDARD', 'OCCUPIED', NOW()),
(4, 'A102-2', 2, 'STANDARD', 'AVAILABLE', NOW()),
(5, 'B201-1', 3, 'STANDARD', 'OCCUPIED', NOW());
