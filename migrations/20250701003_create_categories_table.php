<?php

class CreateCategoriesTable
{
    public function up($db)
    {
        $db->query("
            CREATE TABLE IF NOT EXISTS tbl_categories (
                id INT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(35) NOT NULL,
                id_parent INT DEFAULT NULL,
                type INT DEFAULT NULL,
                status INT DEFAULT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                created_by INT DEFAULT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                updated_by INT DEFAULT NULL,
                deleted_at TIMESTAMP NULL DEFAULT NULL,
                deleted_by INT DEFAULT NULL
            )
        ");
    }

    public function down($db)
    {
        $db->query("DROP TABLE IF EXISTS tbl_categories");
    }
}
