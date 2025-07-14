<?php

declare(strict_types=1);

use App\Application\Controllers\ArticleController;
use App\Application\Controllers\ArticleDetailController;
use App\Application\Controllers\AuthController;
use App\Application\Controllers\DashboardController;
use App\Application\Controllers\AdminController;
use App\Application\Controllers\ContributorController;
use App\Application\Controllers\HomeController;
use App\Application\Controllers\StoryController;
use App\Application\Controllers\CategoryController;
use App\Application\Controllers\UserController;
use App\Application\Controllers\PaymentController;
use App\Application\Middleware\AuthMiddleware;
use App\Application\Middleware\AdminMiddleware;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\App;
use Slim\Interfaces\RouteCollectorProxyInterface as Group;
use Twig\Extension\DebugExtension;

return function (App $app) {
    $container = $app->getContainer();

    // Setup global Twig view
    $container->set('view', function () use ($container) {
        $twig = \Slim\Views\Twig::create(__DIR__ . '/../templates', ['cache' => false, 'debug' => true]);

        session_start();

        $twig->getEnvironment()->addGlobal('flash', [
            'success' => $_SESSION['flash_success'] ?? null,
            'error' => $_SESSION['flash_error'] ?? null,
        ]);

        unset($_SESSION['flash_success'], $_SESSION['flash_error']);

        $twig->getEnvironment()->addExtension(new DebugExtension());

        // Tambahkan global latestArticles untuk footer
        $db = $container->get('db');
        $latestArticles = $db->select('tbl_articles (a)', [
            '[>]tbl_users (u)' => ['a.id_user' => 'id'],
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id']
        ], [
            'a.id',
            'a.title',
            'a.slug',
            'a.image',
            'a.created_at',
            'u.name(author_name)',
            'c.name(category_name)'
        ], [
            'a.status' => 1,
            'a.deleted_at' => null,
            'ORDER' => ['a.created_at' => 'DESC'],
            'LIMIT' => 2
        ]);

        foreach ($latestArticles as &$article) {
            $article['created_at'] = date('d M Y', strtotime($article['created_at']));
        }

        $twig->getEnvironment()->addGlobal('latestArticles', $latestArticles);

        return $twig;
    });

    // Public routes
    $app->get('/', [new HomeController($container), 'index']);
    $app->get('/stories', [new StoryController($container), 'index']);
    $app->get('/register', [new AuthController($container), 'registerPage']);
    $app->post('/register', [new AuthController($container), 'register']);
    $app->get('/login', [new AuthController($container), 'loginPage']);
    $app->post('/login', [new AuthController($container), 'login']);
    $app->get('/logout', [new AuthController($container), 'logout']);

    // Dashboard & Admin
    $app->get('/dashboard', [new DashboardController($container), 'index'])->add(new AuthMiddleware());
    $app->get('/admin', [new AdminController($container), 'index'])->add(new AuthMiddleware())->add(new AdminMiddleware());
    $app->get('/contributor', [new ContributorController($container), 'index'])->add(new AuthMiddleware());

    // Category routes
    $app->group('/categories', function (Group $group) use ($container) {
        $group->get('/{type}', [new CategoryController($container), 'index']);
        $group->get('/{type}/create', [new CategoryController($container), 'create']);
        $group->post('/create', [new CategoryController($container), 'store']);
        $group->get('/{type}/edit/{id}', [new CategoryController($container), 'edit']);
        $group->post('/edit/{id}', [new CategoryController($container), 'update']);
        $group->get('/{type}/delete/{id}', [new CategoryController($container), 'delete']);
    })->add(new AuthMiddleware())->add(new AdminMiddleware());

    // User routes
    $app->group('/users', function (Group $group) use ($container) {
        $group->get('', [new UserController($container), 'index']);
        $group->get('/create', [new UserController($container), 'create']);
        $group->post('/create', [new UserController($container), 'store']);
        $group->get('/edit/{id}', [new UserController($container), 'edit']);
        $group->post('/edit/{id}', [new UserController($container), 'update']);
        $group->get('/delete/{id}', [new UserController($container), 'delete']);
    })->add(new AuthMiddleware())->add(new AdminMiddleware());

    // Article routes
    $app->group('/articles', function (Group $group) use ($container) {
        $group->get('/{type}', [new ArticleController($container), 'index']);
        $group->get('/{type}/create', [new ArticleController($container), 'create']);
        $group->post('/create', [new ArticleController($container), 'store']);
        $group->get('/{type}/show/{id}', [ArticleController::class, 'show']);
        $group->post('/{id}/review', [new ArticleController($container), 'submitReview']);
        $group->get('/{type}/edit/{id}', [new ArticleController($container), 'edit']);
        $group->post('/edit/{id}', [new ArticleController($container), 'update']);
        $group->get('/{type}/delete/{id}', [new ArticleController($container), 'delete']);
    })->add(new AuthMiddleware());

    // Payment routes
    $app->group('/payments', function (Group $group) use ($container) {
        $group->get('', [new PaymentController($container), 'index']);
        $group->get('/show/{id}', [PaymentController::class, 'show']);
        $group->post('/{id}/payment', [new PaymentController($container), 'submitPayment']);
        $group->get('/create', [new PaymentController($container), 'create']);
        $group->post('/create', [new PaymentController($container), 'store']);
        $group->get('/edit/{id}', [new PaymentController($container), 'edit']);
        $group->post('/edit/{id}', [new PaymentController($container), 'update']);
        $group->get('/delete/{id}', [new PaymentController($container), 'delete']);
    })->add(new AuthMiddleware());

    // Detail article by slug
    $app->get('/article/{slug}', [new ArticleDetailController($container), 'show']);

    // CORS preflight
    $app->options('/{routes:.*}', function (Request $request, Response $response) {
        return $response;
    });
};
