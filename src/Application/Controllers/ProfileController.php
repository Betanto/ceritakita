<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Medoo\Medoo;
use Rakit\Validation\Validator;

class ProfileController
{
    protected $view;
    protected $db;
    protected $pagetitle;
    protected $pageicon;

    public function __construct($container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
        $this->pagetitle = 'Profile';
        $this->pageicon = 'bi-person-circle';
    }

    public function index(Request $request, Response $response, array $args)
    {
        $userId = $_SESSION['user']['id'];
        $user = $this->db->get('tbl_users (u)', [
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
            'u.id' => $userId
        ]);

        return $this->view->render($response, 'profile/view.twig', [
            'user' => $_SESSION['user'],
            'profile' => $user,
            'pagetitle' => $this->pagetitle,
            'pageicon' => $this->pageicon
        ]);
    }

    public function edit(Request $request, Response $response, array $args)
    {
        $userId = $_SESSION['user']['id'];
        $user = $this->db->get('tbl_users', '*', ['id' => $userId]);

        if (!$user) {
            $response->getBody()->write('Data tidak ditemukan');
            return $response->withStatus(404);
        }

        return $this->view->render($response, 'profile/edit.twig', [
            'user' => $_SESSION['user'],
            'profile' => $user,
            'pagetitle' => $this->pagetitle,
            'pageicon' => $this->pageicon,
            'action' => 'Edit'
        ]);
    }

    public function update(Request $request, Response $response, array $args)
    {
        $data = $request->getParsedBody();
        $userId = $_SESSION['user']['id'];
        
        $user = $this->db->get('tbl_users', '*', ['id' => $userId]);
        if (!$user) {
            return $response->withStatus(404)->write("Data tidak ditemukan");
        }

        // Manual validation untuk menghindari error custom validator
        $errors = [];

        // Validasi nama
        if (empty($data['name']) || strlen(trim($data['name'])) < 2) {
            $errors['name'] = 'Nama harus minimal 2 karakter';
        }

        // Validasi email
        if (empty($data['username']) || !filter_var($data['username'], FILTER_VALIDATE_EMAIL)) {
            $errors['username'] = 'Format email tidak valid';
        } else {
            // Cek email unique kecuali milik user sendiri
            $existingUser = $this->db->get('tbl_users', 'id', [
                'username' => $data['username'],
                'id[!]' => $userId,
                'deleted_at' => null
            ]);
            
            if ($existingUser) {
                $errors['username'] = 'Email sudah digunakan';
            }
        }

        // Validasi password jika diisi
        if (!empty($data['password'])) {
            if (strlen($data['password']) < 8) {
                $errors['password'] = 'Password minimal 8 karakter';
            } elseif (!preg_match('/[A-Z]/', $data['password'])) {
                $errors['password'] = 'Password harus mengandung huruf besar';
            } elseif (!preg_match('/[a-z]/', $data['password'])) {
                $errors['password'] = 'Password harus mengandung huruf kecil';
            } elseif (!preg_match('/[0-9]/', $data['password'])) {
                $errors['password'] = 'Password harus mengandung angka';
            } elseif (!preg_match('/[!@#$%^&*(),.?":{}|<>]/', $data['password'])) {
                $errors['password'] = 'Password harus mengandung simbol';
            }

            // Validasi konfirmasi password
            if (empty($data['confirm_password'])) {
                $errors['confirm_password'] = 'Konfirmasi password harus diisi';
            } elseif ($data['password'] !== $data['confirm_password']) {
                $errors['confirm_password'] = 'Konfirmasi password tidak sama';
            }
        }

        // Jika ada error, kembali ke form
        if (!empty($errors)) {
            return $this->view->render($response, 'profile/edit.twig', [
                'user' => $_SESSION['user'],
                'profile' => $user,
                'pagetitle' => $this->pagetitle,
                'pageicon' => $this->pageicon,
                'action' => 'Edit',
                'errors' => $errors,
                'old' => $data,
            ]);
        }

        // Prepare data untuk update
        $updateData = [
            'name' => trim($data['name']),
            'username' => trim($data['username']),
            'updated_by' => $userId,
            'updated_at' => date('Y-m-d H:i:s')
        ];

        // Jika password diisi, hash dan tambahkan ke data update
        if (!empty($data['password'])) {
            $updateData['password'] = password_hash($data['password'], PASSWORD_DEFAULT);
        }

        try {
            $updated = $this->db->update('tbl_users', $updateData, ['id' => $userId]);

            // Update session data
            $_SESSION['user']['name'] = $updateData['name'];
            $_SESSION['user']['username'] = $updateData['username'];
            
            $_SESSION['flash_success'] = 'Profile berhasil diperbarui.';
        } catch (Exception $e) {
            $_SESSION['flash_error'] = 'Gagal memperbarui profile: ' . $e->getMessage();
        }

        return $response->withHeader('Location', '/profile')->withStatus(302);
    }

    public function listUsers(Request $request, Response $response, array $args)
    {
        // Check if user is admin
        if ($_SESSION['user']['id_role'] != 1) {
            return $response->withHeader('Location', '/dashboard')->withStatus(302);
        }

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

        return $this->view->render($response, 'profile/list.twig', [
            'user' => $_SESSION['user'],
            'data' => $data,
            'pagetitle' => 'Kelola Pengguna',
            'routename' => 'profile',
            'pageicon' => 'bi-people'
        ]);
    }

    public function deleteUser(Request $request, Response $response, array $args)
    {
        // Check if user is admin
        if ($_SESSION['user']['id_role'] != 1) {
            return $response->withHeader('Location', '/dashboard')->withStatus(302);
        }

        $userId = $args['id'];
        
        // Prevent admin from deleting themselves
        if ($userId == $_SESSION['user']['id']) {
            $_SESSION['flash_error'] = 'Anda tidak dapat menghapus akun sendiri.';
            return $response->withHeader('Location', '/profile/users')->withStatus(302);
        }

        $deleted = $this->db->update('tbl_users', [
            'deleted_at' => Medoo::raw('NOW()'),
            'deleted_by' => $_SESSION['user']['id']
        ], ['id' => $userId]);

        if ($deleted->rowCount() > 0) {
            $_SESSION['flash_success'] = 'Pengguna berhasil dihapus.';
        } else {
            $_SESSION['flash_error'] = 'Gagal menghapus pengguna.';
        }

        return $response->withHeader('Location', '/profile/users')->withStatus(302);
    }
}
