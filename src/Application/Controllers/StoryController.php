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
        $params = $request->getQueryParams();
        $search = $params['q'] ?? '';
        $category = $params['category'] ?? '';
        $sort = $params['sort'] ?? 'latest';
        $page = max(1, (int)($params['page'] ?? 1));
        $limit = 6;
        $offset = ($page - 1) * $limit;

        $where = [
            'a.status' => 1,
            'a.deleted_at' => null
        ];

        if (!empty($search)) {
            $where['a.title[~]'] = $search;
        }

        if (!empty($category)) {
            $where['c.name'] = $category;
        }

        $order = match ($sort) {
            'popular', 'trending' => ['a.created_at' => 'DESC'], // simulasi
            default => ['a.created_at' => 'DESC']
        };

        $total = $this->db->count('tbl_articles (a)', [
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id']
        ], '*', [
            'AND' => $where
        ]);

        $articles = $this->db->select('tbl_articles (a)', [
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
            'AND' => $where,
            'ORDER' => $order,
            'LIMIT' => [$offset, $limit]
        ]);

        foreach ($articles as &$article) {
            $wordCount = str_word_count(strip_tags($article['content']));
            $article['read_time'] = ceil($wordCount / 200);
        }

        $totalPages = ceil($total / $limit);

        $categories = $this->db->select('tbl_categories', [
            'id',
            'name'
        ], [
            'type' => 1,
            'ORDER' => ['name' => 'ASC']
        ]);

        return $this->view->render($response, 'frontend/stories.twig', [
            'articles' => $articles,
            'search' => $search,
            'category' => $category,
            'sort' => $sort,
            'page' => $page,
            'totalPages' => $totalPages,
            'categories' => $categories
        ]);
    }
}
