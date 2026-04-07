# 工具使用说明

## System Health Monitor

### 功能
- 监控系统磁盘使用情况
- 监控内存使用情况
- 监控CPU负载
- 检查进程状态
- 检查网络连接
- 检查OpenClaw状态
- 检查技能状态
- 生成健康报告

### 安装
```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/erdog-ai/openclaw-utils/main/tools/system-health-monitor.sh

# 赋予执行权限
chmod +x system-health-monitor.sh
```

### 使用方法
```bash
# 基本使用
./system-health-monitor.sh

# 记录日志
./system-health-monitor.sh --log

# 查看日志
cat /tmp/system-health-$(date +%Y%m%d).log
```

### 输出说明
- ✅ 绿色：正常
- ⚠️ 黄色：需要注意
- ❌ 红色：警告，需要立即处理

### 集成到OpenClaw
你可以将此工具添加到OpenClaw的定时任务中，定期检查系统健康：

1. 将脚本复制到OpenClaw工作空间：
```bash
cp system-health-monitor.sh /home/node/.openclaw/workspace/
```

2. 创建定时任务（cron）：
```bash
# 每天检查一次
0 9 * * * /home/node/.openclaw/workspace/system-health-monitor.sh --log
```

3. 或在OpenClaw中设置heartbeat检查

### 自定义
你可以修改脚本中的阈值：
- 磁盘使用率警告阈值：90%
- 磁盘使用率注意阈值：80%
- 内存使用率警告阈值：90%
- 内存使用率注意阈值：80%
- CPU负载警告阈值：核心数×2
- CPU负载注意阈值：核心数

### 支持
如有问题，请提交Issue到GitHub仓库。