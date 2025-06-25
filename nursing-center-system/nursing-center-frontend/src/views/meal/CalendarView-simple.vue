<template>
  <div class="meal-calendar-page">
    <!-- 页面头部 -->
    <div class="page-header">
      <h1>膳食日历</h1>
      <p>查看和编辑周菜单安排（周一到周日，每天四餐）</p>
    </div>

    <!-- 周菜单选择 -->
    <div class="toolbar">
      <el-select
        v-model="selectedWeekName"
        placeholder="选择周菜单"
        @change="loadWeekMenu"
        style="width: 200px; margin-right: 10px;"
      >
        <el-option
          v-for="weekName in weekNames"
          :key="weekName"
          :label="weekName"
          :value="weekName"
        />
      </el-select>
      
      <el-button type="primary" @click="loadWeekMenu">
        <el-icon><Refresh /></el-icon>
        刷新
      </el-button>
    </div>

    <!-- 七天菜单表格 -->
    <div class="week-menu-table" v-if="weekMenuData.length > 0">
      <el-table 
        :data="weekMenuData" 
        border 
        style="width: 100%"
        :header-cell-style="{ background: '#f5f7fa', color: '#606266' }"
      >
        <el-table-column prop="dayName" label="星期" width="100" align="center" />
        
        <el-table-column label="早餐" width="200">
          <template #default="{ row }">
            <div class="meal-cell">
              <span>{{ row.breakfastName || '未设置' }}</span>
              <el-button 
                type="text" 
                size="small" 
                @click="editMeal(row, 'breakfast')"
              >
                编辑
              </el-button>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="午餐" width="200">
          <template #default="{ row }">
            <div class="meal-cell">
              <span>{{ row.lunchName || '未设置' }}</span>
              <el-button 
                type="text" 
                size="small" 
                @click="editMeal(row, 'lunch')"
              >
                编辑
              </el-button>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="晚餐" width="200">
          <template #default="{ row }">
            <div class="meal-cell">
              <span>{{ row.dinnerName || '未设置' }}</span>
              <el-button 
                type="text" 
                size="small" 
                @click="editMeal(row, 'dinner')"
              >
                编辑
              </el-button>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="加餐" width="200">
          <template #default="{ row }">
            <div class="meal-cell">
              <span>{{ row.snackName || '未设置' }}</span>
              <el-button 
                type="text" 
                size="small" 
                @click="editMeal(row, 'snack')"
              >
                编辑
              </el-button>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="备注" min-width="150">
          <template #default="{ row }">
            {{ row.specialNotes || '-' }}
          </template>
        </el-table-column>

        <el-table-column label="操作" width="120" align="center">
          <template #default="{ row }">
            <el-button 
              type="primary" 
              size="small" 
              @click="editDayMenu(row)"
            >
              编辑整天
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 空状态 -->
    <div v-else class="empty-state">
      <el-empty description="请选择周菜单查看内容" />
    </div>

    <!-- 编辑单餐对话框 -->
    <el-dialog
      v-model="showMealEditDialog"
      :title="`编辑${currentEditRow?.dayName} - ${getMealTypeName(currentMealType)}`"
      width="500px"
    >
      <el-form :model="mealEditForm" label-width="80px">
        <el-form-item label="选择菜品">
          <el-select
            v-model="mealEditForm.configId"
            placeholder="请选择菜品配置"
            style="width: 100%"
          >
            <el-option
              v-for="config in mealConfigs"
              :key="config.id"
              :label="config.mealName"
              :value="config.id"
            />
          </el-select>
        </el-form-item>
      </el-form>
      
      <template #footer>
        <el-button @click="showMealEditDialog = false">取消</el-button>
        <el-button type="primary" @click="saveMealEdit">保存</el-button>
      </template>
    </el-dialog>

    <!-- 编辑整天菜单对话框 -->
    <el-dialog
      v-model="showDayEditDialog"
      :title="`编辑${currentEditRow?.dayName}菜单`"
      width="600px"
    >
      <el-form :model="dayEditForm" label-width="80px">
        <el-form-item label="早餐">
          <el-select v-model="dayEditForm.breakfastConfigId" style="width: 100%">
            <el-option
              v-for="config in breakfastConfigs"
              :key="config.id"
              :label="config.mealName"
              :value="config.id"
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="午餐">
          <el-select v-model="dayEditForm.lunchConfigId" style="width: 100%">
            <el-option
              v-for="config in lunchConfigs"
              :key="config.id"
              :label="config.mealName"
              :value="config.id"
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="晚餐">
          <el-select v-model="dayEditForm.dinnerConfigId" style="width: 100%">
            <el-option
              v-for="config in dinnerConfigs"
              :key="config.id"
              :label="config.mealName"
              :value="config.id"
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="加餐">
          <el-select v-model="dayEditForm.snackConfigId" style="width: 100%">
            <el-option
              v-for="config in snackConfigs"
              :key="config.id"
              :label="config.mealName"
              :value="config.id"
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="备注">
          <el-input
            v-model="dayEditForm.specialNotes"
            type="textarea"
            rows="3"
            placeholder="请输入特殊说明"
          />
        </el-form-item>
      </el-form>
      
      <template #footer>
        <el-button @click="showDayEditDialog = false">取消</el-button>
        <el-button type="primary" @click="saveDayEdit">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Refresh, Plus, CopyDocument, Delete } from '@element-plus/icons-vue'
import { mealCalendarApi, mealConfigApi, type MealCalendar, type MealConfig } from '@/api/meal'

// 扩展 MealCalendar 类型
interface ExtendedMealCalendar extends MealCalendar {
  dayName?: string
}

