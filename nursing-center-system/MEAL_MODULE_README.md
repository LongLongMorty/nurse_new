# 膳食模块实现文档

## 概述
养老院管理系统膳食模块，包括膳食配置管理、膳食日历编排和AI智能食谱推荐功能。

## 模块结构

### 1. 数据库设计
- `meal_config` - 膳食配置表：存储各类餐食的配置信息
- `meal_calendar` - 膳食日历表：存储每日膳食安排
- `ai_recipe_recommendation` - AI食谱推荐表：存储AI推荐记录和采纳情况
- `meal_feedback` - 膳食反馈表：存储用餐反馈（预留）

### 2. 核心功能

#### 2.1 膳食配置管理
- **实体类**: `MealConfig`
- **DTO**: `MealConfigDTO`, `MealConfigQueryDTO`  
- **Service**: `MealConfigService` / `MealConfigServiceImpl`
- **Controller**: `MealConfigController`
- **Mapper**: `MealConfigMapper` / `MealConfigMapper.xml`

**主要功能**:
- 膳食配置的增删改查
- 分页查询和条件筛选
- 膳食配置的审批管理
- 批量操作（启用/禁用/删除）
- 按餐次类型查询

#### 2.2 膳食日历管理
- **实体类**: `MealCalendar`
- **DTO**: `MealCalendarDTO`, `MealCalendarQueryDTO`
- **Service**: `MealCalendarService` / `MealCalendarServiceImpl`  
- **Controller**: `MealCalendarController`
- **Mapper**: `MealCalendarMapper` / `MealCalendarMapper.xml`

**主要功能**:
- 每日膳食安排的创建和编辑
- 支持多餐次配置（早餐、午餐、晚餐、上午加餐、下午加餐）
- 膳食日历的批量设置
- 日期范围查询和周视图
- 膳食安排的复制功能
- 冲突检测和审批流程

#### 2.3 AI智能食谱推荐
- **实体类**: `AiRecipeRecommendation`
- **DTO**: `AiRecipeRecommendationDTO`, `AiRecipeRecommendationQueryDTO`
- **Service**: `AiRecipeRecommendationService` / `AiRecipeRecommendationServiceImpl`
- **Controller**: `AiRecipeRecommendationController`
- **Mapper**: `AiRecipeRecommendationMapper` / `AiRecipeRecommendationMapper.xml`

**主要功能**:
- AI对话式食谱推荐
- 推荐记录的存储和管理
- 推荐采纳状态跟踪
- 用户反馈收集和分析
- 推荐效果统计

### 3. 枚举定义
- `MealType`: 餐次类型（早餐、午餐、晚餐、上午加餐、下午加餐）
- `ApprovalStatus`: 审批状态（草稿、待审批、已审批、已拒绝）

### 4. API接口

#### 4.1 膳食配置API (`/api/admin/meal-config`)
```
GET    /page              - 分页查询膳食配置
GET    /{id}              - 查询膳食配置详情  
POST   /                  - 新增膳食配置
PUT    /                  - 修改膳食配置
DELETE /{id}              - 删除膳食配置
DELETE /batch             - 批量删除
POST   /batch-enable      - 批量启用
POST   /batch-disable     - 批量禁用
GET    /by-type/{type}    - 按餐次类型查询
POST   /approve           - 审批膳食配置
```

#### 4.2 膳食日历API (`/api/admin/meal-calendar`)
```
GET    /page              - 分页查询膳食日历
GET    /{id}              - 查询膳食日历详情
POST   /                  - 新增膳食日历
PUT    /                  - 修改膳食日历  
DELETE /{id}              - 删除膳食日历
DELETE /batch             - 批量删除
GET    /date/{date}       - 查询指定日期膳食
GET    /date-range        - 查询日期范围膳食
GET    /week              - 查询指定周膳食
POST   /copy              - 复制膳食安排
POST   /batch-copy        - 批量复制到一周
GET    /check-conflict    - 检查膳食冲突
```

#### 4.3 AI食谱推荐API (`/api/admin/ai-recommendation`)
```
GET    /page              - 分页查询AI推荐
GET    /{id}              - 查询推荐详情
POST   /                  - 新增推荐记录
PUT    /                  - 修改推荐记录
DELETE /{id}              - 删除推荐记录  
DELETE /batch             - 批量删除
POST   /adopt             - 采纳推荐
POST   /batch-adopt       - 批量采纳
POST   /feedback          - 提交反馈
GET    /session/{id}      - 查询会话推荐
GET    /stats             - 推荐统计数据
POST   /cleanup           - 清理过期记录
```

