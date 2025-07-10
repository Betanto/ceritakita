<?php

namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Medoo\Medoo;
use Rakit\Validation\Validator;
use Psr\Container\ContainerInterface;

class ArticleController
{
    protected $view;
    protected $db;
    protected $tablename = 'tbl_articles';
    protected $pagetitle = 'Post';
    protected $pageicon = 'bi bi-file-earmark-text';
    protected $routename = 'articles';

    public function __construct(ContainerInterface $container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
    }

    public function index(Request $request, Response $response, array $args)
    {
        if($args['type']=="posts"){
            $type=0;
        }else{
            $type=1;
        }
        $where = [
            'a.deleted_at' => null,
            'c.type' => $type,
            'GROUP' => 'a.id'
        ];

        if (isset($_SESSION['user']['id_role']) && $_SESSION['user']['id_role'] == 2) {
            $where['a.id_user'] = $_SESSION['user']['id'];
        }

        // Tambahkan order jika type=stories
        if ($args['type'] === 'stories') {
            $where['ORDER'] = [
            'a.status' => 'ASC',
            'a.updated_at' => 'DESC'
            ];
        }

        $articles = $this->db->select('tbl_articles (a)', [
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
            'u.name(user_name)',
            'c.name (categories)',
        ], $where);
        // 'a.id_user' => $_SESSION['user']['id'],

        $bulan = [1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun', 7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des'];

        foreach ($articles as &$article) {
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
            $tanggal = date('j', strtotime($article['created_at']));
            $bulanIndo = $bulan[(int)date('n', strtotime($article['created_at']))];
            $tahun = date('Y', strtotime($article['created_at']));
            $article['created_at_formatted'] = "$tanggal $bulanIndo $tahun";
        }

        return $this->view->render($response, $this->routename.'/list.twig', [
            'user' => $_SESSION['user'],
            'articles' => $articles,
            'pagetitle' => $this->pagetitle,
            'pageicon' => $this->pageicon,
            'routename' => $this->routename,
            'type'=> $args['type']
        ]);
    }

    public function create(Request $request, Response $response, array $args)
    {
        if($args['type']=="posts"){
            $type=0;
        }else{
            $type=1;
        }
        $categories = $this->db->select('tbl_categories', '*', ['deleted_at' => null,'status'=>1,'type' => $type]);
        $parentArticles = $this->db->select($this->tablename, ['id', 'title'], ['deleted_at' => null]);

        return $this->view->render($response, $this->routename.'/form.twig', [
            'user' => $_SESSION['user'],
            'article' => null,
            'categories' => $categories,
            'parentArticles' => $parentArticles,
            'pagetitle' => $this->pagetitle,
            'pageicon' => $this->pageicon,
            'routename' => $this->routename,
            'action' => 'Tambah',
            'type'=> $args['type']
        ]);
    }

