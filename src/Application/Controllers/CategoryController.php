<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Medoo\Medoo;
use Rakit\Validation\Validator;

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

    public function index(Request $request, Response $response, array $args)
    {
        // $categories = $this->db->select($this->tablename, '*',[
        //     'deleted_at'=>null
        // ]);
        if($args['type']=="posts"){
            $type=0;
        }else{
            $type=1;
        }
        $categories = $this->db->select('tbl_categories (c)', [
            '[>]tbl_categories (p)' => ['id_parent' => 'id'],
            'tbl_categories (c)' => ['type'=> $type]
        ], [
            'c.id',
            'c.name',
            'c.id_parent',
            'c.status',
            'c.type',
            'p.id(parent_id)',
            'p.name(parent_name)'
        ], [
            'c.deleted_at' => null,
            'c.type' => $type
        ]);

        return $this->view->render($response, 'categories/list.twig', [
            'user' => $_SESSION['user'],
            'categories' => $categories,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon,
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
        $categories = $this->db->select($this->tablename, '*', ['deleted_at'=>null,'type' => $type]);
        return $this->view->render($response, $this->routename.'/form.twig', [
            'user' => $_SESSION['user'],
            'parent' => $categories,
            'category' => null,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon,
            'action' => 'Tambah',
            'type'=> $args['type']
        ]);
    }

    public function store(Request $request, Response $response)
    {
        $data = $request->getParsedBody();

        $validator = new Validator;
        $validator->addValidator('unique', new class($this->db) extends \Rakit\Validation\Rule {
            protected $message = ":attribute sudah digunakan";
            protected $fillableParams = ['table', 'column'];
            protected $db;

            public function __construct(Medoo $db)
            {
                $this->db = $db;
            }

            public function check($value): bool
            {
                $table = $this->parameter('table');
                $column = $this->parameter('column');

                $count = $this->db->count($table, [$column => $value,'deleted_at' => null]);

                return $count === 0;
            }
        });
        $validation = $validator->make($data, [
            'name' => 'required|unique:tbl_categories,name',
        ]);
        $validation->setAliases([
            'name' => 'Judul',
        ]);
        $validation->validate();

        if ($validation->fails()) {
            $categories = $this->db->select($this->tablename, '*', ['deleted_at'=>null]);
            $errors = $validation->errors();
            return $this->view->render($response, 'categories/form.twig', [
                'user' => $_SESSION['user'],
                'parent' => $categories,
                'category' => null,
                'pagetitle' => $this->pagetitle,
                'routename' => $this->routename,
                'pageicon' => $this->pageicon,
                'action' => 'Tambah',
                'errors' => $errors->firstOfAll(),
                'old'    => $data,
            ]);
        }

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
        if($data['type']=="posts"){
            $type=0;
        }else{
            $type=1;
        }
        $insertId = $this->db->insert($this->tablename, [
            'name' => $data['name'],
            'slug' => $slug,
            'id_parent' => $data['id_parent'],
            'type' => $type,
            'created_by' => $_SESSION['user']['id'],
            'updated_by' => $_SESSION['user']['id'],
            'status' => $status
        ]);

        if ($insertId) {
            $_SESSION['flash_success'] = 'Kategori berhasil ditambahkan.';
        } else {
            $_SESSION['flash_error'] = 'Gagal menambahkan kategori.';
        }

        return $response->withHeader('Location', '/categories/' . $data['type'])->withStatus(302);
    }

    public function edit(Request $request, Response $response, array $args)
    {
        if($args['type']=="posts"){
            $type=0;
        }else{
            $type=1;
        }
        $category = $this->db->get($this->tablename, '*', ['id' => $args['id']]);
        $categories = $this->db->select($this->tablename, '*', [
            'id[!]' => $args['id'],
            'deleted_at' => null,
            'type' => $type
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
            'action' => 'Ubah',
            'type'=> $args['type']
        ]);
    }

    public function update(Request $request, Response $response, array $args)
    {
        $data = $request->getParsedBody();
        if($data['type']=="posts"){
            $type=0;
        }else{
            $type=1;
        }
        
        $id = $args['id']; // ID dari URL
        $category = $this->db->get('tbl_categories', '*', ['id' => $id]);
        if (!$category) {
            return $response->withStatus(404)->write("Kategori tidak ditemukan");
        }
        $validator = new Validator;
        $validator->addValidator('unique_except', new class($this->db, $id) extends \Rakit\Validation\Rule {
            protected $message = ":attribute sudah digunakan";
            protected $fillableParams = ['table', 'column', 'except_column'];
            protected $db;
            protected $exceptId;

            public function __construct(Medoo $db, $exceptId)
            {
                $this->db = $db;
                $this->exceptId = $exceptId;
            }

            public function check($value): bool
{
                $table        = $this->parameter('table');
                $column       = $this->parameter('column');
                $exceptColumn = $this->parameter('except_column') ?? 'id';

                $count = $this->db->count($table, [
                    "AND" => [
                        $column . "[=]" => $value,
                        $exceptColumn . "[!]" => $this->exceptId,
                        'deleted_at' => null
                    ]
                ]);

                return $count === 0;
            }
        });

        $validation = $validator->make($data, [
            'name' => 'required|unique_except:tbl_categories,name,id',
        ]);

        // Custom label
        $validation->setAliases([
            'name' => 'Judul',
        ]);

        $validation->validate();

        if ($validation->fails()) {
            $categories = $this->db->select($this->tablename, '*', [
                'id[!]' => $args['id'],
                'deleted_at' => null
            ]);
            $errors = $validation->errors();
            return $this->view->render($response, 'categories/form.twig', [
                'user' => $_SESSION['user'],
                'category' => $category,
                'parent' => $categories,
                'pagetitle' => $this->pagetitle,
                'routename' => $this->routename,
                'pageicon' => $this->pageicon,
                'action' => 'Ubah',
                'errors' => $errors->firstOfAll(),
                'old'    => $data,
                'category' => $category,
                'type'=> $data['type']
            ]);
        }

        if(isset($data['check_status'])){
            $status=1;
        }else{
            $status=0;
        }

        $updated = $this->db->update($this->tablename, [
            'name' => $data['name'],
            'id_parent' => $data['id_parent'],
            'updated_by' => $_SESSION['user']['id'],
            'status' => $status
        ], ['id' => $args['id']]);

        if ($updated->rowCount() > 0) {
            $_SESSION['flash_success'] = 'Kategori berhasil diperbarui.';
        } else {
            $_SESSION['flash_error'] = 'Tidak ada data yang diubah atau gagal.';
        }

        return $response->withHeader('Location', '/categories/' . $data['type'])->withStatus(302);
    }

    public function delete(Request $request, Response $response, array $args)
    {
        // $deleted = $this->db->delete($this->tablename, ['id' => $args['id']]);
        if($args['type']=="posts"){
            $type=0;
        }else{
            $type=1;
        }
        $deleted = $this->db->update($this->tablename, [
            'deleted_at' => Medoo::raw('NOW()'),
            'deleted_by' => $_SESSION['user']['id']
        ], ['id' => $args['id']]);
        if ($deleted->rowCount() > 0) {
            $_SESSION['flash_success'] = 'Kategori berhasil dihapus.';
        } else {
            $_SESSION['flash_error'] = 'Gagal menghapus kategori.';
        }
        return $response->withHeader('Location', '/categories/' . $args['type'])->withStatus(302);
    }
}
