-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 10, 2025 at 01:32 PM
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
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `content` text,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tbl_articles`
--

INSERT INTO `tbl_articles` (`id`, `id_user`, `id_parent`, `title`, `slug`, `image`, `file`, `content`, `status`, `payment_at`, `payment_by`, `amount`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 0, 'Hero Title', 'hero-title', '686fbf63303b2_orang.png', NULL, '<h1 class=\"hero-title\">\r\n    Berbagi Cerita,<br>\r\n    <span style=\"background: linear-gradient(135deg, #f97316 0%, #ea580c 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;\">Menginspirasi Dunia</span>\r\n</h1>\r\n<p class=\"hero-subtitle\">\r\n    Bergabunglah dengan komunitas penulis dan pembaca terbesar di Indonesia. \r\n    Temukan cerita inspiratif dan bagikan pengalaman Anda.\r\n</p>\r\n<div class=\"d-flex flex-wrap gap-3\">\r\n    <a href=\"/stories\" class=\"btn-hero\">\r\n        <i class=\"fas fa-search\"></i>\r\n        Jelajahi Cerita\r\n    </a>\r\n    <a href=\"/register\" class=\"btn btn-outline-primary btn-lg px-4 py-3\" style=\"border-radius: 50px; font-weight: 600;\">\r\n        <i class=\"fas fa-pen\"></i>\r\n        Mulai Menulis\r\n    </a>\r\n</div>\r\n\r\n<!-- Hero Stats -->\r\n<div class=\"row mt-5\">\r\n    <div class=\"col-4\">\r\n        <div class=\"text-center\">\r\n            <h4 class=\"fw-bold text-primary mb-0\">500K+</h4>\r\n            <small class=\"text-muted\">Pembaca</small>\r\n        </div>\r\n    </div>\r\n    <div class=\"col-4\">\r\n        <div class=\"text-center\">\r\n            <h4 class=\"fw-bold text-primary mb-0\">25K+</h4>\r\n            <small class=\"text-muted\">Cerita</small>\r\n        </div>\r\n    </div>\r\n    <div class=\"col-4\">\r\n        <div class=\"text-center\">\r\n            <h4 class=\"fw-bold text-primary mb-0\">1K+</h4>\r\n            <small class=\"text-muted\">Penulis</small>\r\n        </div>\r\n    </div>\r\n</div>', 1, NULL, NULL, NULL, '2025-07-10 12:56:43', 1, '2025-07-10 13:25:55', 1, NULL, NULL);

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
(5, 1, 1);

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
(1, 'Hero Banner', 'hero-banner', 0, 0, 1, '2025-07-10 12:56:19', 1, '2025-07-10 12:56:19', 1, NULL, NULL);

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
(1, 'admin@mail.com', '$2y$10$g8O8brAT9NilFzlfX.vpzOm.PGKtt1GK.YBtg7XzkOvRJX84y7.8u', 'Admin', 1, 1, '2025-07-10 12:55:27', 1, '2025-07-10 12:55:27', 1, NULL, NULL);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_articles`
--
ALTER TABLE `tbl_articles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_articles_categories`
--
ALTER TABLE `tbl_articles_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_categories`
--
ALTER TABLE `tbl_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_reviews`
--
ALTER TABLE `tbl_reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
