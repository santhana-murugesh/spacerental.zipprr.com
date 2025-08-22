<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Config;
use App\Models\PaymentGateway\OnlineGateway;

class CachePaymentGateways extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'payment:cache';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Cache payment gateway configurations from database';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Caching payment gateway configurations...');

        try {
            // Cache Stripe configuration
            $stripe = OnlineGateway::where('keyword', 'stripe')->first();
            if ($stripe && $stripe->status == 1) {
                $stripeConf = json_decode($stripe->information, true);
                if (isset($stripeConf['key']) && isset($stripeConf['secret'])) {
                    Config::set('services.stripe.key', $stripeConf['key']);
                    Config::set('services.stripe.secret', $stripeConf['secret']);
                    $this->info('✓ Stripe configuration cached');
                } else {
                    $this->warn('⚠ Stripe configuration incomplete');
                }
            } else {
                $this->warn('⚠ Stripe is not active');
            }

            // Clear config cache
            $this->call('config:clear');
            $this->info('✓ Configuration cache cleared');

            $this->info('Payment gateway configurations cached successfully!');
        } catch (\Exception $e) {
            $this->error('Error caching payment gateways: ' . $e->getMessage());
            return 1;
        }

        return 0;
    }
}
