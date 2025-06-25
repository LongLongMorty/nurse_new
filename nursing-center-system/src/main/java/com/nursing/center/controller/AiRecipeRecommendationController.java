package com.nursing.center.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.nursing.center.common.result.Result;
import com.nursing.center.dto.AiRecipeRecommendationDTO;
import com.nursing.center.service.AiRecipeRecommendationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * AI食谱推荐控制器
 */
@RestController
@RequestMapping("/api/admin/ai-recipe")
@RequiredArgsConstructor
@Validated
@Slf4j
public class AiRecipeRecommendationController {

    private final AiRecipeRecommendationService aiRecipeRecommendationService;

    /**
     * 分页查询AI食谱推荐记录
     */
    @GetMapping("/page")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<IPage<AiRecipeRecommendationDTO>> getRecommendationPage(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        IPage<AiRecipeRecommendationDTO> page = aiRecipeRecommendationService.getRecommendationPage(pageNum, pageSize);
        return Result.success(page);
    }

    /**
     * 根据ID查询AI食谱推荐详情
     */
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<AiRecipeRecommendationDTO> getRecommendationById(@PathVariable Long id) {
        AiRecipeRecommendationDTO recommendation = aiRecipeRecommendationService.getRecommendationById(id);
        return Result.success(recommendation);
    }

    /**
     * 新增AI食谱推荐记录
     */
    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public Result<Long> addRecommendation(@Valid @RequestBody AiRecipeRecommendationDTO recommendationDTO) {
        Long id = aiRecipeRecommendationService.addRecommendation(recommendationDTO);
        return Result.success(id);
    }

    /**
     * 修改AI食谱推荐记录
     */
    @PutMapping
    @PreAuthorize("hasRole('ADMIN')")
    public Result<String> updateRecommendation(@Valid @RequestBody AiRecipeRecommendationDTO recommendationDTO) {
        aiRecipeRecommendationService.updateRecommendation(recommendationDTO);
        return Result.success("修改成功");
    }

    /**
     * 删除AI食谱推荐记录
     */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<String> deleteRecommendation(@PathVariable Long id) {
        aiRecipeRecommendationService.deleteRecommendation(id);
        return Result.success("删除成功");
    }

    /**
     * 采纳AI推荐食谱
     */
    @PostMapping("/adopt/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<String> adoptRecommendation(@PathVariable Long id, 
                                             @RequestBody AdoptRequest request) {
        aiRecipeRecommendationService.adoptRecommendation(id, request.getAdoptRemark());
        return Result.success("采纳成功");
    }

    /**
     * 拒绝AI推荐食谱
     */
    @PostMapping("/reject/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<String> rejectRecommendation(@PathVariable Long id, 
                                              @RequestBody RejectRequest request) {
        aiRecipeRecommendationService.rejectRecommendation(id, request.getRejectRemark());
        return Result.success("拒绝成功");
    }

    /**
     * 获取用户的推荐历史
     */
    @GetMapping("/history/{userId}")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<List<AiRecipeRecommendationDTO>> getUserRecommendationHistory(@PathVariable Long userId) {
        List<AiRecipeRecommendationDTO> history = aiRecipeRecommendationService.getUserRecommendationHistory(userId);
        return Result.success(history);
    }

    /**
     * 调用AI服务获取食谱推荐
     */
    @PostMapping("/get-recommendation")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<String> getAiRecommendation(@RequestBody AiRecommendationRequest request) {
        String recommendation = aiRecipeRecommendationService.getAiRecommendation(
                request.getUserInput(), request.getDietaryRequirements());
        return Result.success(recommendation);
    }

    /**
     * 保存AI对话记录
     */
    @PostMapping("/save-conversation")
    @PreAuthorize("hasRole('ADMIN')")
    public Result<Long> saveAiConversation(@RequestBody SaveConversationRequest request) {
        Long id = aiRecipeRecommendationService.saveAiConversation(
                request.getUserInput(), 
                request.getAiResponse(), 
                request.getDietaryRequirements(), 
                request.getUserId());
        return Result.success(id);
    }

    /**
     * 采纳请求DTO
     */
    public static class AdoptRequest {
        private String adoptRemark;

        public String getAdoptRemark() {
            return adoptRemark;
        }

        public void setAdoptRemark(String adoptRemark) {
            this.adoptRemark = adoptRemark;
        }
    }

    /**
     * 拒绝请求DTO
     */
    public static class RejectRequest {
        private String rejectRemark;

        public String getRejectRemark() {
            return rejectRemark;
        }

        public void setRejectRemark(String rejectRemark) {
            this.rejectRemark = rejectRemark;
        }
    }

    /**
     * AI推荐请求DTO
     */
    public static class AiRecommendationRequest {
        private String userInput;
        private String dietaryRequirements;

        public String getUserInput() {
            return userInput;
        }

        public void setUserInput(String userInput) {
            this.userInput = userInput;
        }

        public String getDietaryRequirements() {
            return dietaryRequirements;
        }

        public void setDietaryRequirements(String dietaryRequirements) {
            this.dietaryRequirements = dietaryRequirements;
        }
    }

    /**
     * 保存对话请求DTO
     */
    public static class SaveConversationRequest {
        private String userInput;
        private String aiResponse;
        private String dietaryRequirements;
        private Long userId;

        public String getUserInput() {
            return userInput;
        }

        public void setUserInput(String userInput) {
            this.userInput = userInput;
        }

        public String getAiResponse() {
            return aiResponse;
        }

        public void setAiResponse(String aiResponse) {
            this.aiResponse = aiResponse;
        }

        public String getDietaryRequirements() {
            return dietaryRequirements;
        }

        public void setDietaryRequirements(String dietaryRequirements) {
            this.dietaryRequirements = dietaryRequirements;
        }

        public Long getUserId() {
            return userId;
        }

        public void setUserId(Long userId) {
            this.userId = userId;
        }
    }
}
