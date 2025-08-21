<?php

namespace App\Models\HomePage;

use App\Models\Language;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CounterInformation extends Model
{
  use HasFactory;

  protected $table = 'counter_informations';

  /**
   * The attributes that aren't mass assignable.
   *
   * @var array
   */
  protected $guarded = [];

  /**
   * The attributes that are mass assignable.
   * 
   * @var array
   */
  protected $fillable = [
    'language_id',
    'serial_number',
    'amount',
    'title',
    'description', 
    'button_link', // New field for button URL
    'icon',
    'image'
  ];

  public function language()
  {
    return $this->belongsTo(Language::class, 'language_id', 'id');
  }
}
