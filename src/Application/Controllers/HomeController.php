<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Medoo\Medoo;

class HomeController
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
        $data = $this->db->select('tbl_articles (a)', [
            '[><]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[><]tbl_categories (c)' => ['ac.id_category' => 'id']
        ], [
            'a.id',
            'a.title',
            'a.slug',
            'a.image',
            'a.file',
            'a.status',
            'a.content',
            'a.created_at',
            // tambahkan kolom lain jika perlu
        ], [
            'a.status' => 1,
            'a.deleted_at' => null,
            'c.type' => 'posts'
        ]);
        
        return $this->view->render($response, 'frontend/home.twig', [
            'data' => $data
        ]);
    }
}
