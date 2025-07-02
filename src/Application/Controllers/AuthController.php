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
}
