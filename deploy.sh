#!/bin/bash
# 一键部署脚本 · 问问未来
# 用法：在终端运行 bash /Users/bytedance/wenwenweilailai/deploy.sh
# 或者先 chmod +x 后直接运行 ./deploy.sh

set -e

SRC="/Users/bytedance/八字奇门占卜.html"
DEPLOY_DIR="/Users/bytedance/wenwenweilailai"
DEST="$DEPLOY_DIR/index.html"

echo "📦 同步源文件..."
if [ ! -f "$SRC" ]; then
  echo "❌ 找不到源文件: $SRC"
  exit 1
fi
cp "$SRC" "$DEST"

cd "$DEPLOY_DIR"

# 检查是否有改动
if git diff --quiet && git diff --cached --quiet; then
  echo "✓ 没有新的改动，无需部署"
  exit 0
fi

# 自定义提交信息（可选）
MSG="${1:-更新于 $(date '+%Y-%m-%d %H:%M')}"

echo "📝 提交: $MSG"
git add -A
git -c user.email=mxb3141@gmail.com -c user.name=mxb3141-Max commit -q -m "$MSG"

echo "🚀 推送到 GitHub..."
git push -q

echo ""
echo "✅ 部署完成！"
echo "🔗 https://mxb3141-max.github.io/wenwenweilailai/"
echo "⏳ GitHub Pages 通常需要 30 秒 - 2 分钟重新构建"
