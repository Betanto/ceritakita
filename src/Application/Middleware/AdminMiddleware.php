<?php

namespace App\Application\Middleware;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Slim\Psr7\Response;

class AdminMiddleware implements MiddlewareInterface
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
        if (!isset($_SESSION['user']) || $_SESSION['user']['id_role'] !== 1) {
            $response = new Response();
            $response->getBody()->write("403 - Forbidden (Admin only)");
            return $response->withStatus(403);
        }

        // Jika lolos middleware, teruskan ke handler berikutnya
        return $handler->handle($request);
    }
}
