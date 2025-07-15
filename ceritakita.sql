-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 15, 2025 at 02:13 PM
-- Server version: 8.4.3
-- PHP Version: 8.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ceritakita`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  `migrated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`, `migrated_at`) VALUES
(1, '20250701001_create_roles_table.php', 1, '2025-07-10 12:55:25'),
(2, '20250701002_create_users_table.php', 1, '2025-07-10 12:55:25'),
(3, '20250701003_create_categories_table.php', 1, '2025-07-10 12:55:25'),
(4, '20250701004_create_articles_table.php', 1, '2025-07-10 12:55:25'),
(5, '20250701005_create_articles_categories_table.php', 1, '2025-07-10 12:55:25'),
(6, '20250701006_create_reviews_table.php', 1, '2025-07-10 12:55:25'),
(7, '20250701007_create_wallets_table.php', 1, '2025-07-10 12:55:25'),
(8, '20250701008_create_transactions_table.php', 1, '2025-07-10 12:55:25'),
(9, '20250701009_alter_categories_table_add_slug.php', 1, '2025-07-10 12:55:25'),
(10, '20250701010_alter_transactions_table_add_article.php', 1, '2025-07-10 12:55:25'),
(11, '20250701011_alter_articles_table_add_amount.php', 1, '2025-07-10 12:55:25');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_articles`
--

CREATE TABLE `tbl_articles` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_parent` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `status` int NOT NULL DEFAULT '0',
  `payment_at` datetime DEFAULT NULL,
  `payment_by` int DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_articles`
--

