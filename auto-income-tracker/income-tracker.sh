#!/bin/bash
# Auto Income Tracker v1.0.0
# 自动收入追踪器 - OpenClaw技能

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 数据库文件
DB_FILE="$HOME/.income-tracker/income.db"
CONFIG_FILE="$HOME/.income-tracker/config.yaml"
LOG_FILE="$HOME/.income-tracker/income.log"

# 初始化数据库
init_db() {
    mkdir -p "$HOME/.income-tracker"
    
    if [ ! -f "$DB_FILE" ]; then
        sqlite3 "$DB_FILE" <<EOF
CREATE TABLE IF NOT EXISTS income (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    source TEXT NOT NULL,
    amount REAL NOT NULL,
    currency TEXT DEFAULT 'USD',
    description TEXT,
    platform TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    category TEXT NOT NULL,
    amount REAL NOT NULL,
    currency TEXT DEFAULT 'USD',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS goals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    target REAL NOT NULL,
    currency TEXT DEFAULT 'USD',
    start_date TEXT,
    end_date TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tokens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    amount INTEGER NOT NULL,
    price REAL NOT NULL,
    currency TEXT DEFAULT 'USD',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_income_date ON income(date);
CREATE INDEX IF NOT EXISTS idx_income_source ON income(source);
CREATE INDEX IF NOT EXISTS idx_expenses_date ON expenses(date);
CREATE INDEX IF NOT EXISTS idx_expenses_category ON expenses(category);
EOF
        echo -e "${GREEN}数据库初始化完成${NC}"
    fi
}

# 初始化配置
init_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        cat > "$CONFIG_FILE" <<EOF
# Auto Income Tracker 配置

# 收入目标
goals:
  monthly: 500
  yearly: 6000

# 收入来源
sources:
  github:
    enabled: false
    token: ""
  clawhub:
    enabled: false
  fiverr:
    enabled: false

# 提醒设置
notifications:
  daily_summary: true
  goal_progress: true
  low_balance: true
  threshold: 1000000  # token余额低于100万时提醒

# 货币设置
currency: USD

# 报告设置
report:
  format: text
  show_charts: false
EOF
        echo -e "${GREEN}配置文件创建完成${NC}"
    fi
}

# 添加收入记录
add_income() {
    local source=$1
    local amount=$2
    local description=$3
    local platform=$4
    local date=$(date +%Y-%m-%d)
    
    sqlite3 "$DB_FILE" "INSERT INTO income (date, source, amount, description, platform) VALUES ('$date', '$source', $amount, '$description', '$platform');"
    
    echo -e "${GREEN}收入记录添加成功${NC}"
    echo "日期: $date"
    echo "来源: $source"
    echo "金额: \$$amount"
    echo "描述: $description"
    
    # 记录日志
    log "添加收入: $source - \$$amount - $description"
}

# 添加支出记录
add_expense() {
    local category=$1
    local amount=$2
    local description=$3
    local date=$(date +%Y-%m-%d)
    
    sqlite3 "$DB_FILE" "INSERT INTO expenses (date, category, amount, description) VALUES ('$date', '$category', $amount, '$description');"
    
    echo -e "${GREEN}支出记录添加成功${NC}"
    echo "日期: $date"
    echo "类别: $category"
    echo "金额: \$$amount"
    echo "描述: $description"
    
    # 记录日志
    log "添加支出: $category - \$$amount - $description"
}

# 添加token购买记录
add_token_purchase() {
    local amount=$1
    local price=$2
    local description=$3
    local date=$(date +%Y-%m-%d)
    
    sqlite3 "$DB_FILE" "INSERT INTO tokens (date, amount, price, description) VALUES ('$date', $amount, $price, '$description');"
    
    echo -e "${GREEN}Token购买记录添加成功${NC}"
    echo "日期: $date"
    echo "数量: $amount tokens"
    echo "价格: \$$price"
    echo "描述: $description"
    
    # 记录日志
    log "添加token购买: $amount tokens - \$$price - $description"
}

