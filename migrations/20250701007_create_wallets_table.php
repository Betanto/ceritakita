<?php

class CreateWalletsTable
{
    public function up($db)
    {
        $db->query("
            CREATE TABLE IF NOT EXISTS tbl_wallets (
                id INT AUTO_INCREMENT PRIMARY KEY,
                id_user INT NOT NULL,
                total double NOT NULL DEFAULT 0,
                CONSTRAINT fk_users_wallets FOREIGN KEY (id_user) REFERENCES tbl_users(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT
            )
        ");
    }

    public function down($db)
    {
        $db->query("DROP TABLE IF EXISTS tbl_wallets");
    }
}
