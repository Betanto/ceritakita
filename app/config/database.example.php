<?php
use Medoo\Medoo;

$container->set('db', function () {
    return new Medoo([
        'type' => 'mysql',
        'host' => 'localhost',
        'database' => '',
        'username' => '',
        'password' => '',
        'charset' => 'utf8mb4',
    ]);
});
