<?php

class CreateRolesTable
{
    public function up($db)
    {
        $db->query("
            CREATE TABLE IF NOT EXISTS tbl_roles (
                id INT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL
            )
        ");
    }

    public function down($db)
    {
        $db->query("DROP TABLE IF EXISTS tbl_roles");
    }
}
