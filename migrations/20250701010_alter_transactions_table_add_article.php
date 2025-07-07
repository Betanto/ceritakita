<?php

class AlterTransactionsTableAddArticle
{
    public function up($db)
    {
        $db->query("
            ALTER TABLE tbl_transactions ADD COLUMN id_article INT NOT NULL DEFAULT 0 AFTER id_user
        ");
    }

    public function down($db)
    {
        $db->query("ALTER TABLE tbl_transactions DROP COLUMN id_article");
    }
}
