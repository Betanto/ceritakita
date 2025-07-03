<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Medoo\Medoo;

class CategoryController
{
    protected $view;
    protected $db;
    protected $tablename;
    protected $pagetitle;
    protected $pageicon;
    protected $routename;

    public function __construct($container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
        $this->tablename = 'tbl_categories';
        $this->pagetitle = 'Kategori';
        $this->pageicon = 'bi bi-columns-gap';
        $this->routename = 'categories';
    }

    public function index(Request $request, Response $response)
    {
        // $categories = $this->db->select($this->tablename, '*',[
        //     'deleted_at'=>null
        // ]);
        $categories = $this->db->select('tbl_categories (c)', [
            '[>]tbl_categories (p)' => ['id_parent' => 'id']
        ], [
            'c.id',
            'c.name',
            'c.id_parent',
            'c.status',
            'p.id(parent_id)',
            'p.name(parent_name)'
        ], [
            'c.deleted_at' => null
        ]);

        return $this->view->render($response, 'categories/list.twig', [
            'user' => $_SESSION['user'],
            'categories' => $categories,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon
        ]);
    }

    public function create(Request $request, Response $response)
    {
        $categories = $this->db->select($this->tablename, '*', ['deleted_at'=>null]);
        return $this->view->render($response, 'categories/form.twig', [
            'user' => $_SESSION['user'],
            'parent' => $categories,
            'category' => null,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon,
            'action' => 'Tambah'
        ]);
    }

    public function store(Request $request, Response $response)
    {
        $data = $request->getParsedBody();

        if(isset($data['check_status'])){
            $status=1;
        }else{
            $status=0;
        }

        $baseSlug = slugify($data['name']);
        $slug = $baseSlug;
        $counter = 1;

        while ($this->db->has($this->tablename, ['slug' => $slug])) {
            $slug = $baseSlug . '-' . $counter;
            $counter++;
        }

        $insertId = $this->db->insert($this->tablename, [
            'name' => $data['name'],
            'slug' => $slug,
            'id_parent' => $data['id_parent'],
            'type' => 'Post',
            'status' => $status
        ]);

        if ($insertId) {
            $_SESSION['flash_success'] = 'Kategori berhasil ditambahkan.';
        } else {
            $_SESSION['flash_error'] = 'Gagal menambahkan kategori.';
        }

        return $response->withHeader('Location', '/categories')->withStatus(302);
    }

    public function edit(Request $request, Response $response, array $args)
    {
        $category = $this->db->get($this->tablename, '*', ['id' => $args['id']]);
        $categories = $this->db->select($this->tablename, '*', [
            'id[!]' => $args['id'],
            'deleted_at' => null
        ]);

        if (!$category) {
            // return $response->withStatus(404)->write('Buku tidak ditemukan');
            $response->getBody()->write('Kategori tidak ditemukan');
            return $response->withStatus(404);
        }

        return $this->view->render($response, 'categories/form.twig', [
            'user' => $_SESSION['user'],
            'category' => $category,
            'parent' => $categories,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon,
            'action' => 'Ubah'
        ]);
    }

    public function update(Request $request, Response $response, array $args)
    {
        $data = $request->getParsedBody();

        if(isset($data['check_status'])){
            $status=1;
        }else{
            $status=0;
        }

        $updated = $this->db->update($this->tablename, [
            'name' => $data['name'],
            'id_parent' => $data['id_parent'],
            'type' => 'Post',
            'status' => $status
        ], ['id' => $args['id']]);

        if ($updated->rowCount() > 0) {
            $_SESSION['flash_success'] = 'Kategori berhasil diperbarui.';
        } else {
            $_SESSION['flash_error'] = 'Tidak ada data yang diubah atau gagal.';
        }

        return $response->withHeader('Location', '/categories')->withStatus(302);
    }

    public function delete(Request $request, Response $response, array $args)
    {
        // $deleted = $this->db->delete($this->tablename, ['id' => $args['id']]);
        $deleted = $this->db->update($this->tablename, [
            'deleted_at' => Medoo::raw('NOW()'),
            'deleted_by' => $_SESSION['user']['id']
        ], ['id' => $args['id']]);
        if ($deleted->rowCount() > 0) {
            $_SESSION['flash_success'] = 'Kategori berhasil dihapus.';
        } else {
            $_SESSION['flash_error'] = 'Gagal menghapus kategori.';
        }
        return $response->withHeader('Location', '/categories')->withStatus(302);
    }
}
