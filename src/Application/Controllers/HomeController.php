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
        $hero = $this->db->select('tbl_articles (a)', [
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
        ], [
            'a.status' => 1,
            'a.deleted_at' => null,
            'c.slug' => 'hero-banner'
        ]);

        $stats = [
            'articles' => $this->db->count('tbl_articles', ['status' => 1, 'deleted_at' => null]),
            'contributors' => $this->db->count('tbl_users', ['id_role' => 2, 'deleted_at' => null]),
            'categories' => $this->db->count('tbl_categories', ['status' => 1, 'deleted_at' => null])
        ];

        $featuredArticles = $this->db->select('tbl_articles (a)', [
            '[>]tbl_users (u)' => ['a.id_user' => 'id'],
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id']
        ], [
            'a.id',
            'a.title',
            'a.slug',
            'a.content',
            'a.image',
            'a.created_at',
            'u.name(author_name)',
            'c.name(category_name)'
        ], [
            'a.status' => 1,
            'a.deleted_at' => null,
            'ORDER' => ['a.created_at' => 'DESC'],
            'LIMIT' => 3
        ]);

        foreach ($featuredArticles as &$article) {
            $wordCount = str_word_count(strip_tags($article['content']));
            $article['read_time'] = ceil($wordCount / 200);
        }

        $latestArticles = $this->db->select('tbl_articles (a)', [
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

        return $this->view->render($response, 'frontend/home.twig', [
            'hero' => $hero[0] ?? null,
            'stats' => $stats,
            'featuredArticles' => $featuredArticles,
            'latestArticles' => $latestArticles
        ]);
    }
}