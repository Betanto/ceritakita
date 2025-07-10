<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Medoo\Medoo;
use Rakit\Validation\Validator;
use Psr\Container\ContainerInterface;

class PaymentController
{
    protected $view;
    protected $db;
    protected $tablename;
    protected $pagetitle;
    protected $pageicon;
    protected $routename;

    public function __construct(ContainerInterface $container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
        $this->tablename = 'tbl_transactions';
        $this->pagetitle = 'Pembayaran';
        $this->pageicon = 'bi bi-cash';
        $this->routename = 'payments';
    }

    public function index(Request $request, Response $response, array $args)
    {
        $where = [
            'a.deleted_at' => null,
            'c.type' => 1,
            'a.status' => 1,
            'GROUP' => 'a.id'
        ];

        if (isset($_SESSION['user']['id_role']) && $_SESSION['user']['id_role'] == 2) {
            $where['a.id_user'] = $_SESSION['user']['id'];
        }


        $data = $this->db->select('tbl_articles (a)', [
            '[>]tbl_users (u)' => ['a.id_user' => 'id'],
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id'],
        ], [
            'a.id',
            'a.title',
            'a.status',
            'a.image',
            'a.file',
            'a.created_at',
            'a.payment_at',
            'a.amount',
            'u.name(user_name)',
            'c.name (categories)',
        ], $where);

        $bulan = [1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun', 7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des'];

        foreach ($data as &$article) {
            $categories = $this->db->select('tbl_articles_categories (ac)', [
                '[>]tbl_categories (c)' => ['ac.id_category' => 'id']
            ], ['c.name'], ['ac.id_article' => $article['id']]);

            $article['categories'] = array_column($categories, 'name');
            $article['status_label'] = match ((int)$article['status']) {
                1 => 'Disetujui',
                2 => 'Ditolak',
                default => 'Menunggu',
            };

            // Format tanggal
            if($article['payment_at']!=null){
                $tanggal = date('j', strtotime($article['payment_at']));
                $bulanIndo = $bulan[(int)date('n', strtotime($article['payment_at']))];
                $tahun = date('Y', strtotime($article['payment_at']));
                $time = date('H:i:s', strtotime($article['payment_at']));
                $article['payment_at_formatted'] = "$tanggal $bulanIndo $tahun $time";
            }else{
                $article['payment_at_formatted'] = "";
            }
        }

        

        return $this->view->render($response, $this->routename.'/list.twig', [
            'user' => $_SESSION['user'],
            'data' => $data,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon
        ]);
    }

    public function show(Request $request, Response $response, array $args)
    {
        $id = $args['id'];

        $article = $this->db->get('tbl_articles (a)', [
            '[>]tbl_users (u)' => ['a.id_user' => 'id'],
            '[>]tbl_users (up)' => ['a.payment_by' => 'id']
        ], [
            'a.id',
            'a.title',
            'a.content',
            'a.image',
            'a.file',
            'a.status',
            'a.payment_at',
            'a.payment_by',
            'a.amount',
            'a.created_at',
            'u.name(user_name)',
            'up.name(paid_by)'
        ], [
            'a.id' => $id,
            'a.deleted_at' => null
        ]);
        
        $bulan = [1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun', 7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des'];

        if($article['payment_at']!=null){
            $tanggal = date('j', strtotime($article['payment_at']));
            $bulanIndo = $bulan[(int)date('n', strtotime($article['payment_at']))];
            $tahun = date('Y', strtotime($article['payment_at']));
            $time = date('H:i:s', strtotime($article['payment_at']));
            $article['payment_at_formatted'] = "$tanggal $bulanIndo $tahun $time";
        }else{
            $article['payment_at_formatted'] = "";
        }

        if (!$article) {
            $_SESSION['flash_error'] = 'Artikel tidak ditemukan.';
            return $response->withHeader('Location', '/payments')->withStatus(302);
        }

        $categories = $this->db->select('tbl_articles_categories (ac)', [
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id']
        ], ['c.name'], ['ac.id_article' => $id]);
        $article['categories'] = array_column($categories, 'name');

        $bulan = [1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun', 7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des'];
        $tanggal = date('j', strtotime($article['created_at']));
        $bulanIndo = $bulan[(int)date('n', strtotime($article['created_at']))];
        $tahun = date('Y', strtotime($article['created_at']));
        $article['created_at_formatted'] = "$tanggal $bulanIndo $tahun";

        $review = $this->db->get('tbl_reviews', '*', [
            'id_article' => $id,
            'deleted_at' => null,
            'ORDER' => ['created_at' => 'DESC']
        ]);

        $review_history = $this->db->select('tbl_reviews', '*', [
            'id_article' => $id,
            'deleted_at' => null,
            'ORDER' => ['created_at' => 'DESC']
        ]);

        return $this->view->render($response, 'payments/show.twig', [
            'user' => $_SESSION['user'],
            'article' => $article,
            'review' => $review,
            'review_history' => $review_history,
            'pagetitle' => $this->pagetitle,
            'pageicon' => $this->pageicon,
            'routename' => $this->routename
        ]);
    }
    public function submitPayment(Request $request, Response $response, array $args)
    {
        $id_article = $args['id'];
        $data = $request->getParsedBody();
        $amount = str_replace('.','',$data['amount']);

        $id_user = $_SESSION['user']['id'];

        $this->db->update('tbl_articles', [
            'amount' => $amount,
            'payment_by' => $_SESSION['user']['id'],
            'payment_at' => date('Y-m-d H:i:s')
        ], ['id' => $id_article]);

        $_SESSION['flash_success'] = 'Data pembayaran berhasil dilakukan.';
        return $response->withHeader('Location', '/'.$this->routename)->withStatus(302);
    }
}