    public function show(Request $request, Response $response, array $args)
    {
        $id = $args['id'];

        $article = $this->db->get('tbl_articles (a)', [
            '[>]tbl_users (u)' => ['a.id_user' => 'id']
        ], [
            'a.id',
            'a.title',
            'a.content',
            'a.image',
            'a.file',
            'a.status',
            'a.created_at',
            'u.name(user_name)'
        ], [
            'a.id' => $id,
            'a.deleted_at' => null
        ]);

        if (!$article) {
            $_SESSION['flash_error'] = 'Artikel tidak ditemukan.';
            return $response->withHeader('Location', '/articles')->withStatus(302);
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

        return $this->view->render($response, 'articles/show.twig', [
            'user' => $_SESSION['user'],
            'article' => $article,
            'review' => $review,
            'review_history' => $review_history,
            'pagetitle' => $this->pagetitle,
            'pageicon' => $this->pageicon,
            'routename' => $this->routename,
            'type'=> $args['type']
        ]);
    }

    public function store(Request $request, Response $response)
    {
        return $this->save($request, $response);
    }

    public function edit(Request $request, Response $response, array $args)
    {
        if($args['type']=="posts"){
            $type=0;
        }else{
            $type=1;
        }
        $id = $args['id'];
        $article = $this->db->get($this->tablename, '*', ['id' => $id, 'deleted_at' => null]);
        if (!$article) {
            $_SESSION['flash_error'] = 'Data artikel tidak ditemukan.';
            return $response->withHeader('Location', '/articles')->withStatus(302);
        }

        $article['categories'] = $this->db->select('tbl_articles_categories', 'id_category', ['id_article' => $id]);
        $categories = $this->db->select('tbl_categories', '*', ['deleted_at' => null,'status'=>1,'type' => $type]);
        $parentArticles = $this->db->select('tbl_articles', ['id', 'title'], [
            'deleted_at' => null,
            'id[!]' => $id
        ]);

        return $this->view->render($response, 'articles/form.twig', [
            'user' => $_SESSION['user'],
            'article' => $article,
            'categories' => $categories,
            'parentArticles' => $parentArticles,
            'pagetitle' => $this->pagetitle,
            'pageicon' => $this->pageicon,
            'routename' => $this->routename,
            'action' => 'Edit',
            'selectedCategories' => $article['categories'],
            'type'=> $args['type']
        ]);
    }

    public function update(Request $request, Response $response, array $args)
    {
        return $this->save($request, $response, $args['id']);
    }

    private function save(Request $request, Response $response, $id = null)
    {
        $data = $request->getParsedBody();
        $files = $request->getUploadedFiles();

        $validator = new Validator;
        $validation = $validator->make($data, [
            'title' => 'required',
            'id_category' => 'required|array'
        ]);
        $validation->validate();
        $errors = $validation->errors()->firstOfAll();

        $maxImageSize = 2 * 1024 * 1024;
        $maxFileSize = 5 * 1024 * 1024;

        $image = $files['image'] ?? null;
        $file = $files['file'] ?? null;

        if ($image && $image->getError() === UPLOAD_ERR_OK) {
            if ($image->getSize() > $maxImageSize) {
                $errors['image'] = 'Ukuran gambar maksimal 2MB.';
            }
            $allowedImageTypes = ['image/jpeg', 'image/png'];
            if (!in_array($image->getClientMediaType(), $allowedImageTypes)) {
                $errors['image'] = 'Format gambar hanya JPG atau PNG.';
            }
        }

        if ($file && $file->getError() === UPLOAD_ERR_OK) {
            if ($file->getSize() > $maxFileSize) {
                $errors['file'] = 'Ukuran file maksimal 5MB.';
            }
            $allowedFileTypes = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/zip', 'application/x-zip-compressed'];
            if (!in_array($file->getClientMediaType(), $allowedFileTypes)) {
                $errors['file'] = 'Lampiran hanya boleh PDF, DOC, DOCX, atau ZIP.';
            }
        }

        if (!empty($errors)) {
            $categories = $this->db->select('tbl_categories', '*', ['deleted_at' => null,'status'=>1,'type' => $type]);
            $parentArticles = $this->db->select('tbl_articles', ['id', 'title'], ['deleted_at' => null]);
            $article = $id ? $this->db->get($this->tablename, '*', ['id' => $id]) : null;

            return $this->view->render($response, 'articles/form.twig', [
                'user' => $_SESSION['user'],
                'article' => $article,
                'categories' => $categories,
                'parentArticles' => $parentArticles,
                'pagetitle' => $this->pagetitle,
                'pageicon' => $this->pageicon,
                'routename' => $this->routename,
                'action' => $id ? 'Edit' : 'Tambah',
                'errors' => $errors,
                'type' => $data['type'],
                'old' => $data
            ]);
        }

        $slug = slugify($data['title']);
        if($data['type']=='posts'){
            if(isset($data['check_status'])){
                $status=1;
            }else{
                $status=0;
            }
        }else{
            $status = 0;
        }
        $idParent = !empty($data['id_parent']) ? (int)$data['id_parent'] : 0;

        $imageName = null;
        if ($image && $image->getError() === UPLOAD_ERR_OK) {
            $imageName = uniqid() . '_' . $image->getClientFilename();
            $image->moveTo(__DIR__ . '/../../../public/uploads/images/' . $imageName);
        }

        $fileName = null;
        if ($file && $file->getError() === UPLOAD_ERR_OK) {
            $fileName = uniqid() . '_' . $file->getClientFilename();
            $file->moveTo(__DIR__ . '/../../../public/uploads/files/' . $fileName);
        }

        $dataToSave = [
            'id_user' => $_SESSION['user']['id'],
            'id_parent' => $idParent,
            'title' => $data['title'],
            'slug' => $slug,
            'content' => $data['content'],
            'status' => $status,
            'updated_by' => $_SESSION['user']['id']
        ];
        if ($imageName) $dataToSave['image'] = $imageName;
        if ($fileName) $dataToSave['file'] = $fileName;

        if ($id) {
            $this->db->update($this->tablename, $dataToSave, ['id' => $id]);
            $this->db->delete('tbl_articles_categories', ['id_article' => $id]);
            $articleId = $id;
            $_SESSION['flash_success'] = 'Artikel berhasil diperbarui.';
        } else {
            $dataToSave['created_by'] = $_SESSION['user']['id'];
            $this->db->insert($this->tablename, $dataToSave);
            $articleId = $this->db->id();
            $_SESSION['flash_success'] = 'Artikel berhasil ditambahkan.';
        }

        foreach ($data['id_category'] as $catId) {
            $this->db->insert('tbl_articles_categories', [
                'id_article' => $articleId,
                'id_category' => $catId
            ]);
        }

        return $response->withHeader('Location', '/'.$this->routename.'/'.$data['type'])->withStatus(302);
    }

    public function submitReview(Request $request, Response $response, array $args)
    {
        $id_article = $args['id'];
        $data = $request->getParsedBody();
        $notes = trim($data['notes']);
        $status = (int)($data['status'] ?? 0);

        $id_user = $_SESSION['user']['id'];

        $this->db->insert('tbl_reviews', [
            'id_user' => $id_user,
            'id_article' => $id_article,
            'notes' => $notes,
            'status' => $status,
            'created_by' => $id_user,
            'created_at' => date('Y-m-d H:i:s')
        ]);

        $this->db->update('tbl_articles', [
            'status' => $status,
            'updated_by' => $id_user,
            'updated_at' => date('Y-m-d H:i:s')
        ], ['id' => $id_article]);

        $_SESSION['flash_success'] = 'Feedback berhasil ditambahkan.';
        return $response->withHeader('Location', '/'.$this->routename.'/'.$data['type'])->withStatus(302);
    }

    public function delete(Request $request, Response $response, array $args)
    {
        $deleted = $this->db->update($this->tablename, [
            'deleted_at' => Medoo::raw('NOW()'),
            'deleted_by' => $_SESSION['user']['id']
        ], ['id' => $args['id']]);
        if ($deleted->rowCount() > 0) {
            $_SESSION['flash_success'] = 'Data berhasil dihapus.';
        } else {
            $_SESSION['flash_error'] = 'Gagal menghapus data.';
        }
        return $response->withHeader('Location', '/'.$this->routename.'/'.$args['type'])->withStatus(302);
    }
}
