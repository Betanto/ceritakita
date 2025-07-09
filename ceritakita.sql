-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 09, 2025 at 03:02 PM
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
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL,
  `migrated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`, `migrated_at`) VALUES
(1, '20250701001_create_roles_table.php', 1, '2025-07-04 09:17:44'),
(2, '20250701002_create_users_table.php', 1, '2025-07-04 09:17:44'),
(3, '20250701003_create_categories_table.php', 1, '2025-07-04 09:17:44'),
(4, '20250701004_create_articles_table.php', 1, '2025-07-04 09:17:44'),
(5, '20250701005_create_articles_categories_table.php', 1, '2025-07-04 09:17:44'),
(6, '20250701006_create_reviews_table.php', 1, '2025-07-04 09:17:44'),
(7, '20250701007_create_wallets_table.php', 1, '2025-07-04 09:17:44'),
(8, '20250701008_create_transactions_table.php', 1, '2025-07-04 09:17:44'),
(9, '20250701009_alter_categories_table_add_slug.php', 1, '2025-07-04 09:17:44'),
(10, '20250701010_alter_transactions_table_add_article.php', 2, '2025-07-07 10:57:03');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_articles`
--

CREATE TABLE `tbl_articles` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_parent` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `content` text,
  `status` int NOT NULL DEFAULT '0',
  `payment_at` datetime DEFAULT NULL,
  `payment_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_articles`
--

