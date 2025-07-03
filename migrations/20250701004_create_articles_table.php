<?php

class CreateArticlesTable
{
    public function up($db)
    {
        $db->query("
            CREATE TABLE IF NOT EXISTS tbl_articles (
                id INT AUTO_INCREMENT PRIMARY KEY,
                id_user INT NOT NULL,
                id_parent INT DEFAULT NULL,
                title VARCHAR(255) NOT NULL,
                slug VARCHAR(255) NOT NULL,
                image VARCHAR(255) DEFAULT NULL,
                file VARCHAR(255) DEFAULT NULL,
                content text DEFAULT NULL,
                status INT NOT NULL DEFAULT 0,
                payment_at datetime DEFAULT NULL,
                payment_by INT DEFAULT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                created_by INT DEFAULT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                updated_by INT DEFAULT NULL,
                deleted_at TIMESTAMP NULL DEFAULT NULL,
                deleted_by INT DEFAULT NULL,
                CONSTRAINT fk_users FOREIGN KEY (id_user) REFERENCES tbl_users(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT
            )
        ");
    }

    public function down($db)
    {
        $db->query("DROP TABLE IF EXISTS tbl_articles");
    }
}
