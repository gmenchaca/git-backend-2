<?php

use Illuminate\Support\Facades\Route;


Route::middleware('api')->group(function () {
    require __DIR__ . '/api/public/auto.php';

    // Carga rutas con autenticación opcional
    Route::middleware('optional.auth')->group(function () {
        require __DIR__ . '/api/semiauth/auto.php';
    });

    // Carga rutas que requieren autenticación
    Route::middleware('auth:sanctum')->group(function () {
        require __DIR__ . '/api/auth/auto.php';
    });

    // Carga rutas administrativas (requieren autenticación + rol admin)
    Route::middleware(['auth:sanctum', 'can:admin'])
        ->prefix('admin')
        ->as('admin.')
        ->group(function () {
            require __DIR__ . '/api/admin/auto.php';
        });
});