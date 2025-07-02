<?php

namespace App\Application\Middleware;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Slim\Psr7\Response;

class AuthMiddleware implements MiddlewareInterface
{
    public function process(Request $request, RequestHandlerInterface $handler): ResponseInterface
    {
        // Misalnya pengecekan autentikasi
        $isAuthenticated = true; // ubah sesuai logika Anda

        // if (!$isAuthenticated) {
        //     $response = new Response();
        //     $response->getBody()->write('Unauthorized');
        //     return $response->withStatus(401);
        // }
        if (empty($_SESSION['user'])) {
            // Redirect to login page if not authenticated
            return (new Response())->withHeader('Location', '/login')->withStatus(302);
        }

        // Jika lolos middleware, teruskan ke handler berikutnya
        return $handler->handle($request);
    }
}
