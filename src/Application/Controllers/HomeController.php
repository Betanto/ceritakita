<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class HomeController
{
    protected $view;
    protected $db;

    public function __construct($container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
    }

    public function index(Request $request, Response $response): Response
    {
        // Hitung total artikel
        $articles = $this->db->count('tbl_articles', [
            'deleted_at' => null
        ]);

        // Hitung total kontributor (id_role = 2)
        $users = $this->db->count('tbl_users', [
            'id_role' => 2,
            'deleted_at' => null
        ]);

        // Hitung total kategori
        $categories = $this->db->count('tbl_categories', [
            'deleted_at' => null
        ]);

        // Hitung total pembaca unik dalam 30 hari terakhir dari tbl_reviews
        $readers = $this->db->query("
            SELECT COUNT(DISTINCT id_user) as total FROM tbl_reviews
            WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
              AND deleted_at IS NULL
        ")->fetchColumn();

        return $this->view->render($response, 'frontend/home.twig', [
            'stat' => [
                'articles' => $articles,
                'users' => $users,
                'categories' => $categories,
                'readers' => $readers,
            ]
        ]);
    }

}
