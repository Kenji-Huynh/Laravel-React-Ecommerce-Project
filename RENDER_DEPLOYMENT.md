# Deployment Guide: Laravel Backend to Render

## Prerequisites
- GitHub repository connected
- Stripe API keys (live or test)
- Cloudinary account credentials

## Quick Start

### 1️⃣ Fill in the form on Render:

**Public Git Repository:**
```
https://github.com/Kenji-Huynh/Ecommerce-React-Laravel-Project
```

**Name:**
```
ecommerce-backend
```

**Language:**
```
Docker
```

**Branch:**
```
main
```

**Region:**
```
Oregon (US West) - recommended for free tier
```

**Root Directory:**
```
backend
```

---

### 2️⃣ Advanced Settings (click "Advanced" button):

**Dockerfile Path:**
```
./Dockerfile
```

**Docker Build Context Directory:**
```
./
```

**Docker Command (optional - leave empty to use default from Dockerfile)**

---

### 3️⃣ Environment Variables

Click "Add Environment Variable" and add these:

#### Required - Set these manually:
```
APP_KEY=base64:YOUR_KEY_HERE
APP_URL=https://your-app.onrender.com
STRIPE_SECRET=sk_test_YOUR_STRIPE_SECRET
CLOUDINARY_URL=cloudinary://API_KEY:API_SECRET@CLOUD_NAME
CLOUDINARY_UPLOAD_PRESET=your_preset
FRONTEND_URL=https://your-frontend.vercel.app
SANCTUM_STATEFUL_DOMAINS=your-frontend.vercel.app
SESSION_DOMAIN=.onrender.com
```

#### Auto-filled (database will be created):
- DB_HOST
- DB_PORT
- DB_DATABASE
- DB_USERNAME
- DB_PASSWORD

---

### 4️⃣ Create Database

After creating the web service:

1. Go to Dashboard → "New" → "PostgreSQL" or "MySQL"
2. Name: `ecommerce-db`
3. Database name: `ecommerce`
4. Region: Same as web service (Oregon)
5. Plan: Free

Then link it to your web service:
- Go to your web service → Environment
- Click "Link Database"
- Select `ecommerce-db`

---

### 5️⃣ Deploy

Click **"Create Web Service"**

Render will:
1. Clone your repo
2. Build Docker image
3. Run migrations (if enabled in render-build.sh)
4. Start the server

---

## After First Deploy

### Run migrations manually:
1. Go to your service → Shell tab
2. Run:
```bash
php artisan migrate --force
php artisan db:seed --force
```

### Get your backend URL:
```
https://ecommerce-backend-XXXX.onrender.com
```

### Update frontend environment:
In Vercel, set:
```
VITE_API_URL=https://ecommerce-backend-XXXX.onrender.com
```

---

## Troubleshooting

### Build fails?
- Check Logs tab
- Verify Dockerfile path is correct
- Ensure all required PHP extensions are installed

### Can't connect to database?
- Verify database is created and linked
- Check DB_* environment variables are set
- Database might take 1-2 minutes to provision

### 500 errors?
- Check Runtime Logs
- Verify APP_KEY is set (run `php artisan key:generate` in Shell)
- Ensure storage directories have correct permissions

---

## Free Tier Limits

- **Web Service:** Spins down after 15 minutes of inactivity
- **Database:** 1GB storage, 97 hours/month uptime
- **Cold starts:** ~30 seconds on first request after sleep

Upgrade to paid plan ($7/month) for:
- No spin-down
- Better performance
- More resources

---

## Alternative: Use render.yaml (Blueprint)

Instead of manual setup, you can:

1. Push `render.yaml` to your repo
2. On Render dashboard, click "New" → "Blueprint"
3. Connect your repo
4. Render will auto-create service + database from yaml

This is faster for future deployments!