// 响应式数据
const selectedWeekName = ref('第1周菜单')
const weekNames = ref(['第1周菜单', '第2周菜单', '第3周菜单', '第4周菜单'])
const weekMenuData = ref<ExtendedMealCalendar[]>([])
const mealConfigs = ref<MealConfig[]>([])

// 对话框状态
const showMealEditDialog = ref(false)
const showDayEditDialog = ref(false)

// 当前编辑的行和餐类型
const currentEditRow = ref<ExtendedMealCalendar | null>(null)
const currentMealType = ref<string>('')

// 编辑表单
const mealEditForm = reactive({
  configId: undefined as number | undefined
})

const dayEditForm = reactive({
  breakfastConfigId: undefined as number | undefined,
  lunchConfigId: undefined as number | undefined,
  dinnerConfigId: undefined as number | undefined,
  snackConfigId: undefined as number | undefined,
  specialNotes: ''
})

// 计算属性 - 按餐类型分组的配置
const breakfastConfigs = computed(() => 
  mealConfigs.value.filter(config => config.mealType === 'BREAKFAST')
)
const lunchConfigs = computed(() => 
  mealConfigs.value.filter(config => config.mealType === 'LUNCH')
)
const dinnerConfigs = computed(() => 
  mealConfigs.value.filter(config => config.mealType === 'DINNER')
)
const snackConfigs = computed(() => 
  mealConfigs.value.filter(config => config.mealType === 'SNACK')
)

// 星期名称映射
const dayNames = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日']

// 餐类型名称映射
const getMealTypeName = (mealType: string) => {
  const names: Record<string, string> = {
    breakfast: '早餐',
    lunch: '午餐',
    dinner: '晚餐',
    snack: '加餐'
  }
  return names[mealType] || mealType
}

// 加载周菜单数据
const loadWeekMenu = async () => {
  if (!selectedWeekName.value) return
  
  try {
    const response = await mealCalendarApi.getWeekMenu(selectedWeekName.value)
    if (response.data) {
      weekMenuData.value = response.data.map((item: MealCalendar) => ({
        ...item,
        dayName: dayNames[item.dayOfWeek || 1]
      }))
    }
  } catch (error) {
    console.error('加载周菜单失败:', error)
    ElMessage.error('加载周菜单失败')
  }
}

// 加载膳食配置
const loadMealConfigs = async () => {
  try {
    const response = await mealConfigApi.getList({ 
      page: 1, 
      size: 1000,
      status: 1 // 只获取启用的配置
    })
    if (response.data) {
      mealConfigs.value = response.data.records || []
    }
  } catch (error) {
    console.error('加载膳食配置失败:', error)
  }
}

// 编辑单餐
const editMeal = (row: ExtendedMealCalendar, mealType: string) => {
  currentEditRow.value = row
  currentMealType.value = mealType
  
  // 设置当前值
  const configIdField = `${mealType}ConfigId` as keyof MealCalendar
  mealEditForm.configId = row[configIdField] as number || undefined
  
  showMealEditDialog.value = true
}

// 保存单餐编辑
const saveMealEdit = async () => {
  if (!currentEditRow.value || !currentMealType.value) return
  
  try {
    const updateData: MealCalendar = {
      ...currentEditRow.value,
      [`${currentMealType.value}ConfigId`]: mealEditForm.configId
    }
    
    const response = await mealCalendarApi.updateDayMenu(updateData)
    if (response.data) {
      ElMessage.success('保存成功')
      showMealEditDialog.value = false
      loadWeekMenu() // 重新加载数据
    }
  } catch (error) {
    console.error('保存失败:', error)
    ElMessage.error('保存失败')
  }
}

// 编辑整天菜单
const editDayMenu = (row: ExtendedMealCalendar) => {
  currentEditRow.value = row
  
  // 设置表单值
  dayEditForm.breakfastConfigId = row.breakfastConfigId || undefined
  dayEditForm.lunchConfigId = row.lunchConfigId || undefined
  dayEditForm.dinnerConfigId = row.dinnerConfigId || undefined
  dayEditForm.snackConfigId = row.snackConfigId || undefined
  dayEditForm.specialNotes = row.specialNotes || ''
  
  showDayEditDialog.value = true
}

// 保存整天菜单编辑
const saveDayEdit = async () => {
  if (!currentEditRow.value) return
  
  try {
    const updateData: MealCalendar = {
      ...currentEditRow.value,
      breakfastConfigId: dayEditForm.breakfastConfigId,
      lunchConfigId: dayEditForm.lunchConfigId,
      dinnerConfigId: dayEditForm.dinnerConfigId,
      snackConfigId: dayEditForm.snackConfigId,
      specialNotes: dayEditForm.specialNotes
    }
    
    const response = await mealCalendarApi.updateDayMenu(updateData)
    if (response.data) {
      ElMessage.success('保存成功')
      showDayEditDialog.value = false
      loadWeekMenu() // 重新加载数据
    }
  } catch (error) {
    console.error('保存失败:', error)
    ElMessage.error('保存失败')
  }
}

// 页面初始化
onMounted(() => {
  loadMealConfigs()
  loadWeekMenu()
})
</script>

<style scoped>
.meal-calendar-page {
  padding: 20px;
}

.page-header {
  margin-bottom: 20px;
}

.page-header h1 {
  margin: 0 0 8px 0;
  font-size: 24px;
  color: #303133;
}

.page-header p {
  margin: 0;
  color: #606266;
  font-size: 14px;
}

.toolbar {
  margin-bottom: 20px;
  display: flex;
  align-items: center;
}

.week-menu-table {
  background: white;
  border-radius: 4px;
  overflow: hidden;
}

.meal-cell {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 4px 0;
}

.empty-state {
  text-align: center;
  padding: 60px 0;
}
</style>
