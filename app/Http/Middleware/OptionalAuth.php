<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class OptionalAuth
{
    public function handle(Request $request, Closure $next)
    {
        // Get the authenticated user if exists (with Sanctum)
        $user = Auth::guard('sanctum')->user();

        // Add the user (or null) to the request
        $request->merge(['auth_user' => $user]);

        return $next($request);
    }
}