INSERT INTO `tbl_articles` (`id`, `id_user`, `id_parent`, `title`, `slug`, `image`, `file`, `content`, `status`, `payment_at`, `payment_by`, `amount`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 0, 'Hero Title', 'hero-title', '686fbf63303b2_orang.png', NULL, '<h1 class=\"hero-title\">\r\n    Berbagi Cerita,<br>\r\n    <span style=\"background: linear-gradient(135deg, #dc3545 0%, #ea580c 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;\">Menginspirasi Dunia</span>\r\n</h1>\r\n<p class=\"hero-subtitle\">\r\n    Bergabunglah dengan komunitas penulis dan pembaca terbesar di Indonesia. \r\n    Temukan cerita inspiratif dan bagikan pengalaman Anda.\r\n</p>\r\n<div class=\"d-flex flex-wrap gap-3\">\r\n    <a href=\"/stories\" class=\"btn-hero\">\r\n        <i class=\"fas fa-search\"></i>\r\n        Jelajahi Cerita\r\n    </a>\r\n    <a href=\"/register\" class=\"btn btn-outline-primary btn-lg px-4 py-3\" style=\"border-radius: 50px; font-weight: 600;\">\r\n        <i class=\"fas fa-pen\"></i>\r\n        Mulai Menulis\r\n    </a>\r\n</div>\r\n\r\n<!-- Hero Stats -->\r\n<div class=\"row mt-5\">\r\n    <div class=\"col-4\">\r\n        <div class=\"text-center\">\r\n            <h4 class=\"fw-bold text-primary mb-0\">500K+</h4>\r\n            <small class=\"text-muted\">Pembaca</small>\r\n        </div>\r\n    </div>\r\n    <div class=\"col-4\">\r\n        <div class=\"text-center\">\r\n            <h4 class=\"fw-bold text-primary mb-0\">25K+</h4>\r\n            <small class=\"text-muted\">Cerita</small>\r\n        </div>\r\n    </div>\r\n    <div class=\"col-4\">\r\n        <div class=\"text-center\">\r\n            <h4 class=\"fw-bold text-primary mb-0\">1K+</h4>\r\n            <small class=\"text-muted\">Penulis</small>\r\n        </div>\r\n    </div>\r\n</div>', 1, NULL, NULL, NULL, '2025-07-10 12:56:43', 1, '2025-07-14 17:10:17', 1, NULL, NULL),
(8, 1, 0, 'Artikel Pilihan', 'artikel-pilihan', NULL, NULL, '<h2 class=\"display-5 fw-bold text-dark mb-3\">\r\n    Artikel <span style=\"color: var(--primary-dark);\">Pilihan</span>\r\n</h2>\r\n<p class=\"lead text-muted\">Temukan artikel-artikel terbaik dari penulis berbakat</p>', 1, NULL, NULL, NULL, '2025-07-14 15:40:15', 1, '2025-07-14 17:08:23', 1, NULL, NULL),
(9, 1, 0, 'Judul Alasan', 'judul-alasan', NULL, NULL, '<h2 class=\"display-5 fw-bold text-dark mb-3\">\r\n    Mengapa Memilih <span style=\"color: var(--primary-dark);\">Cerita Kita?</span>\r\n</h2>\r\n<p class=\"lead text-muted\">Platform terlengkap untuk berbagi dan menemukan cerita inspiratif</p>', 1, NULL, NULL, NULL, '2025-07-14 16:39:29', 1, '2025-07-14 17:08:43', 1, NULL, NULL),
(10, 1, 0, 'Editor Canggih', 'editor-canggih', '6875348168dea_Screenshot 2025-07-14 at 23.45.48.png', NULL, 'Editor yang mudah digunakan dengan fitur lengkap untuk menulis artikel yang menarik dan profesional.', 1, NULL, NULL, NULL, '2025-07-14 16:46:57', 1, '2025-07-14 16:46:57', 1, NULL, NULL),
(11, 1, 0, 'Komunitas Aktif', 'komunitas-aktif', '687534a2a08af_Screenshot 2025-07-14 at 23.45.56.png', NULL, 'Bergabung dengan komunitas penulis dan pembaca yang saling mendukung dan memberikan feedback konstruktif.', 1, NULL, NULL, NULL, '2025-07-14 16:47:30', 1, '2025-07-14 16:47:30', 1, NULL, NULL),
(12, 1, 0, 'Analytics Detail', 'analytics-detail', '687534b84f160_Screenshot 2025-07-14 at 23.46.01.png', NULL, 'Pantau performa artikel Anda dengan analytics yang detail dan insight yang membantu meningkatkan engagement.', 1, NULL, NULL, NULL, '2025-07-14 16:47:52', 1, '2025-07-14 16:47:52', 1, NULL, NULL),
(13, 1, 0, 'Siap Berbagi Cerita Anda?', 'siap-berbagi-cerita-anda', NULL, NULL, 'Bergabunglah dengan ribuan penulis lainnya dan mulai berbagi cerita inspiratif Anda. Dapatkan penghasilan dari setiap artikel berkualitas yang Anda tulis.', 1, NULL, NULL, NULL, '2025-07-14 17:14:03', 1, '2025-07-14 17:18:19', 1, NULL, NULL),
(14, 1, 0, 'Artikel Footer', 'artikel-footer', NULL, NULL, 'Platform berbagi cerita dan artikel berkualitas. Bergabunglah dengan komunitas penulis dan pembaca yang inspiratif.', 1, NULL, NULL, NULL, '2025-07-14 17:24:52', 1, '2025-07-14 17:59:23', 1, NULL, NULL),
(15, 1, 0, 'facebook', 'facebook', NULL, NULL, 'https://www.facebook.com/itematik', 1, NULL, NULL, NULL, '2025-07-15 06:22:25', 1, '2025-07-15 06:34:45', 1, NULL, NULL),
(16, 1, 0, 'instagram', 'instagram', NULL, NULL, 'https://www.instagram.com/itematik/', 1, NULL, NULL, NULL, '2025-07-15 06:23:07', 1, '2025-07-15 06:34:58', 1, NULL, NULL),
(17, 1, 0, 'twitter', 'twitter', NULL, NULL, 'https://x.com/itematik1', 1, NULL, NULL, NULL, '2025-07-15 06:23:41', 1, '2025-07-15 06:35:25', 1, NULL, NULL),
(18, 1, 0, 'linkedin', 'linkedin', NULL, NULL, 'https://www.linkedin.com/company/pt-itematik-pramitha-nusantara', 1, NULL, NULL, NULL, '2025-07-15 06:25:00', 1, '2025-07-15 06:34:32', 1, NULL, NULL),
(19, 1, 0, 'tiktok', 'tiktok', NULL, NULL, 'https://www.tiktok.com/@itematik', 1, NULL, NULL, NULL, '2025-07-15 06:25:37', 1, '2025-07-15 06:35:12', 1, NULL, NULL),
(21, 5, 0, 'Bangku Kosong', 'bangku-kosong', '68762aa6d17b0_coverbangkukosong.png', '68762aa6d1b43_Bangku Kosong.pdf', '<p data-start=\"241\" data-end=\"654\"><em data-start=\"241\" data-end=\"256\">Bangku Kosong</em> mengisahkan seorang siswi pindahan bernama <strong data-start=\"300\" data-end=\"308\">Rani</strong> yang masuk ke SD Suka Maju dan ditempatkan di kelas 6B. Di sana, ia menemukan bangku di pojok kelas yang selalu dibiarkan kosong dan tidak boleh diduduki. Sejak itu, Rani mengalami berbagai kejadian misterius—dari bisikan halus, bayangan aneh, hingga penemuan buku harian seorang murid lama bernama <strong data-start=\"608\" data-end=\"616\">Adit</strong> yang pernah duduk di bangku tersebut.</p><p data-start=\"656\" data-end=\"1051\">Melalui penyelidikan diam-diam bersama temannya <strong data-start=\"704\" data-end=\"712\">Sari</strong>, Rani menemukan fakta bahwa Adit adalah korban perundungan dan secara tragis meninggal terjebak di gudang sekolah. Kematian itu ditutupi oleh pihak sekolah, dan namanya dilupakan secara paksa. Rani menolak untuk tinggal diam, dan dengan keberanian serta empatinya, ia membuka kembali luka lama agar keadilan dan pengakuan dapat diberikan.</p><p>\r\n\r\n</p><p data-start=\"1053\" data-end=\"1415\">Puncak cerita terjadi saat Rani melakukan “perpisahan spiritual” dengan arwah Adit melalui simbol dan tulisan, yang akhirnya membebaskan jiwa Adit dari keterikatan duniawi. Bangku yang selama ini kosong pun akhirnya bisa kembali digunakan—bukan sebagai tempat terkutuk, melainkan sebagai simbol pengingat bahwa setiap anak layak didengar, dikenang, dan dihargai.</p>', 0, NULL, NULL, NULL, '2025-07-15 10:17:10', 5, '2025-07-15 10:17:10', 5, NULL, NULL),
(22, 5, 0, 'Asal-Usul Jahe', 'asal-usul-jahe', '68763d85db3cc_Asal Usul Jahe.png', '68763d85db4cf_Asal Usul Jahe.pdf', '<p data-start=\"218\" data-end=\"507\">Cerita ini mengisahkan seorang nenek tua bernama <strong data-start=\"267\" data-end=\"282\">Nyi Gingsir</strong> yang hidup sendiri di lereng gunung. Setiap malam, ia merasa kedinginan karena angin pegunungan yang menusuk tulang. Dalam tidurnya, ia mendapat petunjuk melalui mimpi tentang “api yang tidak membakar” dari seekor naga emas.</p><p data-start=\"509\" data-end=\"831\">Esoknya, ia menemukan biji misterius yang ia tanam dan rawat dengan penuh kasih. Dari situ tumbuh tanaman berakar rimpang yang memiliki aroma khas. Saat direbus dan diminum, rimpang itu memberi kehangatan luar biasa pada tubuhnya. Warga desa yang mendengar manfaat tanaman itu pun ikut mencobanya dan merasakan khasiatnya.</p><p>\r\n\r\n</p><p data-start=\"833\" data-end=\"1163\">Akhirnya, atas bisikan naga dalam mimpi, Nyi Gingsir menamai tanaman itu <strong data-start=\"906\" data-end=\"916\">“Jahe”</strong>, berasal dari kata <em data-start=\"936\" data-end=\"951\">Jangga Hening</em>—yang berarti api hening, hangat namun lembut. Sejak itu, tanaman jahe menjadi warisan yang menyebar luas, dikenal sebagai rempah penyembuh dan penghangat yang berasal dari ketulusan hati sang nenek penjaga bumi.</p>', 1, '2025-07-15 13:27:48', 1, 100000, '2025-07-15 11:37:41', 5, '2025-07-15 13:36:58', 1, NULL, NULL),
(23, 5, 0, 'Rahasia Bunga Biru', 'rahasia-bunga-biru', '687640777ae9c_Rahasia Bunga Biru.png', '687640777b175_Rahasia Bunga Biru.pdf', '<p data-start=\"225\" data-end=\"658\">Lana, seorang gadis kecil yang senang membaca dan menggambar, mulai kehilangan penglihatannya karena kondisi bawaan. Dokter menyarankan agar ia berhenti membaca, namun Lana yakin bahwa alam memiliki cara penyembuhan tersendiri. Suatu hari di hutan, ia menemukan bunga biru misterius yang “berbicara” lewat gulungan daun kecil. Dari bunga itu, Lana membuat ramuan herbal yang membantu memulihkan penglihatan dan memperkuat ingatannya.</p><p data-start=\"660\" data-end=\"968\">Dalam mimpinya, Lana bertemu Putri Telara, roh penjaga bunga telang, yang mengingatkannya bahwa kekuatan bunga hanya akan bertahan jika ditanam dan digunakan dengan hati yang tulus. Lana mulai membagikan ilmunya kepada teman-teman dan guru, hingga bunga telang menjadi bagian penting dalam kehidupan desanya.</p><p>\r\n\r\n</p><p data-start=\"970\" data-end=\"1305\">Namun ketika seorang pengusaha ingin mengeksploitasi bunga itu untuk bisnis, Lana harus memilih: mengikuti godaan atau melindungi keseimbangan alam. Ia memilih yang terakhir, dan melalui buku kecilnya <em data-start=\"1171\" data-end=\"1193\">“Rahasia Bunga Biru”</em>, ia menyebarkan pesan penting bahwa kekuatan alam hanya akan datang kepada mereka yang menjaganya dengan cinta.</p>', 0, NULL, NULL, NULL, '2025-07-15 11:50:15', 5, '2025-07-15 11:50:15', 5, NULL, NULL),
(24, 5, 0, 'Jika Tak Ada Kapulaga', 'jika-tak-ada-kapulaga', '687642fe9a5a1_Jika Tak Ada Kapulaga.png', '687642fe9a761_Jika Tak Ada Kapulaga.pdf', '<p data-start=\"218\" data-end=\"621\">Di desa terpencil Kayu Alas, kapulaga tiba-tiba menghilang—bukan hanya dari ladang dan dapur, tapi juga dari ingatan orang-orang. Hanya seorang gadis bernama <strong data-start=\"376\" data-end=\"385\">Ambar</strong> yang masih mengingat aroma dan bentuk rempah misterius itu. Saat warga mulai jatuh sakit dan mengalami kejadian supranatural, Ambar menemukan bahwa kapulaga adalah “pagar” terakhir yang melindungi manusia dari roh lapar yang haus rasa.</p><p data-start=\"623\" data-end=\"890\">Ia menelusuri jejak peninggalan kakeknya, seorang dukun rempah, dan menemukan kebenaran mengerikan: hilangnya kapulaga adalah panggilan bagi makhluk gelap dari alam rasa. Tanpa rempah itu, manusia kehilangan benteng terhadap kegelapan yang mengintai dari balik dapur.</p><p>\r\n\r\n</p><p data-start=\"892\" data-end=\"1122\">Melalui pencarian yang menyeramkan dan ritual purba, Ambar berhasil memanggil kembali kekuatan kapulaga dan menyelamatkan desanya. Tapi ia tahu, dunia modern yang terus meninggalkan rempah asli lambat laun akan membuka celah lagi.</p>', 1, '2025-07-15 13:29:27', 1, 100000, '2025-07-15 12:01:02', 5, '2025-07-15 13:39:02', 1, NULL, NULL),
(25, 5, 0, 'Pahlawan Racik Rempah', 'pahlawan-racik-rempah', '6876447b7797a_Pahlawan Racik Rempah.png', '6876447b77ba1_Pahlawan Racik Rempah.pdf', '<p data-start=\"217\" data-end=\"468\">Tahun 2075, Kota Seroja adalah simbol kemajuan teknologi, di mana makanan dan obat-obatan diciptakan secara sintetis. Namun, di balik klaim kesehatan sempurna, warganya mulai melemah—imunitas menurun, memori memudar, dan anak-anak tumbuh tanpa energi.</p><p data-start=\"470\" data-end=\"861\">Seorang pemuda bernama <strong data-start=\"493\" data-end=\"501\">Raka</strong> menemukan rahasia besar: rempah-rempah, yang dulu menjadi sumber kekuatan dan kesehatan, telah dilupakan dan dihapus oleh korporasi raksasa <strong data-start=\"642\" data-end=\"655\">KorpoChem</strong>. Setelah menemukan buku kuno tentang “Racikan Inti” dan dibimbing oleh Bu Shinta, penjaga warisan rempah, Raka memulai misi mengumpulkan lima rempah utama—jahe, kunyit, kayu manis, kapulaga, dan temulawak.</p><p>\r\n\r\n</p><p data-start=\"863\" data-end=\"1230\">Dengan tekad dan keterampilan, Raka membentuk <strong data-start=\"909\" data-end=\"930\">Pasukan Rasa Asli</strong> dan menghadapi ancaman teknologi dan pasukan steril KorpoChem. Ia berhasil menghidupkan kembali racikan legendaris yang menyembuhkan dan menyadarkan warga. Lewat siaran terbuka, Raka mengajarkan dunia cara meracik dan menghargai rempah—membangkitkan kembali tradisi dan kekuatan alami tubuh manusia.</p>', 1, '2025-07-15 13:25:27', 1, 100000, '2025-07-15 12:07:23', 5, '2025-07-15 13:39:16', 1, NULL, NULL),
(26, 6, 0, 'Kembali ke Akar: Memahami Marketing 1.0', 'kembali-ke-akar-memahami-marketing-1-0', '68764691d98d7_Marketing 1 0.png', '68764691d9b85_Marketing 1 0.pdf', '<p data-start=\"272\" data-end=\"594\">E-book ini membahas dasar-dasar pemasaran klasik yang dikenal sebagai <strong data-start=\"342\" data-end=\"359\">Marketing 1.0</strong>, yaitu pendekatan pemasaran yang berfokus pada produk. Marketing 1.0 berkembang pada era Revolusi Industri, di mana kebutuhan pasar tinggi dan keberhasilan bisnis bergantung pada kualitas, distribusi, dan harga produk yang kompetitif.</p><p data-start=\"596\" data-end=\"863\">Pembaca diajak memahami pilar utama Marketing 1.0: produksi massal, komunikasi satu arah, dan pasar yang homogen. Buku ini juga menyajikan studi kasus seperti Ford Model T dan produk-produk lokal berbasis fungsi, serta mengevaluasi kelebihan dan kelemahan metode ini.</p><p>\r\n\r\n</p><p data-start=\"865\" data-end=\"1188\">Meski dunia kini berada di era Marketing 5.0, prinsip-prinsip dari Marketing 1.0 tetap relevan, terutama untuk pemula, UMKM, atau produk yang menekankan kegunaan praktis. Dengan gaya bahasa sederhana dan pembahasan langsung ke inti, buku ini menjadi panduan dasar sebelum mempelajari strategi pemasaran yang lebih kompleks.</p>', 1, '2025-07-15 13:26:35', 1, 100000, '2025-07-15 12:16:17', 6, '2025-07-15 13:39:21', 1, NULL, NULL),
(27, 6, 0, 'Evolusi Rasa: Memahami Marketing 2.0', 'evolusi-rasa-memahami-marketing-2-0', '687647d76f7fe_Marketing 2 0.png', '687647d76fa75_Marketing 2 0.pdf', '<p data-start=\"266\" data-end=\"555\">Dalam e-book ini, pembaca diajak memahami perubahan besar dalam dunia pemasaran dari pendekatan produk ke pendekatan konsumen. <strong data-start=\"393\" data-end=\"410\">Marketing 2.0</strong> menandai era ketika pelanggan menjadi pusat perhatian, dan brand dituntut membangun koneksi emosional, nilai, dan relasi yang kuat dengan pasar.</p><p data-start=\"557\" data-end=\"849\">Melalui pemaparan konsep, pilar utama, studi kasus seperti Nike dan Wardah, hingga strategi praktis, buku ini menguraikan bagaimana membentuk merek yang tidak hanya menjual produk, tetapi juga <strong data-start=\"750\" data-end=\"770\">cerita dan makna</strong>. Di era ini, personalisasi, segmentasi, dan komunikasi dua arah menjadi kunci.</p><p>\r\n\r\n</p><p data-start=\"851\" data-end=\"1041\">Buku ini relevan bagi pelaku UMKM, brand lokal, maupun perusahaan besar yang ingin memperkuat hubungan jangka panjang dengan pelanggannya melalui pendekatan yang lebih manusiawi dan adaptif.</p>', 1, '2025-07-15 13:28:38', 1, 100000, '2025-07-15 12:21:43', 6, '2025-07-15 13:39:43', 1, NULL, NULL),
(28, 6, 0, 'Merek Bernyawa: Memahami Marketing 3.0', 'merek-bernyawa-memahami-marketing-3-0', '687648dd9a583_Marketing 3 0.png', '687648dd9a747_Marketing 3 0.pdf', '<p data-start=\"270\" data-end=\"554\">E-book ini mengajak pembaca memahami fase pemasaran modern yang lebih dalam dan bermakna: <strong data-start=\"360\" data-end=\"377\">Marketing 3.0</strong>. Berbeda dari pendekatan sebelumnya yang fokus pada produk (1.0) dan konsumen (2.0), Marketing 3.0 mengangkat nilai, spiritualitas, dan tujuan sosial sebagai poros utama merek.</p><p data-start=\"556\" data-end=\"888\">Melalui pembahasan yang ringkas dan reflektif, buku ini menjelaskan bagaimana sebuah merek perlu hadir tidak hanya untuk menjual, tapi juga untuk <strong data-start=\"702\" data-end=\"738\">menginspirasi dan membawa dampak</strong>. Merek harus mampu berbicara pada pikiran, hati, dan jiwa konsumen, serta menjadi bagian dari solusi atas masalah-masalah kemanusiaan dan lingkungan.</p><p>\r\n\r\n</p><p data-start=\"890\" data-end=\"1226\">Buku ini menyuguhkan pilar-pilar utama Marketing 3.0, contoh nyata dari brand seperti Patagonia dan The Body Shop, serta panduan praktis membangun merek yang relevan secara emosional dan sosial. Ditujukan bagi pelaku usaha, pegiat brand, dan kreator perubahan, buku ini adalah panduan menuju pemasaran yang lebih manusiawi dan bermakna.</p>', 1, '2025-07-15 13:30:23', 1, 100000, '2025-07-15 12:26:05', 6, '2025-07-15 13:39:54', 1, NULL, NULL),
(29, 6, 0, 'Merangkul Era Digital: Memahami Marketing 4.0', 'merangkul-era-digital-memahami-marketing-4-0', '68764a0d546ff_Marketing 4 0.png', '68764a0d54927_Marketing 4 0.pdf', '<p data-start=\"284\" data-end=\"601\">E-book ini membahas pergeseran besar dalam dunia pemasaran menuju era digital yang saling terhubung: <strong data-start=\"385\" data-end=\"402\">Marketing 4.0</strong>. Di era ini, strategi pemasaran tidak hanya fokus pada produk, konsumen, atau nilai sosial, tetapi juga pada <strong data-start=\"512\" data-end=\"536\">konektivitas digital</strong> dan pengalaman menyeluruh yang menggabungkan online dan offline.</p><p data-start=\"603\" data-end=\"883\">Buku ini menjelaskan bagaimana merek harus hadir di berbagai platform, berinteraksi secara real-time, memanfaatkan data, serta membangun kepercayaan melalui konten dan komunitas. Pembaca diajak memahami bagaimana perilaku konsumen telah berubah—lebih kritis, cepat, dan terhubung.</p><p>\r\n\r\n</p><p data-start=\"885\" data-end=\"1178\">Dilengkapi dengan contoh nyata seperti Gojek, brand lokal fashion, dan UMKM digital, e-book ini memberikan panduan praktis untuk menerapkan strategi digital yang tetap hangat dan manusiawi. Disusun dengan bahasa yang lugas dan aplikatif, buku ini cocok untuk pelaku bisnis dari berbagai skala.</p>', 0, NULL, NULL, NULL, '2025-07-15 12:31:09', 6, '2025-07-15 12:31:09', 6, NULL, NULL),
(30, 6, 0, 'Masa Depan yang Terhubung: Memahami Marketing 5.0', 'masa-depan-yang-terhubung-memahami-marketing-5-0', '68764bdbc65d4_Marketing 5 0.png', '68764bdbc67cd_Marketing 5 0.pdf', '<p data-start=\"292\" data-end=\"631\">E-book ini mengupas fase terbaru dalam evolusi pemasaran: <strong data-start=\"350\" data-end=\"367\">Marketing 5.0</strong>, di mana teknologi mutakhir seperti AI, Big Data, dan IoT berpadu dengan nilai-nilai kemanusiaan. Dalam era ini, perusahaan tidak hanya memanfaatkan teknologi untuk efisiensi, tapi juga untuk menciptakan <strong data-start=\"572\" data-end=\"630\">pengalaman yang cerdas, personal, dan berdampak sosial</strong>.</p><p data-start=\"633\" data-end=\"933\">Buku ini mengulas pilar-pilar Marketing 5.0 seperti human-centric technology, otomatisasi berbasis misi sosial, dan inovasi yang inklusif. Contoh-contoh nyata dari brand global dan lokal disajikan untuk menunjukkan bagaimana teknologi bisa memperkuat hubungan dengan pelanggan, bukan menggantikannya.</p><p>\r\n\r\n</p><p data-start=\"935\" data-end=\"1214\">Marketing 5.0 menantang para pelaku usaha untuk tidak hanya adaptif terhadap perubahan digital, tapi juga <strong data-start=\"1041\" data-end=\"1092\">beretika, transparan, dan relevan secara sosial</strong>. E-book ini adalah panduan ideal untuk bisnis yang ingin tumbuh secara berkelanjutan di masa depan yang saling terhubung.</p>', 0, NULL, NULL, NULL, '2025-07-15 12:38:51', 6, '2025-07-15 12:38:51', 6, NULL, NULL),
(31, 7, 0, 'Catatan Kebodohan Sehari-hari', 'catatan-kebodohan-sehari-hari', '68764eb47a526_Kebodohan Sehari-hari.png', '68764eb47a97e_Kebodohan Sehari-hari.pdf', '<p>Buku ini adalah kumpulan kisah konyol dan jujur tentang kebodohan-kebodohan kecil yang hampir setiap orang pernah alami. Dengan gaya komedi yang ringan dan relate banget, Kambing Stupid mengajak pembaca tertawa bersama atas kekonyolan diri sendiri—mulai dari sendal yang tertukar, mie goreng tanpa kuah, sampai panik karena HP nggak ngecas padahal colokannya belum masuk.</p><p>Kita semua pernah bego. Tapi justru dari kebodohan sehari-hari itulah kita bisa tertawa dan sadar bahwa hidup nggak harus selalu serius. Yang penting bahagia dan bisa ngetawain diri sendiri.</p>', 0, NULL, NULL, NULL, '2025-07-15 12:51:00', 7, '2025-07-15 12:51:00', 7, NULL, NULL),
(32, 7, 0, 'Rahasia Paling Gak Rahasia: Kejadian Absurd dan Misterius yang Konyol', 'rahasia-paling-gak-rahasia-kejadian-absurd-dan-misterius-yang-konyol', '68765081d6758_Absurd Misterius Konyol.png', '68765081d68ec_Absurd Misterius Konyol.pdf', '<p>Buku ini mengajak kamu menyelami dunia penuh misteri—bukan yang menyeramkan, tapi yang bikin geleng-geleng kepala karena terlalu konyol. Dari kaos kaki yang suka hilang sebelah, nasi goreng yang tiba-tiba muncul di kulkas, sampai alarm jam 3 pagi yang entah disetel siapa. Semuanya dibawakan dengan gaya komedi absurd khas Kambing Stupid, yang bikin kamu ketawa sambil mikir, “Eh, gua juga pernah kayak gini.”</p><p>Tidak semua misteri harus masuk akal. Terkadang, kejadian aneh dan lucu dalam hidup justru membuat hari-hari jadi lebih berwarna. Hidup ini absurd, dan itulah yang bikin seru. Kalau kamu belum pernah ngalamin hal-hal begini… mungkin kamu terlalu normal.</p>', 0, NULL, NULL, NULL, '2025-07-15 12:58:41', 7, '2025-07-15 12:58:41', 7, NULL, NULL),
(33, 7, 0, 'Menjadi Badut Saat Kamu Sedih', 'menjadi-badut-saat-kamu-sedih', '687652abd7cba_Badut Cinta Sedih.png', '687652abd80fc_Badut Cinta Sedih.pdf', '<p>Buku ini adalah kisah tentang cinta yang diam, luka yang tertawa, dan seseorang yang rela jadi badut demi melihat orang yang dia cintai tersenyum, meski bukan untuknya. Lewat kalimat-kalimat sederhana yang penuh emosi, <em data-start=\"438\" data-end=\"454\">Kambing Stupid</em> menyajikan potret cinta sedih yang tak meminta balasan—cinta yang memilih jadi lucu di tengah duka orang lain.</p><p>Kadang, cinta tidak harus memiliki. Ada bentuk cinta yang cukup dengan hadir, menghibur, dan tersenyum walau hati sendiri menangis. E-book ini untuk semua orang yang pernah jadi badut—bukan karena lucu, tapi karena cinta.</p>', 1, '2025-07-15 13:29:56', 1, 100000, '2025-07-15 13:07:55', 7, '2025-07-15 13:56:31', 1, NULL, NULL),
(34, 7, 0, 'Jatuh Cinta, Jatuh Muka: Kisah Konyol Tapi Manis Saat Jatuh Hati', 'jatuh-cinta-jatuh-muka-kisah-konyol-tapi-manis-saat-jatuh-hati', '68765414abf54_Konyol Cinta Romantis.png', '68765414ac330_Konyol Cinta Romantis.pdf', '<p>Cinta tidak selalu soal pelukan di bawah hujan atau lagu-lagu galau. Kadang cinta datang dalam bentuk chat yang cuma dibalas “iya”, stalking gagal, pura-pura ketemu nggak sengaja, sampai gemeteran waktu ngajak jalan. Dalam buku ini, <em data-start=\"522\" data-end=\"538\">Kambing Stupid</em> merayakan cinta dari sisi yang jarang diceritakan—yang malu-malu, canggung, dan penuh kekonyolan yang justru bikin manis.</p><p data-start=\"947\" data-end=\"1194\">Cinta bukan hanya tentang keberanian, tapi juga tentang momen-momen konyol yang bikin jantung berdebar sekaligus pengen nutup muka. Karena kalau kamu belum pernah malu karena cinta… mungkin kamu belum benar-benar jatuh cinta.</p>', 1, '2025-07-15 13:28:14', 1, 100000, '2025-07-15 13:13:56', 7, '2025-07-15 13:56:39', 1, NULL, NULL),
(35, 7, 0, 'Tertawa di Antara Kesedihan: Hidup Emang Gitu, Kita Aja yang Nggak Siap', 'tertawa-di-antara-kesedihan-hidup-emang-gitu-kita-aja-yang-nggak-siap', '687656630ee23_Komedi Sedih Hidup Konyol.png', '687656630f31b_Komedi Sedih Hidup Konyol.pdf', '<p>E-book ini adalah catatan penuh tawa di tengah luka. <em data-start=\"358\" data-end=\"374\">Kambing Stupid</em> membawakan kisah-kisah sehari-hari yang sedih tapi konyol—seperti masak lauk tanpa nasi, curhat salah kirim ke orangnya, pura-pura sibuk biar nggak kelihatan sepi, sampai makan mie ayam lalu nyuci piring karena dompet ketinggalan. Buku ini menyadarkan kita bahwa hidup mungkin menyedihkan, tapi kelakuan kita menghadapinya... kadang lebih lucu dari sinetron.</p><p>Kadang kita nggak bisa bikin hidup lebih mudah, tapi kita bisa bikin hidup lebih bisa ditertawakan. Buku ini untuk kamu yang pernah ngerasa hidup itu absurd tapi tetap jalan, sambil senyum—walau kadang sambil nangis juga.</p>', 1, '2025-07-15 13:24:48', 1, 100000, '2025-07-15 13:23:47', 7, '2025-07-15 13:56:45', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_articles_categories`
--

CREATE TABLE `tbl_articles_categories` (
  `id` int NOT NULL,
  `id_category` int NOT NULL,
  `id_article` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_articles_categories`
--

INSERT INTO `tbl_articles_categories` (`id`, `id_category`, `id_article`) VALUES
(23, 8, 10),
(24, 8, 11),
(25, 8, 12),
(26, 7, 8),
(27, 7, 9),
(29, 1, 1),
(32, 7, 13),
(34, 7, 14),
(40, 9, 18),
(41, 9, 15),
(42, 9, 16),
(43, 9, 19),
(44, 9, 17),
(47, 4, 21),
(48, 5, 21),
(49, 2, 22),
(50, 3, 23),
(51, 10, 23),
(52, 4, 24),
(53, 10, 25),
(54, 11, 25),
(55, 3, 26),
(56, 12, 26),
(57, 3, 27),
(58, 12, 27),
(59, 3, 28),
(60, 12, 28),
(61, 3, 29),
(62, 12, 29),
(63, 3, 30),
(64, 12, 30),
(65, 13, 31),
(66, 5, 32),
(67, 13, 32),
(68, 14, 33),
(69, 15, 33),
(70, 13, 34),
(71, 14, 34),
(72, 13, 35),
(73, 15, 35);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_categories`
--

CREATE TABLE `tbl_categories` (
  `id` int NOT NULL,
  `name` varchar(35) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_parent` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_categories`
--

INSERT INTO `tbl_categories` (`id`, `name`, `slug`, `id_parent`, `type`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'Hero Banner', 'hero-banner', 0, 0, 1, '2025-07-10 12:56:19', 1, '2025-07-10 12:56:19', 1, NULL, NULL),
(2, 'Dongeng', 'dongeng', 0, 1, 1, '2025-07-11 10:10:17', 1, '2025-07-11 10:10:17', 1, NULL, NULL),
(3, 'Pelajaran', 'pelajaran', 0, 1, 1, '2025-07-11 10:10:22', 1, '2025-07-15 08:45:26', 1, NULL, NULL),
(4, 'Horor', 'horor', 0, 1, 1, '2025-07-11 10:10:27', 1, '2025-07-11 10:10:27', 1, NULL, NULL),
(5, 'Misteri', 'misteri', 0, 1, 1, '2025-07-11 10:10:31', 1, '2025-07-11 10:10:31', 1, NULL, NULL),
(7, 'Umum', 'umum', 0, 0, 1, '2025-07-14 15:39:01', 1, '2025-07-14 15:39:01', 1, NULL, NULL),
(8, 'Alasan', 'alasan', 0, 0, 1, '2025-07-14 16:46:11', 1, '2025-07-14 16:46:11', 1, NULL, NULL),
(9, 'Sosial Media', 'sosial-media', 0, 0, 1, '2025-07-15 06:21:40', 1, '2025-07-15 06:21:40', 1, NULL, NULL),
(10, 'Fiksi', 'fiksi', 0, 1, 1, '2025-07-15 10:18:43', 1, '2025-07-15 10:18:43', 1, NULL, NULL),
(11, 'Aksi', 'aksi', 0, 1, 1, '2025-07-15 10:18:54', 1, '2025-07-15 10:18:54', 1, NULL, NULL),
(12, 'Pemasaran', 'pemasaran', 0, 1, 1, '2025-07-15 12:13:22', 1, '2025-07-15 12:13:22', 1, NULL, NULL),
(13, 'Komedi', 'komedi', 0, 1, 1, '2025-07-15 12:40:26', 1, '2025-07-15 12:40:26', 1, NULL, NULL),
(14, 'Romantis', 'romantis', 0, 1, 1, '2025-07-15 12:59:44', 1, '2025-07-15 12:59:44', 1, NULL, NULL),
(15, 'Sedih', 'sedih', 0, 1, 1, '2025-07-15 13:04:23', 1, '2025-07-15 13:04:23', 1, NULL, NULL),
(16, 'Piknik', 'piknik', 0, 1, 1, '2025-07-15 13:58:46', 1, '2025-07-15 13:58:46', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_reviews`
--

CREATE TABLE `tbl_reviews` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_article` int NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_reviews`
--

INSERT INTO `tbl_reviews` (`id`, `id_user`, `id_article`, `notes`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(6, 1, 35, '', 1, '2025-07-15 06:24:41', 1, '2025-07-15 13:24:41', NULL, NULL, NULL),
(7, 1, 25, '', 1, '2025-07-15 06:25:18', 1, '2025-07-15 13:25:18', NULL, NULL, NULL),
(8, 1, 26, '', 1, '2025-07-15 06:26:26', 1, '2025-07-15 13:26:26', NULL, NULL, NULL),
(9, 1, 22, '', 1, '2025-07-15 06:27:39', 1, '2025-07-15 13:27:39', NULL, NULL, NULL),
(10, 1, 34, '', 1, '2025-07-15 06:28:08', 1, '2025-07-15 13:28:08', NULL, NULL, NULL),
(11, 1, 27, '', 1, '2025-07-15 06:28:32', 1, '2025-07-15 13:28:32', NULL, NULL, NULL),
(12, 1, 24, '', 1, '2025-07-15 06:29:19', 1, '2025-07-15 13:29:19', NULL, NULL, NULL),
(13, 1, 33, '', 1, '2025-07-15 06:29:48', 1, '2025-07-15 13:29:48', NULL, NULL, NULL),
(14, 1, 28, '', 1, '2025-07-15 06:30:15', 1, '2025-07-15 13:30:15', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_roles`
--

INSERT INTO `tbl_roles` (`id`, `name`) VALUES
(1, 'Admin'),
(2, 'Kontributor');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transactions`
--

CREATE TABLE `tbl_transactions` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_article` int NOT NULL DEFAULT '0',
  `transaction_at` datetime DEFAULT NULL,
  `transaction_by` int DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `type` int NOT NULL DEFAULT '0',
  `total` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` int NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_role` int NOT NULL,
  `status` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `username`, `password`, `name`, `id_role`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'admin@mail.com', '$2y$10$g8O8brAT9NilFzlfX.vpzOm.PGKtt1GK.YBtg7XzkOvRJX84y7.8u', 'Admin', 1, 1, '2025-07-10 12:55:27', 1, '2025-07-10 12:55:27', 1, NULL, NULL),
(5, 'racikrempah@gmail.com', '$2y$10$YDPZiwbu7mpUmPkSt/tKHeACwzRrmmw7CmvrLOrhAATaZ8pG.kbsG', 'Racik Rempah', 2, 1, '2025-07-15 10:12:25', NULL, '2025-07-15 10:12:25', NULL, NULL, NULL),
(6, 'imajimatra@gmail.com', '$2y$10$H28CJAWlt5uLihAGBoDoDexyVZuW4w5ZPMy7XKzDFgRfrqk1hh/7u', 'Imajimatra Studio', 2, 1, '2025-07-15 12:08:16', NULL, '2025-07-15 12:08:16', NULL, NULL, NULL),
(7, 'kambingstupid@gmail.com', '$2y$10$AYogQ08k6GL6cPUAcAQSFeegeEI8ygu1.CszpgPNqnkYqXBvO7HWW', 'Kambing Stupid', 2, 1, '2025-07-15 12:39:44', NULL, '2025-07-15 12:39:44', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_wallets`
--

CREATE TABLE `tbl_wallets` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `total` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_articles`
--
ALTER TABLE `tbl_articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users` (`id_user`);

--
-- Indexes for table `tbl_articles_categories`
--
ALTER TABLE `tbl_articles_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_categories` (`id_category`),
  ADD KEY `fk_articles` (`id_article`);

--
-- Indexes for table `tbl_categories`
--
ALTER TABLE `tbl_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_reviews`
--
ALTER TABLE `tbl_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users_reviews` (`id_user`),
  ADD KEY `fk_articles_reviews` (`id_article`);

--
-- Indexes for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_transactions`
--
ALTER TABLE `tbl_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users_transactions` (`id_user`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_role` (`id_role`);

--
-- Indexes for table `tbl_wallets`
--
ALTER TABLE `tbl_wallets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users_wallets` (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_articles`
--
ALTER TABLE `tbl_articles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `tbl_articles_categories`
--
ALTER TABLE `tbl_articles_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `tbl_categories`
--
ALTER TABLE `tbl_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tbl_reviews`
--
ALTER TABLE `tbl_reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_transactions`
--
ALTER TABLE `tbl_transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_wallets`
--
ALTER TABLE `tbl_wallets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_articles`
--
ALTER TABLE `tbl_articles`
  ADD CONSTRAINT `fk_users` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `tbl_articles_categories`
--
ALTER TABLE `tbl_articles_categories`
  ADD CONSTRAINT `fk_articles` FOREIGN KEY (`id_article`) REFERENCES `tbl_articles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_categories` FOREIGN KEY (`id_category`) REFERENCES `tbl_categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `tbl_reviews`
--
ALTER TABLE `tbl_reviews`
  ADD CONSTRAINT `fk_articles_reviews` FOREIGN KEY (`id_article`) REFERENCES `tbl_articles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_reviews` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `tbl_transactions`
--
ALTER TABLE `tbl_transactions`
  ADD CONSTRAINT `fk_users_transactions` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD CONSTRAINT `fk_users_roles` FOREIGN KEY (`id_role`) REFERENCES `tbl_roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `tbl_wallets`
--
ALTER TABLE `tbl_wallets`
  ADD CONSTRAINT `fk_users_wallets` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
