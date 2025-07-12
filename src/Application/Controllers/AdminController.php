<?php

namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Container\ContainerInterface;

class AdminController
{
    protected $view;
    protected $db;
    protected $pagetitle = 'Admin Dashboard';
    protected $pageicon = 'bi-house';
    protected $routename = 'admin';

    public function __construct(ContainerInterface $container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
    }

    public function index(Request $request, Response $response)
    {
        $totalCeritaResult = $this->db->select('tbl_articles (a)', [
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id'],
        ], 'a.id', [
            'a.deleted_at' => null,
            'c.type' => 1,
            'GROUP' => 'a.id'
        ]);
        $totalCerita = count($totalCeritaResult);

        $totalKontributor = $this->db->count('tbl_users', '*', [
            'deleted_at' => null,
            'id_role' => 2
        ]);

        $yangDisetujuiResult = $this->db->select('tbl_articles (a)', [
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id'],
        ], 'a.id', [
            'a.deleted_at' => null,
            'a.status' => 1,
            'c.type' => 1,
            'GROUP' => 'a.id'
        ]);
        $yangDisetujui = count($yangDisetujuiResult);

        $yangDibayarResult = $this->db->select('tbl_articles (a)', [
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id'],
        ], 'a.id', [
            'a.deleted_at' => null,
            'a.status' => 1,
            'a.amount[>]' => 0,
            'a.payment_at[!]' => null,
            'c.type' => 1,
            'GROUP' => 'a.id'
        ]);
        $yangDibayar = count($yangDibayarResult);

        $latestStories = $this->db->select('tbl_articles (a)', [
            '[>]tbl_users (u)' => ['a.id_user' => 'id'],
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id'],
        ], [
            'a.id',
            'a.title',
            'a.status',
            'a.created_at',
            'u.name(user_name)',
        ], [
            'a.deleted_at' => null,
            'c.type' => 1,
            'GROUP' => 'a.id',
            'ORDER' => ['a.created_at' => 'DESC'],
            'LIMIT' => 3
        ]);

        $bulan = [1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun', 7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des'];
        
        foreach ($latestStories as &$story) {
            $story['status_label'] = match ((int)$story['status']) {
                1 => 'Disetujui',
                2 => 'Ditolak',
                default => 'Menunggu',
            };

            $tanggal = date('j', strtotime($story['created_at']));
            $bulanIndo = $bulan[(int)date('n', strtotime($story['created_at']))];
            $tahun = date('Y', strtotime($story['created_at']));
            $story['created_at_formatted'] = "$tanggal $bulanIndo $tahun";
        }

        return $this->view->render($response, 'dashboards/admin.twig', [
            'user' => $_SESSION['user'],
            'pagetitle' => $this->pagetitle,
            'pageicon' => $this->pageicon,
            'routename' => $this->routename,
            'totalCerita' => $totalCerita,
            'totalKontributor' => $totalKontributor,
            'yangDisetujui' => $yangDisetujui,
            'yangDibayar' => $yangDibayar,
            'latestStories' => $latestStories
        ]);
    }
}
