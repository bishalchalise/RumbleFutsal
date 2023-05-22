<?php

use App\Http\Controllers\BookkingsController;
use App\Http\Controllers\DocsController;
use App\Http\Controllers\UsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::post('/login', [UsersController::class, 'login']);
Route::post('/register', [UsersController::class, 'register']);

//retrun user's data if authenticated successfully
Route::middleware('auth:sanctum')->group(function() {
    Route::get('/user', [UsersController::class, 'index']);
    Route::post('/fav', [UsersController::class, 'storeFavGround']);  //post to store Fav Ground
    Route::post('/logout', [UsersController::class, 'logout']); 
    Route::post('/book', [BookkingsController::class, 'store']);
    Route::post('/cancel', [DocsController::class, 'cancelBooking']);
    Route::post('/reviews', [DocsController::class, 'store']);
    Route::get('/getbook', [BookkingsController::class, 'index']);
    Route::post('/update', [UsersController::class, 'uDetails']); 
    Route::post('/photo', [UsersController::class, 'updatePhoto']); 
    Route::post('/ratings', [DocsController::class, 'index']); 

});
