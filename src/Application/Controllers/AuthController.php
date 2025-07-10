<?php
namespace App\Application\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class AuthController
{
    protected $view;
    protected $db;

    public function __construct($container)
    {
        $this->view = $container->get('view');
        $this->db = $container->get('db');
    }

    public function loginPage(Request $request, Response $response)
    {
        return $this->view->render($response, 'auth/login.twig');
    }

    public function login(Request $request, Response $response)
    {
        $data = $request->getParsedBody();
        $user = $this->db->get('tbl_users', '*', [
            'username' => $data['username']
        ]);

        if ($user && password_verify($data['password'], $user['password'])) {
            $_SESSION['user'] = $user;
            return $response->withHeader('Location', '/dashboard')->withStatus(302);
        } else {
            return $this->view->render($response, 'auth/login.twig', ['error' => 'Invalid credentials']);
        }
    }

    public function logout(Request $request, Response $response)
    {
        $_SESSION = [];
        session_destroy();
        return $response->withHeader('Location', '/login')->withStatus(302);
    }

    //REGISTER PAGE
    public function registerPage(Request $request, Response $response)
    {
        return $this->view->render($response, 'auth/register.twig');
    }

    //HANDLE FORM REGISTER
    public function register(Request $request, Response $response)
    {
        $data = $request->getParsedBody();
        $username = trim($data['email'] ?? '');
        $name = trim($data['name'] ?? '');
        $password = trim($data['password'] ?? '');

        if (!$username || !$password) {
            $stream = new \Slim\Psr7\Stream(fopen('php://temp', 'r+'));
            $stream->write(json_encode(['status' => 'error', 'message' => 'Email dan password wajib diisi.']));
            $stream->rewind();
            return $response->withHeader('Content-Type', 'application/json')
                ->withStatus(400)
                ->withBody($stream);
        }

        // Cek apakah username sudah ada
        $existing = $this->db->get('tbl_users', '*', ['username' => $username]);
        if ($existing) {
            $stream = new \Slim\Psr7\Stream(fopen('php://temp', 'r+'));
            $stream->write(json_encode(['status' => 'error', 'message' => 'Email sudah digunakan.']));
            $stream->rewind();
            return $response->withHeader('Content-Type', 'application/json')
                ->withStatus(409)
                ->withBody($stream);
        }

        // Simpan user baru dengan id_role=2
        $this->db->insert('tbl_users', [
            'username' => $username,
            'name' => $name,
            'password' => password_hash($password, PASSWORD_DEFAULT),
            'id_role' => 2,
            'status' => 1
        ]);

        $stream = new \Slim\Psr7\Stream(fopen('php://temp', 'r+'));
        $stream->write(json_encode(['status' => 'success', 'message' => 'Akun berhasil dibuat. Silakan login.']));
        $stream->rewind();
        return $response->withHeader('Content-Type', 'application/json')
            ->withStatus(201)
            ->withBody($stream);
        // $data = $request->getParsedBody();
        // $username = trim($data['username'] ?? '');
        // $password = trim($data['password'] ?? '');

        // if (!$username || !$password) {
        //     $_SESSION['flash_error'] = 'Username dan password wajib diisi.';
        //     return $response->withHeader('Location', '/register')->withStatus(302);
        // }

        // // Cek apakah username sudah ada
        // $existing = $this->db->get('tbl_users', '*', ['username' => $username]);
        // if ($existing) {
        //     $_SESSION['flash_error'] = 'Username sudah digunakan.';
        //     return $response->withHeader('Location', '/register')->withStatus(302);
        // }

        // // Simpan user baru
        // $this->db->insert('tbl_users', [
        //     'username' => $username,
        //     'password' => password_hash($password, PASSWORD_DEFAULT),
        // ]);

        // $_SESSION['flash_success'] = 'Akun berhasil dibuat. Silakan login.';
        // return $response->withHeader('Location', '/login')->withStatus(302);
    }
}
