<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Config;
use App\Models\PaymentGateway\OnlineGateway;

class PaymentGatewayServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        // Dynamically load Stripe configuration from database
        try {
            $stripeConfig = getPaymentGatewayConfig('stripe');
            if ($stripeConfig && isset($stripeConfig['key']) && isset($stripeConfig['secret'])) {
                Config::set('services.stripe.key', $stripeConfig['key']);
                Config::set('services.stripe.secret', $stripeConfig['secret']);
            }
        } catch (\Exception $e) {
            // Log error if database is not available during boot
            \Log::warning('Could not load Stripe configuration from database: ' . $e->getMessage());
        }
    }
}
