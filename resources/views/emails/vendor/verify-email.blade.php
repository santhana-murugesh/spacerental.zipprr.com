<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify Your Email Address</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 10px;
        }
        .title {
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
        }
        .content {
            margin-bottom: 30px;
        }
        .button {
            display: inline-block;
            background-color: #007bff;
            color: #ffffff;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            margin: 20px 0;
        }
        .button:hover {
            background-color: #0056b3;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            color: #666;
            font-size: 14px;
        }
        .warning {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">{{ $site_name }}</div>
            <div class="title">Verify Your Email Address</div>
        </div>
        
        <div class="content">
            <p>Hello <strong>{{ $vendor_name }}</strong>,</p>
            
            <p>Thank you for registering as a vendor on {{ $site_name }}. To complete your registration and access your vendor dashboard, please verify your email address by clicking the button below:</p>
            
            <div style="text-align: center;">
                <a href="{{ $verification_url }}" class="button">Verify Email Address</a>
            </div>
            
            <p>If the button above doesn't work, you can copy and paste the following link into your browser:</p>
            <p style="word-break: break-all; color: #007bff;">{{ $verification_url }}</p>
            
            <div class="warning">
                <strong>Important:</strong> This verification link will expire after 24 hours. If you don't verify your email within this time, you may need to request a new verification email.
            </div>
            
            <p>If you didn't create an account on {{ $site_name }}, please ignore this email.</p>
        </div>
        
        <div class="footer">
            <p>Best regards,<br>The {{ $site_name }} Team</p>
            <p>This is an automated email. Please do not reply to this message.</p>
        </div>
    </div>
</body>
</html>
