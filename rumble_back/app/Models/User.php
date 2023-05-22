<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Fortify\TwoFactorAuthenticatable;
use Laravel\Jetstream\HasProfilePhoto;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens;
    use HasFactory;
    use HasProfilePhoto;
    use Notifiable;
    use TwoFactorAuthenticatable;

    /**
     * The attributes that are mass assignable.
     *
     * @var string[]
     */
    protected $fillable = [
        'name',
        'type', //add this "type", to differentiate user and ground
        'email',
        'password',
        'profile_photo_path',
        'phone',
        'address',
        'position',
       
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
        'two_factor_recovery_codes',
        'two_factor_secret',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    /**
     * The accessors to append to the model's array form.
     *
     * @var array
     */
    protected $appends = [
        'profile_photo_url',
    ];

    //this is to state that users has one relationship with ground
    //each user id refer to one ground id
    public function ground(){
        return $this->hasOne(Ground::class, 'ground_id');
    }

    //same go to user details
    public function user_details(){
        return $this->hasOne(UserDetails::class, 'user_id');
    }
    //user can have many bookings
    public function bookings(){
        return $this->hasMany(Bookings::class, 'user_id');
    }


    public function reviews(){

        return $this->hasMany(Reviews::class, 'user_id');
    }

}