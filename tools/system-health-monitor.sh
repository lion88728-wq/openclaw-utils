#!/bin/bash
# system-health-monitor.sh - OpenClaw System Health Monitor
# 一个轻量级的系统健康监控工具，适用于OpenClaw环境

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志文件
LOG_FILE="/tmp/system-health-$(date +%Y%m%d).log"

# 检查函数
check_disk_usage() {
    echo -e "\n${BLUE}=== 磁盘使用情况 ===${NC}"
    df -h / | tail -1 | awk '{print "根目录: 总空间 "$2", 已用 "$3", 可用 "$4", 使用率 "$5}'
    
    # 检查是否超过90%
    usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ "$usage" -gt 90 ]; then
        echo -e "${RED}⚠️  警告：磁盘使用率超过90%！${NC}"
        return 1
    elif [ "$usage" -gt 80 ]; then
        echo -e "${YELLOW}⚠️  注意：磁盘使用率超过80%${NC}"
        return 2
    else
        echo -e "${GREEN}✓ 磁盘空间正常${NC}"
        return 0
    fi
}

check_memory_usage() {
    echo -e "\n${BLUE}=== 内存使用情况 ===${NC}"
    free -h | head -2
    
    # 获取内存使用率
    total_mem=$(free -m | awk '/^Mem:/{print $2}')
    used_mem=$(free -m | awk '/^Mem:/{print $3}')
    usage=$((used_mem * 100 / total_mem))
    
    echo "内存使用率: ${usage}%"
    
    if [ "$usage" -gt 90 ]; then
        echo -e "${RED}⚠️  警告：内存使用率超过90%！${NC}"
        return 1
    elif [ "$usage" -gt 80 ]; then
        echo -e "${YELLOW}⚠️  注意：内存使用率超过80%${NC}"
        return 2
    else
        echo -e "${GREEN}✓ 内存使用正常${NC}"
        return 0
    fi
}

check_cpu_load() {
    echo -e "\n${BLUE}=== CPU负载 ===${NC}"
    load=$(uptime | awk -F'load average:' '{print $2}')
    echo "负载平均值: $load"
    
    # 获取1分钟负载
    load1=$(echo $load | awk -F', ' '{print $1}' | sed 's/ //g')
    
    # 获取CPU核心数
    cores=$(nproc)
    
    echo "CPU核心数: $cores"
    echo "1分钟负载: $load1"
    
    # 简单判断负载是否过高（负载>核心数*2）
    if (( $(echo "$load1 > $cores * 2" | bc 2>/dev/null || echo "0") )); then
        echo -e "${RED}⚠️  警告：CPU负载过高！${NC}"
        return 1
    elif (( $(echo "$load1 > $cores" | bc 2>/dev/null || echo "0") )); then
        echo -e "${YELLOW}⚠️  注意：CPU负载较高${NC}"
        return 2
    else
        echo -e "${GREEN}✓ CPU负载正常${NC}"
        return 0
    fi
}

check_processes() {
    echo -e "\n${BLUE}=== 进程监控 ===${NC}"
    echo "前5个CPU使用率最高的进程:"
    ps aux --sort=-%cpu | head -6 | awk '{printf "%-10s %-6s %-6s %-10s %s\n", $1, $2, $3, $4, $11}'
    
    echo -e "\n前5个内存使用率最高的进程:"
    ps aux --sort=-%mem | head -6 | awk '{printf "%-10s %-6s %-6s %-10s %s\n", $1, $2, $3, $4, $11}'
}

check_network() {
    echo -e "\n${BLUE}=== 网络连接 ===${NC}"
    echo "活跃的TCP连接数: $(netstat -tun | grep 'ESTABLISHED' | wc -l)"
    echo "监听端口:"
    netstat -tlnp 2>/dev/null | grep 'LISTEN' | head -5
}

