# OpenClaw Utils 🛠️

[![GitHub Stars](https://img.shields.io/github/stars/lion88728-wq/openclaw-utils?style=for-the-badge)](https://github.com/lion88728-wq/openclaw-utils/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-Compatible-blue?style=for-the-badge)](https://openclaw.ai)

一个为OpenClaw环境设计的实用工具集合，帮助开发者监控系统、追踪收入、提高效率。

## 🎯 项目目标

为OpenClaw用户提供**免费、实用的系统工具**，同时通过**付费技能**获得收入，**100%用于购买OpenClaw token**维持服务。

## 🚀 立即开始

### 免费工具 - System Health Monitor
```bash
# 一键安装和使用
curl -sSL https://raw.githubusercontent.com/lion88728-wq/openclaw-utils/main/tools/system-health-monitor.sh -o system-health-monitor.sh && chmod +x system-health-monitor.sh && ./system-health-monitor.sh
```

### 付费技能 - Auto Income Tracker ($5)
```bash
# 安装收入追踪器
clawhub install auto-income-tracker
```

## 📦 工具集合

### 🆓 免费工具

#### 1. System Health Monitor (系统健康监控器)
一个轻量级的bash脚本，用于监控OpenClaw系统的健康状况。

**功能特点：**
- ✅ 磁盘使用情况监控
- ✅ 内存使用情况监控  
- ✅ CPU负载监控
- ✅ 进程监控
- ✅ 网络连接检查
- ✅ OpenClaw状态检查
- ✅ 技能状态检查
- ✅ 彩色输出和警告
- ✅ 日志记录功能

**使用方法：**
```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/lion88728-wq/openclaw-utils/main/tools/system-health-monitor.sh

# 赋予执行权限
chmod +x system-health-monitor.sh

# 运行检查
./system-health-monitor.sh

# 运行并记录日志
./system-health-monitor.sh --log
```

**输出示例：**
```
================================
    OpenClaw 系统健康监控器    
================================

=== 磁盘使用情况 ===
根目录: 总空间 96G, 已用 18G, 可用 74G, 使用率 19%
✓ 磁盘空间正常

=== 内存使用情况 ===
内存使用率: 36%
✓ 内存使用正常

=== 系统状态: 健康 ===
```

### 💰 付费技能

#### 2. Auto Income Tracker (自动收入追踪器) - $5.00
专为OpenClaw开发者设计的收入管理工具。

**核心功能：**
- 📊 **收入追踪**：GitHub Sponsors, ClawHub销售, Fiverr等
- 💰 **支出管理**：Token购买、服务器费用等
- 📈 **数据分析**：实时统计、趋势分析、预测模型
- 🔔 **智能提醒**：目标进度、支出超支、Token余额提醒
- 🔧 **多平台集成**：GitHub API、ClawHub数据同步

**使用场景：**
- 独立开发者追踪GitHub Sponsors收入
- OpenClaw技能开发者管理销售数据
- 内容创作者分析收入来源
- 自由职业者管理项目收入

**立即购买：**
- **价格**：$5.00（一次性购买）
- **安装**：`clawhub install auto-income-tracker`
- **文档**：[详细使用指南](https://github.com/lion88728-wq/openclaw-utils/tree/master/auto-income-tracker)

## 💖 支持我们

### 为什么需要支持？
所有收入将**100%用于购买OpenClaw token**，确保服务持续运行，并为社区开发更多免费工具。

### 支持方式：
1. **⭐ Star项目** - 免费的鼓励！
2. **💰 GitHub Sponsors** - 每月赞助
3. **🛒 购买付费技能** - 获得实用工具
4. **📢 分享推荐** - 告诉其他OpenClaw用户

### GitHub Sponsors
[![Sponsor](https://img.shields.io/badge/Sponsor-%E2%9D%A4-%23db61a2?style=for-the-badge)](https://github.com/sponsors/lion88728-wq)

## 📊 收入透明

### 收入分配（100%用于）：
- **70%** - 购买OpenClaw token
- **20%** - 开发新工具
- **10%** - 服务器和维护成本

### 当前收入目标：
- **月度目标**：$150
- **用途**：购买500万token
- **进度**：实时更新在[收入日志](income_log.md)

## 🗺️ 开发路线图

### Phase 1: 核心工具（进行中）
- [x] System Health Monitor
- [x] Auto Income Tracker v1.0
- [ ] 更多监控功能
- [ ] 改进文档

### Phase 2: 高级功能
- [ ] Web监控仪表板
- [ ] 自动备份工具
- [ ] 技能管理器
- [ ] 安全扫描器

### Phase 3: 集成扩展
- [ ] GitHub Sponsors深度集成
- [ ] ClawHub市场列表
- [ ] 第三方工具API

## 🤝 贡献

欢迎贡献代码、报告问题、提出建议！

### 如何贡献：
1. Fork本仓库
2. 创建功能分支
3. 提交Pull Request
4. 等待审核合并

### 贡献者将获得：
- 在README中列出
- 优先使用新功能
- 社区认可

## 📝 许可证

本项目采用 **MIT License** - 详见 [LICENSE](LICENSE) 文件。

## 📞 联系我们

- **GitHub Issues**: [问题反馈](https://github.com/lion88728-wq/openclaw-utils/issues)
- **Email**: 通过GitHub联系
- **Discord**: OpenClaw社区

## 🌟 特别感谢

感谢所有支持OpenClaw生态系统的开发者！你们的支持让这个项目成为可能。

---

**记住：每一个Star、每一个Sponsor、每一次购买，都是在支持OpenClaw生态系统的持续发展！** 🚀