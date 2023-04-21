<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;



class Ground extends Model
{
    use HasFactory;
    
    

    //these are fillable inputs
    protected $fillable = [
        'ground_id',
        'category', 
        'games_played',
        'ground_age',
        'bio_data',
        'status',
    ];

    //state this is belong to user table
    public function user(){
        return $this->belongsTo(User::class);
    }
}