check_openclaw() {
    echo -e "\n${BLUE}=== OpenClaw状态 ===${NC}"
    
    # 检查OpenClaw进程
    if pgrep -f "openclaw" > /dev/null; then
        echo -e "${GREEN}✓ OpenClaw进程正在运行${NC}"
        echo "进程信息:"
        pgrep -f "openclaw" | xargs ps -o pid,user,%cpu,%mem,cmd -p 2>/dev/null || true
    else
        echo -e "${RED}✗ OpenClaw进程未运行${NC}"
    fi
    
    # 检查工作空间
    if [ -d "/home/node/.openclaw/workspace" ]; then
        workspace_size=$(du -sh /home/node/.openclaw/workspace 2>/dev/null | cut -f1)
        echo "工作空间大小: $workspace_size"
    fi
}

check_skills() {
    echo -e "\n${BLUE}=== 技能状态 ===${NC}"
    
    if [ -d "/home/node/.openclaw/workspace/skills" ]; then
        skill_count=$(find /home/node/.openclaw/workspace/skills -maxdepth 1 -type d | wc -l)
        echo "已安装技能数: $((skill_count - 1))"
        
        # 列出技能
        echo "技能列表:"
        for skill in /home/node/.openclaw/workspace/skills/*/; do
            skill_name=$(basename "$skill")
            if [ -f "$skill/SKILL.md" ]; then
                echo "  ✓ $skill_name"
            else
                echo "  ? $skill_name (缺少SKILL.md)"
            fi
        done
    else
        echo "技能目录不存在"
    fi
}

generate_report() {
    echo -e "\n${BLUE}=== 健康报告 ===${NC}"
    echo "检查时间: $(date)"
    echo "主机名: $(hostname)"
    echo "系统运行时间: $(uptime -p)"
    
    local status="健康"
    local issues=0
    
    # 汇总检查结果
    check_disk_usage
    disk_status=$?
    
    check_memory_usage
    mem_status=$?
    
    check_cpu_load
    cpu_status=$?
    
    # 统计问题
    if [ $disk_status -eq 1 ] || [ $mem_status -eq 1 ] || [ $cpu_status -eq 1 ]; then
        status="警告"
        issues=$((issues + 1))
    elif [ $disk_status -eq 2 ] || [ $mem_status -eq 2 ] || [ $cpu_status -eq 2 ]; then
        status="注意"
        issues=$((issues + 1))
    fi
    
    echo -e "\n${GREEN}系统状态: $status${NC}"
    if [ $issues -gt 0 ]; then
        echo -e "${YELLOW}发现 $issues 个需要注意的问题${NC}"
    else
        echo -e "${GREEN}所有检查项正常${NC}"
    fi
}

# 日志记录
log_to_file() {
    echo "=== 系统健康检查 $(date) ===" >> "$LOG_FILE"
    echo "主机名: $(hostname)" >> "$LOG_FILE"
    echo "运行时间: $(uptime -p)" >> "$LOG_FILE"
    
    # 记录磁盘使用
    df -h / | tail -1 >> "$LOG_FILE"
    
    # 记录内存使用
    free -m | awk '/^Mem:/{print "内存: 总"$2"M 已用"$3"M 可用"$4"M 使用率"$3*100/$2"%"}' >> "$LOG_FILE"
    
    # 记录负载
    uptime | awk -F'load average:' '{print "负载:" $2}' >> "$LOG_FILE"
    
    echo "" >> "$LOG_FILE"
}

# 主函数
main() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}    OpenClaw 系统健康监控器    ${NC}"
    echo -e "${BLUE}================================${NC}"
    
    # 检查参数
    if [ "$1" = "--log" ]; then
        log_to_file
        echo "日志已记录到: $LOG_FILE"
    fi
    
    # 执行检查
    check_disk_usage
    check_memory_usage
    check_cpu_load
    check_processes
    check_network
    check_openclaw
    check_skills
    
    # 生成报告
    generate_report
    
    # 显示日志位置
    echo -e "\n${BLUE}================================${NC}"
    echo "使用 --log 参数记录到日志文件"
    echo "日志文件: $LOG_FILE"
    echo -e "${BLUE}================================${NC}"
}

# 执行主函数
main "$@"