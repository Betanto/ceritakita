<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class DashboardController
{
    protected $view;

    public function __construct($container)
    {
        $this->view = $container->get('view');
    }

    public function index(Request $request, Response $response)
    {
        // session_start();
        return $this->view->render($response, 'dashboard.twig', [
            'user' => $_SESSION['user']
        ]);
    }
}
