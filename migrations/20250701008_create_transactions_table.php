<?php

class CreateTransactionsTable
{
    public function up($db)
    {
        $db->query("
            CREATE TABLE IF NOT EXISTS tbl_transactions (
                id INT AUTO_INCREMENT PRIMARY KEY,
                id_user INT NOT NULL,
                transaction_at datetime DEFAULT NULL,
                transaction_by INT DEFAULT NULL,
                notes varchar(255) DEFAULT NULL,
                amount double NOT NULL DEFAULT 0,
                type INT NOT NULL DEFAULT 0, -- 0: in, 1: out
                total double NOT NULL DEFAULT 0,
                CONSTRAINT fk_users_transactions FOREIGN KEY (id_user) REFERENCES tbl_users(id)
                    ON UPDATE CASCADE
                    ON DELETE RESTRICT
            )
        ");
    }

    public function down($db)
    {
        $db->query("DROP TABLE IF EXISTS tbl_transactions");
    }
}
