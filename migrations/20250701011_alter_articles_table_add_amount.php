<?php

class AlterArticlesTableAddAmount
{
    public function up($db)
    {
        $db->query("
            ALTER TABLE tbl_articles ADD COLUMN amount DOUBLE AFTER payment_by
        ");
    }

    public function down($db)
    {
        $db->query("ALTER TABLE tbl_articles DROP COLUMN amount");
    }
}
