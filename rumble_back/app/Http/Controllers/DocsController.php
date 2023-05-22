<?php

namespace App\Http\Controllers;

use App\Models\Bookings;
use App\Models\Reviews;
use App\Models\User;
use App\Models\UserDetails;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DocsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //to get ground's booking, total_bookings and display on the dashboard
        $ground = Auth::user();
        $booking = Bookings::where('ground_id', $ground->id)->where('status', 'upcoming')->get();
        $reviews = Reviews::where('ground_id', $ground->id)->where('status', 'active')->get();

        //return all data to dashboard

        return view('dashboard')->with(['ground' => $ground, 'bookings' => $booking, 'reviews' => $reviews]);
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
        //this controller is to store booking details post from mobile app
        $reviews = new Reviews();
        //this is to update the booking status from "upcoming" to "complete"
        $booking = Bookings::where('id', $request->get('booking_id'))->first();

        //save the ratings and reviews from user
        $reviews->user_id = Auth::user()->id;
        $reviews->ground_id = $request->get('ground_id');
        $reviews->ratings = $request->get('ratings');
        $reviews->reviews = $request->get('reviews');
        $reviews->reviewed_by = Auth::user()->name;
        $reviews->status = 'active';
        $reviews->save();

        //change appointment status
        $booking->status = 'complete';
        $booking->save();

        return response()->json([
            'success' => 'The booking has been completed and reviewed successfully!',
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function cancelBooking(Request $request)
    {
        // Find the booking record by ID
        $booking = Bookings::find($request->get('booking_id'));

        // Check if the booking exists
        if (!$booking) {
            return response()->json([
                'error' => 'Booking not found'
            ], 404);
        }

        // Update the booking status to "cancelled"
        $booking->status = 'cancel';
        $booking->save();

        return response()->json([
            'success' => 'The booking has been cancelled successfully'
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
       

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}