INSERT INTO `tbl_articles` (`id`, `id_user`, `id_parent`, `title`, `slug`, `image`, `file`, `content`, `status`, `payment_at`, `payment_by`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(2, 1, 0, 'Hero Title', 'hero-title', NULL, NULL, '<h1 class=\"hero-title\">\r\n    Berbagi Cerita,<br>\r\n    <span style=\"background: linear-gradient(135deg, #f97316 0%, #ea580c 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;\">Menginspirasi Dunia</span>\r\n</h1>', 1, NULL, NULL, '2025-07-09 09:10:51', 1, '2025-07-09 10:34:45', 1, NULL, NULL),
(3, 1, 0, 'Hero Subtitle', 'hero-subtitle', NULL, NULL, '<p class=\"hero-subtitle\">\r\n    Bergabunglah dengan komunitas penulis dan pembaca terbesar di Indonesia. \r\n    Temukan cerita inspiratif dan bagikan pengalaman Anda.\r\n</p>', 1, NULL, NULL, '2025-07-09 09:14:04', 1, '2025-07-09 10:34:40', 1, NULL, NULL),
(4, 1, 0, 'Hero Button', 'hero-button', NULL, NULL, '<div class=\"d-flex flex-wrap gap-3\">\r\n    <a href=\"/stories\" class=\"btn-hero\">\r\n        <i class=\"fas fa-search\"></i>\r\n        Jelajahi Cerita\r\n    </a>\r\n    <a href=\"/register\" class=\"btn btn-outline-primary btn-lg px-4 py-3\" style=\"border-radius: 50px; font-weight: 600;\">\r\n        <i class=\"fas fa-pen\"></i>\r\n        Mulai Menulis\r\n    </a>\r\n</div>', 1, NULL, NULL, '2025-07-09 10:27:07', 1, '2025-07-09 10:41:31', 1, NULL, NULL),
(5, 10, 0, 'Test 1', 'test-1', '686e6fa7c213f_16082514904047_Image-Prosedur_Izin_Penelitian.png', '686e6fa7c2243_203. Surat Edaran Rektor Syarat UAS Genap 20242025.pdf', '<p>Test Konten</p>', 3, NULL, NULL, '2025-07-09 10:42:36', 1, '2025-07-09 14:20:55', 1, NULL, NULL),
(6, 10, 0, 'Test lagi', 'test-lagi', NULL, NULL, '<p>sdfsdf</p>', 2, NULL, NULL, '2025-07-09 14:28:06', 10, '2025-07-09 07:30:26', 1, NULL, NULL),
(7, 10, 0, 'Test diterima', 'test-diterima', '686e81b9d730f_wallpaperflare.com_wallpaper copy.jpg', '686e81b9d7544_203. Surat Edaran Rektor Syarat UAS Genap 20242025.pdf', '<p>Test untuk kasus diterima</p>', 0, NULL, NULL, '2025-07-09 14:50:33', 10, '2025-07-09 14:50:33', 10, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_articles_categories`
--

CREATE TABLE `tbl_articles_categories` (
  `id` int NOT NULL,
  `id_category` int NOT NULL,
  `id_article` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_articles_categories`
--

INSERT INTO `tbl_articles_categories` (`id`, `id_category`, `id_article`) VALUES
(6, 10, 3),
(7, 10, 2),
(15, 10, 4),
(16, 11, 4),
(21, 14, 5),
(22, 15, 5),
(23, 13, 6),
(24, 15, 6),
(25, 13, 7),
(26, 15, 7);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_categories`
--

CREATE TABLE `tbl_categories` (
  `id` int NOT NULL,
  `name` varchar(35) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `id_parent` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_categories`
--

INSERT INTO `tbl_categories` (`id`, `name`, `slug`, `id_parent`, `type`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(10, 'Hero Banner', 'hero-banner', 0, 0, 1, '2025-07-09 09:04:42', 1, '2025-07-09 09:05:16', 1, NULL, NULL),
(11, 'Statistik', 'statistik', 0, 0, 1, '2025-07-09 09:05:29', 1, '2025-07-09 09:05:29', 1, NULL, NULL),
(12, 'Keunggulan', 'keunggulan', 0, 0, 1, '2025-07-09 09:06:28', 1, '2025-07-09 09:06:28', 1, NULL, NULL),
(13, 'Anak-Anak', 'anak-anak', 0, 1, 1, '2025-07-09 10:31:58', 1, '2025-07-09 10:31:58', 1, NULL, NULL),
(14, 'Pelajaran', 'pelajaran', 0, 1, 1, '2025-07-09 10:32:11', 1, '2025-07-09 10:42:07', 1, NULL, NULL),
(15, 'Dongeng', 'dongeng', 0, 1, 1, '2025-07-09 10:42:19', 1, '2025-07-09 10:42:19', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_reviews`
--

CREATE TABLE `tbl_reviews` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_article` int NOT NULL,
  `notes` text,
  `status` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_reviews`
--

INSERT INTO `tbl_reviews` (`id`, `id_user`, `id_article`, `notes`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 5, 'Rapikan heading', 2, '2025-07-09 07:01:10', 1, '2025-07-09 14:01:10', NULL, NULL, NULL),
(2, 1, 5, 'Masih ada yang keliru', 2, '2025-07-09 07:16:00', 1, '2025-07-09 14:16:00', NULL, NULL, NULL),
(3, 1, 5, 'Masih kurang benar', 2, '2025-07-09 07:18:26', 1, '2025-07-09 14:18:26', NULL, NULL, NULL),
(4, 1, 5, 'Maaf belum bisa masuk', 3, '2025-07-09 07:19:13', 1, '2025-07-09 14:19:13', NULL, NULL, NULL),
(5, 1, 6, 'Perlu revisi', 2, '2025-07-09 07:30:26', 1, '2025-07-09 14:30:26', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `notes` varchar(255) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `type` int NOT NULL DEFAULT '0',
  `total` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `id_role` int NOT NULL,
  `status` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `username`, `password`, `name`, `id_role`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'admin@mail.com', '$2y$10$Sdt7nZRmFg27YlzVq7Owo.l/wUiv2QYW5GvqHH78Wok5FoS8GdTme', 'Admin', 1, 1, '2025-07-04 09:17:50', NULL, '2025-07-08 17:14:09', NULL, NULL, NULL),
(10, 'betanto@gmail.com', '$2y$10$9Lzelk4RioCvsFEGrJIjL.WMhb2HBpq3yFyr86K3p.sJs.nInAb0.', 'Betanto', 2, 1, '2025-07-08 17:53:28', NULL, '2025-07-09 04:55:02', 1, '2025-07-09 04:55:02', 1),
(11, 'kedua@mail.com', '$2y$10$dL1AHtEGLV9TIASAl5gJiuRilR0QutmL6RToWvUNYgEWWaMVbNqJi', 'Akun Kedua', 2, 1, '2025-07-09 15:01:18', NULL, '2025-07-09 15:01:18', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_wallets`
--

CREATE TABLE `tbl_wallets` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `total` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_articles`
--
ALTER TABLE `tbl_articles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_articles_categories`
--
ALTER TABLE `tbl_articles_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `tbl_categories`
--
ALTER TABLE `tbl_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_reviews`
--
ALTER TABLE `tbl_reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
