package com.nursing.center.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * AI食谱推荐记录实体类
 * @author system
 * @since 2025-06-22
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ai_recipe_recommendation")
public class AiRecipeRecommendation extends BaseEntity {

    /**
     * 主键ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 会话ID
     */
    @TableField("session_id")
    private String sessionId;

    /**
     * 用户ID
     */
    @TableField("user_id")
    private Long userId;

    /**
     * 用户姓名
     */
    @TableField("user_name")
    private String userName;

    /**
     * 用户提问内容
     */
    @TableField("user_question")
    private String userQuestion;

    /**
     * AI回复内容
     */
    @TableField("ai_response")
    private String aiResponse;

    /**
     * 问题类型：SYMPTOMS-症状咨询，NUTRITION-营养建议，RECIPE-食谱推荐，DIETARY_RESTRICTIONS-饮食禁忌等
     */
    @TableField("question_type")
    private String questionType;

    /**
     * 相关症状标签
     */
    @TableField("related_symptoms")
    private String relatedSymptoms;

    /**
     * 推荐食物（JSON格式）
     */
    @TableField("recommended_foods")
    private String recommendedFoods;

    /**
     * 避免食物（JSON格式）
     */
    @TableField("avoid_foods")
    private String avoidFoods;

    /**
     * 是否被采纳：0-未采纳，1-已采纳到膳食配置
     */
    @TableField("is_adopted")
    private Integer isAdopted;

    /**
     * 采纳到的膳食配置ID
     */
    @TableField("adopted_meal_config_id")
    private Long adoptedMealConfigId;

    /**
     * AI响应时间（毫秒）
     */
    @TableField("response_time")
    private Long responseTime;
}
