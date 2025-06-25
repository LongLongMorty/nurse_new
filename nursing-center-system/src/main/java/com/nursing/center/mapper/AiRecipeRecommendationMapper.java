package com.nursing.center.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nursing.center.dto.AiRecipeRecommendationDTO;
import com.nursing.center.entity.AiRecipeRecommendation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * AI食谱推荐Mapper接口
 * @author system
 * @since 2025-06-22
 */
@Mapper
public interface AiRecipeRecommendationMapper extends BaseMapper<AiRecipeRecommendation> {

    /**
     * 分页查询AI推荐记录
     */
    IPage<AiRecipeRecommendationDTO> selectRecommendationPage(Page<AiRecipeRecommendationDTO> page, 
                                                              @Param("userId") Long userId, 
                                                              @Param("questionType") String questionType);

    /**
     * 根据会话ID查询推荐记录
     */
    List<AiRecipeRecommendationDTO> selectBySessionId(@Param("sessionId") String sessionId);

    /**
     * 查询用户的历史推荐记录
     */
    List<AiRecipeRecommendationDTO> selectUserRecommendations(@Param("userId") Long userId, 
                                                              @Param("limit") Integer limit);
}
