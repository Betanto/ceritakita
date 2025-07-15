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
            'c.slug (category_slug)',
        ], [
            'a.status' => 1,
            'a.deleted_at' => null
        ]);

        $filteredHero = array_filter($data, function($item) {
            return isset($item['category_slug']) && $item['category_slug'] === 'hero-banner';
        });
        $heroBanner = array_values($filteredHero)[0] ?? null;

        $filteredFeatured = array_filter($data, function($item) {
            return isset($item['slug']) && $item['slug'] === 'artikel-pilihan';
        });
        $featuredTitle = array_values($filteredFeatured)[0] ?? null;

        $filteredReason = array_filter($data, function($item) {
            return isset($item['slug']) && $item['slug'] === 'judul-alasan';
        });
        $reasonTitle = array_values($filteredReason)[0] ?? null;

        $filteredReason = array_filter($data, function($item) {
            return isset($item['category_slug']) && $item['category_slug'] === 'alasan';
        });
        $Reasons = array_values($filteredReason) ?? null;

        $filteredCTA = array_filter($data, function($item) {
            return isset($item['slug']) && $item['slug'] === 'siap-berbagi-cerita-anda';
        });
        $CTATitle = array_values($filteredCTA)[0] ?? null;


        $stories = $this->db->select('tbl_articles (a)', [
            '[>]tbl_users (u)' => ['a.id_user' => 'id'],
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id'],
        ], [
            'a.id',
            'a.title',
            'a.content',
            'a.status',
            'a.image',
            'a.file',
            'a.created_at',
            'u.name(user_name)',
        ], [
            'a.deleted_at' => null,
            'c.type' => 1,
            'a.status' => 1,
            'a.payment_at[!]' => null,
            'ORDER' => ['a.created_at' => 'DESC'],
            'GROUP' => 'a.id'
        ]);
        $i=0;
        foreach ($stories as $item) {
            $sc = $this->db->select('tbl_articles_categories (ac)', [
                '[>]tbl_categories (c)' => ['ac.id_category' => 'id']
            ], ['c.name'], ['ac.id_article' => $item['id']]);
            $stories[$i]['categories'] = array_column($sc, 'name');
            $bulan = [1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun', 7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des'];
            $tanggal = date('j', strtotime($item['created_at']));
            $bulanIndo = $bulan[(int)date('n', strtotime($item['created_at']))];
            $tahun = date('Y', strtotime($item['created_at']));
            $stories[$i]['created_at_formatted'] = "$tanggal $bulanIndo $tahun";
            $i++;
        }

        $stats = [
            'articles' => count($stories),
            'contributors' => $this->db->count('tbl_users', ['id_role' => 2, 'deleted_at' => null, 'status' => 1]),
            'categories' => $this->db->count('tbl_categories', ['status' => 1, 'deleted_at' => null, 'status' => 1, 'type' => 1]),
        ];
        
        $featuredArticles = array_slice($stories, 0, 3);
        $latestArticles = array_slice($stories, 0, 2);

        return $this->view->render($response, 'frontend/home.twig', [
            'hero' => $heroBanner,
            'stats' => $stats,
            'featuredTitle' => $featuredTitle,
            'featuredArticles' => $featuredArticles,
            'reasonTitle' => $reasonTitle,
            'Reasons' => $Reasons,
            'CTATitle' => $CTATitle,
            'latestArticles' => $latestArticles
        ]);
    }
}