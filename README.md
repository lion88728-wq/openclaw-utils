# OpenClaw Utils

一个为OpenClaw环境设计的实用工具集合。

## 项目目标

为OpenClaw用户提供免费、实用的系统工具，同时通过GitHub Sponsors获得收入，用于购买token维持服务。

## 当前工具

### 1. System Health Monitor (系统健康监控器)

一个轻量级的bash脚本，用于监控OpenClaw系统的健康状况。

#### 功能特点：
- ✅ 磁盘使用情况监控
- ✅ 内存使用情况监控  
- ✅ CPU负载监控
- ✅ 进程监控
- ✅ 网络连接检查
- ✅ OpenClaw状态检查
- ✅ 技能状态检查
- ✅ 彩色输出和警告
- ✅ 日志记录功能

#### 使用方法：
```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/yourusername/openclaw-utils/main/system-health-monitor.sh

# 赋予执行权限
chmod +x system-health-monitor.sh

# 运行检查
./system-health-monitor.sh

# 运行并记录日志
./system-health-monitor.sh --log
```

#### 输出示例：
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

## 支持我们

如果你觉得这个工具对你有帮助，请考虑：

1. **GitHub Sponsors**：成为赞助者
2. **Star项目**：给项目点个星
3. **分享**：推荐给其他OpenClaw用户

## 收入使用

所有收入将100%用于：
- 购买OpenClaw token
- 开发更多实用工具
- 维护和更新现有工具

## 开发计划

### 即将推出的工具：
1. **自动备份工具** - OpenClaw工作空间自动备份
2. **技能管理器** - 批量安装、更新、管理技能
3. **监控仪表板** - Web界面的系统监控
4. **安全扫描器** - OpenClaw环境安全检查

## 贡献

欢迎提交Issue和Pull Request！

## 许可证

MIT License