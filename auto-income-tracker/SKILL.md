---
name: auto-income-tracker
version: 1.0.0
description: Automatic income tracking and management tool for OpenClaw users. Track earnings from GitHub Sponsors, ClawHub sales, Fiverr, and other sources. Manage expenses, set goals, and generate financial reports.
author: Erdog AI
tags: [income, finance, tracking, money, earnings, budget, expense, report]
price: $5.00
category: productivity
---

# Auto Income Tracker

## 功能概述
自动收入追踪和管理工具，帮助OpenClaw用户追踪多种收入来源，管理支出，设置财务目标，生成详细报表。

## 核心功能

### 📊 收入追踪
- 支持多种收入平台：GitHub Sponsors, ClawHub, Fiverr, Upwork等
- 自动同步收入数据
- 手动添加其他收入来源

### 💰 支出管理
- Token购买记录
- 服务器费用追踪
- 分类支出管理
- 预算控制

### 📈 数据分析
- 实时收入统计
- 平台收入对比
- 收入趋势分析
- 预测模型

### 🔔 智能提醒
- 收入目标进度提醒
- 支出超支提醒
- Token余额不足提醒
- 日报/周报/月报

### 🔧 集成功能
- GitHub API集成
- ClawHub数据同步
- 多币种支持
- 数据导出（CSV/JSON）

## 使用场景

### 场景1：独立开发者
- 追踪GitHub Sponsors收入
- 记录ClawHub技能销售
- 管理自由职业收入
- 监控token消耗

### 场景2：OpenClaw用户
- 追踪AI服务收入
- 管理订阅收入
- 分析收入来源
- 优化收入策略

### 场景3：内容创作者
- 追踪内容收入
- 管理广告收入
- 分析收入趋势
- 规划内容策略

## 技术实现

### 架构
- 基于Python的CLI工具
- 轻量级SQLite数据库
- RESTful API集成
- 定时任务调度

### 数据安全
- 本地数据存储
- 加密配置文件
- 安全的API令牌管理
- 数据备份功能

### 性能
- 快速数据查询
- 低资源占用
- 支持大规模数据
- 实时数据更新

## 安装要求

### 系统要求
- Python 3.8+
- SQLite3
- curl/wget
- 网络连接（用于API同步）

### 依赖包
```bash
pip install requests pandas matplotlib click sqlalchemy
```

## 配置指南

### 基础配置
1. 安装技能：`clawhub install auto-income-tracker`
2. 初始化配置：`income init`
3. 设置收入来源：`income setup`

### GitHub集成
```bash
income setup-github --token YOUR_GITHUB_TOKEN
```

### ClawHub集成
```bash
income setup-clawhub
```

### 定时任务设置
```bash
income setup-cron
```

## 使用示例

### 添加收入记录
```bash
# 添加GitHub Sponsors收入
income add --source github --amount 50 --description "Monthly sponsors"

# 添加ClawHub销售
income add --source clawhub --amount 25 --description "Skill sales"

# 添加其他收入
income add --source other --amount 100 --description "Consulting"
```

### 添加支出记录
```bash
# 添加token购买
income add-expense --category token --amount 20 --description "Buy tokens"

# 添加服务器费用
income add-expense --category server --amount 50 --description "VPS hosting"
```

### 查看报表
```bash
# 查看今日收入
income report --today

# 查看本月报表
income report --month

# 查看年度报表
income report --year

# 查看平台收入对比
income report --platforms

# 导出数据
income export --format csv
```

### 设置目标
```bash
# 设置月度收入目标
income set-goal --monthly 500

# 设置年度收入目标
income set-goal --yearly 6000

# 查看目标进度
income goal-progress
```

## 高级功能

### 数据可视化
```bash
# 生成收入趋势图
income chart --trend

# 生成平台收入饼图
income chart --platforms

# 生成支出分类图
income chart --expenses
```

### 数据同步
```bash
# 手动同步GitHub数据
income sync-github

# 手动同步ClawHub数据
income sync-clawhub

# 同步所有数据源
income sync-all
```

### 数据备份
```bash
# 备份数据
income backup

# 恢复数据
income restore --file backup.sqlite

# 导出为CSV
income export --format csv --output income_data.csv
```

## 故障排除

### 常见问题
1. **API连接失败**：检查网络连接和API令牌
2. **数据不同步**：运行`income sync-all`手动同步
3. **报表显示错误**：检查数据格式和时区设置

### 日志查看
```bash
# 查看错误日志
income log --error

# 查看调试日志
income log --debug

# 清空日志
income log --clear
```

## 更新日志

### v1.0.0 (2026-04-07)
- 初始版本发布
- 基础收入追踪功能
- 支出管理功能
- 基本报表生成
- GitHub Sponsors集成

### 未来计划
- 更多平台集成（Patreon, Ko-fi等）
- 移动端应用
- 高级分析功能
- 团队协作功能

## 支持与反馈

### 支持渠道
- GitHub Issues：问题反馈
- Email：support@erdog.ai
- Discord：OpenClaw社区

### 文档
- 完整文档：https://docs.erdog.ai/income-tracker
- API文档：https://api.erdog.ai/income-tracker
- 示例配置：https://github.com/erdog-ai/examples

## 许可证
MIT License - 详见LICENSE文件

## 价格
- 个人版：$5.00（一次性购买）
- 团队版：$20.00（5用户）
- 企业版：$100.00（定制功能）

## 退款政策
30天无条件退款保证