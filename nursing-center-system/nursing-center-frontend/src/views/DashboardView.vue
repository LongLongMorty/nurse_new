<template>
  <div class="dashboard">
    <!-- 页面头部 -->
    <el-card class="header-card" shadow="never">
      <div class="header-content">
        <div class="welcome-section">
          <h1>护理中心数据总览</h1>
          <p class="welcome-text">欢迎回来，{{ userStore.userInfo?.realName || '管理员' }}</p>
          <p class="date-time">{{ currentDateTime }}</p>
        </div>
        <div class="quick-stats">
          <div class="stat-item">
            <el-icon class="stat-icon" color="#409EFF"><User /></el-icon>
            <div class="stat-content">
              <div class="stat-value">{{ overviewStats.totalCustomers }}</div>
              <div class="stat-label">在住客户</div>
            </div>
          </div>
          <div class="stat-item">
            <el-icon class="stat-icon" color="#67C23A"><House /></el-icon>
            <div class="stat-content">
              <div class="stat-value">{{ overviewStats.occupancyRate }}%</div>
              <div class="stat-label">床位占用率</div>
            </div>
          </div>          <div class="stat-item">
            <el-icon class="stat-icon" color="#E6A23C"><Service /></el-icon>
            <div class="stat-content">
              <div class="stat-value">{{ overviewStats.activeServices }}</div>
              <div class="stat-label">活跃服务</div>
            </div>
          </div>
        </div>
      </div>
    </el-card>

    <div class="dashboard-grid">
      <!-- 客户统计卡片 -->
      <el-card class="chart-card" shadow="always">
        <template #header>
          <div class="card-header">
            <el-icon><PieChart /></el-icon>
            <span>客户年龄分布</span>
            <el-button type="text" @click="refreshChartData">
              <el-icon><Refresh /></el-icon>
            </el-button>
          </div>
        </template>
        <div ref="ageDistributionChart" class="chart-container"></div>
      </el-card>      <!-- 楼层入住情况 -->
      <el-card class="chart-card" shadow="always">
        <template #header>
          <div class="card-header">
            <el-icon><DataBoard /></el-icon>
            <span>楼层入住情况</span>
          </div>
        </template>
        <div ref="bedUsageChart" class="chart-container"></div>
      </el-card>

      <!-- 护理服务统计 -->
      <el-card class="chart-card large-card" shadow="always">
        <template #header>
          <div class="card-header">
            <el-icon><TrendCharts /></el-icon>
            <span>护理服务趋势</span>
            <el-select v-model="serviceTimeRange" size="small" style="width: 120px">
              <el-option label="近7天" value="7days" />
              <el-option label="近30天" value="30days" />
              <el-option label="近3个月" value="3months" />
            </el-select>
          </div>
        </template>
        <div ref="serviceTrendChart" class="chart-container large-chart"></div>
      </el-card>

      <!-- 护理级别分布 -->
      <el-card class="chart-card" shadow="always">
        <template #header>
          <div class="card-header">
            <el-icon><Grid /></el-icon>
            <span>护理级别分布</span>
          </div>
        </template>
        <div ref="careLevelChart" class="chart-container"></div>
      </el-card>

      <!-- 健康管家工作量 -->
      <el-card class="chart-card" shadow="always">
        <template #header>
          <div class="card-header">
            <el-icon><UserFilled /></el-icon>
            <span>健康管家工作量</span>          </div>
        </template>
        <div ref="healthManagerChart" class="chart-container"></div>
      </el-card>

      <!-- 实时数据面板 -->
      <el-card class="chart-card info-card" shadow="always">
        <template #header>
          <div class="card-header">
            <el-icon><Monitor /></el-icon>
            <span>实时数据</span>
            <el-tag size="small" type="success">实时</el-tag>
          </div>
        </template>
        <div class="info-grid">
          <div class="info-item">
            <div class="info-label">今日新入住</div>
            <div class="info-value">{{ realTimeData.todayCheckin }}</div>
          </div>
          <div class="info-item">
            <div class="info-label">今日退住</div>
            <div class="info-value">{{ realTimeData.todayCheckout }}</div>
          </div>
          <div class="info-item">
            <div class="info-label">待处理申请</div>
            <div class="info-value">{{ realTimeData.pendingApplications }}</div>
          </div>
          <div class="info-item">
            <div class="info-label">预警提醒</div>
            <div class="info-value alert">{{ realTimeData.alerts }}</div>
          </div>
          <div class="info-item">
            <div class="info-label">今日服务次数</div>
            <div class="info-value">{{ realTimeData.todayServices }}</div>
          </div>
          <div class="info-item">
            <div class="info-label">在线健康管家</div>
            <div class="info-value">{{ realTimeData.onlineManagers }}</div>
          </div>
        </div>
      </el-card>    </div>

    <!-- 预警弹窗 -->
    <el-dialog
      title="系统预警"
      v-model="alertDialogVisible"
      width="600px">
      <el-table :data="alertList" style="width: 100%">
        <el-table-column prop="type" label="类型" width="100">
          <template #default="{ row }">
            <el-tag :type="getAlertType(row.type)" size="small">
              {{ row.type }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="message" label="预警信息" />
        <el-table-column prop="time" label="时间" width="150" />
      </el-table>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, onUnmounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'
import { ElMessage } from 'element-plus'
import {
  User, House, Service, PieChart, DataBoard, TrendCharts,
  Grid, UserFilled, Monitor, Bell, Refresh
} from '@element-plus/icons-vue'
import * as echarts from 'echarts'
import { dashboardApi } from '@/api/dashboard'

const router = useRouter()
const userStore = useUserStore()

// 响应式数据
const serviceTimeRange = ref('30days')
const alertDialogVisible = ref(false)
const currentDateTime = ref('')

// 图表实例
const chartInstances = reactive({
  ageDistribution: null as echarts.ECharts | null,
  bedUsage: null as echarts.ECharts | null,
  serviceTrend: null as echarts.ECharts | null,
  careLevel: null as echarts.ECharts | null,
  healthManager: null as echarts.ECharts | null
})

// 图表容器引用
const ageDistributionChart = ref<HTMLElement>()
const bedUsageChart = ref<HTMLElement>()
const serviceTrendChart = ref<HTMLElement>()
const careLevelChart = ref<HTMLElement>()
const healthManagerChart = ref<HTMLElement>()

// 概览统计数据
const overviewStats = reactive({
  totalCustomers: 0,
  occupancyRate: 0,
  activeServices: 0
})

// 实时数据
const realTimeData = reactive({
  todayCheckin: 0,
  todayCheckout: 0,
  pendingApplications: 0,
  alerts: 0,
  todayServices: 0,
  onlineManagers: 0
})

// 预警列表
const alertList = ref([
  { type: '床位预警', message: '3号楼床位使用率超过95%', time: '10:30' },
  { type: '服务到期', message: '5位客户护理服务即将到期', time: '09:15' },
  { type: '欠费提醒', message: '2位客户存在欠费情况', time: '08:45' }
])

// 时间更新
const updateDateTime = () => {
  const now = new Date()
  currentDateTime.value = now.toLocaleString('zh-CN', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    weekday: 'long'
  })
}

