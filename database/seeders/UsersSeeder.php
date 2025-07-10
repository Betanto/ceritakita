<?php
use Medoo\Medoo;

return function (Medoo $db) {
    $username = 'admin@mail.com';

    if (!$db->has('tbl_users', ['username' => $username])) {
        $db->insert('tbl_users', [
            'username' => $username,
            'password' => password_hash('admin123', PASSWORD_DEFAULT),
            'name' => 'Admin',
            'status' => 1,
            'created_by' => 1,
            'updated_by' => 1,
            'id_role' => 1
        ]);
        echo "[OK] User admin inserted.\n";
    } else {
        echo "[SKIP] User already exists.\n";
    }
};
