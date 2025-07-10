<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Medoo\Medoo;
use Rakit\Validation\Validator;

class UserController
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
        $this->tablename = 'tbl_users';
        $this->pagetitle = 'Pengguna';
        $this->pageicon = 'bi bi-people';
        $this->routename = 'users';
    }

    public function index(Request $request, Response $response, array $args)
    {
        $data = $this->db->select('tbl_users (u)', [
            '[>]tbl_roles (r)' => ['u.id_role' => 'id']
        ], [
            'u.id',
            'u.name',
            'u.username',
            'u.status',
            'u.created_at',
            'u.updated_at',
            'r.name(role_name)'
        ], [
            'u.deleted_at' => null
        ]);

        return $this->view->render($response, $this->routename.'/list.twig', [
            'user' => $_SESSION['user'],
            'data' => $data,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon
        ]);
    }

    public function create(Request $request, Response $response, array $args)
    {
        $roles = $this->db->select('tbl_roles', '*');
        return $this->view->render($response, $this->routename.'/form.twig', [
            'user' => $_SESSION['user'],
            'roles' => $roles,
            'data' => null,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon,
            'action' => 'Tambah'
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
        $validator->addValidator('match', new class extends \Rakit\Validation\Rule {
            protected $message = ":attribute tidak sama";
            protected $fillableParams = ['other'];

            public function check($value): bool
            {
                $other = $this->parameter('other');
                return isset($this->input[$other]) && $value === $this->input[$other];
            }
        });
        $validation = $validator->make($data, [
            'username' => 'required|unique:tbl_users,username',
            // 'password' => 'required|min:6',
            'password' => 'required|match:konfirmasi_password',
            'name' => 'required',
            'id_role' => 'required'
        ]);
        $validation->setAliases([
            'username' => 'Email',
        ]);
        $validation->validate();

        if ($validation->fails()) {
            $roles = $this->db->select('tbl_roles', '*');
            $errors = $validation->errors();
            return $this->view->render($response, $this->routename.'/form.twig', [
                'user' => $_SESSION['user'],
                'roles' => $roles,
                'data' => null,
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
        $insertId = $this->db->insert($this->tablename, [
            'username' => $data['username'],
            'name' => $data['name'],
            'id_role' => $data['id_role'],
            'password' => password_hash($data['password'], PASSWORD_DEFAULT),
            'created_by' => $_SESSION['user']['id'],
            'updated_by' => $_SESSION['user']['id'],
            'status' => $status
        ]);

        if ($insertId) {
            $_SESSION['flash_success'] = 'Data berhasil ditambahkan.';
        } else {
            $_SESSION['flash_error'] = 'Gagal menambahkan data.';
        }

        return $response->withHeader('Location', '/'.$this->routename)->withStatus(302);
    }

    public function edit(Request $request, Response $response, array $args)
    {
        $data = $this->db->get($this->tablename, '*', ['id' => $args['id']]);
        $roles = $this->db->select('tbl_roles', '*');

        if (!$data) {
            // return $response->withStatus(404)->write('Buku tidak ditemukan');
            $response->getBody()->write('Data tidak ditemukan');
            return $response->withStatus(404);
        }

        return $this->view->render($response, $this->routename.'/form.twig', [
            'user' => $_SESSION['user'],
            'data' => $data,
            'roles' => $roles,
            'pagetitle' => $this->pagetitle,
            'routename' => $this->routename,
            'pageicon' => $this->pageicon,
            'action' => 'Ubah'
        ]);
    }

    public function update(Request $request, Response $response, array $args)
    {
        $data = $request->getParsedBody();
        $id = $args['id']; // ID dari URL
        $user = $this->db->get($this->tablename, '*', ['id' => $id]);
        if (!$user) {
            return $response->withStatus(404)->write("Data tidak ditemukan");
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
        $validator->addValidator('match', new class extends \Rakit\Validation\Rule {
            protected $message = ":attribute tidak sama";
            protected $fillableParams = ['other'];

            public function check($value): bool
            {
                $other = $this->parameter('other');
                return isset($this->input[$other]) && $value === $this->input[$other];
            }
        });

        // Jika password diisi, tambahkan validasi match konfirmasi_password
        // $rules = [
        //     'name' => 'required',
        //     'username' => 'required|unique_except:tbl_users,username,id',
        // ];

        // if (!empty($data['password'])) {
        //     $rules['password'] = 'match:konfirmasi_password';
        // }
        $validation = $validator->make($data, [
            'name' => 'required',
            'username' => 'required|unique_except:tbl_users,username,id',
        ]);

        // Custom label
        $validation->setAliases([
            'username' => 'Email',
        ]);

        $validation->validate();

        if ($validation->fails()) {
            $roles = $this->db->select('tbl_roles', '*');
            $errors = $validation->errors();
            return $this->view->render($response, $this->routename.'/form.twig', [
                'user' => $_SESSION['user'],
                'roles' => $roles,
                'pagetitle' => $this->pagetitle,
                'routename' => $this->routename,
                'pageicon' => $this->pageicon,
                'action' => 'Ubah',
                'errors' => $errors->firstOfAll(),
                'old'    => $data,
                'data' => $user
            ]);
        }

        if(isset($data['check_status'])){
            $status=1;
        }else{
            $status=0;
        }
        if(!empty($data['password'])){
            $password = password_hash($data['password'], PASSWORD_DEFAULT);
        } else {
            $password = $user['password'];
        }
        $updated = $this->db->update($this->tablename, [
            // (isset($data['password']) && !empty($data['password']) ? ['password' => password_hash($data['password'], PASSWORD_DEFAULT)] : []) +
            'name' => $data['name'],
            'password' => $password,
            'username' => $data['username'],
            'id_role' => $data['id_role'],
            'updated_by' => $_SESSION['user']['id'],
            'status' => $status
        ], ['id' => $args['id']]);

        if ($updated->rowCount() > 0) {
            $_SESSION['flash_success'] = 'Data berhasil diperbarui.';
        } else {
            $_SESSION['flash_error'] = 'Tidak ada data yang diubah atau gagal.';
        }

        return $response->withHeader('Location', '/'.$this->routename)->withStatus(302);
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
        return $response->withHeader('Location', '/'.$this->routename)->withStatus(302);
    }
}
