# ceritakita
Aplikasi untuk pemenuhan kebutuhan Bootcamp

Installasi

* Clone dengan menggunakan perintah
```
git clone https://github.com/Betanto/ceritakita.git
```
* Copy file database.example.php menjadi database.php
```
cp /app/config/database.example.php /app/config/database.php
```
* Inputkan nama database, username, dan password pada file /app/config/database.php
* jalankan perintah migrasi
```
php scripts/migrate.php migrate
```
* jalankan perintah seeder
```
php scripts/seed.php
```