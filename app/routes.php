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
use App\Application\Controllers\BookController;
use App\Application\Controllers\CustomerController;
use App\Application\Controllers\LoanController;
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
    // $app->get('/', function ($request, $response) {
    //     if (isset($_SESSION['user'])) {
    //         return $response->withHeader('Location', '/dashboard')->withStatus(302);
    //     }
    //     return $response->withHeader('Location', '/login')->withStatus(302);
    // });
    $app->get('/', [new HomeController($container), 'index']);
    $app->get('/login', [new AuthController($container), 'loginPage']);
    $app->post('/login', [new AuthController($container), 'login']);
    $app->get('/logout', [new AuthController($container), 'logout']);
    
    $app->get('/dashboard', [new DashboardController($container), 'index'])->add(new AuthMiddleware());
    $app->group('/books', function ($group) use ($container) {
        $group->get('', [new BookController($container), 'index']);
        $group->get('/create', [new BookController($container), 'create']);
        $group->post('/create', [new BookController($container), 'store']);
        $group->get('/edit/{id}', [new BookController($container), 'edit']);
        $group->post('/edit/{id}', [new BookController($container), 'update']);
        $group->get('/delete/{id}', [new BookController($container), 'delete']);
    })->add(new AuthMiddleware());
    $app->group('/customers', function ($group) use ($container) {
        $group->get('', [new CustomerController($container), 'index']);
        $group->get('/create', [new CustomerController($container), 'create']);
        $group->post('/create', [new CustomerController($container), 'store']);
        $group->get('/edit/{id}', [new CustomerController($container), 'edit']);
        $group->post('/edit/{id}', [new CustomerController($container), 'update']);
        $group->get('/delete/{id}', [new CustomerController($container), 'delete']);
    })->add(new AuthMiddleware());
    $app->group('/loans', function ($group) use ($container) {
        $group->get('', [new LoanController($container), 'index']);
        $group->get('/create', [new LoanController($container), 'create']);
        $group->post('/create', [new LoanController($container), 'store']);
        $group->get('/edit/{id}', [new LoanController($container), 'edit']);
        $group->post('/edit/{id}', [new LoanController($container), 'update']);
        $group->get('/delete/{id}', [new LoanController($container), 'delete']);
    })->add(new AuthMiddleware());


    $app->options('/{routes:.*}', function (Request $request, Response $response) {
        return $response;
    });
};