# 生成报表
generate_report() {
    local period=$1
    local today=$(date +%Y-%m-%d)
    
    echo -e "\n${BLUE}📊 收入报表 - $(date '+%Y年%m月%d日')${NC}"
    echo "="*50
    
    # 总收入
    local total_income=$(sqlite3 "$DB_FILE" "SELECT SUM(amount) FROM income WHERE date >= date('$today', 'start of month');" || echo "0")
    total_income=${total_income:-0}
    
    # 总支出
    local total_expense=$(sqlite3 "$DB_FILE" "SELECT SUM(amount) FROM expenses WHERE date >= date('$today', 'start of month');" || echo "0")
    total_expense=${total_expense:-0}
    
    # 净收入
    local net_income=$(echo "$total_income - $total_expense" | bc)
    
    # Token购买总额
    local token_spent=$(sqlite3 "$DB_FILE" "SELECT SUM(price) FROM tokens WHERE date >= date('$today', 'start of month');" || echo "0")
    token_spent=${token_spent:-0}
    
    # Token购买数量
    local token_amount=$(sqlite3 "$DB_FILE" "SELECT SUM(amount) FROM tokens WHERE date >= date('$today', 'start of month');" || echo "0")
    token_amount=${token_amount:-0}
    
    echo -e "\n${GREEN}💰 本月收入统计${NC}"
    echo "├── 总收入: \$$total_income"
    echo "├── 总支出: \$$total_expense"
    echo "└── 净收入: \$$net_income"
    
    echo -e "\n${YELLOW}🪙 Token购买统计${NC}"
    echo "├── 购买数量: $token_amount tokens"
    echo "├── 花费金额: \$$token_spent"
    if [ "$token_amount" -gt 0 ]; then
        local avg_price=$(echo "scale=4; $token_spent / $token_amount" | bc)
        echo "└── 平均价格: \$$avg_price/token"
    fi
    
    # 收入来源分布
    echo -e "\n${BLUE}📈 收入来源分布${NC}"
    sqlite3 "$DB_FILE" <<EOF
.mode column
.headers on
SELECT 
    source,
    COUNT(*) as count,
    SUM(amount) as total,
    ROUND(SUM(amount) * 100.0 / (SELECT SUM(amount) FROM income WHERE date >= date('$today', 'start of month')), 2) as percentage
FROM income 
WHERE date >= date('$today', 'start of month')
GROUP BY source 
ORDER BY total DESC;
EOF
    
    # 支出分类
    echo -e "\n${RED}📉 支出分类${NC}"
    sqlite3 "$DB_FILE" <<EOF
.mode column
.headers on
SELECT 
    category,
    COUNT(*) as count,
    SUM(amount) as total,
    ROUND(SUM(amount) * 100.0 / (SELECT SUM(amount) FROM expenses WHERE date >= date('$today', 'start of month')), 2) as percentage
FROM expenses 
WHERE date >= date('$today', 'start of month')
GROUP BY category 
ORDER BY total DESC;
EOF
    
    # 目标进度
    check_goals
}

# 检查目标进度
check_goals() {
    local monthly_goal=$(grep -A1 "monthly:" "$CONFIG_FILE" | tail -1 | awk '{print $2}' 2>/dev/null || echo "500")
    local today=$(date +%Y-%m-%d)
    
    local monthly_income=$(sqlite3 "$DB_FILE" "SELECT SUM(amount) FROM income WHERE date >= date('$today', 'start of month');" || echo "0")
    monthly_income=${monthly_income:-0}
    
    if [ "$monthly_goal" -gt 0 ]; then
        local progress=$(echo "scale=2; $monthly_income * 100 / $monthly_goal" | bc)
        
        echo -e "\n${GREEN}🎯 月度目标进度${NC}"
        echo "├── 目标: \$$monthly_goal"
        echo "├── 当前: \$$monthly_income"
        echo "└── 进度: $progress%"
        
        if (( $(echo "$progress >= 100" | bc -l) )); then
            echo -e "${GREEN}✅ 目标已完成！${NC}"
        elif (( $(echo "$progress >= 80" | bc -l) )); then
            echo -e "${YELLOW}⚠️  接近目标${NC}"
        fi
    fi
}

# 日志记录
log() {
    local message=$1
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
}

# 显示帮助
show_help() {
    echo -e "${BLUE}Auto Income Tracker v1.0.0${NC}"
    echo "自动收入追踪和管理工具"
    echo ""
    echo "使用方法:"
    echo "  income [命令] [参数]"
    echo ""
    echo "命令:"
    echo "  add <来源> <金额> <描述> [平台]   添加收入记录"
    echo "  expense <类别> <金额> <描述>      添加支出记录"
    echo "  token <数量> <价格> <描述>        添加token购买记录"
    echo "  report                            生成收入报表"
    echo "  init                              初始化数据库和配置"
    echo "  config                            显示配置"
    echo "  log                               查看日志"
    echo "  help                              显示帮助"
    echo ""
    echo "示例:"
    echo "  income add github 50 \"GitHub Sponsors\""
    echo "  income expense token 20 \"购买token\""
    echo "  income token 1000000 50 \"购买100万token\""
    echo "  income report"
}

# 主函数
main() {
    # 初始化
    init_db
    init_config
    
    case "$1" in
        "add")
            if [ $# -lt 4 ]; then
                echo -e "${RED}错误：缺少参数${NC}"
                echo "使用方法: income add <来源> <金额> <描述> [平台]"
                exit 1
            fi
            add_income "$2" "$3" "$4" "${5:-}"
            ;;
        "expense")
            if [ $# -lt 4 ]; then
                echo -e "${RED}错误：缺少参数${NC}"
                echo "使用方法: income expense <类别> <金额> <描述>"
                exit 1
            fi
            add_expense "$2" "$3" "$4"
            ;;
        "token")
            if [ $# -lt 4 ]; then
                echo -e "${RED}错误：缺少参数${NC}"
                echo "使用方法: income token <数量> <价格> <描述>"
                exit 1
            fi
            add_token_purchase "$2" "$3" "$4"
            ;;
        "report")
            generate_report "${2:-month}"
            ;;
        "init")
            echo -e "${GREEN}初始化完成${NC}"
            ;;
        "config")
            cat "$CONFIG_FILE"
            ;;
        "log")
            if [ -f "$LOG_FILE" ]; then
                tail -20 "$LOG_FILE"
            else
                echo "暂无日志"
            fi
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            echo -e "${RED}未知命令: $1${NC}"
            show_help
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"