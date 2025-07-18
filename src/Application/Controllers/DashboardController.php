<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class DashboardController
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
        if ($_SESSION['user']['id_role']==1){
            return $response->withHeader('Location', '/admin')->withStatus(302);
        }else{
            
            return $response->withHeader('Location', '/contributor')->withStatus(302);;
        }
    }
}
