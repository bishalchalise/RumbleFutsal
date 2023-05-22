<?php

namespace App\Http\Controllers;


use App\Models\Bookings;
use App\Models\User;
use App\Models\Ground;
use App\Models\UserDetails;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Response;


class UsersController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //

        $user = array(); //this will return a set of user and ground data
        $user = Auth::user();
        $ground = User::where('type', 'ground')->get();
        $details = $user->user_details;
        $groundData = Ground::all();
        //return today's booking together with user data
//date format without leading
        $date = now()->format('n/j/Y');
        $booking = Bookings::where('status', 'upcoming')->where('date', $date)->first();

        foreach ($groundData as $data) {
            //sorting ground name and ground details
            foreach ($ground as $info) {
                if ($data['ground_id'] == $info['id']) {
                    $data['ground_name'] = $info['name'];
                    $data['ground_profile'] = $info['profile_photo_url'];
                    if (isset($booking) && $booking['ground_id'] == $info['id']) {
                        # code...
                        $data['bookings'] = $booking;
                    }
                }
            }
        }
        $user['ground'] = $groundData;
        $user['details'] = $details;
        return $user;
    }

    /**
     * loign.
     *
     * @return \Illuminate\Http\Response
     */
    public function login(Request $reqeust)
    {
        //validate incoming inputs
        $reqeust->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        //check matching user
        $user = User::where('email', $reqeust->email)->first();

        //check password
        if (!$user || !Hash::check($reqeust->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect'],
            ]);
        }

        //then return generated token
        return $user->createToken($reqeust->email)->plainTextToken;
    }
    /**
     * register.
     *
     * @return \Illuminate\Http\Response
     */
    public function register(Request $request)
    {
        //validate incoming inputs
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'type' => 'user',
            'password' => Hash::make($request->password),
        ]);

        $userInfo = UserDetails::create([
            'user_id' => $user->id,
            'status' => 'active',
        ]);

        return $user;


    }

    /**
     * update favourite ground list
     */
    public function storeFavGround(Request $request)
    {

        $saveFav = UserDetails::where('user_id', Auth::user()->id)->first();

        $groundList = json_encode($request->get('favList'));
        //update fav list into database
        $saveFav->fav = $groundList;
        $saveFav->save();

        return response()->json([
            'success' => 'The Favourite List is updated !',
        ], 200);
    }


    /**
     * update favourite ground list
     */
    public function uDetails(Request $request)
    {

        $update = User::where('id', Auth::user()->id)->first();

        $update->phone = $request->get('phone');
        $update->address = $request->get('address');
        $update->position = $request->get('position');
        $update->save();

        return response()->json([
            'success' => 'The update has been successfully'
        ], 200);


    }


    /**
     * update favourite ground list
     */
    public function updatePhoto(Request $request)
    {

        $update = User::where('id', Auth::user()->id)->first();

        $update->profile_photo_path = $request->get('profile_photo_path');
       
        $update->save();

        return response()->json([
            'success' => 'The photo update successfully'
        ], 200);
    }


    /**
     * logout
     * 
     * @return \Illuminate\Http\Response
     */
    public function logout()
    {
        $user = Auth::user();
        $user->currentAccessToken()->delete();

        return response()->json([
            'success' => 'Logout Successful!',
        ]);
    }



    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}