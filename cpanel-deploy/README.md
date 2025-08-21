# 🚀 Laravel cPanel Deployment Guide

## Quick Fix for 404 Errors

### Step 1: Upload Files
Upload your entire Laravel project to `public_html/`

### Step 2: Set Document Root
In cPanel → Domains → Set Document Root to: `public_html/public`

### Step 3: Check File Structure
Your `public_html/` should look like:
```
public_html/
├── app/
├── bootstrap/
├── config/
├── database/
├── public/          ← This should be your document root
│   ├── .htaccess
│   ├── index.php
│   ├── assets/
│   └── ...
├── resources/
├── routes/
├── storage/
├── vendor/
└── ...
```

### Step 4: Set Permissions
In cPanel File Manager:
- `storage/` → 755
- `bootstrap/cache/` → 755
- `public/.htaccess` → 644
- `public/index.php` → 644

### Step 5: Test
Visit your domain - it should work!

## Alternative: Move Public Files
If you can't change document root:
1. Move `public/*` files to `public_html/`
2. Update `index.php` paths
3. Ensure `.htaccess` is in root

## Common Issues
- ❌ 404: Wrong document root
- ❌ 500: Missing vendor folder
- ❌ 500: Permission issues
- ❌ 500: Missing .htaccess

## Support
If still having issues, check cPanel error logs!
