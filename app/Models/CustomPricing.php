<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomPricing extends Model
{
    use HasFactory;
    protected $fillable = [
       'hotel_id', 
        'room_id', 
        'date', 
        'booking_hours_id', 
        'price', 
        'vendor_id'
    ] ;
    protected $table = 'custom_pricings';
    public function hotel()
    {
        return $this->belongsTo(Hotel::class);
    }
    public function room()
    {
        return $this->belongsTo(Room::class);
    }
    public function contents()
    {
        return $this->hasMany(HotelContent::class, 'hotel_id');
    }
    public function bookingHour()
    {
        return $this->belongsTo(BookingHour::class, 'booking_hours_id');
    }
        
}
