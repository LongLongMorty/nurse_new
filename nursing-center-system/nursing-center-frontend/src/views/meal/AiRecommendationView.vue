<template>
  <div class="ai-recommendation-container">
    <el-card class="page-header">
      <h2 class="page-title">智能食谱推荐</h2>
      <p class="page-description">基于AI技术，为您推荐营养均衡的膳食配方</p>
    </el-card>

    <!-- 搜索和筛选区域 -->
    <el-card class="search-card">
      <el-form :model="searchForm" :inline="true" label-width="80px">
        <el-form-item label="菜品类型">
          <el-select v-model="searchForm.dishType" placeholder="请选择菜品类型" clearable>
            <el-option label="早餐" value="BREAKFAST" />
            <el-option label="午餐" value="LUNCH" />
            <el-option label="晚餐" value="DINNER" />
            <el-option label="加餐" value="SNACK" />
          </el-select>
        </el-form-item>
        <el-form-item label="营养要求">
          <el-select v-model="searchForm.nutritionType" placeholder="请选择营养类型" clearable>
            <el-option label="高蛋白" value="HIGH_PROTEIN" />
            <el-option label="低盐" value="LOW_SALT" />
            <el-option label="低糖" value="LOW_SUGAR" />
            <el-option label="低脂" value="LOW_FAT" />
            <el-option label="高纤维" value="HIGH_FIBER" />
          </el-select>
        </el-form-item>
        <el-form-item label="适用人群">
          <el-select v-model="searchForm.targetGroup" placeholder="请选择适用人群" clearable>
            <el-option label="糖尿病" value="DIABETES" />
            <el-option label="高血压" value="HYPERTENSION" />
            <el-option label="心脏病" value="HEART_DISEASE" />
            <el-option label="肾病" value="KIDNEY_DISEASE" />
            <el-option label="一般老人" value="GENERAL" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="search">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
          <el-button type="success" @click="generateRecommendation">
            <el-icon><MagicStick /></el-icon>
            生成推荐
          </el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 推荐列表 -->
    <el-card class="table-card">
      <template #header>
        <div class="card-header">
          <span>推荐列表</span>
          <div class="header-actions">
            <el-button 
              type="primary" 
              :disabled="selectedIds.length === 0"
              @click="batchAdopt"
            >
              批量采纳 ({{ selectedIds.length }})
            </el-button>
            <el-button 
              type="danger" 
              :disabled="selectedIds.length === 0"
              @click="batchReject"
            >
              批量拒绝
            </el-button>
          </div>
        </div>
      </template>

      <el-table 
        :data="tableData" 
        v-loading="loading"
        @selection-change="handleSelectionChange"
        style="width: 100%"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="dishName" label="菜品名称" min-width="120" />
        <el-table-column prop="dishType" label="类型" width="80">
          <template #default="{ row }">
            <el-tag :type="getDishTypeTag(row.dishType)">
              {{ getDishTypeText(row.dishType) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="ingredients" label="主要食材" min-width="200" show-overflow-tooltip />
        <el-table-column prop="nutritionInfo" label="营养信息" min-width="150">
          <template #default="{ row }">
            <div class="nutrition-info">
              <div>热量: {{ row.calories }}kcal</div>
              <div>蛋白质: {{ row.protein }}g</div>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="targetGroup" label="适用人群" width="100">
          <template #default="{ row }">
            <el-tag size="small" :type="getTargetGroupTag(row.targetGroup)">
              {{ getTargetGroupText(row.targetGroup) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="aiScore" label="AI评分" width="80">
          <template #default="{ row }">
            <el-rate 
              v-model="row.aiScore" 
              :max="5" 
              :allow-half="true"
              disabled
              show-score
              text-color="#ff9900"
            />
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="80">
          <template #default="{ row }">
            <el-tag :type="getStatusTag(row.status)">
              {{ getStatusText(row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="推荐时间" width="180" />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button 
              type="primary" 
              size="small" 
              @click="viewDetail(row)"
            >
              详情
            </el-button>
            <el-button 
              v-if="row.status === 'PENDING'"
              type="success" 
              size="small" 
              @click="adoptRecommendation(row)"
            >
              采纳
            </el-button>
            <el-button 
              v-if="row.status === 'PENDING'"
              type="danger" 
              size="small" 
              @click="rejectRecommendation(row)"
            >
              拒绝
            </el-button>
            <el-button 
              type="info" 
              size="small" 
              @click="provideFeedback(row)"
            >
              反馈
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-container">
        <el-pagination
          v-model:current-page="pagination.page"
          v-model:page-size="pagination.size"
          :total="pagination.total"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <!-- 详情弹窗 -->
    <el-dialog v-model="detailDialogVisible" title="食谱详情" width="800px">
      <div v-if="currentDetail" class="detail-content">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="菜品名称">{{ currentDetail.dishName }}</el-descriptions-item>
          <el-descriptions-item label="菜品类型">{{ getDishTypeText(currentDetail.dishType) }}</el-descriptions-item>
          <el-descriptions-item label="热量">{{ currentDetail.calories }} kcal</el-descriptions-item>
          <el-descriptions-item label="蛋白质">{{ currentDetail.protein }} g</el-descriptions-item>
          <el-descriptions-item label="脂肪">{{ currentDetail.fat }} g</el-descriptions-item>
          <el-descriptions-item label="碳水化合物">{{ currentDetail.carbohydrate }} g</el-descriptions-item>
          <el-descriptions-item label="适用人群" :span="2">{{ getTargetGroupText(currentDetail.targetGroup) }}</el-descriptions-item>
        </el-descriptions>

        <el-divider>制作方法</el-divider>
        <div class="cooking-method">
          <p>{{ currentDetail.cookingMethod || '暂无制作方法' }}</p>
        </div>

        <el-divider>营养分析</el-divider>
        <div class="nutrition-analysis">
          <p>{{ currentDetail.nutritionAnalysis || '暂无营养分析' }}</p>
        </div>

        <el-divider>AI推荐理由</el-divider>
        <div class="ai-reason">
          <p>{{ currentDetail.aiReason || '暂无推荐理由' }}</p>
        </div>
      </div>
    </el-dialog>

    <!-- 反馈弹窗 -->
    <el-dialog v-model="feedbackDialogVisible" title="提供反馈" width="600px">
      <el-form :model="feedbackForm" label-width="100px">
        <el-form-item label="反馈评分">
          <el-rate v-model="feedbackForm.rating" :max="5" show-text />
        </el-form-item>
        <el-form-item label="反馈内容">
          <el-input 
            v-model="feedbackForm.content"
            type="textarea"
            :rows="4"
            placeholder="请输入您的反馈意见..."
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="feedbackDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitFeedback">提交反馈</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { MagicStick } from '@element-plus/icons-vue'

// 响应式数据
const loading = ref(false)
const tableData = ref<any[]>([])
const selectedIds = ref<number[]>([])
const detailDialogVisible = ref(false)
const feedbackDialogVisible = ref(false)
const currentDetail = ref<any>(null)

// 搜索表单
const searchForm = reactive({
  dishType: '',
  nutritionType: '',
  targetGroup: ''
})

// 分页数据
const pagination = reactive({
  page: 1,
  size: 20,
  total: 0
})

// 反馈表单
const feedbackForm = reactive({
  rating: 0,
  content: ''
})

// 获取推荐列表
const getRecommendationList = async () => {
  loading.value = true
  try {
    // TODO: 调用API获取数据
    // const response = await aiRecommendationApi.getList({
    //   ...searchForm,
    //   page: pagination.page,
    //   size: pagination.size
    // })
    
    // 模拟数据
    const mockData = [
      {
        id: 1,
        dishName: '清蒸鲈鱼',
        dishType: 'LUNCH',
        ingredients: '鲈鱼、生抽、葱、姜',
        calories: 120,
        protein: 22,
        fat: 3,
        carbohydrate: 0,
        targetGroup: 'GENERAL',
        aiScore: 4.5,
        status: 'PENDING',
        createTime: '2024-01-15 10:30:00',
        cookingMethod: '1. 鲈鱼洗净，划刀；2. 放入蒸锅蒸10分钟；3. 淋上蒸鱼豉油，撒葱丝即可。',
        nutritionAnalysis: '富含优质蛋白质，脂肪含量低，适合老年人食用。',
        aiReason: '根据老年人营养需求，推荐高蛋白低脂的鱼类食品，有利于维持肌肉质量。'
      },
      {
        id: 2,
        dishName: '银耳莲子汤',
        dishType: 'SNACK',
        ingredients: '银耳、莲子、冰糖',
        calories: 80,
        protein: 2,
        fat: 0.5,
        carbohydrate: 18,
        targetGroup: 'DIABETES',
        aiScore: 4.0,
        status: 'ADOPTED',
        createTime: '2024-01-15 09:15:00',
        cookingMethod: '1. 银耳泡发撕小朵；2. 莲子去芯；3. 文火炖煮1小时即可。',
        nutritionAnalysis: '含有丰富的胶原蛋白和膳食纤维，有助于血糖控制。',
        aiReason: '针对糖尿病患者，推荐低糖高纤维的食品，有助于血糖稳定。'
      }
    ]
    
    tableData.value = mockData
    pagination.total = mockData.length
  } catch (error) {
    ElMessage.error('获取推荐列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索
const search = () => {
  pagination.page = 1
  getRecommendationList()
}

// 重置搜索
const resetSearch = () => {
  Object.assign(searchForm, {
    dishType: '',
    nutritionType: '',
    targetGroup: ''
  })
  search()
}

// 生成新推荐
const generateRecommendation = async () => {
  loading.value = true
  try {
    // TODO: 调用AI推荐生成API
    ElMessage.success('正在生成AI推荐，请稍候...')
    setTimeout(() => {
      getRecommendationList()
    }, 2000)
  } catch (error) {
    ElMessage.error('生成推荐失败')
    loading.value = false
  }
}

// 选择变化
const handleSelectionChange = (selection: any[]) => {
  selectedIds.value = selection.map(item => item.id)
}

// 批量采纳
const batchAdopt = async () => {
  try {
    await ElMessageBox.confirm(`确认采纳选中的 ${selectedIds.value.length} 个推荐吗？`, '提示')
    // TODO: 调用批量采纳API
    ElMessage.success('批量采纳成功')
    getRecommendationList()
  } catch {
    // 用户取消
  }
}

// 批量拒绝
const batchReject = async () => {
  try {
    await ElMessageBox.confirm(`确认拒绝选中的 ${selectedIds.value.length} 个推荐吗？`, '提示')
    // TODO: 调用批量拒绝API
    ElMessage.success('批量拒绝成功')
    getRecommendationList()
  } catch {
    // 用户取消
  }
}

// 查看详情
const viewDetail = (row: any) => {
  currentDetail.value = row
  detailDialogVisible.value = true
}

// 采纳推荐
const adoptRecommendation = async (row: any) => {
  try {
    await ElMessageBox.confirm('确认采纳此推荐吗？', '提示')
    // TODO: 调用采纳API
    ElMessage.success('采纳成功')
    getRecommendationList()
  } catch {
    // 用户取消
  }
}

// 拒绝推荐
const rejectRecommendation = async (row: any) => {
  try {
    await ElMessageBox.confirm('确认拒绝此推荐吗？', '提示')
    // TODO: 调用拒绝API
    ElMessage.success('拒绝成功')
    getRecommendationList()
  } catch {
    // 用户取消
  }
}

// 提供反馈
const provideFeedback = (row: any) => {
  currentDetail.value = row
  feedbackForm.rating = 0
  feedbackForm.content = ''
  feedbackDialogVisible.value = true
}

// 提交反馈
const submitFeedback = async () => {
  if (feedbackForm.rating === 0) {
    ElMessage.warning('请先进行评分')
    return
  }
  
  try {
    // TODO: 调用提交反馈API
    ElMessage.success('反馈提交成功')
    feedbackDialogVisible.value = false
  } catch (error) {
    ElMessage.error('反馈提交失败')
  }
}

// 分页处理
const handleSizeChange = (size: number) => {
  pagination.size = size
  pagination.page = 1
  getRecommendationList()
}

const handleCurrentChange = (page: number) => {
  pagination.page = page
  getRecommendationList()
}

// 辅助方法
const getDishTypeText = (type: string) => {
  const map: Record<string, string> = {
    BREAKFAST: '早餐',
    LUNCH: '午餐',
    DINNER: '晚餐',
    SNACK: '加餐'
  }
  return map[type] || type
}

const getDishTypeTag = (type: string) => {
  const map: Record<string, string> = {
    BREAKFAST: 'warning',
    LUNCH: 'success',
    DINNER: 'info',
    SNACK: 'primary'
  }
  return map[type] || ''
}

const getTargetGroupText = (group: string) => {
  const map: Record<string, string> = {
    DIABETES: '糖尿病',
    HYPERTENSION: '高血压',
    HEART_DISEASE: '心脏病',
    KIDNEY_DISEASE: '肾病',
    GENERAL: '一般老人'
  }
  return map[group] || group
}

const getTargetGroupTag = (group: string) => {
  const map: Record<string, string> = {
    DIABETES: 'warning',
    HYPERTENSION: 'danger',
    HEART_DISEASE: 'danger',
    KIDNEY_DISEASE: 'warning',
    GENERAL: 'success'
  }
  return map[group] || ''
}

const getStatusText = (status: string) => {
  const map: Record<string, string> = {
    PENDING: '待处理',
    ADOPTED: '已采纳',
    REJECTED: '已拒绝'
  }
  return map[status] || status
}

const getStatusTag = (status: string) => {
  const map: Record<string, string> = {
    PENDING: 'warning',
    ADOPTED: 'success',
    REJECTED: 'danger'
  }
  return map[status] || ''
}

// 初始化
onMounted(() => {
  getRecommendationList()
})
</script>

<style scoped>
.ai-recommendation-container {
  padding: 20px;
}

.page-header {
  margin-bottom: 20px;
}

.page-title {
  margin: 0 0 10px 0;
  color: #303133;
  font-size: 24px;
  font-weight: 600;
}

.page-description {
  margin: 0;
  color: #909399;
  font-size: 14px;
}

.search-card {
  margin-bottom: 20px;
}

.table-card .card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-actions {
  display: flex;
  gap: 10px;
}

.nutrition-info {
  font-size: 12px;
  line-height: 1.4;
}

.pagination-container {
  margin-top: 20px;
  text-align: right;
}

.detail-content {
  max-height: 60vh;
  overflow-y: auto;
}

.cooking-method,
.nutrition-analysis,
.ai-reason {
  padding: 10px;
  background-color: #f8f9fa;
  border-radius: 4px;
  line-height: 1.6;
}
</style>
