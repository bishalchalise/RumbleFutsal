<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bookings extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'ground_id',
        'date',
        'day',
        'time',
        'status',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }
}
