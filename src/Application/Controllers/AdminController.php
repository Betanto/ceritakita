<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class AdminController
{
    protected $view;
    protected $tablename;
    protected $pagetitle;
    protected $pageicon;
    protected $routename;

    public function __construct($container)
    {
        $this->view = $container->get('view');
        $this->pagetitle = 'Dashboard';
        $this->pageicon = 'bi-house';
        $this->routename = 'dashboard';
    }

    public function index(Request $request, Response $response)
    {
        // session_start();
        return $this->view->render($response, 'dashboards/admin.twig', [
            'user' => $_SESSION['user'],
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon
        ]);
    }
}
