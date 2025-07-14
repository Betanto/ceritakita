<?php

declare(strict_types=1);

use App\Application\Actions\User\ListUsersAction;
use App\Application\Actions\User\ViewUserAction;
use App\Application\Controllers\ArticleController;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\App;
use Slim\Interfaces\RouteCollectorProxyInterface as Group;
use App\Application\Controllers\AuthController;
use App\Application\Controllers\DashboardController;
use App\Application\Controllers\AdminController;
use App\Application\Controllers\ContributorController;
use App\Application\Controllers\HomeController;
use App\Application\Controllers\StoryController;
use App\Application\Controllers\CategoryController;
use App\Application\Controllers\UserController;
use App\Application\Controllers\PaymentController;
use App\Application\Controllers\ProfileController;
use App\Application\Middleware\AuthMiddleware;
use App\Application\Middleware\AdminMiddleware;
use Twig\Extension\DebugExtension;


return function (App $app) {
    $container = $app->getContainer();
    $container->set('view', function () {
        $twig = \Slim\Views\Twig::create(__DIR__ . '/../templates', ['cache' => false, 'debug' => true]);

        session_start();

        $twig->getEnvironment()->addGlobal('flash', [
            'success' => $_SESSION['flash_success'] ?? null,
            'error' => $_SESSION['flash_error'] ?? null,
        ]);

        unset($_SESSION['flash_success'], $_SESSION['flash_error']);

        $twig->getEnvironment()->addExtension(new DebugExtension());
        return $twig;
    });

    $app->get('/register', [new AuthController($container), 'registerPage']);
    $app->post('/register', [new AuthController($container), 'register']);


    $app->get('/', [new HomeController($container), 'index']);
    $app->get('/stories', [new StoryController($container), 'index']);
    $app->get('/login', [new AuthController($container), 'loginPage']);
    $app->post('/login', [new AuthController($container), 'login']);
    $app->get('/logout', [new AuthController($container), 'logout']);

    $app->get('/dashboard', [new DashboardController($container), 'index'])->add(new AuthMiddleware());
    $app->get('/admin', [new AdminController($container), 'index'])->add(new AuthMiddleware())->add(new AdminMiddleware());
    $app->get('/contributor', [new ContributorController($container), 'index'])->add(new AuthMiddleware());

    $app->group('/categories', function ($group) use ($container) {
        $group->get('/{type}', [new CategoryController($container), 'index']);
        $group->get('/{type}/create', [new CategoryController($container), 'create']);
        $group->post('/create', [new CategoryController($container), 'store']);
        $group->get('/{type}/edit/{id}', [new CategoryController($container), 'edit']);
        $group->post('/edit/{id}', [new CategoryController($container), 'update']);
        $group->get('/{type}/delete/{id}', [new CategoryController($container), 'delete']);
    })->add(new AuthMiddleware())->add(new AdminMiddleware());
    $app->group('/users', function ($group) use ($container) {
        $group->get('', [new UserController($container), 'index']);
        $group->get('/create', [new UserController($container), 'create']);
        $group->post('/create', [new UserController($container), 'store']);
        $group->get('/edit/{id}', [new UserController($container), 'edit']);
        $group->post('/edit/{id}', [new UserController($container), 'update']);
        $group->get('/delete/{id}', [new UserController($container), 'delete']);
    })->add(new AuthMiddleware())->add(new AdminMiddleware());

    $app->group('/articles', function ($group) use ($container) {
        $group->get('/{ type }', [new ArticleController($container), 'index']);
        $group->get('/{ type }/create', [new ArticleController($container), 'create']);
        $group->post('/create', [new ArticleController($container), 'store']);
        $group->get('/{ type }/show/{id}', [ArticleController::class, 'show']);
        $group->post('/{id}/review', [new ArticleController($container), 'submitReview']);
        $group->get('/{ type }/edit/{id}', [new ArticleController($container), 'edit']);
        $group->post('/edit/{id}', [new ArticleController($container), 'update']);
        $group->get('/{ type }/delete/{id}', [new ArticleController($container), 'delete']);
    })->add(new AuthMiddleware());

    $app->group('/payments', function ($group) use ($container) {
        $group->get('', [new PaymentController($container), 'index']);
        $group->get('/show/{id}', [PaymentController::class, 'show']);
        $group->post('/{id}/payment', [new PaymentController($container), 'submitPayment']);

        $group->get('/create', [new PaymentController($container), 'create']);
        $group->post('/create', [new PaymentController($container), 'store']);
        $group->get('/edit/{id}', [new PaymentController($container), 'edit']);
        $group->post('/edit/{id}', [new PaymentController($container), 'update']);
        $group->get('/delete/{id}', [new PaymentController($container), 'delete']);
    })->add(new AuthMiddleware());


    $app->options('/{routes:.*}', function (Request $request, Response $response) {
        return $response;
    });

    // Profile routes - accessible by both admin and contributor
$app->get('/profile', [new ProfileController($container), 'index'])->add(new AuthMiddleware());
$app->get('/profile/edit', [new ProfileController($container), 'edit'])->add(new AuthMiddleware());
$app->post('/profile/edit', [new ProfileController($container), 'update'])->add(new AuthMiddleware());
};
