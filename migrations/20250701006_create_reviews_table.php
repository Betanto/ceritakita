<?php

class CreateReviewsTable
{
    public function up($db)
    {
        $db->query("
            CREATE TABLE IF NOT EXISTS tbl_reviews (
                id INT AUTO_INCREMENT PRIMARY KEY,
                id_user INT NOT NULL,
                id_article INT NOT NULL,
                notes text DEFAULT NULL,
                status INT NOT NULL DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                created_by INT DEFAULT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                updated_by INT DEFAULT NULL,
                deleted_at TIMESTAMP NULL DEFAULT NULL,
                deleted_by INT DEFAULT NULL,
                CONSTRAINT fk_users_reviews FOREIGN KEY (id_user) REFERENCES tbl_users(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT,
                CONSTRAINT fk_articles_reviews FOREIGN KEY (id_article) REFERENCES tbl_articles(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT
            )
        ");
    }

    public function down($db)
    {
        $db->query("DROP TABLE IF EXISTS tbl_reviews");
    }
}