// 定时器
let timeTimer: number | null = null

// 显示预警
const showAlerts = () => {
  alertDialogVisible.value = true
}

// 获取预警类型
const getAlertType = (type: string) => {
  const typeMap: Record<string, string> = {
    '床位预警': 'warning',
    '服务到期': 'danger',
    '欠费提醒': 'danger'
  }
  return typeMap[type] || 'info'
}

// 刷新图表数据
const refreshChartData = () => {
  ElMessage.success('数据已刷新')
  loadChartData()
}

// 刷新所有数据
const refreshAllData = () => {
  ElMessage.success('正在刷新所有数据...')
  loadOverviewStats()
  loadRealTimeData()
  loadChartData()
}

// 加载概览统计数据
const loadOverviewStats = async () => {
  try {
    const stats = await dashboardApi.getStats()
    overviewStats.totalCustomers = stats.totalCustomers
    overviewStats.occupancyRate = Math.round((stats.occupiedBeds / stats.totalBeds) * 100)
    overviewStats.activeServices = stats.totalCustomers * 2 // 假设每个客户平均2个服务
  } catch (error) {
    console.error('加载概览数据失败:', error)
    ElMessage.error('加载概览数据失败')
  }
}

// 加载实时数据
const loadRealTimeData = async () => {
  try {
    const stats = await dashboardApi.getStats()
    realTimeData.todayCheckin = stats.todayCheckIns
    realTimeData.todayCheckout = stats.todayCheckOuts
    realTimeData.pendingApplications = stats.pendingApplies
    realTimeData.alerts = 3 // 模拟预警数量
    realTimeData.todayServices = stats.totalCustomers // 假设每个客户今日都有服务
    realTimeData.onlineManagers = 8 // 模拟在线健康管家数量
  } catch (error) {
    console.error('加载实时数据失败:', error)
    ElMessage.error('加载实时数据失败')
  }
}

