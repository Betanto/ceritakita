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
            'a.deleted_at' => null,
            'c.type' => 1,
            'a.status' => 1,
            'a.payment_at[!]' => null
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
            'LIMIT' => [$offset, $limit],
            'GROUP' => 'a.id'
        ]);
        $i=0;
        foreach ($articles as $item) {
            $sc = $this->db->select('tbl_articles_categories (ac)', [
                '[>]tbl_categories (c)' => ['ac.id_category' => 'id']
            ], ['c.name'], ['ac.id_article' => $item['id']]);
            $articles[$i]['categories'] = array_column($sc, 'name');
            $bulan = [1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun', 7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des'];
            $tanggal = date('j', strtotime($item['created_at']));
            $bulanIndo = $bulan[(int)date('n', strtotime($item['created_at']))];
            $tahun = date('Y', strtotime($item['created_at']));
            $articles[$i]['created_at_formatted'] = "$tanggal $bulanIndo $tahun";
            $i++;
        }

        // foreach ($articles as &$article) {
        //     $wordCount = str_word_count(strip_tags($article['content']));
        //     $article['read_time'] = ceil($wordCount / 200);
        // }

        $totalPages = ceil($total / $limit);

        $categories = $this->db->select('tbl_categories', [
            'id',
            'name'
        ], [
            'type' => 1,
            'status' => 1,
            'deleted_at' => null,
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
