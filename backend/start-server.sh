#!/bin/sh
set -e

echo "🚀 Starting Laravel Ecommerce Backend..."

# 1. Create all required directories
echo "📁 Creating required directories..."
mkdir -p bootstrap/cache
mkdir -p storage/framework/cache/data
mkdir -p storage/framework/sessions
mkdir -p storage/framework/views
mkdir -p storage/logs
mkdir -p storage/app/public

# 2. Clear config cache
echo "🧹 Clearing config cache..."
php artisan config:clear

# 3. Run database migrations (allow failure)
echo "🗄️  Running database migrations..."
php artisan migrate --force || echo "⚠️  Migration failed or skipped (continuing anyway)"

# 4. Start PHP development server
echo "✅ Server starting on 0.0.0.0:${PORT:-8080}"
php -S 0.0.0.0:${PORT:-8080} -t public
