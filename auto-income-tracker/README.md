# Auto Income Tracker - 自动收入追踪器

一个为OpenClaw用户设计的自动收入追踪和管理工具。

## 功能特点

### 📊 收入追踪
- 自动记录多种收入来源
- 支持GitHub Sponsors、ClawHub销售、Fiverr等平台
- 实时收入统计和图表展示

### 💰 支出管理
- 记录token购买支出
- 分类管理各项开支
- 预算控制和提醒

### 📈 数据分析
- 收入趋势分析
- 平台收入对比
- 预测未来收入

### 🔔 智能提醒
- 收入目标提醒
- 支出超支提醒
- token余额提醒

### 📱 多平台支持
- GitHub Sponsors API集成
- ClawHub销售数据同步
- Fiverr订单追踪

## 安装

```bash
clawhub install auto-income-tracker
```

## 使用方法

### 基本命令
```bash
# 添加收入记录
income add --source github --amount 50 --description "GitHub Sponsors"

# 添加支出记录
income add-expense --category token --amount 20 --description "购买token"

# 查看收入报表
income report

# 查看月度统计
income report --month

# 设置收入目标
income set-goal --monthly 500
```

### 自动同步
```bash
# 设置GitHub Sponsors自动同步
income setup-github --token YOUR_GITHUB_TOKEN

# 设置ClawHub自动同步
income setup-clawhub

# 设置定时同步
income setup-cron
```

## 配置文件

创建 `~/.income-tracker/config.yaml`：

```yaml
# 收入目标
goals:
  monthly: 500
  yearly: 6000

# 收入来源
sources:
  github:
    enabled: true
    token: ${GITHUB_TOKEN}
  clawhub:
    enabled: true
  fiverr:
    enabled: false

# 提醒设置
notifications:
  daily_summary: true
  goal_progress: true
  low_balance: true
  threshold: 1000000  # token余额低于100万时提醒
```

## 收入报表示例

```
📊 收入报表 - 2026年4月

收入来源：
├── GitHub Sponsors: $150.00 (30%)
├── ClawHub销售: $250.00 (50%)
└── Fiverr服务: $100.00 (20%)

📈 月度趋势：
├── 4月目标: $500.00
├── 当前收入: $500.00
└── 完成度: 100% ✅

💰 支出情况：
├── Token购买: $200.00
├── 服务器费用: $50.00
└── 其他: $30.00

💹 净收入: $220.00
🪙 Token余额: 1,200,000
```

## 集成到OpenClaw

### 作为技能使用
```yaml
# 在SKILL.md中添加
triggers:
  - income
  - 收入
  - 赚钱
  - 财务
```

### 定时任务
```bash
# 每天上午9点生成日报
0 9 * * * income report --daily

# 每周一生成周报
0 9 * * 1 income report --weekly
```

## 价格
- 基础版：免费（收入追踪基本功能）
- 专业版：$5（自动同步、多平台支持、高级报表）

## 支持
- 文档：https://github.com/erdog-ai/auto-income-tracker
- 问题反馈：GitHub Issues
- 赞助：GitHub Sponsors

## 许可证
MIT License