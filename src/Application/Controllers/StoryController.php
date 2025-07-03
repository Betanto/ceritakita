<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class StoryController
{
    protected $view;
    protected $db;

    public function __construct($container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
    }

    public function index(Request $request, Response $response)
    {
        // $books = $this->db->select('buku', '*');
        // return $this->view->render($response, 'books/list.twig', ['books' => $books]);
        return $this->view->render($response, 'frontend/stories.twig');
    }
}
