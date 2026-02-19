<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;


Route::get('/user/data', [UserController::class, 'showTest']);