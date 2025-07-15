-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 15, 2025 at 06:56 AM
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
(3, 2, 0, 'Artikel 1 dari Betanto', 'artikel-1-dari-betanto', '6870e341683e4_16082514904047_Image-Prosedur_Izin_Penelitian.png', '6870e341687ad_203. Surat Edaran Rektor Syarat UAS Genap 20242025.pdf', '<p>Test isi dari Betanto isinya ditambah</p>', 1, '2025-07-11 10:15:02', 1, 100000, '2025-07-11 10:11:13', 2, '2025-07-11 10:15:02', 1, NULL, NULL),
(4, 3, 0, 'Contoh Cerita 1 dari Kedua', 'contoh-cerita-1-dari-kedua', NULL, NULL, '<p>isi&nbsp;Contoh Cerita 1 dari Kedua</p>', 0, NULL, NULL, NULL, '2025-07-11 10:12:46', 3, '2025-07-11 10:12:46', 3, NULL, NULL),
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
(19, 1, 0, 'tiktok', 'tiktok', NULL, NULL, 'https://www.tiktok.com/@itematik', 1, NULL, NULL, NULL, '2025-07-15 06:25:37', 1, '2025-07-15 06:35:12', 1, NULL, NULL);

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
(9, 4, 3),
(10, 4, 4),
(11, 5, 3),
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
(44, 9, 17);

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
(3, 'Pelajaran', 'pelajaran', 0, 1, 1, '2025-07-11 10:10:22', 1, '2025-07-11 10:10:22', 1, NULL, NULL),
(4, 'Horor', 'horor', 0, 1, 1, '2025-07-11 10:10:27', 1, '2025-07-11 10:10:27', 1, NULL, NULL),
(5, 'Misteri', 'misteri', 0, 1, 1, '2025-07-11 10:10:31', 1, '2025-07-11 10:10:31', 1, NULL, NULL),
(7, 'Umum', 'umum', 0, 0, 1, '2025-07-14 15:39:01', 1, '2025-07-14 15:39:01', 1, NULL, NULL),
(8, 'Alasan', 'alasan', 0, 0, 1, '2025-07-14 16:46:11', 1, '2025-07-14 16:46:11', 1, NULL, NULL),
(9, 'Sosial Media', 'sosial-media', 0, 0, 1, '2025-07-15 06:21:40', 1, '2025-07-15 06:21:40', 1, NULL, NULL);

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
(1, 1, 3, 'ada yang perlu direvisi', 0, '2025-07-11 03:11:39', 1, '2025-07-11 10:11:39', NULL, NULL, NULL),
(2, 1, 3, 'Revisi bagian isi', 2, '2025-07-11 03:11:59', 1, '2025-07-11 10:11:59', NULL, NULL, NULL),
(3, 1, 3, 'Mantab', 1, '2025-07-11 03:13:08', 1, '2025-07-11 10:13:08', NULL, NULL, NULL);

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
(2, 'betanto@gmail.com', '$2y$10$RObP9drWbOLgkD2bQAECueNTR2QeynTgjx5xNCpENsIT3T4025Xge', 'betanto', 2, 1, '2025-07-11 10:07:24', NULL, '2025-07-11 10:07:24', NULL, NULL, NULL),
(3, 'kedua@mail.com', '$2y$10$oqDQe8wT.zYYAr9cI/hamelhNrijn1EjZZB4THlpeq8BEmVKzuQ9u', 'Kedua', 2, 1, '2025-07-11 10:08:12', NULL, '2025-07-14 15:35:38', 1, NULL, NULL);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tbl_articles_categories`
--
ALTER TABLE `tbl_articles_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `tbl_categories`
--
ALTER TABLE `tbl_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_reviews`
--
ALTER TABLE `tbl_reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
