<?php

declare(strict_types=1);

use App\Application\Actions\User\ListUsersAction;
use App\Application\Actions\User\ViewUserAction;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\App;
use Slim\Interfaces\RouteCollectorProxyInterface as Group;
use App\Application\Controllers\AuthController;
use App\Application\Controllers\DashboardController;
use App\Application\Controllers\HomeController;
use App\Application\Middleware\AuthMiddleware;
use Twig\Extension\DebugExtension;

return function (App $app) {
    $container = $app->getContainer();
    $container->set('view', function () {
        $twig = \Slim\Views\Twig::create(__DIR__ . '/../templates', ['cache' => false,'debug' => true]);

        session_start();

        $twig->getEnvironment()->addGlobal('flash', [
            'success' => $_SESSION['flash_success'] ?? null,
            'error' => $_SESSION['flash_error'] ?? null,
        ]);
        
        unset($_SESSION['flash_success'], $_SESSION['flash_error']);
        
        $twig->getEnvironment()->addExtension(new DebugExtension());
        return $twig;
    });

    $app->get('/', [new HomeController($container), 'index']);
    $app->get('/login', [new AuthController($container), 'loginPage']);
    $app->post('/login', [new AuthController($container), 'login']);
    $app->get('/logout', [new AuthController($container), 'logout']);
    
    $app->get('/dashboard', [new DashboardController($container), 'index'])->add(new AuthMiddleware());


    $app->options('/{routes:.*}', function (Request $request, Response $response) {
        return $response;
    });
};
