package com.nursing.center.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.nursing.center.dto.AiRecipeRecommendationDTO;

import java.util.List;

/**
 * AI食谱推荐服务接口
 */
public interface AiRecipeRecommendationService {

    /**
     * 分页查询AI食谱推荐记录
     */
    IPage<AiRecipeRecommendationDTO> getRecommendationPage(Integer pageNum, Integer pageSize);

    /**
     * 根据ID查询AI食谱推荐详情
     */
    AiRecipeRecommendationDTO getRecommendationById(Long id);

    /**
     * 新增AI食谱推荐记录
     */
    Long addRecommendation(AiRecipeRecommendationDTO recommendationDTO);

    /**
     * 修改AI食谱推荐记录
     */
    void updateRecommendation(AiRecipeRecommendationDTO recommendationDTO);

    /**
     * 删除AI食谱推荐记录
     */
    void deleteRecommendation(Long id);

    /**
     * 采纳AI推荐食谱
     */
    void adoptRecommendation(Long id, String adoptRemark);

    /**
     * 拒绝AI推荐食谱
     */
    void rejectRecommendation(Long id, String rejectRemark);

    /**
     * 获取用户的推荐历史
     */
    List<AiRecipeRecommendationDTO> getUserRecommendationHistory(Long userId);

    /**
     * 调用AI服务获取食谱推荐
     */
    String getAiRecommendation(String userInput, String dietaryRequirements);

    /**
     * 保存AI对话记录
     */
    Long saveAiConversation(String userInput, String aiResponse, String dietaryRequirements, Long userId);
}