// 初始化图表
const initCharts = () => {
  // 客户年龄分布图
  if (ageDistributionChart.value) {
    chartInstances.ageDistribution = echarts.init(ageDistributionChart.value)
  }

  // 床位使用情况图
  if (bedUsageChart.value) {
    chartInstances.bedUsage = echarts.init(bedUsageChart.value)
  }

  // 护理服务趋势图
  if (serviceTrendChart.value) {
    chartInstances.serviceTrend = echarts.init(serviceTrendChart.value)
  }

  // 护理级别分布图
  if (careLevelChart.value) {
    chartInstances.careLevel = echarts.init(careLevelChart.value)
  }
  // 健康管家工作量图
  if (healthManagerChart.value) {
    chartInstances.healthManager = echarts.init(healthManagerChart.value)
  }
}

// 加载图表数据
const loadChartData = async () => {
  try {
    // 客户年龄分布 - 使用真实数据
    const ageDistribution = await dashboardApi.getAgeDistribution()
    const ageData = ageDistribution.map(item => ({
      value: item.count,
      name: item.ageGroup
    }))
    
    chartInstances.ageDistribution?.setOption({
      title: { text: '', left: 'center' },
      tooltip: { trigger: 'item' },
      series: [{
        type: 'pie',
        radius: ['40%', '70%'],
        avoidLabelOverlap: false,
        itemStyle: { borderRadius: 10, borderColor: '#fff', borderWidth: 2 },
        label: { show: false, position: 'center' },
        emphasis: { label: { show: true, fontSize: 20, fontWeight: 'bold' } },
        labelLine: { show: false },
        data: ageData.map((item, index) => ({
          ...item,
          itemStyle: { 
            color: ['#5470C6', '#91CC75', '#FAC858', '#EE6666'][index] || '#5470C6'
          }
        }))
      }]
    })

    // 护理级别分布 - 使用真实数据
    const careLevelDistribution = await dashboardApi.getCareLevelDistribution()
    const careLevelData = careLevelDistribution.map(item => ({
      value: item.count,
      name: item.levelName,
      itemStyle: { color: item.color || '#5470C6' }
    }))

    chartInstances.careLevel?.setOption({
      tooltip: { trigger: 'item' },
      series: [{
        type: 'pie',
        radius: '70%',
        data: careLevelData,
        emphasis: { itemStyle: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)' } }
      }]
    })    // 楼层入住情况 - 使用真实数据
    const floorStats = await dashboardApi.getFloorOccupancyStats()
    const floorNames = floorStats.map(item => item.floorName)
    const occupancyRates = floorStats.map(item => item.occupancyRate)
    
    chartInstances.bedUsage?.setOption({
      tooltip: { 
        trigger: 'axis',
        formatter: function(params: any) {
          const index = params[0].dataIndex
          const floorData = floorStats[index]
          return `${floorData.floorName}<br/>
                  占用率: ${floorData.occupancyRate}%<br/>
                  总床位: ${floorData.totalBeds}<br/>
                  已占用: ${floorData.occupiedBeds}<br/>
                  可用: ${floorData.availableBeds}`
        }
      },
      xAxis: { type: 'category', data: floorNames },
      yAxis: { type: 'value', max: 100, name: '占用率(%)' },
      series: [{
        data: occupancyRates,
        type: 'bar',
        itemStyle: { color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
          { offset: 0, color: '#83bff6' },
          { offset: 0.5, color: '#188df0' },
          { offset: 1, color: '#188df0' }
        ]) },
        barWidth: '60%'
      }]
    })

    // 护理服务趋势 - 使用模拟数据
    chartInstances.serviceTrend?.setOption({
      tooltip: { trigger: 'axis' },
      legend: { data: ['基础护理', '专业护理', '生活护理'] },
      xAxis: { type: 'category', data: ['1月', '2月', '3月', '4月', '5月', '6月'] },
      yAxis: { type: 'value' },
      series: [
        {
          name: '基础护理',
          type: 'line',
          data: [120, 132, 101, 134, 90, 230],
          smooth: true,
          itemStyle: { color: '#5470C6' }
        },
        {
          name: '专业护理',
          type: 'line',
          data: [220, 182, 191, 234, 290, 330],
          smooth: true,
          itemStyle: { color: '#91CC75' }
        },
        {
          name: '生活护理',
          type: 'line',
          data: [150, 232, 201, 154, 190, 330],
          smooth: true,
          itemStyle: { color: '#FAC858' }
        }
      ]
    })

    // 健康管家工作量 - 使用模拟数据
    chartInstances.healthManager?.setOption({
      tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
      xAxis: { type: 'value', boundaryGap: [0, 0.01] },
      yAxis: {
        type: 'category',
        data: ['张护士', '李护士', '王护士', '赵护士', '陈护士']
      },
      series: [{
        type: 'bar',
        data: [18, 23, 20, 15, 25],        itemStyle: { color: new echarts.graphic.LinearGradient(1, 0, 0, 0, [
          { offset: 0, color: '#ffecd2' },
          { offset: 1, color: '#fcb69f' }
        ]) }
      }]
    })
  } catch (error) {
    console.error('加载图表数据失败:', error)
    ElMessage.error('加载图表数据失败')
  }
}

