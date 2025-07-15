<?php

declare(strict_types=1);

use App\Application\Handlers\HttpErrorHandler;
use App\Application\Handlers\ShutdownHandler;
use App\Application\ResponseEmitter\ResponseEmitter;
use App\Application\Settings\SettingsInterface;
use DI\ContainerBuilder;
use Slim\Factory\AppFactory;
use Slim\Factory\ServerRequestCreatorFactory;
use Slim\Views\Twig;
use Slim\Views\TwigMiddleware;
use App\Application\Middleware\ViewGlobalMiddleware;


use Slim\Exception\HttpNotFoundException;
use Slim\Exception\HttpMethodNotAllowedException;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Psr7\Response;


require __DIR__ . '/../vendor/autoload.php';
require __DIR__ . '/../src/helpers.php'; // adjust path if needed

$uploadFolders = [
    __DIR__ . '/uploads',
    __DIR__ . '/uploads/images',
    __DIR__ . '/uploads/files',
];

foreach ($uploadFolders as $folder) {
    if (!is_dir($folder)) {
        mkdir($folder, 0777, true);
    }
}

// Instantiate PHP-DI ContainerBuilder
$containerBuilder = new ContainerBuilder();

if (false) { // Should be set to true in production
    $containerBuilder->enableCompilation(__DIR__ . '/../var/cache');
}

// Set up settings
$settings = require __DIR__ . '/../app/settings.php';
$settings($containerBuilder);

// Set up dependencies
$dependencies = require __DIR__ . '/../app/dependencies.php';
$dependencies($containerBuilder);

// Set up repositories
$repositories = require __DIR__ . '/../app/repositories.php';
$repositories($containerBuilder);

// Build PHP-DI Container instance
$container = $containerBuilder->build();

// Instantiate the app
AppFactory::setContainer($container);
$app = AppFactory::create();
$callableResolver = $app->getCallableResolver();
$twig = Twig::create(__DIR__ . '/../templates', ['cache' => false]);
$app->add(TwigMiddleware::create($app, $twig));

$database = require __DIR__ . '/../app/config/database.php';

// Register middleware
$middleware = require __DIR__ . '/../app/middleware.php';
$middleware($app);

// Register routes
$routes = require __DIR__ . '/../app/routes.php';
$routes($app);
$app->add(new ViewGlobalMiddleware($container));
/** @var SettingsInterface $settings */
$settings = $container->get(SettingsInterface::class);

// $displayErrorDetails = $settings->get('displayErrorDetails');
$displayErrorDetails = $settings->get('displayErrorDetails');
$logError = $settings->get('logError');
$logErrorDetails = $settings->get('logErrorDetails');

// Create Request object from globals
$serverRequestCreator = ServerRequestCreatorFactory::create();
$request = $serverRequestCreator->createServerRequestFromGlobals();

// Create Error Handler
$responseFactory = $app->getResponseFactory();
$errorHandler = new HttpErrorHandler($callableResolver, $responseFactory);

// Create Shutdown Handler
$shutdownHandler = new ShutdownHandler($request, $errorHandler, $displayErrorDetails);
register_shutdown_function($shutdownHandler);

// Add Routing Middleware
$app->addRoutingMiddleware();

// Add Body Parsing Middleware
$app->addBodyParsingMiddleware();

// Add Error Middleware
$errorMiddleware = $app->addErrorMiddleware($displayErrorDetails, $logError, $logErrorDetails);
$errorMiddleware->setDefaultErrorHandler($errorHandler);

// Run App & Emit Response
$response = $app->handle($request);
$responseEmitter = new ResponseEmitter();
$responseEmitter->emit($response);

// Error Middleware
$errorMiddleware = $app->addErrorMiddleware(false, true, true); // `false` agar halaman error tampil, bukan stack trace

// 404 Not Found Handler
$errorMiddleware->setErrorHandler(HttpNotFoundException::class, function (
    Request $request,
    \Throwable $exception,
    bool $displayErrorDetails,
    bool $logErrors,
    bool $logErrorDetails
) {
    $view = Twig::fromRequest($request);
    $response = new \Slim\Psr7\Response();
    return $view->render($response->withStatus(404), 'errors/404.twig');
});

// 405 Method Not Allowed Handler
$errorMiddleware->setErrorHandler(HttpMethodNotAllowedException::class, function (
    Request $request,
    \Throwable $exception,
    bool $displayErrorDetails,
    bool $logErrors,
    bool $logErrorDetails
) {
    $view = Twig::fromRequest($request);
    $response = new \Slim\Psr7\Response();
    return $view->render($response->withStatus(405), 'errors/405.twig');
});

// 500 Internal Server Error Handler (default)
$errorMiddleware->setDefaultErrorHandler(function (
    Request $request,
    \Throwable $exception,
    bool $displayErrorDetails,
    bool $logErrors,
    bool $logErrorDetails
) {
    $view = Twig::fromRequest($request);
    $response = new \Slim\Psr7\Response();
    return $view->render($response->withStatus(500), 'errors/500.twig');
});