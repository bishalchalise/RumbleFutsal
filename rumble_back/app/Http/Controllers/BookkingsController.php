<?php

namespace App\Http\Controllers;

use App\Models\Bookings;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class BookkingsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
         //retrieve all appointments from the user
         $booking = Bookings::where('user_id', Auth::user()->id)->get();
         $ground = User::where('type', 'ground')->get();
 
         //sorting appointment and doctor details
         //and get all related appointment
         foreach($booking as $data){
             foreach($ground as $info){
                 $details = $info->ground;
                 if($data['ground_id'] == $info['id']){
                     $data['ground_name'] = $info['name'];
                     $data['ground_profile'] = $info['profile_photo_url']; //typo error found
                     $data['category'] = $details['category'];
                 }
             }
         }
 
         return $booking;
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
        $booking = new Bookings(); 
        $booking->user_id= Auth::user()->id;
        $booking->ground_id = $request->get('ground_id');
        $booking->date = $request->get('date');
        $booking->day = $request->get('day');
        $booking->time = $request->get('time');
        $booking->status = 'upcoming';
        $booking->save();

        return response()->json([
                'success' => 'New Booking Successful'
        ], 200);
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
