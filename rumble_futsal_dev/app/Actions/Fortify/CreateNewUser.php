<?php

namespace App\Actions\Fortify;

use App\Models\UserDetails;
use App\Models\User;
use App\Models\Ground;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Laravel\Fortify\Contracts\CreatesNewUsers;
use Laravel\Jetstream\Jetstream;


//register new user/ground


class CreateNewUser implements CreatesNewUsers
{
    use PasswordValidationRules;
    

    /**
     * Validate and create a newly registered user.
     *
     * @param  array<string, string>  $input
     */
    public function create(array $input): User
    {
        Validator::make($input, [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => $this->passwordRules(),
            'terms' => Jetstream::hasTermsAndPrivacyPolicyFeature() ? ['accepted', 'required'] : '',
        ])->validate();
       

        $user = User::create([
            'name' => $input['name'],
            'email' => $input['email'],
            'type' => 'ground', //to store type of user (ground/user)
            'password' => Hash::make($input['password']),
        ]);

   
            $groundInfo = Ground::create([
                'ground_id' => $user->id,
                'status'=>'active',
            ]);
           
        
            
           
        
        return $user;


    }
}
