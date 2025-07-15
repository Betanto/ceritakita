# ceritakita
Aplikasi untuk pemenuhan kebutuhan Bootcamp

Installasi

* Clone dengan menggunakan perintah
```
git clone https://github.com/Betanto/ceritakita.git
```
* Masuk ke folder dengan perintah
```
cd ceritakita
```
* Install vendor dengan perintah
```
composer install
```
* Copy file database.example.php menjadi database.php
```
cp app/config/database.example.php app/config/database.php
```
* Inputkan nama database, username, dan password pada file /app/config/database.php
* Buat database dengan nama sesuai yang dituliskan pada file database.php (misal: ceritakita)
* Import file ceritaku.sql ke dalam database yang dituliskan pada file database.php (misal: ceritakita)
* jalankan perintah berikut
```
composer start
```
* Buka browser dengan alamat [http://localhost:8080](http://localhost:8080)