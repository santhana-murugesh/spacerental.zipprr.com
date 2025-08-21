<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BookingHour extends Model
{
    use HasFactory;
    protected $fillable = [
        'hour',
        'serial_number'
    ];
    public function prices()
    {
        return $this->hasMany(HourlyRoomPrice::class, 'hour_id', 'id');
    }
     public function room()
    {
        return $this->belongsTo(Room::class);
    }
     public function hours()
    {
        return $this->belongsTo(CustomPricing::class);
    }
    public function customPricings()
    {
        return $this->hasMany(CustomPricing::class, 'booking_hours_id');
    }
    public function hotel()
    {
        return $this->belongsTo(Hotel::class);
    }
    public function hourlyPrices() {
        return $this->hasMany(HourlyRoomPrice::class, 'hour_id');
    }
}
    