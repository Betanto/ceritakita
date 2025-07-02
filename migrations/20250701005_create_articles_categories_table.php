<?php

class CreateArticlesCategoriesTable
{
    public function up($db)
    {
        $db->query("
            CREATE TABLE IF NOT EXISTS tbl_articles_categories (
                id INT AUTO_INCREMENT PRIMARY KEY,
                id_category INT NOT NULL,
                id_article INT NOT NULL,
                CONSTRAINT fk_categories FOREIGN KEY (id_category) REFERENCES tbl_categories(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT,
                CONSTRAINT fk_articles FOREIGN KEY (id_article) REFERENCES tbl_articles(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT
            )
        ");
    }

    public function down($db)
    {
        $db->query("DROP TABLE IF EXISTS tbl_articles_categories");
    }
}
