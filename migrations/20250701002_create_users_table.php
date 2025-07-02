<?php

class CreateUsersTable
{
    public function up($db)
    {
        $db->query("
            CREATE TABLE IF NOT EXISTS tbl_users (
                id INT AUTO_INCREMENT PRIMARY KEY,
                username VARCHAR(255) NOT NULL,
                password VARCHAR(255) NOT NULL,
                name VARCHAR(255) NOT NULL,
                id_role INT NOT NULL,
                status INT DEFAULT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                created_by INT DEFAULT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                updated_by INT DEFAULT NULL,
                deleted_at TIMESTAMP DEFAULT NULL,
                deleted_by INT DEFAULT NULL,
                INDEX idx_role (id_role),
                CONSTRAINT fk_users_roles FOREIGN KEY (id_role) REFERENCES tbl_roles(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT
            )
        ");
    }

    public function down($db)
    {
        $db->query("DROP TABLE IF EXISTS tbl_users");
    }
}
