<?php

class AlterCategoriesTableAddSlug
{
    public function up($db)
    {
        $db->query("
            ALTER TABLE tbl_categories ADD COLUMN slug VARCHAR(255) AFTER name
        ");
    }

    public function down($db)
    {
        $db->query("ALTER TABLE tbl_categories DROP COLUMN slug");
    }
}