## 数据表结构

### meal_config 膳食配置表
| 字段 | 类型 | 说明 |
|-----|------|------|
| id | bigint | 主键ID |
| meal_name | varchar(100) | 膳食名称 |
| meal_type | varchar(20) | 餐次类型 |
| description | text | 膳食描述 |
| ingredients | text | 食材清单 |
| cooking_method | text | 制作方法 |
| nutrition_info | text | 营养信息 |
| suitable_groups | text | 适宜人群 |
| estimated_cost | decimal(8,2) | 预估成本 |
| estimated_time | int | 预估时间(分钟) |
| difficulty_level | varchar(20) | 难度等级 |
| status | varchar(20) | 状态 |
| approval_status | varchar(20) | 审批状态 |

### meal_calendar 膳食日历表  
| 字段 | 类型 | 说明 |
|-----|------|------|
| id | bigint | 主键ID |
| meal_date | date | 膳食日期 |
| day_of_week | tinyint | 星期几 |
| breakfast_config_id | bigint | 早餐配置ID |
| lunch_config_id | bigint | 午餐配置ID |
| dinner_config_id | bigint | 晚餐配置ID |
| morning_snack_config_id | bigint | 上午加餐配置ID |
| afternoon_snack_config_id | bigint | 下午加餐配置ID |
| special_notes | text | 特殊说明 |
| total_estimated_cost | decimal(10,2) | 当日总预估成本 |
| approval_status | varchar(20) | 审批状态 |

### ai_recipe_recommendation AI食谱推荐表
| 字段 | 类型 | 说明 |
|-----|------|------|
| id | bigint | 主键ID |
| session_id | varchar(100) | 会话ID |
| user_id | bigint | 用户ID |
| user_query | text | 用户查询 |
| ai_response | text | AI回复 |
| recommendation_content | text | 推荐内容 |
| adoption_status | varchar(20) | 采纳状态 |
| adopted_config_id | bigint | 被采纳的配置ID |
| feedback_rating | int | 反馈评分 |
| feedback_comment | text | 反馈评论 |

## 使用示例

### 1. 运行测试数据
```sql
-- 执行测试数据脚本
source meal_module_test_data.sql;
```

### 2. API调用示例
```bash
# 查询膳食配置
curl -X GET "http://localhost:8080/api/admin/meal-config/page?page=1&size=10"

# 新增膳食日历  
curl -X POST "http://localhost:8080/api/admin/meal-calendar" \
  -H "Content-Type: application/json" \
  -d '{
    "mealDate": "2025-06-27",
    "breakfastConfigId": 1,
    "lunchConfigId": 4,
    "dinnerConfigId": 7,
    "specialNotes": "周六营养餐"
  }'

# AI食谱推荐
curl -X POST "http://localhost:8080/api/admin/ai-recommendation" \
  -H "Content-Type: application/json" \
  -d '{
    "sessionId": "session_005",
    "userId": 1,
    "userQuery": "请推荐适合高血压患者的午餐"
  }'
```

## 技术栈
- **后端框架**: Spring Boot 2.7+
- **数据库**: MySQL 8.0+
- **ORM框架**: MyBatis Plus 3.5+
- **权限控制**: Spring Security
- **API文档**: Swagger/OpenAPI 3
- **日志框架**: Logback + SLF4J

## 开发规范
1. 所有实体类继承 `BaseEntity`，包含公共字段
2. DTO类用于API数据传输，与实体类分离
3. Service层包含业务逻辑，支持事务管理
4. Controller层只负责参数校验和响应格式化
5. 统一异常处理和结果封装
6. 数据库字段采用下划线命名，Java对象采用驼峰命名

## 待完善功能
1. AI食谱推荐的实际大模型API对接
2. 膳食营养成分自动计算
3. 膳食成本统计和分析
4. 用餐反馈收集和分析
5. 膳食过敏原管理
6. 个性化膳食推荐算法
7. 膳食库存管理集成
8. 移动端用餐应用

## 更新日志
- 2025-06-22: 完成膳食模块基础架构设计和实现
- 2025-06-22: 创建数据库表结构和测试数据
- 2025-06-22: 实现膳食配置、日历、AI推荐的完整CRUD功能
- 2025-06-22: 完善Service、Controller、Mapper层代码
