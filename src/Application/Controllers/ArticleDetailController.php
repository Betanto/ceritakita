<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Medoo\Medoo;

class ArticleDetailController
{
    protected $view;
    protected $db;

    public function __construct($container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
    }

    public function show(Request $request, Response $response, array $args)
    {
        $slug = $args['slug'];

        $article = $this->db->get('tbl_articles (a)', [
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
            'u.id(author_id)',
            'c.name(category_name)'
        ], [
            'a.slug' => $slug,
            'a.status' => 1,
            'a.deleted_at' => null
        ]);

        if (!$article) {
            return $response->withHeader('Location', '/')->withStatus(302);
        }

        // Hitung waktu baca
        $wordCount = str_word_count(strip_tags($article['content']));
        $article['read_time'] = ceil($wordCount / 200);

        // Ambil artikel terkait (dari kategori yang sama)
        $relatedArticles = $this->db->select('tbl_articles (a)', [
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id'],
            '[>]tbl_users (u)' => ['a.id_user' => 'id']
        ], [
            'a.id',
            'a.title',
            'a.slug',
            'a.image',
            'a.created_at',
            'u.name(author_name)'
        ], [
            'c.name' => $article['category_name'],
            'a.id[!]' => $article['id'],
            'a.status' => 1,
            'a.deleted_at' => null,
            'LIMIT' => 3
        ]);

        return $this->view->render($response, 'frontend/article-detail.twig', [
            'article' => $article,
            'relatedArticles' => $relatedArticles
        ]);
    }
}