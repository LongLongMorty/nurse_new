package com.nursing.center.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * AI食谱推荐DTO
 * @author system
 * @since 2025-06-22
 */
@Data
public class AiRecipeRecommendationDTO {

    /**
     * 主键ID
     */
    private Long id;

    /**
     * 会话ID
     */
    private String sessionId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户姓名
     */
    private String userName;

    /**
     * 用户提问内容
     */
    @NotBlank(message = "问题内容不能为空")
    private String userQuestion;

    /**
     * AI回复内容
     */
    private String aiResponse;

    /**
     * 问题类型
     */
    private String questionType;

    /**
     * 相关症状标签
     */
    private String relatedSymptoms;

    /**
     * 推荐食物（JSON格式）
     */
    private String recommendedFoods;

    /**
     * 避免食物（JSON格式）
     */
    private String avoidFoods;

    /**
     * 是否被采纳
     */
    private Integer isAdopted;

    /**
     * 采纳到的膳食配置ID
     */
    private Long adoptedMealConfigId;

    /**
     * AI响应时间（毫秒）
     */
    private Long responseTime;
}
