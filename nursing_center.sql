/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80035
 Source Host           : localhost:3306
 Source Schema         : nursing_center

 Target Server Type    : MySQL
 Target Server Version : 80035
 File Encoding         : 65001

 Date: 25/06/2025 15:53:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ai_recipe_recommendation
-- ----------------------------
DROP TABLE IF EXISTS `ai_recipe_recommendation`;
CREATE TABLE `ai_recipe_recommendation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `session_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会话ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `user_question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户提问内容',
  `ai_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'AI回复内容',
  `question_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '问题类型：SYMPTOMS-症状咨询，NUTRITION-营养建议，RECIPE-食谱推荐，DIETARY_RESTRICTIONS-饮食禁忌等',
  `related_symptoms` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '相关症状标签',
  `recommended_foods` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '推荐食物（JSON格式）',
  `avoid_foods` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '避免食物（JSON格式）',
  `is_adopted` tinyint NULL DEFAULT 0 COMMENT '是否被采纳：0-未采纳，1-已采纳到膳食配置',
  `adopted_meal_config_id` bigint NULL DEFAULT NULL COMMENT '采纳到的膳食配置ID',
  `response_time` bigint NULL DEFAULT NULL COMMENT 'AI响应时间（毫秒）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_session_id`(`session_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_question_type`(`question_type` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'AI食谱推荐记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ai_recipe_recommendation
-- ----------------------------

-- ----------------------------
-- Table structure for bed
-- ----------------------------
DROP TABLE IF EXISTS `bed`;
CREATE TABLE `bed`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `room_id` bigint NOT NULL COMMENT '房间ID',
  `bed_no` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '床位号',
  `bed_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'STANDARD' COMMENT '床位类型：STANDARD-标准床，CARE-护理床',
  `bed_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'AVAILABLE' COMMENT '床位状态：AVAILABLE-空闲，OCCUPIED-有人，OUT-外出',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-停用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_room_bed`(`room_id` ASC, `bed_no` ASC) USING BTREE,
  INDEX `idx_room_id`(`room_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '床位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bed
-- ----------------------------
INSERT INTO `bed` VALUES (1, 1, '1号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', '2025-06-22 09:24:43', 0);
INSERT INTO `bed` VALUES (2, 1, '2号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (3, 1, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (4, 1, '4号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (5, 2, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (6, 2, '2号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (7, 2, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (8, 2, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (9, 3, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (10, 3, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (11, 3, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (12, 3, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (13, 4, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (14, 4, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (15, 4, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (16, 4, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (17, 5, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (18, 5, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (19, 5, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (20, 5, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (21, 6, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (22, 6, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (23, 6, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (24, 6, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (25, 7, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (26, 7, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (27, 7, '3号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (28, 7, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (29, 8, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (30, 8, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (31, 8, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (32, 8, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (33, 9, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (34, 9, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (35, 9, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (36, 9, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (37, 10, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (38, 10, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (39, 10, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (40, 10, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (41, 11, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (42, 11, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (43, 11, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (44, 11, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (45, 12, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (46, 12, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (47, 12, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (48, 12, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (49, 13, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (50, 13, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (51, 13, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (52, 13, '4号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (53, 14, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (54, 14, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (55, 14, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (56, 14, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (57, 15, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (58, 15, '2号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (59, 15, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (60, 15, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (61, 16, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (62, 16, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (63, 16, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (64, 16, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (65, 17, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (66, 17, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (67, 17, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (68, 17, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (69, 18, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (70, 18, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (71, 18, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (72, 18, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (73, 19, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (74, 19, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (75, 19, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (76, 19, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (77, 20, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (78, 20, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (79, 20, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (80, 20, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (81, 21, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (82, 21, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (83, 21, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (84, 21, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (85, 22, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (86, 22, '2号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (87, 22, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (88, 22, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (89, 23, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (90, 23, '2号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (91, 23, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (92, 23, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (93, 24, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (94, 24, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (95, 24, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (96, 24, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (97, 25, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (98, 25, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (99, 25, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (100, 25, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (101, 26, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (102, 26, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (103, 26, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (104, 26, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (105, 27, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (106, 27, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (107, 27, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (108, 27, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (109, 28, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (110, 28, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (111, 28, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (112, 28, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (113, 29, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (114, 29, '2号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (115, 29, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (116, 29, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (117, 30, '1号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (118, 30, '2号床', 'STANDARD', 'OCCUPIED', 1, '2025-06-07 15:57:06', NULL, 0);
INSERT INTO `bed` VALUES (119, 30, '3号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `bed` VALUES (120, 30, '4号床', 'STANDARD', 'AVAILABLE', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);

-- ----------------------------
-- Table structure for bed_usage
-- ----------------------------
DROP TABLE IF EXISTS `bed_usage`;
CREATE TABLE `bed_usage`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `bed_id` bigint NOT NULL COMMENT '床位ID',
  `room_id` bigint NOT NULL COMMENT '房间ID',
  `building_id` bigint NOT NULL COMMENT '楼栋ID',
  `start_date` date NOT NULL COMMENT '入住开始时间',
  `end_date` date NULL DEFAULT NULL COMMENT '入住结束时间',
  `usage_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'USING' COMMENT '使用状态：USING-正在使用，HISTORY-使用历史',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `idx_bed_id`(`bed_id` ASC) USING BTREE,
  INDEX `idx_bed_usage_status`(`usage_status` ASC) USING BTREE,
  INDEX `idx_bed_usage_date`(`start_date` ASC, `end_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '床位使用详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bed_usage
-- ----------------------------
INSERT INTO `bed_usage` VALUES (1, 9, 1, 1, 1, '2025-06-07', '2025-06-07', 'HISTORY', '2025-06-07 16:43:04', '2025-06-07 16:44:17', 0);
INSERT INTO `bed_usage` VALUES (2, 10, 1, 1, 1, '2025-06-07', NULL, 'USING', '2025-06-07 16:45:23', '2025-06-07 16:45:23', 0);
INSERT INTO `bed_usage` VALUES (3, 11, 6, 2, 1, '2025-06-07', NULL, 'USING', '2025-06-07 23:25:32', '2025-06-07 23:25:32', 0);
INSERT INTO `bed_usage` VALUES (4, 12, 7, 2, 1, '2025-06-07', '2025-06-11', 'HISTORY', '2025-06-07 23:25:54', '2025-06-11 19:17:46', 0);
INSERT INTO `bed_usage` VALUES (5, 13, 4, 1, 1, '2025-06-07', '2025-06-11', 'HISTORY', '2025-06-07 23:26:28', '2025-06-11 11:52:58', 0);
INSERT INTO `bed_usage` VALUES (6, 14, 27, 7, 1, '2025-06-07', NULL, 'USING', '2025-06-07 23:26:51', '2025-06-07 23:26:51', 0);
INSERT INTO `bed_usage` VALUES (7, 15, 52, 13, 1, '2025-06-07', NULL, 'USING', '2025-06-07 23:27:36', '2025-06-07 23:27:36', 0);
INSERT INTO `bed_usage` VALUES (8, 16, 118, 30, 1, '2025-06-07', NULL, 'USING', '2025-06-07 23:28:03', '2025-06-07 23:28:03', 0);
INSERT INTO `bed_usage` VALUES (9, 17, 90, 23, 1, '2025-06-07', NULL, 'USING', '2025-06-07 23:28:15', '2025-06-07 23:28:15', 0);
INSERT INTO `bed_usage` VALUES (10, 18, 86, 22, 1, '2025-06-07', NULL, 'USING', '2025-06-07 23:28:39', '2025-06-07 23:28:39', 0);
INSERT INTO `bed_usage` VALUES (11, 19, 58, 15, 1, '2025-06-07', '2025-06-11', 'HISTORY', '2025-06-07 23:29:00', '2025-06-11 16:03:59', 0);
INSERT INTO `bed_usage` VALUES (16, 12, 2, 1, 1, '2025-06-11', NULL, 'USING', '2025-06-11 19:17:46', '2025-06-11 19:17:46', 0);

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `building_no` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '楼栋编号',
  `building_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '楼栋名称',
  `floor_count` int NULL DEFAULT 0 COMMENT '楼层数',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-停用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_building_no`(`building_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '楼栋表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES (1, '606', '606号楼', 6, 1, '2025-06-05 09:52:00', '2025-06-05 09:52:00', 0);

-- ----------------------------
-- Table structure for care_item
-- ----------------------------
DROP TABLE IF EXISTS `care_item`;
CREATE TABLE `care_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `item_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目编号',
  `item_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目名称',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '价格',
  `execute_cycle` int NULL DEFAULT 1 COMMENT '执行周期（天）',
  `execute_times` int NULL DEFAULT 1 COMMENT '执行次数',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '描述',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-停用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_item_code`(`item_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '护理项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of care_item
-- ----------------------------
INSERT INTO `care_item` VALUES (1, 'DAILY_001', '日常生活护理', 50.00, 1, 1, '协助老人进行日常生活护理，包括洗漱、更衣、整理等', 1, '2025-06-11 21:56:02', NULL, 0);
INSERT INTO `care_item` VALUES (2, 'DAILY_002', '协助进餐', 30.00, 1, 3, '协助老人进餐，确保营养摄入充足', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (3, 'DAILY_003', '协助如厕', 25.00, 1, 1, '协助老人如厕，保持个人卫生', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (4, 'DAILY_004', '床铺整理', 20.00, 1, 1, '整理床铺，保持居住环境整洁', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (5, 'DAILY_005', '洗澡护理', 80.00, 2, 1, '协助老人洗澡，保持身体清洁', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (6, 'MEDICAL_001', '血压测量', 15.00, 1, 2, '定期测量血压，监测健康状况', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (7, 'MEDICAL_002', '血糖监测', 20.00, 1, 3, '监测血糖水平，预防糖尿病并发症', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (8, 'MEDICAL_003', '用药指导', 25.00, 1, 1, '指导老人正确用药，确保用药安全', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (9, 'MEDICAL_004', '伤口护理', 60.00, 1, 1, '专业伤口护理，促进愈合', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (10, 'MEDICAL_005', '输液护理', 100.00, 1, 1, '静脉输液护理，确保输液安全', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (11, 'REHAB_001', '功能训练', 80.00, 1, 1, '进行功能性康复训练，提高生活自理能力', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (12, 'REHAB_002', '物理治疗', 120.00, 1, 1, '专业物理治疗，改善身体功能', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (13, 'REHAB_003', '认知训练', 100.00, 2, 1, '认知功能训练，延缓认知衰退', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (14, 'REHAB_004', '语言训练', 90.00, 1, 1, '语言功能康复训练', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (15, 'PSYCH_001', '心理疏导', 100.00, 3, 1, '专业心理疏导，关注老人心理健康', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (16, 'PSYCH_002', '陪伴聊天', 40.00, 1, 1, '陪伴老人聊天，缓解孤独感', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (17, 'PSYCH_003', '娱乐活动', 60.00, 2, 1, '组织参与娱乐活动，丰富精神生活', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (18, 'PROF_001', '鼻饲护理', 80.00, 1, 3, '鼻饲管护理，确保营养供给', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (19, 'PROF_002', '导尿护理', 70.00, 1, 2, '导尿管护理，预防感染', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (20, 'PROF_003', '翻身护理', 40.00, 1, 6, '定期翻身，预防压疮', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_item` VALUES (22, 'test', 'test', 1.00, 1, 1, '1', 1, NULL, NULL, 0);

-- ----------------------------
-- Table structure for care_level
-- ----------------------------
DROP TABLE IF EXISTS `care_level`;
CREATE TABLE `care_level`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `level_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '护理级别名称',
  `level_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '护理级别编码',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '描述',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-停用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_level_code`(`level_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '护理级别表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of care_level
-- ----------------------------
INSERT INTO `care_level` VALUES (1, '一级护理', 'LEVEL_1', '适用于完全自理的老人，提供基础的生活护理和健康监测服务', 1, '2025-06-11 21:56:02', NULL, 0);
INSERT INTO `care_level` VALUES (2, '二级护理', 'LEVEL_2', '适用于部分自理的老人，提供日常生活协助和专业护理服务', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level` VALUES (3, '三级护理', 'LEVEL_3', '适用于不能自理的老人，提供全面的生活护理和医疗护理服务', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level` VALUES (4, '特级护理', 'LEVEL_SPECIAL', '适用于重度失能老人，提供24小时专业护理和医疗监护服务', 1, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level` VALUES (6, 'Test', 'Test', '测试', 0, '2025-06-12 11:27:34', NULL, 0);

-- ----------------------------
-- Table structure for care_level_item
-- ----------------------------
DROP TABLE IF EXISTS `care_level_item`;
CREATE TABLE `care_level_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `care_level_id` bigint NOT NULL COMMENT '护理级别ID',
  `care_item_id` bigint NOT NULL COMMENT '护理项目ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_level_item`(`care_level_id` ASC, `care_item_id` ASC) USING BTREE,
  INDEX `idx_care_level_id`(`care_level_id` ASC) USING BTREE,
  INDEX `idx_care_item_id`(`care_item_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '护理级别项目关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of care_level_item
-- ----------------------------
INSERT INTO `care_level_item` VALUES (28, 1, 1, '2025-06-11 21:56:02', '2025-06-13 20:30:48', 1);
INSERT INTO `care_level_item` VALUES (29, 1, 2, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (30, 1, 4, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (31, 1, 6, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (32, 1, 16, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (33, 2, 1, '2025-06-11 21:56:02', '2025-06-13 20:30:48', 1);
INSERT INTO `care_level_item` VALUES (34, 2, 2, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (35, 2, 3, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (36, 2, 4, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (37, 2, 5, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (38, 2, 6, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (39, 2, 7, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (40, 2, 8, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (41, 2, 11, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (42, 2, 16, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (43, 3, 1, '2025-06-11 21:56:02', '2025-06-13 20:30:48', 1);
INSERT INTO `care_level_item` VALUES (44, 3, 2, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (45, 3, 3, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (46, 3, 4, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (47, 3, 5, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (48, 3, 6, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (49, 3, 7, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (50, 3, 8, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (51, 3, 9, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (52, 3, 11, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (53, 3, 12, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (54, 3, 15, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (55, 3, 16, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (56, 3, 20, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (57, 4, 1, '2025-06-11 21:56:02', '2025-06-13 20:30:48', 1);
INSERT INTO `care_level_item` VALUES (58, 4, 2, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (59, 4, 3, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (60, 4, 4, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (61, 4, 5, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (62, 4, 6, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (63, 4, 7, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (64, 4, 8, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (65, 4, 9, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (66, 4, 10, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (67, 4, 11, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (68, 4, 12, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (69, 4, 13, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (70, 4, 15, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (71, 4, 16, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (72, 4, 18, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (73, 4, 19, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (74, 4, 20, '2025-06-11 21:56:02', '2025-06-11 21:56:02', 0);
INSERT INTO `care_level_item` VALUES (76, 1, 5, NULL, NULL, 0);

-- ----------------------------
-- Table structure for care_record
-- ----------------------------
DROP TABLE IF EXISTS `care_record`;
CREATE TABLE `care_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `care_item_id` bigint NOT NULL COMMENT '护理项目ID',
  `health_manager_id` bigint NOT NULL COMMENT '健康管家ID',
  `care_time` datetime NOT NULL COMMENT '护理时间',
  `care_quantity` int NULL DEFAULT 1 COMMENT '护理数量',
  `care_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '护理内容',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `idx_care_item_id`(`care_item_id` ASC) USING BTREE,
  INDEX `idx_health_manager_id`(`health_manager_id` ASC) USING BTREE,
  INDEX `idx_care_record_time`(`care_time` ASC) USING BTREE,
  INDEX `idx_care_record_customer_time`(`customer_id` ASC, `care_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '护理记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of care_record
-- ----------------------------
INSERT INTO `care_record` VALUES (13, 9, 1, 4, '2024-01-15 09:30:00', 1, '协助张三完成晨间护理，包括洗漱、更衣等。老人配合度较好，身体状况稳定。', '老人心情愉快，建议继续现有护理方案', '2025-06-11 21:56:03', '2025-06-14 11:02:42', 0);
INSERT INTO `care_record` VALUES (14, 9, 2, 4, '2024-01-15 12:00:00', 1, '协助张三午餐，食欲良好，进食正常。', '建议增加蔬菜摄入', '2025-06-11 21:56:03', '2025-06-14 11:02:44', 0);
INSERT INTO `care_record` VALUES (15, 9, 6, 5, '2024-01-15 14:00:00', 1, '测量血压：130/85mmHg，数值正常。', '血压稳定，继续观察', '2025-06-11 21:56:03', '2025-06-14 11:02:46', 0);
INSERT INTO `care_record` VALUES (16, 10, 1, 5, '2024-01-15 08:45:00', 1, '协助李四进行日常护理，老人行动不便，需要较多协助。', '建议增加康复训练频次', '2025-06-11 21:56:03', '2025-06-14 11:02:49', 0);
INSERT INTO `care_record` VALUES (17, 10, 7, 5, '2024-01-15 11:00:00', 1, '测量血糖：6.8mmol/L，数值正常。', '血糖控制良好', '2025-06-11 21:56:03', '2025-06-14 11:02:50', 0);
INSERT INTO `care_record` VALUES (18, 10, 11, 5, '2024-01-15 15:30:00', 1, '进行下肢功能训练30分钟，老人配合度一般。', '训练过程中老人略感疲劳，建议适当调整强度', '2025-06-11 21:56:03', '2025-06-14 11:02:51', 0);
INSERT INTO `care_record` VALUES (19, 11, 20, 5, '2024-01-15 10:00:00', 1, '为王五进行翻身护理，检查皮肤状况。', '皮肤完整性良好，无压疮征象', '2025-06-11 21:56:03', '2025-06-14 11:02:52', 0);
INSERT INTO `care_record` VALUES (20, 11, 2, 6, '2024-01-15 12:30:00', 1, '协助王五午餐，需要协助咀嚼和吞咽。', '进食缓慢，需要耐心协助', '2025-06-11 21:56:03', '2025-06-14 11:02:53', 0);
INSERT INTO `care_record` VALUES (21, 11, 9, 5, '2024-01-15 16:00:00', 1, '更换左腿伤口敷料，伤口愈合良好。', '伤口无感染征象，继续现有护理方案', '2025-06-11 21:56:03', '2025-06-14 11:02:54', 0);
INSERT INTO `care_record` VALUES (22, 9, 1, 6, '2024-01-14 09:15:00', 1, '协助张三晨间护理，老人精神状态良好。', '', '2025-06-11 21:56:03', '2025-06-14 11:02:55', 0);
INSERT INTO `care_record` VALUES (23, 9, 2, 6, '2024-01-14 18:30:00', 1, '协助张三晚餐，食欲良好。', '', '2025-06-11 21:56:03', '2025-06-14 11:02:56', 0);
INSERT INTO `care_record` VALUES (24, 10, 5, 4, '2024-01-14 10:30:00', 1, '协助李四洗澡，水温适宜，老人感觉舒适。', '洗澡后精神状态有所改善', '2025-06-11 21:56:03', '2025-06-14 11:03:03', 0);
INSERT INTO `care_record` VALUES (25, 10, 8, 5, '2024-01-14 20:00:00', 1, '指导李四晚间用药，确保按时按量服用。', '老人记忆力有所下降，需要反复提醒', '2025-06-11 21:56:03', '2025-06-14 11:03:05', 0);
INSERT INTO `care_record` VALUES (26, 11, 1, 5, '2024-01-14 08:30:00', 1, '协助王五晨间护理，需要全程协助。', '', '2025-06-11 21:56:03', '2025-06-14 11:03:06', 0);
INSERT INTO `care_record` VALUES (27, 11, 12, 5, '2024-01-14 14:30:00', 1, '进行物理治疗，主要针对上肢功能恢复。', '治疗过程配合良好，有轻微改善', '2025-06-11 21:56:03', '2025-06-14 11:03:07', 0);
INSERT INTO `care_record` VALUES (28, 9, 6, 5, '2024-01-13 09:00:00', 1, '测量血压：125/80mmHg，数值正常。', '', '2025-06-11 21:56:03', '2025-06-14 11:03:07', 0);
INSERT INTO `care_record` VALUES (29, 10, 7, 4, '2024-01-13 17:00:00', 1, '测量血糖：7.2mmol/L，略高于正常值。', '建议调整饮食结构', '2025-06-11 21:56:03', '2025-06-14 11:03:09', 0);
INSERT INTO `care_record` VALUES (30, 11, 15, 5, '2024-01-13 15:00:00', 1, '进行心理疏导，老人情绪有所低落。', '老人表达了对家人的思念，需要更多关注', '2025-06-11 21:56:03', '2025-06-14 11:03:11', 0);
INSERT INTO `care_record` VALUES (31, 10, 2, 4, '2025-06-20 15:43:33', 1, '', '', '2025-06-20 23:57:28', '2025-06-20 23:57:32', 0);
INSERT INTO `care_record` VALUES (32, 10, 2, 4, '2025-06-20 16:28:03', 1, '11111', '11111', NULL, NULL, 0);

-- ----------------------------
-- Table structure for checkout_apply
-- ----------------------------
DROP TABLE IF EXISTS `checkout_apply`;
CREATE TABLE `checkout_apply`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `applicant_id` bigint NOT NULL COMMENT '申请人ID（健康管家）',
  `checkout_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '退住类型：NORMAL-正常退住，DEATH-死亡退住，RESERVE-保留床位',
  `checkout_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '退住原因',
  `checkout_date` date NOT NULL COMMENT '退住时间',
  `apply_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'SUBMITTED' COMMENT '申请状态：SUBMITTED-已提交，APPROVED-通过，REJECTED-不通过',
  `approver_id` bigint NULL DEFAULT NULL COMMENT '审批人ID',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `approve_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '审批备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `idx_applicant_id`(`applicant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '退住申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of checkout_apply
-- ----------------------------
INSERT INTO `checkout_apply` VALUES (2, 10, 4, 'NORMAL', '老人家属要求转院至其他养老机构，希望能够就近照顾。老人身体状况良好，无重大疾病，可以正常办理退住手续。', '2025-06-15', 'REJECTED', 1, '2025-06-09 17:14:49', '不行', '2025-06-09 15:43:28', NULL, 0);
INSERT INTO `checkout_apply` VALUES (4, 11, 4, 'NORMAL', '已经恢复，正常退住，', '2025-06-22', 'REJECTED', 1, '2025-06-22 11:15:24', '不通过', '2025-06-22 11:14:58', '2025-06-22 11:15:24', 0);

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户姓名',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '性别：MALE-男，FEMALE-女',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '身份证号',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `blood_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '血型：A、B、AB、O',
  `guardian_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '家属姓名',
  `guardian_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '家属联系电话',
  `building_id` bigint NULL DEFAULT NULL COMMENT '楼栋ID',
  `room_id` bigint NULL DEFAULT NULL COMMENT '房间ID',
  `bed_id` bigint NULL DEFAULT NULL COMMENT '床位ID',
  `check_in_date` date NULL DEFAULT NULL COMMENT '入住时间',
  `contract_expire_date` date NULL DEFAULT NULL COMMENT '合同到期时间',
  `care_level_id` bigint NULL DEFAULT NULL COMMENT '护理级别ID',
  `health_manager_id` bigint NULL DEFAULT NULL COMMENT '健康管家ID',
  `customer_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'SELF_CARE' COMMENT '客户类型：SELF_CARE-自理老人，CARE-护理老人',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-已退住，1-在住',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_id_card`(`id_card` ASC) USING BTREE,
  INDEX `idx_health_manager_id`(`health_manager_id` ASC) USING BTREE,
  INDEX `idx_care_level_id`(`care_level_id` ASC) USING BTREE,
  INDEX `idx_bed_id`(`bed_id` ASC) USING BTREE,
  INDEX `idx_customer_name`(`customer_name` ASC) USING BTREE,
  INDEX `idx_customer_type`(`customer_type` ASC) USING BTREE,
  INDEX `idx_customer_status`(`status` ASC) USING BTREE,
  INDEX `idx_customer_checkin_date`(`check_in_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '客户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (9, '陈建国', 79, 'MALE', '110101194601010009', '1946-01-01', 'A', '陈小军', '13800138009', 1, 1, 1, '2023-05-31', '2026-06-03', NULL, NULL, 'SELF_CARE', 1, '2025-06-07 16:24:11', '2025-06-13 22:19:21', 1);
INSERT INTO `customer` VALUES (10, '刘淑华', 74, 'FEMALE', '110101195101010010', '1951-01-01', 'B', '刘小亮', '13800138010', 1, 1, 1, '2025-06-03', '2026-06-03', 1, 4, 'CARE', 1, '2025-06-07 16:24:11', NULL, 0);
INSERT INTO `customer` VALUES (11, '黄志明', 81, 'MALE', '110101194401010011', '1944-01-01', 'O', '黄小龙', '13800138011', 1, 2, 6, '2023-06-05', '2027-06-08', 2, 4, 'CARE', 1, '2025-06-07 16:24:11', '2025-06-16 01:28:44', 0);
INSERT INTO `customer` VALUES (12, '杨秀兰', 77, 'FEMALE', '110101194801010012', '1948-01-01', 'AB', '杨小凤', '13800138012', 1, 1, 2, '2025-05-05', '2026-06-11', NULL, 5, 'CARE', 1, '2025-06-07 16:24:11', '2025-06-15 16:31:10', 0);
INSERT INTO `customer` VALUES (13, '马永强', 83, 'MALE', '110101194201010013', '1942-01-01', 'A', '马小东', '13800138013', 1, 1, 4, '2025-05-31', '2026-07-07', NULL, 5, 'CARE', 1, '2025-06-07 16:24:11', '2025-06-15 16:31:17', 0);
INSERT INTO `customer` VALUES (14, '郭美丽', 70, 'FEMALE', '110101195501010014', '1955-01-01', 'B', '郭小帅', '13800138014', 1, 7, 27, '2025-06-03', '2026-06-16', NULL, NULL, 'SELF_CARE', 1, '2025-06-07 16:24:11', '2025-06-13 22:18:47', 0);
INSERT INTO `customer` VALUES (15, '林建华', 76, 'MALE', '110101194901010015', '1949-01-01', 'O', '林小斌', '13800138015', 1, 13, 52, '2025-06-15', '2027-06-22', NULL, NULL, 'SELF_CARE', 1, '2025-06-07 16:24:11', NULL, 0);
INSERT INTO `customer` VALUES (16, '何丽娟', 82, 'FEMALE', '110101194301010016', '1943-01-01', 'A', '何小峰', '13800138016', 1, 30, 118, '2025-06-03', '2026-06-18', NULL, NULL, 'CARE', 1, '2025-06-07 16:24:11', NULL, 0);
INSERT INTO `customer` VALUES (17, '高德福', 78, 'MALE', '110101194701010017', '1947-01-01', 'AB', '高小云', '13800138017', 1, 23, 90, '2025-06-02', '2025-06-08', NULL, NULL, 'SELF_CARE', 1, '2025-06-07 16:24:11', NULL, 0);
INSERT INTO `customer` VALUES (18, '朱桂花', 75, 'FEMALE', '110101195001010018', '1950-01-01', 'B', '朱小虎', '13800138018', 1, 22, 86, '2025-06-04', '2027-06-17', NULL, 6, 'CARE', 1, '2025-06-07 16:24:11', '2025-06-15 16:45:30', 0);
INSERT INTO `customer` VALUES (19, '谢志强', 80, 'MALE', '110101194501010019', '1945-01-01', 'O', '谢小鹏', '13800138019', 1, 15, 58, '2025-06-11', '2026-02-03', NULL, NULL, 'SELF_CARE', 1, '2025-06-07 16:24:11', NULL, 0);

-- ----------------------------
-- Table structure for customer_care
-- ----------------------------
DROP TABLE IF EXISTS `customer_care`;
CREATE TABLE `customer_care`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `care_item_id` bigint NOT NULL COMMENT '护理项目ID',
  `purchase_date` date NOT NULL COMMENT '购买服务日期',
  `purchase_quantity` int NULL DEFAULT 1 COMMENT '购买数量',
  `used_quantity` int NULL DEFAULT 0 COMMENT '已使用数量',
  `remaining_quantity` int NULL DEFAULT 0 COMMENT '剩余数量',
  `expire_date` date NOT NULL COMMENT '服务到期日期',
  `service_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'NORMAL' COMMENT '服务状态：NORMAL-正常，EXPIRED-到期，ARREARS-欠费，USED_UP-用完',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `idx_care_item_id`(`care_item_id` ASC) USING BTREE,
  INDEX `idx_customer_care_status`(`service_status` ASC) USING BTREE,
  INDEX `idx_customer_care_expire`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 168 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '客户护理服务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer_care
-- ----------------------------
INSERT INTO `customer_care` VALUES (43, 14, 2, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:18:14', 1);
INSERT INTO `customer_care` VALUES (44, 14, 4, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:18:14', 1);
INSERT INTO `customer_care` VALUES (45, 14, 6, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:18:14', 1);
INSERT INTO `customer_care` VALUES (46, 14, 16, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:18:14', 1);
INSERT INTO `customer_care` VALUES (47, 14, 5, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:18:14', 1);
INSERT INTO `customer_care` VALUES (48, 10, 2, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (49, 10, 3, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (50, 10, 4, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (51, 10, 5, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (52, 10, 6, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (53, 10, 7, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (54, 10, 8, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (55, 10, 11, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (56, 10, 16, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-13 22:34:09', 1);
INSERT INTO `customer_care` VALUES (57, 10, 2, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (58, 10, 4, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (59, 10, 6, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (60, 10, 16, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (61, 10, 5, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (62, 11, 2, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (63, 11, 3, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (64, 11, 4, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (65, 11, 5, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (66, 11, 6, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (67, 11, 7, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (68, 11, 8, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (69, 11, 11, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (70, 11, 16, '2025-06-13', 1, 0, 1, '2025-09-11', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (71, 10, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (72, 10, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (73, 10, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (74, 10, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (75, 10, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:10:15', 1);
INSERT INTO `customer_care` VALUES (76, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (77, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (78, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (79, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (80, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (81, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (82, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (83, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (84, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (85, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (86, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (87, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (88, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (89, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (90, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (91, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (92, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (93, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (94, 10, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 21:34:33', 1);
INSERT INTO `customer_care` VALUES (95, 10, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 21:39:54', 1);
INSERT INTO `customer_care` VALUES (96, 10, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 21:39:54', 1);
INSERT INTO `customer_care` VALUES (97, 10, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 21:39:54', 1);
INSERT INTO `customer_care` VALUES (98, 10, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 21:39:54', 1);
INSERT INTO `customer_care` VALUES (99, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (100, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (101, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (102, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (103, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (104, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (105, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (106, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (107, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (108, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (109, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (110, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (111, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (112, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (113, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (114, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (115, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (116, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:14:54', 1);
INSERT INTO `customer_care` VALUES (117, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (118, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (119, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (120, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (121, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (122, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (123, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (124, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (125, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (126, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (127, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (128, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (129, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (130, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (131, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (132, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (133, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (134, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:15:38', 1);
INSERT INTO `customer_care` VALUES (135, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (136, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (137, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (138, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (139, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (140, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (141, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (142, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (143, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (144, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (145, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (146, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (147, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (148, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (149, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (150, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (151, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (152, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, '2025-06-15 18:20:40', 1);
INSERT INTO `customer_care` VALUES (153, 11, 2, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (154, 11, 3, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (155, 11, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (156, 11, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (157, 11, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (158, 11, 7, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (159, 11, 8, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (160, 11, 11, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (161, 11, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (162, 10, 2, '2025-06-15', 3, 2, 1, '2025-09-14', 'NORMAL', NULL, '2025-06-21 00:28:06', 0);
INSERT INTO `customer_care` VALUES (163, 10, 4, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (164, 10, 6, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (165, 10, 16, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (166, 10, 5, '2025-06-15', 1, 0, 1, '2025-09-13', 'NORMAL', NULL, NULL, 0);
INSERT INTO `customer_care` VALUES (167, 10, 1, '2025-06-16', 1, 0, 1, '2025-07-15', 'NORMAL', NULL, NULL, 0);

-- ----------------------------
-- Table structure for health_manager_customer
-- ----------------------------
DROP TABLE IF EXISTS `health_manager_customer`;
CREATE TABLE `health_manager_customer`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `health_manager_id` bigint NOT NULL COMMENT '健康管家ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `service_start_date` date NOT NULL COMMENT '服务开始日期',
  `service_end_date` date NULL DEFAULT NULL COMMENT '服务结束日期',
  `status` tinyint NULL DEFAULT 1 COMMENT '服务状态：0-停止服务，1-正在服务',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_health_manager_id`(`health_manager_id` ASC) USING BTREE,
  INDEX `idx_customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `idx_service_status`(`status` ASC) USING BTREE,
  INDEX `idx_health_manager_customer_service`(`health_manager_id` ASC, `customer_id` ASC, `status` ASC) USING BTREE,
  INDEX `idx_health_manager_customer_date`(`service_start_date` ASC, `service_end_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '健康管家客户关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of health_manager_customer
-- ----------------------------
INSERT INTO `health_manager_customer` VALUES (1, 4, 11, '2025-06-15', '2025-06-15', 0, NULL, NULL, 0);

-- ----------------------------
-- Table structure for meal_calendar
-- ----------------------------
DROP TABLE IF EXISTS `meal_calendar`;
CREATE TABLE `meal_calendar`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `week_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '周菜单名称，如：第1周菜单',
  `day_of_week` tinyint NOT NULL COMMENT '星期几：1-周一，2-周二...7-周日',
  `breakfast_config_id` bigint NULL DEFAULT NULL COMMENT '早餐配置ID',
  `lunch_config_id` bigint NULL DEFAULT NULL COMMENT '午餐配置ID',
  `dinner_config_id` bigint NULL DEFAULT NULL COMMENT '晚餐配置ID',
  `snack_config_id` bigint NULL DEFAULT NULL COMMENT '加餐配置ID',
  `is_active` tinyint NULL DEFAULT 1 COMMENT '是否启用：0-禁用，1-启用',
  `special_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '特殊说明',
  `total_estimated_cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '当日总预估成本',
  `creator_id` bigint NOT NULL COMMENT '创建者ID',
  `creator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建者姓名',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_week_day`(`week_name` ASC, `day_of_week` ASC) USING BTREE,
  INDEX `idx_week_name`(`week_name` ASC) USING BTREE,
  INDEX `idx_day_of_week`(`day_of_week` ASC) USING BTREE,
  INDEX `idx_creator_id`(`creator_id` ASC) USING BTREE,
  INDEX `fk_mc_breakfast_config`(`breakfast_config_id` ASC) USING BTREE,
  INDEX `fk_mc_lunch_config`(`lunch_config_id` ASC) USING BTREE,
  INDEX `fk_mc_dinner_config`(`dinner_config_id` ASC) USING BTREE,
  INDEX `fk_mc_snack_config`(`snack_config_id` ASC) USING BTREE,
  CONSTRAINT `fk_mc_breakfast_config` FOREIGN KEY (`breakfast_config_id`) REFERENCES `meal_config` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_mc_dinner_config` FOREIGN KEY (`dinner_config_id`) REFERENCES `meal_config` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_mc_lunch_config` FOREIGN KEY (`lunch_config_id`) REFERENCES `meal_config` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_mc_snack_config` FOREIGN KEY (`snack_config_id`) REFERENCES `meal_config` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '膳食日历表（周菜单）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meal_calendar
-- ----------------------------
INSERT INTO `meal_calendar` VALUES (1, '固定菜单', 1, 1, 4, 7, 10, 1, '周一菜单', NULL, 1, NULL, '2025-06-25 15:09:55', '2025-06-25 15:24:10', 0);
INSERT INTO `meal_calendar` VALUES (2, '固定菜单', 2, 1, 4, 7, 10, 1, '周二菜单', NULL, 1, NULL, '2025-06-25 15:12:51', '2025-06-25 15:24:16', 0);
INSERT INTO `meal_calendar` VALUES (36, '固定菜单', 3, 1, 4, 7, 10, 1, '周三菜单', 65.00, 1, '管理员', '2025-06-25 15:15:18', '2025-06-25 15:15:18', 0);
INSERT INTO `meal_calendar` VALUES (37, '固定菜单', 4, 1, 4, 7, 10, 1, '周四菜单', 61.00, 1, '管理员', '2025-06-25 15:15:18', '2025-06-25 15:15:18', 0);
INSERT INTO `meal_calendar` VALUES (38, '固定菜单', 5, 1, 4, 7, 10, 1, '周五菜单', 64.00, 1, '管理员', '2025-06-25 15:15:18', '2025-06-25 15:15:18', 0);
INSERT INTO `meal_calendar` VALUES (39, '固定菜单', 6, 1, 4, 7, 10, 1, '周六菜单', 65.00, 1, '管理员', '2025-06-25 15:15:18', '2025-06-25 15:15:18', 0);
INSERT INTO `meal_calendar` VALUES (40, '固定菜单', 7, 1, 4, 7, 10, 1, '周日菜单', 61.00, 1, '管理员', '2025-06-25 15:15:18', '2025-06-25 15:15:18', 0);

-- ----------------------------
-- Table structure for meal_config
-- ----------------------------
DROP TABLE IF EXISTS `meal_config`;
CREATE TABLE `meal_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `meal_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '膳食名称',
  `meal_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '膳食类型：BREAKFAST-早餐，LUNCH-午餐，DINNER-晚餐，SNACK-加餐',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '膳食描述',
  `main_food` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '主食内容（JSON格式）',
  `side_dishes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '菜品内容（JSON格式）',
  `soup` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '汤品',
  `fruits` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '水果',
  `nutrition_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '营养信息（JSON格式：热量、蛋白质、脂肪、碳水化合物等）',
  `suitable_crowd` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '适宜人群（JSON格式）',
  `dietary_restrictions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '饮食禁忌（JSON格式）',
  `cooking_method` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '烹饪方法说明',
  `estimated_cost` decimal(10, 2) NULL DEFAULT NULL COMMENT '预估成本（元）',
  `creator_id` bigint NOT NULL COMMENT '创建者ID',
  `creator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建者姓名',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_meal_type`(`meal_type` ASC) USING BTREE,
  INDEX `idx_creator_id`(`creator_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '膳食配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meal_config
-- ----------------------------
INSERT INTO `meal_config` VALUES (1, '营养早餐套餐A', 'BREAKFAST', '富含蛋白质和维生素的营养早餐呢', '{\"items\": [{\"name\": \"全麦面包\", \"amount\": \"2片\", \"calories\": 160}, {\"name\": \"煮鸡蛋\", \"amount\": \"1个\", \"calories\": 78}]}', '{\"items\": [{\"name\": \"培根\", \"amount\": \"2片\", \"calories\": 86}, {\"name\": \"生菜沙拉\", \"amount\": \"1份\", \"calories\": 25}]}', '豆浆', '苹果', '{\"calories\": 420, \"protein\": \"18g\", \"fat\": \"15g\", \"carbs\": \"48g\", \"fiber\": \"6g\"}', '[\"上班族\", \"学生\", \"健身人群\"]', '[\"高血压患者少盐\", \"糖尿病患者控制分量\"]', '煮蛋3-5分钟，面包烤制2分钟，培根煎制至微焦', 15.50, 1001, '张营养师', 1, '2025-06-22 15:55:04', '2025-06-24 00:07:29', 0);
INSERT INTO `meal_config` VALUES (2, '传统中式早餐', 'BREAKFAST', '经典中式早餐，温和养胃', '{\"items\": [{\"name\": \"小笼包\", \"amount\": \"4个\", \"calories\": 280}, {\"name\": \"白粥\", \"amount\": \"1碗\", \"calories\": 120}]}', '{\"items\": [{\"name\": \"咸菜\", \"amount\": \"小份\", \"calories\": 15}, {\"name\": \"茶叶蛋\", \"amount\": \"1个\", \"calories\": 85}]}', '紫菜蛋花汤', '无', '{\"calories\": 380, \"protein\": \"15g\", \"fat\": \"12g\", \"carbs\": \"55g\", \"fiber\": \"3g\"}', '[\"老年人\", \"肠胃虚弱者\", \"传统口味爱好者\"]', '[\"高血糖者注意粥的分量\", \"高血压者少食咸菜\"]', '包子蒸制8-10分钟，粥文火熬煮30分钟', 12.00, 1002, '李大厨', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (3, '健康轻食早餐', 'BREAKFAST', '低卡路里高营养的健康早餐', '{\"items\": [{\"name\": \"燕麦片\", \"amount\": \"40g\", \"calories\": 150}, {\"name\": \"酸奶\", \"amount\": \"200ml\", \"calories\": 120}]}', '{\"items\": [{\"name\": \"坚果混合\", \"amount\": \"20g\", \"calories\": 110}, {\"name\": \"蓝莓\", \"amount\": \"50g\", \"calories\": 30}]}', '无', '香蕉半根', '{\"calories\": 350, \"protein\": \"12g\", \"fat\": \"8g\", \"carbs\": \"58g\", \"fiber\": \"8g\"}', '[\"减肥人群\", \"健身爱好者\", \"注重健康者\"]', '[\"乳糖不耐受者选择无乳糖酸奶\", \"坚果过敏者避免\"]', '燕麦用热水或牛奶冲泡，搭配酸奶和水果', 18.00, 1003, '王营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (4, '家常午餐套餐', 'LUNCH', '营养均衡的家常午餐，荤素搭配', '{\"items\": [{\"name\": \"米饭\", \"amount\": \"1碗\", \"calories\": 200}, {\"name\": \"馒头\", \"amount\": \"半个\", \"calories\": 110}]}', '{\"items\": [{\"name\": \"红烧肉\", \"amount\": \"80g\", \"calories\": 280}, {\"name\": \"清炒小白菜\", \"amount\": \"150g\", \"calories\": 35}, {\"name\": \"麻婆豆腐\", \"amount\": \"100g\", \"calories\": 120}]}', '冬瓜排骨汤', '无', '{\"calories\": 680, \"protein\": \"28g\", \"fat\": \"25g\", \"carbs\": \"82g\", \"fiber\": \"5g\"}', '[\"普通成年人\", \"体力劳动者\", \"青少年\"]', '[\"高血脂者少食红烧肉\", \"糖尿病者控制米饭分量\"]', '红烧肉炖制1小时，小白菜大火快炒，豆腐嫩滑', 25.00, 1001, '张营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (5, '清淡养生午餐', 'LUNCH', '低油少盐的养生午餐，适合中老年人', '{\"items\": [{\"name\": \"杂粮饭\", \"amount\": \"1碗\", \"calories\": 180}, {\"name\": \"紫薯\", \"amount\": \"100g\", \"calories\": 82}]}', '{\"items\": [{\"name\": \"清蒸鱼\", \"amount\": \"120g\", \"calories\": 150}, {\"name\": \"菠菜豆腐\", \"amount\": \"150g\", \"calories\": 80}, {\"name\": \"凉拌黄瓜\", \"amount\": \"100g\", \"calories\": 20}]}', '银耳莲子汤', '猕猴桃', '{\"calories\": 480, \"protein\": \"25g\", \"fat\": \"8g\", \"carbs\": \"75g\", \"fiber\": \"12g\"}', '[\"中老年人\", \"高血压患者\", \"养生人群\"]', '[\"肾病患者注意蛋白质摄入\", \"痛风患者少食豆制品\"]', '清蒸鱼10分钟，菠菜焯水后炒制，黄瓜凉拌', 22.00, 1004, '陈医师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (7, '清爽晚餐', 'DINNER', '清淡易消化的晚餐，适合晚间食用', '{\"items\": [{\"name\": \"小米粥\", \"amount\": \"1碗\", \"calories\": 90}, {\"name\": \"蒸蛋羹\", \"amount\": \"1份\", \"calories\": 120}]}', '{\"items\": [{\"name\": \"清炒时蔬\", \"amount\": \"200g\", \"calories\": 60}, {\"name\": \"凉拌海带丝\", \"amount\": \"100g\", \"calories\": 25}]}', '丝瓜汤', '梨', '{\"calories\": 320, \"protein\": \"12g\", \"fat\": \"8g\", \"carbs\": \"48g\", \"fiber\": \"6g\"}', '[\"老年人\", \"消化不良者\", \"减肥人群\"]', '[\"胃寒者少食凉拌菜\", \"糖尿病者注意水果摄入\"]', '小米粥慢煮40分钟，蒸蛋羹嫩滑，时蔬快炒', 15.00, 1002, '李大厨', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (8, '蛋白质晚餐', 'DINNER', '高蛋白低碳水的健身晚餐', '{\"items\": [{\"name\": \"藜麦\", \"amount\": \"80g\", \"calories\": 120}, {\"name\": \"紫薯\", \"amount\": \"80g\", \"calories\": 66}]}', '{\"items\": [{\"name\": \"煎鸡胸肉\", \"amount\": \"150g\", \"calories\": 180}, {\"name\": \"蒸蛋白\", \"amount\": \"3个\", \"calories\": 51}, {\"name\": \"芦笋\", \"amount\": \"150g\", \"calories\": 30}]}', '无', '蓝莓', '{\"calories\": 425, \"protein\": \"38g\", \"fat\": \"6g\", \"carbs\": \"48g\", \"fiber\": \"10g\"}', '[\"健身人群\", \"减脂期人群\", \"高蛋白需求者\"]', '[\"肾功能不全者谨慎\", \"痛风患者适量\"]', '鸡胸肉煎至两面金黄，芦笋焯水炒制', 30.00, 1003, '王营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (9, '温补晚餐', 'DINNER', '滋补养生的温性晚餐', '{\"items\": [{\"name\": \"红豆薏米饭\", \"amount\": \"1碗\", \"calories\": 190}, {\"name\": \"山药\", \"amount\": \"100g\", \"calories\": 56}]}', '{\"items\": [{\"name\": \"当归炖鸡\", \"amount\": \"120g\", \"calories\": 200}, {\"name\": \"菠菜\", \"amount\": \"150g\", \"calories\": 35}]}', '枸杞银耳汤', '红枣', '{\"calories\": 520, \"protein\": \"26g\", \"fat\": \"12g\", \"carbs\": \"72g\", \"fiber\": \"8g\"}', '[\"体质虚弱者\", \"产后妇女\", \"免疫力低下者\"]', '[\"热性体质者适量\", \"感冒发热者暂停\"]', '鸡肉炖制1.5小时，山药蒸制15分钟', 35.00, 1006, '中医营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (10, '下午茶点心', 'SNACK', '健康的下午茶搭配', '{\"items\": [{\"name\": \"全麦饼干\", \"amount\": \"4片\", \"calories\": 120}, {\"name\": \"坚果\", \"amount\": \"15g\", \"calories\": 85}]}', '{\"items\": []}', '无', '葡萄', '{\"calories\": 245, \"protein\": \"6g\", \"fat\": \"12g\", \"carbs\": \"28g\", \"fiber\": \"4g\"}', '[\"办公室人群\", \"学生\", \"下午饥饿者\"]', '[\"坚果过敏者避免\", \"减肥者控制分量\"]', '直接食用，搭配茶水或咖啡', 12.00, 1007, '茶艺师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (11, '运动前加餐', 'SNACK', '运动前30分钟的能量补充', '{\"items\": [{\"name\": \"香蕉\", \"amount\": \"1根\", \"calories\": 105}, {\"name\": \"全麦吐司\", \"amount\": \"1片\", \"calories\": 80}]}', '{\"items\": [{\"name\": \"花生酱\", \"amount\": \"1勺\", \"calories\": 95}]}', '无', '无', '{\"calories\": 280, \"protein\": \"8g\", \"fat\": \"8g\", \"carbs\": \"48g\", \"fiber\": \"5g\"}', '[\"健身人群\", \"运动员\", \"体力工作者\"]', '[\"花生过敏者避免\", \"肠胃敏感者少量\"]', '香蕉切片配吐司，花生酱涂抹', 10.00, 1003, '王营养师', 1, '2025-06-22 15:55:04', '2025-06-22 23:17:50', 1);
INSERT INTO `meal_config` VALUES (12, '夜宵轻食', 'SNACK', '低卡路里的健康夜宵', '{\"items\": [{\"name\": \"燕麦片\", \"amount\": \"30g\", \"calories\": 110}, {\"name\": \"牛奶\", \"amount\": \"150ml\", \"calories\": 90}]}', '{\"items\": []}', '无', '无', '{\"calories\": 200, \"protein\": \"8g\", \"fat\": \"5g\", \"carbs\": \"32g\", \"fiber\": \"4g\"}', '[\"熬夜人群\", \"失眠者\", \"轻度饥饿者\"]', '[\"乳糖不耐受者选择豆浆\", \"睡前1小时食用\"]', '燕麦用温牛奶冲泡，可加少量蜂蜜', 8.00, 1008, '夜班营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (13, '素食主义午餐', 'LUNCH', '营养全面的素食午餐', '{\"items\": [{\"name\": \"糙米饭\", \"amount\": \"1碗\", \"calories\": 170}, {\"name\": \"全麦馒头\", \"amount\": \"半个\", \"calories\": 100}]}', '{\"items\": [{\"name\": \"宫保杏鲍菇\", \"amount\": \"150g\", \"calories\": 120}, {\"name\": \"麻婆豆腐\", \"amount\": \"120g\", \"calories\": 140}, {\"name\": \"清炒菠菜\", \"amount\": \"150g\", \"calories\": 35}]}', '紫菜豆腐汤', '苹果', '{\"calories\": 550, \"protein\": \"20g\", \"fat\": \"15g\", \"carbs\": \"85g\", \"fiber\": \"12g\"}', '[\"素食主义者\", \"减肥人群\", \"环保主义者\"]', '[\"豆制品过敏者注意\", \"缺铁者需补充\"]', '杏鲍菇爆炒，豆腐嫩滑，菠菜快炒', 20.00, 1009, '素食营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (16, '老年人软食晚餐', 'DINNER', '易咀嚼易消化的老年人晚餐', '{\"items\": [{\"name\": \"软烂米粥\", \"amount\": \"1碗\", \"calories\": 100}, {\"name\": \"蒸蛋羹\", \"amount\": \"1份\", \"calories\": 120}]}', '{\"items\": [{\"name\": \"蒸蛋羹肉末\", \"amount\": \"80g\", \"calories\": 110}, {\"name\": \"胡萝卜泥\", \"amount\": \"100g\", \"calories\": 40}]}', '白萝卜汤', '香蕉泥', '{\"calories\": 390, \"protein\": \"18g\", \"fat\": \"12g\", \"carbs\": \"52g\", \"fiber\": \"4g\"}', '[\"65岁以上老人\", \"咀嚼困难者\", \"消化不良者\"]', '[\"糖尿病者注意粥类\", \"高血压者少盐\"]', '粥煮至软烂，蛋羹蒸制嫩滑，胡萝卜蒸熟压泥', 16.00, 1012, '老年营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (17, '减脂健身餐', 'DINNER', '低卡高蛋白的减脂晚餐', '{\"items\": [{\"name\": \"魔芋面\", \"amount\": \"100g\", \"calories\": 20}, {\"name\": \"糙米\", \"amount\": \"50g\", \"calories\": 85}]}', '{\"items\": [{\"name\": \"水煮鸡胸肉\", \"amount\": \"150g\", \"calories\": 165}, {\"name\": \"生菜沙拉\", \"amount\": \"200g\", \"calories\": 30}, {\"name\": \"西兰花\", \"amount\": \"150g\", \"calories\": 45}]}', '无', '柚子', '{\"calories\": 365, \"protein\": \"35g\", \"fat\": \"3g\", \"carbs\": \"45g\", \"fiber\": \"15g\"}', '[\"减肥人群\", \"健身爱好者\", \"模特演员\"]', '[\"营养不良者不宜长期\", \"青少年不建议\"]', '鸡胸肉水煮无油，蔬菜清炒或生食', 25.00, 1013, '健身营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (19, '病后调理餐', 'LUNCH', '适合病后恢复期的清淡营养餐', '{\"items\": [{\"name\": \"白粥\", \"amount\": \"1碗\", \"calories\": 120}, {\"name\": \"蒸蛋羹\", \"amount\": \"1份\", \"calories\": 120}]}', '{\"items\": [{\"name\": \"清蒸鸡蛋\", \"amount\": \"1个\", \"calories\": 78}, {\"name\": \"冬瓜片\", \"amount\": \"100g\", \"calories\": 12}]}', '小米汤', '苹果泥', '{\"calories\": 350, \"protein\": \"15g\", \"fat\": \"8g\", \"carbs\": \"55g\", \"fiber\": \"3g\"}', '[\"病后恢复者\", \"肠胃炎患者\", \"术后患者\"]', '[\"重症患者需医嘱\", \"过敏体质注意\"]', '所有食物蒸煮制作，易消化易吸收', 14.00, 1015, '临床营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);
INSERT INTO `meal_config` VALUES (20, '补血养颜餐', 'DINNER', '富含铁质和胶原蛋白的美容晚餐', '{\"items\": [{\"name\": \"红豆饭\", \"amount\": \"1碗\", \"calories\": 190}, {\"name\": \"血糯米\", \"amount\": \"50g\", \"calories\": 85}]}', '{\"items\": [{\"name\": \"猪蹄炖花生\", \"amount\": \"100g\", \"calories\": 280}, {\"name\": \"菠菜\", \"amount\": \"150g\", \"calories\": 35}, {\"name\": \"红枣银耳\", \"amount\": \"1份\", \"calories\": 80}]}', '当归汤', '红枣', '{\"calories\": 720, \"protein\": \"25g\", \"fat\": \"22g\", \"carbs\": \"105g\", \"fiber\": \"8g\"}', '[\"贫血女性\", \"气血不足者\", \"美容需求者\"]', '[\"高血脂者少食\", \"痛风患者避免\"]', '猪蹄炖制2小时，银耳提前泡发', 40.00, 1016, '美容营养师', 1, '2025-06-22 15:55:04', '2025-06-22 15:55:04', 0);

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '操作用户ID',
  `operation_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作类型',
  `operation_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '操作描述',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请求方法',
  `request_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请求URL',
  `request_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '请求参数',
  `response_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '响应结果',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户代理',
  `execute_time` bigint NULL DEFAULT NULL COMMENT '执行时间（毫秒）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operation_log
-- ----------------------------

-- ----------------------------
-- Table structure for outing_apply
-- ----------------------------
DROP TABLE IF EXISTS `outing_apply`;
CREATE TABLE `outing_apply`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `applicant_id` bigint NOT NULL COMMENT '申请人ID（健康管家）',
  `outing_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '外出事由',
  `outing_date` datetime NOT NULL COMMENT '外出时间',
  `expected_return_date` datetime NOT NULL COMMENT '预计回院时间',
  `actual_return_date` datetime NULL DEFAULT NULL COMMENT '实际回院时间',
  `apply_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'SUBMITTED' COMMENT '申请状态：SUBMITTED-已提交，APPROVED-通过，REJECTED-不通过',
  `approver_id` bigint NULL DEFAULT NULL COMMENT '审批人ID',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `approve_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '审批备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `idx_applicant_id`(`applicant_id` ASC) USING BTREE,
  INDEX `idx_outing_apply_status`(`apply_status` ASC) USING BTREE,
  INDEX `idx_outing_apply_date`(`outing_date` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '外出申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of outing_apply
-- ----------------------------
INSERT INTO `outing_apply` VALUES (2, 12, 5, '陪同杨秀兰老人前往北京市海淀区人民医院进行定期体检，预约时间为上午9:00。老人身体状况良好，能够正常出行，预计下午3点前返回养老院。由护工张护士全程陪同，确保老人安全。紧急联系人：杨小凤（13800138012）。', '2025-06-10 08:30:00', '2025-06-10 15:00:00', '2025-06-10 15:30:00', 'APPROVED', 1, '2025-06-09 22:42:18', '同意外出', '2025-06-09 22:31:57', '2025-06-10 10:57:22', 0);
INSERT INTO `outing_apply` VALUES (5, 10, 4, 'MEDICAL', '2025-06-21 00:00:00', '2025-06-22 00:00:00', '2025-06-22 00:00:00', 'APPROVED', 1, '2025-06-21 22:06:15', '通过', '2025-06-21 21:53:36', '2025-06-22 09:24:43', 0);

-- ----------------------------
-- Table structure for return_apply
-- ----------------------------
DROP TABLE IF EXISTS `return_apply`;
CREATE TABLE `return_apply`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `outing_apply_id` bigint NOT NULL COMMENT '关联的外出申请ID',
  `applicant_id` bigint NOT NULL COMMENT '申请人ID（健康管家）',
  `return_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回院事由',
  `requested_return_date` datetime NOT NULL COMMENT '申请回院时间',
  `actual_return_date` datetime NULL DEFAULT NULL COMMENT '实际回院时间',
  `apply_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'SUBMITTED' COMMENT '申请状态：SUBMITTED-已提交，APPROVED-通过，REJECTED-不通过',
  `approver_id` bigint NULL DEFAULT NULL COMMENT '审批人ID',
  `approve_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `approve_remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '审批备注',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `idx_outing_apply_id`(`outing_apply_id` ASC) USING BTREE,
  INDEX `idx_applicant_id`(`applicant_id` ASC) USING BTREE,
  INDEX `idx_apply_status`(`apply_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '回院申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of return_apply
-- ----------------------------
INSERT INTO `return_apply` VALUES (1, 12, 2, 5, '老人体检结束，身体状况良好，各项检查指标正常。现申请老人按计划回院。老人情绪稳定，能够正常行走，预计今日下午15:30回到养老院。已通知家属杨小凤，请安排接院准备工作。', '2025-06-10 15:30:00', '2025-06-10 15:30:00', 'APPROVED', 1, '2025-06-10 10:57:22', '予以回院', '2025-06-10 10:51:44', '2025-06-10 10:57:22', 0);
INSERT INTO `return_apply` VALUES (2, 10, 5, 4, 'SCHEDULED_RETURN', '2025-06-22 00:00:00', '2025-06-22 00:00:00', 'APPROVED', 1, '2025-06-22 09:24:43', '通过', '2025-06-22 09:24:22', '2025-06-22 09:24:43', 0);

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `building_id` bigint NOT NULL COMMENT '楼栋ID',
  `room_no` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '房间号',
  `room_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '房间名称',
  `floor_no` int NOT NULL COMMENT '楼层号',
  `bed_count` int NULL DEFAULT 0 COMMENT '床位数量',
  `room_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'STANDARD' COMMENT '房间类型：STANDARD-标准间，VIP-贵宾间',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-停用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_building_room`(`building_id` ASC, `room_no` ASC) USING BTREE,
  INDEX `idx_building_id`(`building_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '房间表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, 1, '101', '101室', 1, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (2, 1, '102', '102室', 1, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (3, 1, '103', '103室', 1, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (4, 1, '104', '104室', 1, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (5, 1, '105', '105室', 1, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (6, 1, '106', '106室', 1, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (7, 1, '201', '201室', 2, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (8, 1, '202', '202室', 2, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (9, 1, '203', '203室', 2, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (10, 1, '204', '204室', 2, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (11, 1, '205', '205室', 2, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (12, 1, '206', '206室', 2, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (13, 1, '301', '301室', 3, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (14, 1, '302', '302室', 3, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (15, 1, '303', '303室', 3, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (16, 1, '304', '304室', 3, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (17, 1, '305', '305室', 3, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (18, 1, '306', '306室', 3, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (19, 1, '401', '401室', 4, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (20, 1, '402', '402室', 4, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (21, 1, '403', '403室', 4, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (22, 1, '404', '404室', 4, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (23, 1, '405', '405室', 4, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (24, 1, '406', '406室', 4, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (25, 1, '501', '501室', 5, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (26, 1, '502', '502室', 5, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (27, 1, '503', '503室', 5, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (28, 1, '504', '504室', 5, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (29, 1, '505', '505室', 5, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);
INSERT INTO `room` VALUES (30, 1, '506', '506室', 5, 4, 'STANDARD', 1, '2025-06-07 15:57:06', '2025-06-07 15:57:06', 0);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色：ADMIN-管理员, HEALTH_MANAGER-健康管家',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$4Xms4wvAm4CQmqgeLL.ww.jyMwJsWozvbaKVqnKYY8L4yeh/zL4aS', '系统管理员', '13800000001', 'ADMIN', 1, '2025-06-05 09:52:00', '2025-06-05 11:24:48', 0);
INSERT INTO `sys_user` VALUES (2, 'admin1', '$2a$10$4Xms4wvAm4CQmqgeLL.ww.jyMwJsWozvbaKVqnKYY8L4yeh/zL4aS', '管理员1', '13800000002', 'ADMIN', 1, '2025-06-05 09:52:00', '2025-06-05 11:24:48', 0);
INSERT INTO `sys_user` VALUES (3, 'admin2', '$2a$10$4Xms4wvAm4CQmqgeLL.ww.jyMwJsWozvbaKVqnKYY8L4yeh/zL4aS', '管理员2', '13800000003', 'ADMIN', 1, '2025-06-05 09:52:00', '2025-06-05 11:24:48', 0);
INSERT INTO `sys_user` VALUES (4, 'nurse001', '$2a$10$Uld9dKlmTCt8YRBRzpoivuLiX7s.CEYVo.LNew8p.7pIe1R7thSqu', '张护士', '13800001001', 'HEALTH_MANAGER', 1, '2025-06-05 09:52:00', '2025-06-18 01:09:19', 0);
INSERT INTO `sys_user` VALUES (5, 'nurse002', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8imdQMkhskqfLaOCzf3xCl5HgFzn2', '李护士', '13800001002', 'HEALTH_MANAGER', 1, '2025-06-05 09:52:00', '2025-06-05 09:52:00', 0);
INSERT INTO `sys_user` VALUES (6, 'nurse003', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8imdQMkhskqfLaOCzf3xCl5HgFzn2', '王护士', '13800001003', 'HEALTH_MANAGER', 1, '2025-06-05 09:52:00', '2025-06-05 09:52:00', 0);
INSERT INTO `sys_user` VALUES (11, 'nurse004', '$2a$10$smdy9fFFSukbakS/xL.xhObbNFme4dodVuOqoVpbKOniq9Ge5cLsi', '刘护士', '13841410000', 'HEALTH_MANAGER', 1, '2025-06-17 12:16:05', '2025-06-17 12:16:05', 0);

SET FOREIGN_KEY_CHECKS = 1;
