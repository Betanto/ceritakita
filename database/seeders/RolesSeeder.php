<?php
use Medoo\Medoo;

return function (Medoo $db) {
    $roles = [
        ['id' => 1, 'name' => 'Admin'],
        ['id' => 2, 'name' => 'Kontributor'],
    ];

    foreach ($roles as $role) {
        $exists = $db->has('tbl_roles', ['id' => $role['id']]);
        if (!$exists) {
            $db->insert('tbl_roles', $role);
            echo "[OK] Role '{$role['name']}' inserted.\n";
        } else {
            echo "[SKIP] Role '{$role['name']}' already exists.\n";
        }
    }
};
