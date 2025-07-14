<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class ContributorController
{
    protected $view;
    protected $db;
    protected $pagetitle = 'Dashboard';
    protected $pageicon = 'bi-house';
    protected $routename = 'dashboard';

    public function __construct($container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
    }

    public function index(Request $request, Response $response)
    {
        $userId = $_SESSION['user']['id'];

        $stats = [
            'total_stories' => $this->db->count('tbl_articles', [
                'id_user' => $userId,
                'deleted_at' => null
            ]),
            'approved_articles' => $this->db->count('tbl_articles', [
                'id_user' => $userId,
                'status' => 1, 
                'deleted_at' => null
            ]),
            'paid_articles' => $this->db->count('tbl_articles', [
                'id_user' => $userId,
                'status' => 1, 
                'payment_at[!]' => null, 
                'deleted_at' => null
            ])
        ];

        $recentStories = $this->db->select('tbl_articles', [
            'id',
            'title',
            'created_at',
            'status'
        ], [
            'id_user' => $userId,
            'deleted_at' => null,
            'ORDER' => ['created_at' => 'DESC'],
            'LIMIT' => 5
        ]);

        return $this->view->render($response, 'dashboards/contributor.twig', [
            'user' => $_SESSION['user'],
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon,
            'stats' => $stats,
            'recent_stories' => $recentStories
        ]);
    }
}