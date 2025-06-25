package com.nursing.center.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nursing.center.common.exception.BusinessException;
import com.nursing.center.dto.AiRecipeRecommendationDTO;
import com.nursing.center.entity.AiRecipeRecommendation;
import com.nursing.center.mapper.AiRecipeRecommendationMapper;
import com.nursing.center.service.AiRecipeRecommendationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * AI食谱推荐服务实现类
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiRecipeRecommendationServiceImpl implements AiRecipeRecommendationService {

    private final AiRecipeRecommendationMapper aiRecipeRecommendationMapper;    @Override
    public IPage<AiRecipeRecommendationDTO> getRecommendationPage(Integer pageNum, Integer pageSize) {
        Page<AiRecipeRecommendationDTO> page = new Page<>(pageNum, pageSize);
        return aiRecipeRecommendationMapper.selectRecommendationPage(page, null, null);
    }

    @Override
    public AiRecipeRecommendationDTO getRecommendationById(Long id) {
        AiRecipeRecommendation recommendation = aiRecipeRecommendationMapper.selectById(id);
        if (recommendation == null) {
            throw new BusinessException("AI食谱推荐记录不存在");
        }
        
        AiRecipeRecommendationDTO dto = new AiRecipeRecommendationDTO();
        BeanUtils.copyProperties(recommendation, dto);
        return dto;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long addRecommendation(AiRecipeRecommendationDTO recommendationDTO) {
        AiRecipeRecommendation recommendation = new AiRecipeRecommendation();
        BeanUtils.copyProperties(recommendationDTO, recommendation);
        recommendation.setCreateTime(LocalDateTime.now());
        recommendation.setUpdateTime(LocalDateTime.now());
        recommendation.setDeleted(0);
        
        aiRecipeRecommendationMapper.insert(recommendation);
        log.info("新增AI食谱推荐记录成功，ID: {}", recommendation.getId());
        return recommendation.getId();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateRecommendation(AiRecipeRecommendationDTO recommendationDTO) {
        AiRecipeRecommendation existingRecommendation = aiRecipeRecommendationMapper.selectById(recommendationDTO.getId());
        if (existingRecommendation == null) {
            throw new BusinessException("AI食谱推荐记录不存在");
        }

        AiRecipeRecommendation recommendation = new AiRecipeRecommendation();
        BeanUtils.copyProperties(recommendationDTO, recommendation);
        recommendation.setUpdateTime(LocalDateTime.now());
        
        aiRecipeRecommendationMapper.updateById(recommendation);
        log.info("修改AI食谱推荐记录成功，ID: {}", recommendation.getId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteRecommendation(Long id) {
        AiRecipeRecommendation recommendation = aiRecipeRecommendationMapper.selectById(id);
        if (recommendation == null) {
            throw new BusinessException("AI食谱推荐记录不存在");
        }
        
        aiRecipeRecommendationMapper.deleteById(id);
        log.info("删除AI食谱推荐记录成功，ID: {}", id);
    }    @Override
    @Transactional(rollbackFor = Exception.class)
    public void adoptRecommendation(Long id, String adoptRemark) {
        AiRecipeRecommendation recommendation = aiRecipeRecommendationMapper.selectById(id);
        if (recommendation == null) {
            throw new BusinessException("AI食谱推荐记录不存在");
        }
        
        AiRecipeRecommendation updateRecommendation = new AiRecipeRecommendation();
        updateRecommendation.setId(id);
        updateRecommendation.setIsAdopted(1); // 已采纳
        updateRecommendation.setUpdateTime(LocalDateTime.now());
        
        aiRecipeRecommendationMapper.updateById(updateRecommendation);
        log.info("采纳AI食谱推荐成功，ID: {}", id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void rejectRecommendation(Long id, String rejectRemark) {
        AiRecipeRecommendation recommendation = aiRecipeRecommendationMapper.selectById(id);
        if (recommendation == null) {
            throw new BusinessException("AI食谱推荐记录不存在");
        }
        
        AiRecipeRecommendation updateRecommendation = new AiRecipeRecommendation();
        updateRecommendation.setId(id);
        updateRecommendation.setIsAdopted(0); // 未采纳
        updateRecommendation.setUpdateTime(LocalDateTime.now());
        
        aiRecipeRecommendationMapper.updateById(updateRecommendation);
        log.info("拒绝AI食谱推荐成功，ID: {}", id);
    }    @Override
    public List<AiRecipeRecommendationDTO> getUserRecommendationHistory(Long userId) {
        return aiRecipeRecommendationMapper.selectRecommendationPage(new Page<>(1, 100), userId, null).getRecords();
    }

    @Override
    public String getAiRecommendation(String userInput, String dietaryRequirements) {
        // TODO: 实现AI推荐功能，调用大模型API
        // 这里先返回模拟数据
        log.info("调用AI服务获取食谱推荐，用户输入: {}, 饮食要求: {}", userInput, dietaryRequirements);
        
        return "根据您的需求，推荐以下膳食搭配：\n" +
               "早餐：小米粥、蒸蛋、青菜包子\n" +
               "午餐：红烧肉、清炒菠菜、冬瓜汤、米饭\n" +
               "晚餐：清蒸鱼、蒜蓉西兰花、紫菜蛋花汤、小米粥\n" +
               "注意：以上搭配营养均衡，适合老年人食用。";
    }    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long saveAiConversation(String userInput, String aiResponse, String dietaryRequirements, Long userId) {
        AiRecipeRecommendation recommendation = new AiRecipeRecommendation();
        recommendation.setUserQuestion(userInput); // 使用正确的字段名
        recommendation.setAiResponse(aiResponse);
        recommendation.setUserId(userId);
        recommendation.setIsAdopted(0); // 默认未采纳
        recommendation.setCreateTime(LocalDateTime.now());
        recommendation.setUpdateTime(LocalDateTime.now());
        recommendation.setDeleted(0);
        
        aiRecipeRecommendationMapper.insert(recommendation);
        log.info("保存AI对话记录成功，ID: {}, 用户ID: {}", recommendation.getId(), userId);
        return recommendation.getId();
    }
}