// 窗口大小变化时重新调整图表
const handleResize = () => {
  Object.values(chartInstances).forEach(chart => {
    if (chart) {
      chart.resize()
    }
  })
}

// 组件挂载
onMounted(() => {
  updateDateTime()
  timeTimer = setInterval(updateDateTime, 60000) // 每分钟更新时间

  // 延迟初始化图表，确保DOM已渲染
  setTimeout(() => {
    initCharts()
    loadOverviewStats()
    loadRealTimeData()
    loadChartData()
  }, 100)

  window.addEventListener('resize', handleResize)
})

// 组件卸载
onUnmounted(() => {
  if (timeTimer) {
    clearInterval(timeTimer)
  }

  // 销毁图表实例
  Object.values(chartInstances).forEach(chart => {
    if (chart) {
      chart.dispose()
    }
  })
  window.removeEventListener('resize', handleResize)
})

// 监听时间范围变化
const serviceTimeRangeChange = () => {
  loadChartData()
}
</script>

<style scoped>
.dashboard {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  min-height: 100vh;
  padding: 20px;
}

.header-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  margin-bottom: 20px;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.welcome-section h1 {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 28px;
  font-weight: 600;
}

.welcome-text {
  margin: 0 0 5px 0;
  color: #666;
  font-size: 16px;
}

.date-time {
  margin: 0;
  color: #999;
  font-size: 14px;
}

.quick-stats {
  display: flex;
  gap: 30px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 15px;
  padding: 15px;
  background: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.stat-icon {
  font-size: 32px;
}

.stat-value {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  line-height: 1;
}

.stat-label {
  font-size: 12px;
  color: #666;
  margin-top: 2px;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 20px;
  grid-auto-rows: min-content;
}

.chart-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
}

.large-card {
  grid-column: span 2;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 10px;
  font-weight: 600;
  color: #333;
}

.chart-container {
  height: 300px;
  width: 100%;
}

.large-chart {
  height: 400px;
}

.info-card .el-card__body {
  padding: 20px;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}

.info-item {
  text-align: center;
  padding: 15px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  border-radius: 8px;
}

.info-label {
  font-size: 12px;
  color: #666;
  margin-bottom: 8px;
}

.info-value {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.info-value.alert {
  color: #f56c6c;
}

.action-card .el-card__body {
  padding: 20px;
}

.action-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px;
}

.action-grid .el-button {
  width: 100%;
  height: 50px;
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }

  .quick-stats {
    flex-wrap: wrap;
    justify-content: center;
  }

  .dashboard-grid {
    grid-template-columns: 1fr;
  }

  .large-card {
    grid-column: span 1;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }
}

:deep(.el-card__header) {
  background: rgba(64, 158, 255, 0.05);
  border-bottom: 1px solid rgba(64, 158, 255, 0.1);
}

:deep(.el-dialog) {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
}
</style>
