<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\DestinationController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TourController;
use App\Http\Controllers\UserController;


Route::resource('admin-destinations', DestinationController::class);

Route::get('test', [AuthController::class, 'test']);

// Authenticated user account routes
Route::post('/users-pass', [UserController::class, 'changePassword']);
Route::post('/change-password', [UserController::class, 'changePasswordValidation']);
Route::post('/logout', [AuthController::class, 'logout']);
