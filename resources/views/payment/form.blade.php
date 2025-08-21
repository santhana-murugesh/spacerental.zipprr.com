<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - {{ $gateway }}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .payment-container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .payment-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .payment-body {
            padding: 30px;
        }
        .payment-summary {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .payment-summary h5 {
            color: #495057;
            margin-bottom: 15px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 8px 0;
            border-bottom: 1px solid #dee2e6;
        }
        .summary-item:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.1em;
        }
        .gateway-info {
            background: #e3f2fd;
            border: 1px solid #bbdefb;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .btn-back {
            background: #6c757d;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            color: white;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }
        .btn-back:hover {
            background: #5a6268;
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-container">
            <div class="payment-header">
                <h2><i class="fas fa-credit-card me-2"></i>Payment Processing</h2>
                <p class="mb-0">Complete your booking payment</p>
            </div>
            
            <div class="payment-body">
                <div class="payment-summary">
                    <h5><i class="fas fa-receipt me-2"></i>Payment Summary</h5>
                    <div class="summary-item">
                        <span>Order Number:</span>
                        <span>{{ $orderNumber }}</span>
                    </div>
                    <div class="summary-item">
                        <span>Customer:</span>
                        <span>{{ $customerName }}</span>
                    </div>
                    <div class="summary-item">
                        <span>Payment Gateway:</span>
                        <span>{{ ucfirst($gateway) }}</span>
                    </div>
                    <div class="summary-item">
                        <span>Amount:</span>
                        <span>${{ number_format($amount, 2) }}</span>
                    </div>
                </div>
                
                <div class="gateway-info">
                    <h6><i class="fas fa-info-circle me-2"></i>Payment Gateway Information</h6>
                    {!! $paymentForm !!}
                </div>
                
                <div class="text-center">
                    <a href="{{ route('frontend.checkout') }}" class="btn-back">
                        <i class="fas fa-arrow-left me-2"></i>Back to Checkout
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/your-fontawesome-kit.js"></script>
</body>
</html>
