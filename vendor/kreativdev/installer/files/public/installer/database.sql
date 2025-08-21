-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 05, 2025 at 10:08 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `timestay_main_file`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_us`
--

CREATE TABLE `about_us` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `features_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `about_us`
--

INSERT INTO `about_us` (`id`, `language_id`, `title`, `subtitle`, `text`, `button_text`, `button_url`, `features_title`, `created_at`, `updated_at`) VALUES
(1, 20, 'Why You Choose Us', 'Trusted, Convenient, and Secure Service Booking.', '<p>&nbsp;Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum aspernatur minus exercitationem vero, repudiandae ducimus ut beatae, sit, dolor laudantium culpa ullam itaque consequatur incidunt distinctio deserunt expedita quae sequi iure. Ipsam pariatur corporis ullam, quos est.</p>\r\n<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum aspernatur minus exercitationem vero, repudiandae ducimus ut beatae, sit, dolor laudantium culpa ullam itaque consequatur incidunt distinctio deserunt expedita quae sequi iure. Ipsam pariatur corporis ullam, quos est.&nbsp;</p>', 'More', 'https://hottlo.test/rooms', NULL, '2024-12-06 21:31:59', '2024-12-06 21:42:57');

-- --------------------------------------------------------

--
-- Table structure for table `additional_services`
--

CREATE TABLE `additional_services` (
  `id` bigint UNSIGNED NOT NULL,
  `status` bigint DEFAULT NULL,
  `serial_number` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `additional_services`
--

INSERT INTO `additional_services` (`id`, `status`, `serial_number`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2024-12-02 02:15:18', '2024-12-02 02:15:18'),
(2, 1, 2, '2024-12-02 02:15:55', '2024-12-02 02:15:55'),
(3, 1, 3, '2024-12-02 02:16:17', '2024-12-02 02:16:17'),
(4, 1, 4, '2024-12-02 02:16:42', '2024-12-02 02:16:42'),
(5, 1, 5, '2024-12-02 02:22:18', '2024-12-02 02:24:21'),
(6, 1, 6, '2024-12-02 02:24:55', '2024-12-02 02:24:55'),
(7, 1, 7, '2024-12-02 02:25:26', '2024-12-02 02:25:26'),
(8, 1, 8, '2024-12-02 02:26:13', '2024-12-02 02:26:13'),
(9, 1, 9, '2024-12-02 02:27:49', '2024-12-02 02:27:49'),
(10, 1, 10, '2024-12-02 02:30:01', '2024-12-25 23:06:48');

-- --------------------------------------------------------

--
-- Table structure for table `additional_service_contents`
--

CREATE TABLE `additional_service_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `additional_service_id` bigint DEFAULT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `additional_service_contents`
--

INSERT INTO `additional_service_contents` (`id`, `additional_service_id`, `language_id`, `title`, `created_at`, `updated_at`) VALUES
(1, 1, 20, 'In-Room Dining', '2024-12-02 02:15:18', '2024-12-02 02:15:18'),
(2, 1, 21, 'تناول الطعام داخل الغرفة', '2024-12-02 02:15:18', '2024-12-02 02:15:18'),
(3, 2, 20, 'Room Decoration Services', '2024-12-02 02:15:55', '2024-12-02 02:15:55'),
(4, 2, 21, 'خدمات تزيين الغرف', '2024-12-02 02:15:55', '2024-12-02 02:15:55'),
(5, 3, 20, 'Airport Pickup and Drop-off', '2024-12-02 02:16:17', '2024-12-02 02:16:17'),
(6, 3, 21, 'الاستقبال والتوصيل من المطار', '2024-12-02 02:16:17', '2024-12-02 02:16:17'),
(7, 4, 20, 'Luggage Storage', '2024-12-02 02:16:42', '2024-12-02 02:16:42'),
(8, 4, 21, 'تخزين الأمتعة', '2024-12-02 02:16:42', '2024-12-02 02:16:42'),
(9, 5, 20, 'Fitness Center Access', '2024-12-02 02:22:18', '2024-12-02 02:24:14'),
(10, 5, 21, 'الوصول إلى مركز اللياقة البدنية', '2024-12-02 02:22:18', '2024-12-02 02:24:14'),
(11, 6, 20, 'Breakfast in Bed', '2024-12-02 02:24:55', '2024-12-02 02:24:55'),
(12, 6, 21, 'الإفطار في السرير', '2024-12-02 02:24:55', '2024-12-02 02:24:55'),
(13, 7, 20, 'Private Dining Options', '2024-12-02 02:25:26', '2024-12-02 02:25:26'),
(14, 7, 21, 'خيارات تناول الطعام الخاصة', '2024-12-02 02:25:26', '2024-12-02 02:25:26'),
(15, 8, 20, 'Childcare and Babysitting', '2024-12-02 02:26:13', '2024-12-02 02:26:13'),
(16, 8, 21, 'رعاية الأطفال ومجالسة الأطفال', '2024-12-02 02:26:13', '2024-12-02 02:26:13'),
(17, 9, 20, 'Tech Rentals', '2024-12-02 02:27:49', '2024-12-02 02:27:49'),
(18, 9, 21, 'تأجير التكنولوجيا', '2024-12-02 02:27:49', '2024-12-02 02:27:49'),
(19, 10, 20, 'Photography Packages', '2024-12-02 02:30:01', '2024-12-02 02:30:01'),
(20, 10, 21, 'باقات التصوير الفوتوغرافي', '2024-12-02 02:30:01', '2024-12-02 02:30:01');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `show_email_address` int DEFAULT '0',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `show_phone_number` int NOT NULL DEFAULT '0',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `details` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `lang_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `role_id`, `first_name`, `last_name`, `image`, `username`, `email`, `show_email_address`, `phone`, `show_phone_number`, `password`, `address`, `details`, `code`, `lang_code`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, NULL, '674d20db3045e.png', 'admin', 'admin@example.com', 1, '+1234567890', 1, '$2y$10$7rcuMv8LG9adF09JnRjt.O35YL/3dkFWA7EBhBT.LOZvS07OaeDFm', 'House no 3, Road 5/c, sector 11, Uttara, Dhaka, Bangladesh', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Molestiae blanditiis minus tempora quibusdam quas quo magni, repellat sit? Adipisci accusantium quasi autem tempora nemo aspernatur tenetur repellat numquam sed cupiditate.', 'en', 'admin_en', 1, NULL, '2025-01-05 03:35:23');

-- --------------------------------------------------------

--
-- Table structure for table `advertisements`
--

CREATE TABLE `advertisements` (
  `id` bigint UNSIGNED NOT NULL,
  `ad_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `resolution_type` smallint UNSIGNED NOT NULL COMMENT '1 => 300 x 250, 2 => 300 x 600, 3 => 728 x 90',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slot` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `views` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `advertisements`
--

INSERT INTO `advertisements` (`id`, `ad_type`, `resolution_type`, `image`, `url`, `slot`, `views`, `created_at`, `updated_at`) VALUES
(1, 'banner', 3, '675d26ffa0315.png', 'http://example.com/', NULL, 0, '2024-12-14 00:34:39', '2024-12-14 00:34:39'),
(2, 'banner', 3, '675d270d060fa.png', 'http://example.com/', NULL, 0, '2024-12-14 00:34:53', '2024-12-14 00:34:53'),
(3, 'banner', 1, '675d272729b8c.png', 'http://example.com/', NULL, 0, '2024-12-14 00:35:19', '2024-12-14 00:35:19'),
(4, 'banner', 1, '675d27343cc9f.png', 'http://example.com/', NULL, 0, '2024-12-14 00:35:32', '2024-12-14 00:35:32'),
(5, 'banner', 2, '675d27475b319.png', 'http://example.com/', NULL, 0, '2024-12-14 00:35:51', '2024-12-14 00:35:51'),
(6, 'banner', 2, '675d2754079e8.png', 'http://example.com/', NULL, 0, '2024-12-14 00:36:04', '2024-12-14 00:36:04');

-- --------------------------------------------------------

--
-- Table structure for table `amenities`
--

CREATE TABLE `amenities` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `amenities`
--

INSERT INTO `amenities` (`id`, `language_id`, `title`, `icon`, `created_at`, `updated_at`) VALUES
(1, 20, 'Free Wi-Fi', 'fas fa-wifi', '2024-11-30 22:36:13', '2024-11-30 22:36:13'),
(2, 20, 'Swimming Pool', 'fas fa-swimming-pool', '2024-11-30 22:36:37', '2024-11-30 22:36:37'),
(3, 20, 'Fitness Center', 'fas fa-dumbbell', '2024-11-30 22:37:11', '2024-11-30 22:37:11'),
(4, 20, 'Restaurant', 'fas fa-utensils', '2024-11-30 22:37:33', '2024-11-30 22:37:33'),
(5, 20, 'Spa', 'fas fa-spa', '2024-11-30 22:38:08', '2024-11-30 22:38:08'),
(6, 20, 'Room Service', 'fas fa-concierge-bell', '2024-11-30 22:38:34', '2024-11-30 22:38:34'),
(7, 20, 'Parking', 'fas fa-parking', '2024-11-30 22:38:55', '2024-11-30 22:38:55'),
(8, 20, 'Air Conditioning', 'fas fa-temperature-high', '2024-11-30 22:39:17', '2024-11-30 22:39:17'),
(9, 20, '24-Hour Front Desk', 'fas fa-clock', '2024-11-30 22:41:19', '2024-11-30 22:41:19'),
(10, 20, 'Pet-Friendly', 'fas fa-paw', '2024-11-30 22:41:55', '2024-11-30 22:41:55'),
(11, 20, 'Business Center', 'fas fa-laptop', '2024-11-30 22:42:35', '2024-11-30 22:42:35'),
(12, 20, 'Safety Deposit Box', 'fas fa-lock-open', '2024-11-30 22:42:59', '2024-11-30 22:42:59'),
(13, 21, 'خدمة الواي فاي المجانية', 'fas fa-wifi', '2024-11-30 22:36:13', '2025-01-03 20:48:05'),
(14, 21, 'حمام السباحة', 'fas fa-swimming-pool', '2024-11-30 22:36:37', '2025-01-03 20:51:06'),
(15, 21, 'مركز اللياقة البدنية', 'fas fa-dumbbell', '2024-11-30 22:37:11', '2025-01-03 20:50:51'),
(16, 21, 'مطعم', 'fas fa-utensils', '2024-11-30 22:37:33', '2025-01-03 20:50:39'),
(17, 21, 'سبا', 'fas fa-spa', '2024-11-30 22:38:08', '2025-01-03 20:50:24'),
(18, 21, 'خدمة الغرف', 'fas fa-concierge-bell', '2024-11-30 22:38:34', '2025-01-03 20:50:12'),
(19, 21, 'وقوف السيارات', 'fas fa-parking', '2024-11-30 22:38:55', '2025-01-03 20:49:24'),
(20, 21, 'تكييف', 'fas fa-temperature-high', '2024-11-30 22:39:17', '2025-01-03 20:49:12'),
(21, 21, 'مكتب استقبال يعمل على مدار 24 ساعة', 'fas fa-clock', '2024-11-30 22:41:19', '2025-01-03 20:48:59'),
(22, 21, 'صديقة للحيوانات الأليفة', 'fas fa-paw', '2024-11-30 22:41:55', '2025-01-03 20:48:44'),
(23, 21, 'مركز الأعمال', 'fas fa-laptop', '2024-11-30 22:42:35', '2025-01-03 20:48:31'),
(24, 21, 'صندوق الأمانات', 'fas fa-lock-open', '2024-11-30 22:42:59', '2025-01-03 20:48:17');

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `basic_settings`
--

CREATE TABLE `basic_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `uniqid` int UNSIGNED NOT NULL DEFAULT '12345',
  `favicon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `logo_two` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `website_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `theme_version` smallint UNSIGNED NOT NULL,
  `base_currency_symbol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_symbol_position` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_text` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_text_position` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_rate` decimal(8,2) DEFAULT NULL,
  `primary_color` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_status` tinyint DEFAULT NULL,
  `smtp_host` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_port` int DEFAULT NULL,
  `encryption` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `from_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `to_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `breadcrumb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `disqus_status` tinyint UNSIGNED DEFAULT NULL,
  `disqus_short_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_recaptcha_status` tinyint DEFAULT NULL,
  `google_recaptcha_site_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_recaptcha_secret_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_status` tinyint UNSIGNED DEFAULT NULL,
  `whatsapp_number` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_header_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_popup_status` tinyint UNSIGNED DEFAULT NULL,
  `whatsapp_popup_message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `maintenance_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `maintenance_status` tinyint DEFAULT NULL,
  `maintenance_msg` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `total_earning` double(8,2) NOT NULL DEFAULT '0.00',
  `bypass_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `footer_logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `footer_background_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `admin_theme_version` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'light',
  `notification_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_adsense_publisher_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `equipment_tax_amount` decimal(5,2) UNSIGNED DEFAULT NULL,
  `hotel_tax_amount` double DEFAULT NULL,
  `self_pickup_status` tinyint UNSIGNED DEFAULT NULL,
  `two_way_delivery_status` tinyint UNSIGNED DEFAULT NULL,
  `guest_checkout_status` tinyint UNSIGNED NOT NULL,
  `hotel_view` int DEFAULT NULL,
  `room_view` int DEFAULT NULL,
  `facebook_login_status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1 -> enable, 0 -> disable',
  `facebook_app_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `facebook_app_secret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_login_status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1 -> enable, 0 -> disable',
  `google_client_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_client_secret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_map_api_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_map_api_key_status` int NOT NULL DEFAULT '0',
  `radius` int NOT NULL DEFAULT '10',
  `tawkto_status` tinyint UNSIGNED NOT NULL COMMENT '1 -> enable, 0 -> disable',
  `tawkto_direct_chat_link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_admin_approval` int NOT NULL DEFAULT '0' COMMENT '1 active, 2 deactive',
  `vendor_email_verification` int NOT NULL DEFAULT '0' COMMENT '1 active, 2 deactive',
  `admin_approval_notice` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `expiration_reminder` int DEFAULT '3',
  `timezone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `hero_section_video_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `contact_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_subtile` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `latitude` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `preloader_status` int DEFAULT '1',
  `preloader` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `time_format` int DEFAULT NULL,
  `about_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `hero_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `feature_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `counter_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `call_to_action_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `call_to_action_section_inner_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `testimonial_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `basic_settings`
--

INSERT INTO `basic_settings` (`id`, `uniqid`, `favicon`, `logo`, `logo_two`, `website_title`, `email_address`, `contact_number`, `address`, `theme_version`, `base_currency_symbol`, `base_currency_symbol_position`, `base_currency_text`, `base_currency_text_position`, `base_currency_rate`, `primary_color`, `smtp_status`, `smtp_host`, `smtp_port`, `encryption`, `smtp_username`, `smtp_password`, `from_mail`, `from_name`, `to_mail`, `breadcrumb`, `disqus_status`, `disqus_short_name`, `google_recaptcha_status`, `google_recaptcha_site_key`, `google_recaptcha_secret_key`, `whatsapp_status`, `whatsapp_number`, `whatsapp_header_title`, `whatsapp_popup_status`, `whatsapp_popup_message`, `maintenance_img`, `maintenance_status`, `maintenance_msg`, `total_earning`, `bypass_token`, `footer_logo`, `footer_background_image`, `admin_theme_version`, `notification_image`, `google_adsense_publisher_id`, `equipment_tax_amount`, `hotel_tax_amount`, `self_pickup_status`, `two_way_delivery_status`, `guest_checkout_status`, `hotel_view`, `room_view`, `facebook_login_status`, `facebook_app_id`, `facebook_app_secret`, `google_login_status`, `google_client_id`, `google_client_secret`, `google_map_api_key`, `google_map_api_key_status`, `radius`, `tawkto_status`, `tawkto_direct_chat_link`, `vendor_admin_approval`, `vendor_email_verification`, `admin_approval_notice`, `expiration_reminder`, `timezone`, `hero_section_video_url`, `contact_title`, `contact_subtile`, `contact_details`, `latitude`, `longitude`, `preloader_status`, `preloader`, `time_format`, `about_section_image`, `hero_section_image`, `feature_section_image`, `counter_section_image`, `call_to_action_section_image`, `call_to_action_section_inner_image`, `testimonial_section_image`, `updated_at`) VALUES
(2, 12345, '677514981fe2f.png', '6775123ebcb9e.png', '64ed7071b1844.png', 'TimeStay', 'timestay@example.com', '+70133', '450 Young Road, New York, USA', 1, '$', 'right', 'USD', 'left', 1.00, 'C6834B', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'example@example.com', '6641d13fcffde.jpg', 0, NULL, 1, '6LfFRt4pAAAAAF_FSbQN8b538Q04C-6ulR8f7vl_', '6LfFRt4pAAAAAFOiikW2B-GgWFVgP5jGpny3U5-p', 1, '+8811111111111', 'Hi,there', 1, 'If you have any issues, let us know.', '1632725312.png', 0, 'We are upgrading our site. We will come back soon. \r\nPlease stay with us.\r\nThank you.', 0.00, 'azim', '677511ec6df9e.png', '66a1e5bc9ee81.jpg', 'light', '619b7d5e5e9df.png', 'dvf', 5.00, 5, 1, 1, 0, 0, 0, 1, '882678273570258', 'bb014c58bd4e278315db8b39703dc23e', 1, '839746240383-1dhilrs0dpqsjel8bas6og7fmusoqm8s.apps.googleusercontent.com', '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', 'AIzaSyBh-Q9sZzK43b6UssN6vCDrdwgWv4NOL68', 1, 5000, 1, 'https://tawk.to/chat/65617f23da19b36217909aae/1hg2dh96j', 1, 1, 'Your account is deactive or pending now. Please Contact with admin!', 3, 'Asia/Dhaka', 'https://www.youtube.com/watch?v=9l6RywtDlKA', 'Get Connected', 'How Can We Help You?', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\r\n\r\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.', '23.21', '90.3785693', 1, '673b11564dea9.gif', 12, '6753c1ab4183e.png', '674bcea685119.png', '674bcebb407a3.png', '674bcf2dec7d8.jpg', '674bcf2decaeb.jpg', '6753e46fe0ee6.png', '6753e40c0e036.jpg', '2025-01-03 23:28:18');

-- --------------------------------------------------------

--
-- Table structure for table `benifits`
--

CREATE TABLE `benifits` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `background_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `benifits`
--

INSERT INTO `benifits` (`id`, `language_id`, `background_image`, `title`, `text`, `created_at`, `updated_at`) VALUES
(1, 20, '6753e5456adb3.jpg', 'Night Stay', 'Stay night with comfortable time', '2024-12-07 00:03:49', '2024-12-07 00:03:49'),
(2, 20, '6753e56c8f132.jpg', 'Family Travel', 'Create memories with every journey', '2024-12-07 00:04:28', '2024-12-07 00:16:11'),
(4, 20, '6753e7217eed3.jpg', 'Skill Training', 'Sharpen skills in a focused environment', '2024-12-07 00:11:45', '2024-12-07 00:16:48'),
(5, 20, '6753e74714ceb.jpg', 'Office Meeting', 'Professional spaces for every agenda', '2024-12-07 00:12:23', '2024-12-07 00:16:33'),
(6, 21, '6753e90398d74.jpg', 'إقامة ليلية', 'البقاء ليلا مع وقت مريح', '2024-12-07 00:03:49', '2024-12-07 00:22:04'),
(7, 21, '6753e8f4bb2b0.jpg', 'سفر العائلة', 'اصنع ذكريات مع كل رحلة', '2024-12-07 00:04:28', '2024-12-07 00:20:48'),
(8, 21, '6753e8e448270.jpg', 'التدريب على المهارات', 'شحذ المهارات في بيئة مركزة', '2024-12-07 00:11:45', '2024-12-07 00:20:28'),
(9, 21, '6753e8d43fcbd.jpg', 'اجتماع المكتب', 'مساحات احترافية لكل جدول أعمال', '2024-12-07 00:12:23', '2024-12-07 00:20:08');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` mediumint UNSIGNED NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `image`, `serial_number`, `status`, `created_at`, `updated_at`) VALUES
(28, '674eb8d6dd43b.png', 1, '1', '2024-12-03 01:52:54', '2024-12-03 01:52:54'),
(29, '674eb9939c8d7.png', 2, '1', '2024-12-03 01:56:03', '2024-12-03 01:56:03'),
(30, '674eba264de42.png', 3, '1', '2024-12-03 01:58:30', '2024-12-03 01:58:30'),
(31, '674ebaae9e759.png', 4, '1', '2024-12-03 02:00:46', '2024-12-03 02:00:46'),
(32, '674ebb9c5d52a.png', 5, '1', '2024-12-03 02:04:44', '2024-12-03 02:04:44'),
(33, '674ebc4ee8669.png', 6, '1', '2024-12-03 02:07:42', '2024-12-03 02:07:42'),
(34, '674ebcbadf56f.png', 7, '1', '2024-12-03 02:09:30', '2024-12-03 02:09:30'),
(35, '674ebea22110b.png', 8, '1', '2024-12-03 02:12:43', '2024-12-03 02:17:38');

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `language_id`, `name`, `slug`, `status`, `serial_number`, `created_at`, `updated_at`) VALUES
(42, 20, 'Business Travel', 'business-travel', 1, 1, '2023-08-19 00:45:17', '2024-12-03 01:34:51'),
(43, 20, 'Family Travel', 'family-travel', 1, 2, '2023-08-19 00:45:38', '2024-12-03 01:39:15'),
(44, 20, 'Romantic Stays', 'romantic-stays', 1, 3, '2023-08-19 00:45:51', '2024-12-03 01:39:47'),
(45, 20, 'Travel Tips and Advice', 'travel-tips-and-advice', 1, 4, '2023-08-19 00:46:06', '2024-12-03 01:41:31'),
(48, 21, 'الإقامات الرومانسية', 'الإقامات-الرومانسية', 1, 3, '2023-08-19 00:47:35', '2025-01-05 03:35:16'),
(49, 21, 'نصائح وإرشادات السفر', 'نصائح-وإرشادات-السفر', 1, 4, '2023-08-19 00:48:23', '2025-01-05 03:35:03'),
(51, 21, 'سفر الأعمال', 'سفر-الأعمال', 1, 1, '2024-12-03 01:38:47', '2025-01-05 03:34:49'),
(52, 21, 'سفر العائلة', 'سفر-العائلة', 1, 2, '2024-12-03 01:39:26', '2025-01-05 03:34:28');

-- --------------------------------------------------------

--
-- Table structure for table `blog_informations`
--

CREATE TABLE `blog_informations` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `blog_category_id` bigint UNSIGNED NOT NULL,
  `blog_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `author` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_informations`
--

INSERT INTO `blog_informations` (`id`, `language_id`, `blog_category_id`, `blog_id`, `title`, `slug`, `author`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(52, 20, 45, 28, 'Packing Essentials for Short Hotel Stays', 'packing-essentials-for-short-hotel-stays', 'Admin', 0x3c703e5768656e20796f7527726520706c616e6e696e6720612073686f727420686f74656c20737461792c207375636820617320616e206f7665726e696768742074726970206f7220612066657720686f75727320617420616e20686f75726c7920686f74656c2c207061636b696e672063616e206665656c206c696b652061206d696e6f722064657461696c2e20486f77657665722c206265696e6720707265706172656420776974682074686520726967687420657373656e7469616c732063616e206d616b6520796f7572207374617920736d6f6f746865722c206d6f726520656e6a6f7961626c652c20616e64207374726573732d667265652e205768657468657220796f752772652073746179696e672061742061206c757875727920686f74656c206f72206120636f6e76656e69656e7420627573696e6573732d667269656e646c792073706f742c207061636b696e6720656666696369656e746c7920697320746865206b657920746f206d6178696d697a696e6720796f75722073686f72742076697369742e3c2f703e0d0a3c68343e312e203c7374726f6e673e54726176656c2d467269656e646c7920546f696c6574726965733c2f7374726f6e673e3c2f68343e0d0a3c703e5768696c65206d616e7920686f74656c732070726f7669646520626173696320746f696c657472696573206c696b65207368616d706f6f2c20636f6e646974696f6e65722c20616e6420736f61702c20796f75206d61792070726566657220796f7572206f776e2070726f64756374732e204120736d616c6c20746f696c657472792062616720776974682074726176656c2d73697a6564206974656d732c207375636820617320746f6f746870617374652c206120746f6f746862727573682c2064656f646f72616e742c20616e6420736b696e6361726520657373656e7469616c732c20656e737572657320796f75207374617920667265736820616e6420636f6d666f727461626c652e20466f722073686f72742073746179732c20746865736520636f6d70616374206f7074696f6e732073617665207370616365207768696c65206b656570696e6720796f757220726f7574696e6520696e746163742e3c2f703e0d0a3c68343e322e203c7374726f6e673e436f6d666f727461626c6520436c6f7468696e673c2f7374726f6e673e3c2f68343e0d0a3c703e43686f6f736520766572736174696c6520636c6f7468696e67207468617420666974732074686520707572706f7365206f6620796f757220737461792e20466f7220627573696e6573732074726176656c6572732c207061636b2061207772696e6b6c652d66726565206f757466697420666f72206d656574696e67732e20496620796f752772652073746179696e6720666f72206c6569737572652c206f707420666f722072656c6178656420617474697265206c696b652062726561746861626c65206c6f756e676577656172206f722063617375616c20636c6f746865732e20446f6ee280997420666f726765742061206c69676874776569676874206a61636b6574206f7220736861776c20696620746865207765617468657220697320756e7072656469637461626c652e3c2f703e0d0a3c68343e332e203c7374726f6e673e506572736f6e616c20456c656374726f6e6963733c2f7374726f6e673e3c2f68343e0d0a3c703e4576656e20666f7220612073686f727420737461792c20796f7572206761646765747320617265206c696b656c7920746f20706c6179206120726f6c6520696e20796f757220636f6d666f7274206f722070726f6475637469766974792e204272696e6720796f75722070686f6e6520636861726765722c206120706f727461626c6520706f7765722062616e6b2c20616e642c206966206e65656465642c2061206c6170746f70206f72207461626c65742e204e6f6973652d63616e63656c696e67206865616470686f6e65732063616e20616c736f20636f6d6520696e2068616e647920666f722072656c61786174696f6e206f7220666f6375732e3c2f703e0d0a3c68343e342e203c7374726f6e673e4120436f6d7061637420456e7465727461696e6d656e74204b69743c2f7374726f6e673e3c2f68343e0d0a3c703e496620796f75206861766520646f776e74696d652c206120626f6f6b2c206d6167617a696e652c206f7220652d7265616465722063616e2070726f7669646520612077656c636f6d65206469737472616374696f6e2e20466f722066616d696c6965732c2061207461626c6574206c6f6164656420776974682067616d6573206f72206d6f76696573206b65657073206b69647320656e7465727461696e65642e3c2f703e0d0a3c68343e352e203c7374726f6e673e4865616c746820616e642048796769656e65204974656d733c2f7374726f6e673e3c2f68343e0d0a3c703e446f6ee2809974206f7665726c6f6f6b20796f757220706572736f6e616c206865616c7468206e656564732e20496e636c75646520616e79206461696c79206d656469636174696f6e732c206120736d616c6c2066697273742d616964206b69742c20616e642068616e642073616e6974697a65722e20466f7220616464656420636f6d666f72742c20657370656369616c6c7920647572696e6720636f6c646572206d6f6e7468732c20612074726176656c2d73697a6564206d6f6973747572697a6572206f72206c69702062616c6d2063616e2062652061206c69666573617665722e3c2f703e0d0a3c68343e362e203c7374726f6e673e536e61636b7320616e64204472696e6b733c2f7374726f6e673e3c2f68343e0d0a3c703e536f6d652073686f7274207374617973206d6179206e6f7420616c6c6f7720656e6f7567682074696d6520746f20656e6a6f7920726f6f6d2073657276696365206f72206578706c6f7265206c6f63616c2064696e696e67206f7074696f6e732e205061636b696e67206120666577206865616c74687920736e61636b73206f722061207265757361626c6520776174657220626f74746c6520656e737572657320796f75e280997265206e65766572206361756768742068756e677279206f7220746869727374792e3c2f703e0d0a3c68343e372e203c7374726f6e673e4120536d616c6c20446179204261673c2f7374726f6e673e3c2f68343e0d0a3c703e496620796f7520706c616e20746f206578706c6f726520746865206172656120647572696e6720796f757220737461792c206272696e67206120636f6d7061637420626167206f72206261636b7061636b20666f72206361727279696e6720657373656e7469616c73206c696b6520612077616c6c65742c206b6579732c20616e642061206d61702e2054686973206d696e696d697a657320746865206e65656420746f2072657475726e20746f2074686520686f74656c206672657175656e746c792e3c2f703e0d0a3c68343e382e203c7374726f6e673e54726176656c20446f63756d656e747320616e642049443c2f7374726f6e673e3c2f68343e0d0a3c703e466f72207365616d6c65737320636865636b2d696e2c20656e7375726520796f75206861766520796f757220626f6f6b696e6720636f6e6669726d6174696f6e20616e64206964656e74696669636174696f6e2e2053746f72696e67207468657365206469676974616c6c7920616e6420706879736963616c6c79206164647320616e206578747261206c61796572206f662073656375726974792e3c2f703e0d0a3c68333e46696e616c2054686f75676874733c2f68333e0d0a3c703e5061636b696e6720666f7220612073686f727420686f74656c207374617920646f65736ee2809974206e65656420746f206265206f7665727768656c6d696e672e20427920666f637573696e67206f6e20657373656e7469616c73207461696c6f72656420746f2074686520707572706f7365206f6620796f75722076697369742c20796f752063616e20656e73757265206120686173736c652d6672656520657870657269656e63652e20576865746865722069742773206120717569636b20627573696e65737320747269702c2061206c61796f7665722c206f72206120627269656620726f6d616e74696320676574617761792c20746865736520746970732068656c7020796f752074726176656c206c6967687420776974686f7574206d697373696e67206f7574206f6e20636f6d666f72742e20536f2c207061636b20736d6172742c2074726176656c206c696768742c20616e6420656e6a6f79206576657279206d6f6d656e74206f6620796f75722073746179213c2f703e, NULL, NULL, '2024-12-03 01:52:54', '2024-12-07 02:42:04'),
(53, 21, 49, 28, 'أساسيات التعبئة للإقامات القصيرة في الفندق', 'أساسيات-التعبئة-للإقامات-القصيرة-في-الفندق', 'مسؤل', 0x3c703ed8b9d986d8af20d8a7d984d8aad8aed8b7d98ad8b720d984d8a5d982d8a7d985d8a920d982d8b5d98ad8b1d8a920d981d98a20d981d986d8afd982d88c20d8b3d988d8a7d8a120d983d8a7d986d8aa20d8a5d982d8a7d985d8a920d984d984d98ad984d8a920d988d8a7d8add8afd8a920d8a3d98820d984d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d981d98a20d981d986d8afd98220d8a8d986d8b8d8a7d98520d8a7d984d8add8acd8b220d8a8d8a7d984d8b3d8a7d8b9d8a9d88c20d982d8af20d8aad8a8d8afd98820d8b9d985d984d98ad8a920d8a7d984d8aad8b9d8a8d8a6d8a920d985d8acd8b1d8af20d8aad981d8b5d98ad98420d8b5d8bad98ad8b12e20d988d985d8b920d8b0d984d983d88c20d981d8a5d98620d8a7d984d8aad8add8b6d98ad8b120d8a7d984d8acd98ad8af20d988d8add8b2d98520d8a7d984d8a3d8bad8b1d8a7d8b620d8a7d984d8b6d8b1d988d8b1d98ad8a920d98ad985d983d98620d8a3d98620d98ad8acd8b9d98420d8a5d982d8a7d985d8aad98320d8a3d983d8abd8b120d8b1d8a7d8add8a920d988d8b3d984d8a7d8b3d8a92e20d8b3d988d8a7d8a120d983d986d8aa20d8aad982d98ad98520d981d98a20d981d986d8afd98220d981d8a7d8aed8b120d8a3d98820d981d986d8afd98220d8b9d985d984d98a20d98ad986d8a7d8b3d8a820d8b1d8add984d8a7d8aa20d8a7d984d8b9d985d984d88c20d981d8a5d98620d8a7d984d8aad8b9d8a8d8a6d8a920d8a7d984d8b0d983d98ad8a920d987d98a20d8a7d984d985d981d8aad8a7d8ad20d984d8aad8add982d98ad98220d8a3d982d8b5d98920d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d8b2d98ad8a7d8b1d8aad98320d8a7d984d982d8b5d98ad8b1d8a92e3c2f703e0d0a3c68343e312e203c7374726f6e673ed985d8b3d8aad8add8b6d8b1d8a7d8aa20d8a7d984d8b9d986d8a7d98ad8a920d8a7d984d8b4d8aed8b5d98ad8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed8b9d984d98920d8a7d984d8b1d8bad98520d985d98620d8a3d98620d985d8b9d8b8d98520d8a7d984d981d986d8a7d8afd98220d8aad982d8afd98520d985d8b3d8aad984d8b2d985d8a7d8aa20d8a3d8b3d8a7d8b3d98ad8a920d985d8abd98420d8a7d984d8b4d8a7d985d8a8d98820d988d8a7d984d8b5d8a7d8a8d988d986d88c20d981d982d8af20d8aad981d8b6d98420d8a7d8b3d8aad8aed8afd8a7d98520d985d986d8aad8acd8a7d8aad98320d8a7d984d8aed8a7d8b5d8a92e20d8add982d98ad8a8d8a920d8b5d8bad98ad8b1d8a920d8aad8add8aad988d98a20d8b9d984d98920d985d8b3d8aad984d8b2d985d8a7d8aa20d8a7d984d8b3d981d8b120d985d8abd98420d985d8b9d8acd988d98620d8a7d984d8a3d8b3d986d8a7d986d88c20d981d8b1d8b4d8a7d8a920d8a7d984d8a3d8b3d986d8a7d986d88c20d985d8b2d98ad98420d8a7d984d8b9d8b1d982d88c20d988d985d986d8aad8acd8a7d8aa20d8a7d984d8b9d986d8a7d98ad8a920d8a8d8a7d984d8a8d8b4d8b1d8a920d8b3d8aad8b6d985d98620d8a3d986d98320d8aad8a8d982d98920d985d986d8aad8b9d8b4d98bd8a720d988d985d8b1d98ad8add98bd8a72e20d987d8b0d98720d8a7d984d8aed98ad8a7d8b1d8a7d8aa20d8a7d984d985d8afd985d8acd8a920d8aad988d981d8b120d985d8b3d8a7d8add8a920d988d8aad8a8d982d98ad98320d985d8b1d8aad8a7d8add98bd8a720d8a3d8abd986d8a7d8a120d8a5d982d8a7d985d8aad9832e3c2f703e0d0a3c68343e322e203c7374726f6e673ed985d984d8a7d8a8d8b320d985d8b1d98ad8add8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed8a7d8aed8aad8b120d985d984d8a7d8a8d8b320d985d8aad8b9d8afd8afd8a920d8a7d984d8a7d8b3d8aad8aed8afd8a7d985d8a7d8aa20d8aad986d8a7d8b3d8a820d8a7d984d8bad8b1d8b620d985d98620d8a5d982d8a7d985d8aad9832e20d984d984d985d8b3d8a7d981d8b1d98ad98620d8a8d8bad8b1d8b620d8a7d984d8b9d985d984d88c20d98ad985d983d98620d8a7d8aed8aad98ad8a7d8b120d985d984d8a7d8a8d8b320d985d982d8a7d988d985d8a920d984d984d8aad8acd8b9d8af20d984d984d8a7d8acd8aad985d8a7d8b9d8a7d8aa2e20d8a3d985d8a720d8a5d8b0d8a720d983d8a7d986d8aa20d8a7d984d8a5d982d8a7d985d8a920d8a8d8bad8b1d8b620d8a7d984d8a7d8b3d8aad8b1d8aed8a7d8a1d88c20d981d8a7d8aed8aad8b120d985d984d8a7d8a8d8b320d985d8b1d98ad8add8a920d988d8aed981d98ad981d8a92e20d984d8a720d8aad986d8b320d8a5d8add8b6d8a7d8b120d8b3d8aad8b1d8a920d8aed981d98ad981d8a920d8a3d98820d8b4d8a7d98420d981d98a20d8add8a7d98420d983d8a7d98620d8a7d984d8b7d982d8b320d985d8aad982d984d8a8d98bd8a72e3c2f703e0d0a3c68343e332e203c7374726f6e673ed8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a7d8aa20d8a7d984d8b4d8aed8b5d98ad8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed8add8aad98920d8aed984d8a7d98420d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d982d8b5d98ad8b1d8a9d88c20d8aad984d8b9d8a820d8a7d984d8a3d8acd987d8b2d8a920d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a920d8afd988d8b1d98bd8a720d981d98a20d8b1d8a7d8add8aad98320d988d8a5d986d8aad8a7d8acd98ad8aad9832e20d8aad8a3d983d8af20d985d98620d8a5d8add8b6d8a7d8b120d8b4d8a7d8add98620d8a7d984d987d8a7d8aad981d88c20d8a8d986d98320d8b7d8a7d982d8a920d985d8add985d988d984d88c20d988d8b1d8a8d985d8a720d8acd987d8a7d8b220d983d985d8a8d98ad988d8aad8b120d985d8add985d988d98420d8a3d98820d8acd987d8a7d8b220d984d988d8add98a20d8a5d8b0d8a720d984d8b2d98520d8a7d984d8a3d985d8b12e20d98ad985d983d98620d8a3d98620d8aad983d988d98620d8b3d985d8a7d8b9d8a7d8aa20d8a7d984d8b1d8a3d8b320d8a7d984d985d8b2d988d8afd8a920d8a8d8aed8a7d8b5d98ad8a920d8b9d8b2d98420d8a7d984d8b6d988d8b6d8a7d8a120d985d981d98ad8afd8a920d984d984d8a7d8b3d8aad8b1d8aed8a7d8a120d8a3d98820d8a7d984d8aad8b1d983d98ad8b22e3c2f703e0d0a3c68343e342e203c7374726f6e673ed985d8acd985d988d8b9d8a920d8aad8b1d981d98ad987d98ad8a920d8b5d8bad98ad8b1d8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed8a5d8b0d8a720d983d8a7d98620d984d8afd98ad98320d988d982d8aa20d981d8b1d8a7d8bad88c20d981d8a5d98620d983d8aad8a7d8a8d98bd8a720d8a3d98820d985d8acd984d8a920d8a3d98820d982d8a7d8b1d8a6d98bd8a720d8a5d984d983d8aad8b1d988d986d98ad98bd8a720d98ad985d983d98620d8a3d98620d98ad988d981d8b120d8aad8b3d984d98ad8a920d985d985d8aad8b9d8a92e20d984d984d8b9d8a7d8a6d984d8a7d8aad88c20d98ad98fd985d983d98620d8aad8add985d98ad98420d8a3d984d8b9d8a7d8a820d8a3d98820d8a3d981d984d8a7d98520d8b9d984d98920d8a7d984d8acd987d8a7d8b220d8a7d984d984d988d8add98a20d984d8a5d8a8d982d8a7d8a120d8a7d984d8a3d8b7d981d8a7d98420d985d8b4d8bad988d984d98ad9862e3c2f703e0d0a3c68343e352e203c7374726f6e673ed985d986d8aad8acd8a7d8aa20d8a7d984d8b5d8add8a920d988d8a7d984d986d8b8d8a7d981d8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed984d8a720d8aad987d985d98420d8a7d8add8aad98ad8a7d8acd8a7d8aad98320d8a7d984d8b5d8add98ad8a920d8a7d984d8b4d8aed8b5d98ad8a92e20d8a7d8add8b1d8b520d8b9d984d98920d8a5d8add8b6d8a7d8b120d8a3d98a20d8a3d8afd988d98ad8a920d98ad988d985d98ad8a9d88c20d8add982d98ad8a8d8a920d8a5d8b3d8b9d8a7d981d8a7d8aa20d8a3d988d984d98ad8a920d8b5d8bad98ad8b1d8a9d88c20d988d985d8b9d982d98520d984d984d98ad8afd98ad9862e20d984d984d8add8b5d988d98420d8b9d984d98920d985d8b2d98ad8af20d985d98620d8a7d984d8b1d8a7d8add8a9d88c20d8aed8b5d988d8b5d98bd8a720d8aed984d8a7d98420d8a7d984d8a3d8b4d987d8b120d8a7d984d8a8d8a7d8b1d8afd8a9d88c20d98ad985d983d98620d8a3d98620d98ad983d988d98620d983d8b1d98ad98520d985d8b1d8b7d8a820d8b5d8bad98ad8b120d8a3d98820d8a8d984d8b3d98520d8a7d984d8b4d981d8a7d98720d985d981d98ad8afd98bd8a72e3c2f703e0d0a3c68343e362e203c7374726f6e673ed988d8acd8a8d8a7d8aa20d8aed981d98ad981d8a920d988d985d8b4d8b1d988d8a8d8a7d8aa3c2f7374726f6e673e3c2f68343e0d0a3c703ed982d8af20d984d8a720d8aad8aad98ad8ad20d984d98320d8a7d984d8a5d982d8a7d985d8a920d8a7d984d982d8b5d98ad8b1d8a920d8a7d984d988d982d8aa20d984d984d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d8aed8afd985d8a7d8aa20d8a7d984d981d986d8afd98220d8a3d98820d8a7d8b3d8aad983d8b4d8a7d98120d8aed98ad8a7d8b1d8a7d8aa20d8a7d984d8b7d8b9d8a7d98520d8a7d984d985d8add984d98ad8a92e20d8a7d8add8b1d8b520d8b9d984d98920d8aad8b9d8a8d8a6d8a920d8a8d8b9d8b620d8a7d984d988d8acd8a8d8a7d8aa20d8a7d984d8aed981d98ad981d8a920d8a7d984d8b5d8add98ad8a920d8a3d98820d8b2d8acd8a7d8acd8a920d985d8a7d8a120d982d8a7d8a8d984d8a920d984d8a5d8b9d8a7d8afd8a920d8a7d984d8aad8b9d8a8d8a6d8a920d984d8aad981d8a7d8afd98a20d8a7d984d8acd988d8b920d8a3d98820d8a7d984d8b9d8b7d8b42e3c2f703e0d0a3c68343e372e203c7374726f6e673ed8add982d98ad8a8d8a920d8b5d8bad98ad8b1d8a920d98ad988d985d98ad8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed8a5d8b0d8a720d983d986d8aa20d8aad8aed8b7d8b720d984d8a7d8b3d8aad983d8b4d8a7d98120d8a7d984d985d986d8b7d982d8a920d8a3d8abd986d8a7d8a120d8a5d982d8a7d985d8aad983d88c20d8a3d8add8b6d8b120d8add982d98ad8a8d8a920d8b5d8bad98ad8b1d8a920d8a3d98820d8add982d98ad8a8d8a920d8b8d987d8b120d984d8add985d98420d8a7d984d8a3d8bad8b1d8a7d8b620d8a7d984d8a3d8b3d8a7d8b3d98ad8a920d985d8abd98420d8a7d984d985d8add981d8b8d8a920d988d8a7d984d985d981d8a7d8aad98ad8ad20d988d8a7d984d8aed8b1d98ad8b7d8a92e20d987d8b0d8a720d98ad982d984d98420d985d98620d8a7d984d8add8a7d8acd8a920d984d984d8b9d988d8afd8a920d8a5d984d98920d8a7d984d981d986d8afd98220d8a8d8b4d983d98420d985d8aad983d8b1d8b12e3c2f703e0d0a3c68343e382e203c7374726f6e673ed8a7d984d985d8b3d8aad986d8afd8a7d8aa20d988d988d8abd8a7d8a6d98220d8a7d984d8b3d981d8b13c2f7374726f6e673e3c2f68343e0d0a3c703ed984d8a5d8acd8b1d8a7d8a1d8a7d8aa20d8aad8b3d8acd98ad98420d988d8b5d988d98420d8b3d984d8b3d8a9d88c20d8aad8a3d983d8af20d985d98620d8a3d98620d984d8afd98ad98320d8aad8a3d983d98ad8af20d8a7d984d8add8acd8b220d988d8a8d8b7d8a7d982d8a920d8a7d984d987d988d98ad8a92e20d8a7d984d8a7d8add8aad981d8a7d8b820d8a8d986d8b3d8aed8a920d8b1d982d985d98ad8a920d988d988d8b1d982d98ad8a920d98ad8b6d98ad98120d8b7d8a8d982d8a920d8a5d8b6d8a7d981d98ad8a920d985d98620d8a7d984d8a3d985d8a7d9862e3c2f703e0d0a3c68333ed8a7d984d8aed984d8a7d8b5d8a93c2f68333e0d0a3c703ed8a7d984d8aad8b9d8a8d8a6d8a920d984d984d8a5d982d8a7d985d8a920d8a7d984d982d8b5d98ad8b1d8a920d981d98a20d8a7d984d981d986d8a7d8afd98220d984d98ad8b3d8aa20d8a3d985d8b1d98bd8a720d985d8b9d982d8afd98bd8a72e20d8a8d8a7d984d8aad8b1d983d98ad8b220d8b9d984d98920d8a7d984d8a3d8b3d8a7d8b3d98ad8a7d8aa20d8a7d984d8aad98a20d8aad986d8a7d8b3d8a820d8bad8b1d8b620d8b2d98ad8a7d8b1d8aad983d88c20d98ad985d983d986d98320d8b6d985d8a7d98620d8aad8acd8b1d8a8d8a920d8aed8a7d984d98ad8a920d985d98620d8a7d984d985d8aad8a7d8b9d8a82e20d8b3d988d8a7d8a120d983d8a7d986d8aa20d8b1d8add984d8a920d8b9d985d98420d8b3d8b1d98ad8b9d8a9d88c20d8aad988d982d981d98bd8a720d985d8a4d982d8aad98bd8a7d88c20d8a3d98820d8a5d8acd8a7d8b2d8a920d982d8b5d98ad8b1d8a920d8b1d988d985d8a7d986d8b3d98ad8a9d88c20d8aad8b3d8a7d8b9d8afd98320d987d8b0d98720d8a7d984d986d8b5d8a7d8a6d8ad20d8b9d984d98920d8a7d984d8b3d981d8b120d8a8d8aed981d8a920d988d8afd988d98620d8a7d984d8aad8b6d8add98ad8a920d8a8d8a7d984d8b1d8a7d8add8a92e20d984d8b0d8a7d88c20d8a7d8b3d8aad8b9d8af20d8a8d8b0d983d8a7d8a1d88c20d988d8b3d8a7d981d8b120d8a8d8aed981d8a9d88c20d988d8a7d8b3d8aad985d8aad8b920d8a8d983d98420d984d8add8b8d8a920d985d98620d8a5d982d8a7d985d8aad983213c2f703e, NULL, NULL, '2024-12-03 01:52:54', '2024-12-07 02:42:04'),
(54, 20, 45, 29, 'Top Mistakes to Avoid When Booking Hourly Hotels', 'top-mistakes-to-avoid-when-booking-hourly-hotels', 'Admin', 0x3c703e486f75726c7920686f74656c20626f6f6b696e67732068617665206265636f6d6520696e6372656173696e676c7920706f70756c61722064756520746f20746865697220666c65786962696c69747920616e6420636f6e76656e69656e63652e205768657468657220796f75277265206120627573696e6573732074726176656c657220696e206e656564206f66206120717569636b206e6170206265747765656e206d656574696e67732c206120636f75706c65207365656b696e67206120726f6d616e74696320726574726561742c206f72206120746f7572697374206c6f6f6b696e6720666f72206120627269656620726573742073746f702c20686f75726c7920686f74656c7320636174657220746f20766172696f7573206e656564732e20486f77657665722c206c696b6520616e7920736572766963652c2074686572652061726520636f6d6d6f6e206d697374616b65732070656f706c65206d616b65207768656e20626f6f6b696e6720686f75726c7920686f74656c7320746861742063616e206c65616420746f20616e20756e706c656173616e7420657870657269656e63652e2048657265e2809973206120677569646520746f2068656c7020796f752061766f6964207468656d2e3c2f703e0d0a3c68343e312e203c7374726f6e673e4e6f7420436865636b696e67205265766965777320616e6420526174696e67733c2f7374726f6e673e3c2f68343e0d0a3c703e4f6e65206f66207468652062696767657374206d697374616b657320697320736b697070696e67207468652073746570206f662072656164696e6720726576696577732e204120686f74656c2773207374617220726174696e6720616e6420677565737420666565646261636b2063616e206769766520796f75206120636c6561722070696374757265206f66207768617420746f206578706563742e204c6f6f6b20666f7220636f6e73697374656e7420636f6d706c61696e7473206f7220707261697365732c20657370656369616c6c792061626f757420636c65616e6c696e6573732c20736572766963652c20616e6420616d656e69746965732e2052656c6961626c6520706c6174666f726d73206c696b6520476f6f676c652c205472697041647669736f722c206f722074686520686f74656c27732077656273697465206f6674656e20686f737420746865736520726576696577732e3c2f703e0d0a3c68343e322e203c7374726f6e673e4f7665726c6f6f6b696e67204c6f636174696f6e20616e64204163636573736962696c6974793c2f7374726f6e673e3c2f68343e0d0a3c703e5768696c6520626f6f6b696e672c206d616e792070656f706c6520666f63757320736f6c656c79206f6e20707269636520616e6420666f7267657420746f20636f6e73696465722074686520686f74656c2773206c6f636174696f6e2e204120636865617020686f75726c7920686f74656c206f6e20746865206f7574736b69727473206f66207468652063697479206d69676874206e6f74207361766520796f75206d6f6e657920696620796f75206861766520746f207370656e64206578747261206f6e207472616e73706f72746174696f6e2e20416c776179732063686f6f73652061206c6f636174696f6e20636f6e76656e69656e7420666f7220796f7572206e656564732c2077686574686572206e6561722074686520616972706f72742c20747261696e2073746174696f6e2c206f7220636974792063656e7465722e3c2f703e0d0a3c68343e332e203c7374726f6e673e49676e6f72696e6720436865636b2d496e20616e6420436865636b2d4f757420506f6c69636965733c2f7374726f6e673e3c2f68343e0d0a3c703e486f75726c7920686f74656c73206f706572617465206f6e2073706563696669632074696d6520736c6f74732c20736f206974e280997320657373656e7469616c20746f20756e6465727374616e6420746865697220706f6c69636965732e204d6973756e6465727374616e64696e6720636865636b2d696e20616e6420636865636b2d6f75742074696d65732063616e206c65616420746f20756e6e65636573736172792063686172676573206f7220612072757368656420657870657269656e63652e20416c7761797320636f6e6669726d2074686520657861637420686f75727320796f75e280996c6c206265207573696e672074686520726f6f6d20616e642077686574686572207468657265e280997320666c65786962696c69747920666f7220657874656e73696f6e732e3c2f703e0d0a3c68343e342e203c7374726f6e673e536b697070696e672074686520416d656e697469657320436865636b3c2f7374726f6e673e3c2f68343e0d0a3c703e446966666572656e7420686f74656c73206f6666657220646966666572656e7420616d656e697469657320666f7220686f75726c792073746179732e20536f6d65206d6967687420696e636c75646520657373656e7469616c73206c696b652057692d46692c20726566726573686d656e74732c206f7220746f696c6574726965732c207768696c65206f7468657273206d6179206e6f742e204d616b65207375726520796f75207665726966792077686174e280997320696e636c7564656420696e20796f757220626f6f6b696e672e20466f7220696e7374616e63652c20696620796f75e280997265206f6e206120627573696e65737320747269702c2072656c6961626c6520696e7465726e657420616e64206120717569657420737061636520617265206c696b656c79206372756369616c20666f7220796f752e3c2f703e0d0a3c68343e352e203c7374726f6e673e4e6f7420436c6172696679696e672048696464656e20436861726765733c2f7374726f6e673e3c2f68343e0d0a3c703e4120636f6d6d6f6e206672757374726174696f6e20666f722074726176656c65727320697320656e636f756e746572696e672068696464656e20666565732075706f6e20636865636b2d6f75742e20536f6d6520686f75726c7920686f74656c73206d61792063686172676520666f72206164646974696f6e616c2073657276696365732073756368206173207061726b696e672c206c61746520636865636b2d6f7574732c206f7220726f6f6d2075706772616465732e2052656164207468652066696e65207072696e7420616e6420636f6e6669726d20616c6c20636f737473206265666f726568616e6420746f2061766f6964207375727072697365732e3c2f703e0d0a3c68343e362e203c7374726f6e673e4661696c696e6720746f20426f6f6b20696e20416476616e63653c2f7374726f6e673e3c2f68343e0d0a3c703e416c74686f75676820686f75726c7920686f74656c73206172652064657369676e656420666f722073706f6e74616e656f757320626f6f6b696e67732c207365637572696e6720796f757220726f6f6d20696e20616476616e636520697320616c7761797320776973652c20657370656369616c6c7920647572696e67207065616b2074696d6573206f7220696e2062757379206369746965732e204c6173742d6d696e75746520626f6f6b696e6773206d69676874206c6561766520796f752077697468206665776572206f7074696f6e73206f72206869676865722072617465732e3c2f703e0d0a3c68343e372e203c7374726f6e673e4e65676c656374696e672053616665747920616e6420507269766163793c2f7374726f6e673e3c2f68343e0d0a3c703e5361666574792073686f756c64206e6576657220626520636f6d70726f6d697365642e20526573656172636820776865746865722074686520686f74656c2068617320676f6f64207365637572697479206d6561737572657320696e20706c6163652c207375636820617320434354562c20736563757265206c6f636b732c20616e642070726f66657373696f6e616c2073746166662e204164646974696f6e616c6c792c20656e737572652074686520686f74656c2076616c75657320796f757220707269766163792c20657370656369616c6c7920696620796f75e28099726520626f6f6b696e6720666f72206120706572736f6e616c20676574617761792e3c2f703e0d0a3c68343e436f6e636c7573696f6e3c2f68343e0d0a3c703e426f6f6b696e6720686f75726c7920686f74656c732063616e20626520612067616d652d6368616e67657220666f722074726176656c657273207365656b696e6720666c65786962696c69747920616e64206166666f72646162696c6974792c20627574206f6e6c7920696620646f6e652072696768742e2042792061766f6964696e6720746865736520636f6d6d6f6e206d697374616b65732c20796f752063616e20656e73757265206120736d6f6f746820616e6420656e6a6f7961626c6520657870657269656e63652e205768657468657220666f7220776f726b2c20726573742c206f72206c6569737572652c206265696e6720696e666f726d656420616e642070726f6163746976652077696c6c206d616b6520796f75722073686f72742073746179207472756c7920776f7274687768696c652e3c2f703e, NULL, NULL, '2024-12-03 01:56:03', '2024-12-03 01:56:03'),
(55, 21, 49, 29, 'أهم الأخطاء التي يجب تجنبها عند حجز الفنادق بالساعة', 'أهم-الأخطاء-التي-يجب-تجنبها-عند-حجز-الفنادق-بالساعة', 'مسؤل', 0x3c68333e3c7374726f6e673ed8a3d987d98520d8a7d984d8a3d8aed8b7d8a7d8a120d8a7d984d8aad98a20d98ad8acd8a820d8aad8acd986d8a8d987d8a720d8b9d986d8af20d8add8acd8b220d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed8a3d8b5d8a8d8add8aa20d8add8acd988d8b2d8a7d8aa20d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8b4d8a7d8a6d8b9d8a920d8a8d8b4d983d98420d985d8aad8b2d8a7d98ad8af20d8a8d8b3d8a8d8a820d985d8b1d988d986d8aad987d8a720d988d985d984d8a7d8a1d985d8aad987d8a72e20d8b3d988d8a7d8a120d983d986d8aa20d985d8b3d8a7d981d8b1d98bd8a720d8a8d8bad8b1d8b620d8a7d984d8b9d985d98420d988d8aad8add8aad8a7d8ac20d8a5d984d98920d982d8b3d8b720d985d98620d8a7d984d8b1d8a7d8add8a920d8a8d98ad98620d8a7d984d8a7d8acd8aad985d8a7d8b9d8a7d8aad88c20d8a3d98820d8b2d988d8acd98ad98620d8aad8a8d8add8abd8a7d98620d8b9d98620d8a7d8b3d8aad8b1d8a7d8add8a920d8b1d988d985d8a7d986d8b3d98ad8a9d88c20d8a3d98820d8b3d8a7d8a6d8add98bd8a720d98ad8b1d8bad8a820d981d98a20d8a7d8b3d8aad8b1d8a7d8add8a920d982d8b5d98ad8b1d8a9d88c20d981d8a5d98620d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8aad984d8a8d98a20d8a7d8add8aad98ad8a7d8acd8a7d8aa20d985d8aad986d988d8b9d8a92e20d988d985d8b920d8b0d984d983d88c20d985d8abd98420d8a3d98a20d8aed8afd985d8a920d8a3d8aed8b1d989d88c20d987d986d8a7d98320d8a3d8aed8b7d8a7d8a120d8b4d8a7d8a6d8b9d8a920d98ad8b1d8aad983d8a8d987d8a720d8a7d984d8a8d8b9d8b620d8b9d986d8af20d8add8acd8b220d987d8b0d98720d8a7d984d981d986d8a7d8afd982d88c20d985d985d8a720d982d8af20d98ad8a4d8afd98a20d8a5d984d98920d8aad8acd8b1d8a8d8a920d8bad98ad8b120d985d8b1d8b6d98ad8a92e20d8a5d984d98ad98320d8afd984d98ad984d98bd8a720d984d8aad8acd986d8a820d987d8b0d98720d8a7d984d8a3d8aed8b7d8a7d8a12e3c2f703e0d0a3c68343e312e203c7374726f6e673ed8b9d8afd98520d8a7d984d8aad8add982d98220d985d98620d8a7d984d8aad982d98ad98ad985d8a7d8aa20d988d8a7d984d985d8b1d8a7d8acd8b9d8a7d8aa3c2f7374726f6e673e3c2f68343e0d0a3c703ed985d98620d8a3d983d8a8d8b120d8a7d984d8a3d8aed8b7d8a7d8a120d8a7d984d8aad98a20d98ad985d983d98620d8a3d98620d8aad8b1d8aad983d8a8d987d8a720d987d98820d8aad8acd8a7d988d8b220d8aed8b7d988d8a920d982d8b1d8a7d8a1d8a920d8a7d984d985d8b1d8a7d8acd8b9d8a7d8aa2e20d8aad982d98ad98ad98520d8a7d984d981d986d8afd98220d988d8a2d8b1d8a7d8a120d8a7d984d8b6d98ad988d98120d98ad985d983d98620d8a3d98620d98ad985d986d8add98320d981d983d8b1d8a920d988d8a7d8b6d8add8a920d8b9d985d8a720d98ad985d983d98620d8aad988d982d8b9d9872e20d8a7d8a8d8add8ab20d8b9d98620d8a7d984d8aad8b9d984d98ad982d8a7d8aa20d8a7d984d8aad98a20d8aad8aad8add8afd8ab20d8a8d8a7d8b3d8aad985d8b1d8a7d8b120d8b9d98620d8a7d984d986d8b8d8a7d981d8a920d8a3d98820d8a7d984d8aed8afd985d8a920d8a3d98820d8a7d984d985d8b1d8a7d981d9822e20d98ad985d983d986d98320d8a7d984d8b9d8abd988d8b120d8b9d984d98920d987d8b0d98720d8a7d984d985d8b1d8a7d8acd8b9d8a7d8aa20d8b9d8a8d8b120d985d986d8b5d8a7d8aa20d985d988d8abd988d982d8a920d985d8abd98420476f6f676c6520d8a3d988205472697041647669736f7220d8a3d98820d985d988d982d8b920d8a7d984d981d986d8afd9822e3c2f703e0d0a3c68343e322e203c7374726f6e673ed8aad8acd8a7d987d98420d8a7d984d985d988d982d8b920d988d8b3d987d988d984d8a920d8a7d984d988d8b5d988d9843c2f7374726f6e673e3c2f68343e0d0a3c703ed8b9d986d8af20d8a7d984d8add8acd8b2d88c20d98ad8b1d983d8b220d8a7d984d983d8abd98ad8b1d988d98620d8b9d984d98920d8a7d984d8b3d8b9d8b120d981d982d8b720d988d98ad8aad8acd8a7d987d984d988d98620d985d988d982d8b920d8a7d984d981d986d8afd9822e20d982d8af20d984d8a720d98ad988d981d8b120d8a7d984d981d986d8afd98220d8a7d984d8b1d8aed98ad8b520d981d98a20d8b6d988d8a7d8add98a20d8a7d984d985d8afd98ad986d8a920d8a7d984d983d8abd98ad8b120d8a5d8b0d8a720d983d8a7d98620d8b9d984d98ad98320d8a5d986d981d8a7d98220d8a7d984d985d8b2d98ad8af20d8b9d984d98920d988d8b3d8a7d8a6d98420d8a7d984d986d982d9842e20d8a7d8aed8aad8b120d8afd8a7d8a6d985d98bd8a720d985d988d982d8b9d98bd8a720d985d984d8a7d8a6d985d98bd8a720d984d8a7d8add8aad98ad8a7d8acd8a7d8aad983d88c20d8b3d988d8a7d8a120d983d8a7d98620d8a8d8a7d984d982d8b1d8a820d985d98620d8a7d984d985d8b7d8a7d8b120d8a3d98820d985d8add8b7d8a920d8a7d984d982d8b7d8a7d8b120d8a3d98820d988d8b3d8b720d8a7d984d985d8afd98ad986d8a92e3c2f703e0d0a3c68343e332e203c7374726f6e673ed8b9d8afd98520d981d987d98520d8b3d98ad8a7d8b3d8a7d8aa20d8aad8b3d8acd98ad98420d8a7d984d8afd8aed988d98420d988d8a7d984d8aed8b1d988d8ac3c2f7374726f6e673e3c2f68343e0d0a3c703ed8aad8b9d985d98420d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8a8d986d8a7d8a1d98b20d8b9d984d98920d981d8aad8b1d8a7d8aa20d8b2d985d986d98ad8a920d985d8add8afd8afd8a9d88c20d984d8b0d8a720d985d98620d8a7d984d8b6d8b1d988d8b1d98a20d981d987d98520d8b3d98ad8a7d8b3d8a7d8aad987d8a72e20d98ad985d983d98620d8a3d98620d98ad8a4d8afd98a20d8b3d988d8a120d8a7d984d981d987d98520d8a8d8b4d8a3d98620d8a3d988d982d8a7d8aa20d8aad8b3d8acd98ad98420d8a7d984d8afd8aed988d98420d988d8a7d984d8aed8b1d988d8ac20d8a5d984d98920d8b1d8b3d988d98520d8a5d8b6d8a7d981d98ad8a920d8a3d98820d8aad8acd8b1d8a8d8a920d8bad98ad8b120d985d8b1d98ad8add8a92e20d8aad8a3d983d8af20d8afd8a7d8a6d985d98bd8a720d985d98620d985d8b9d8b1d981d8a920d8a7d984d8b3d8a7d8b9d8a7d8aa20d8a7d984d985d8add8afd8afd8a920d8a7d984d8aad98a20d8b3d8aad8b3d8aad8aed8afd98520d981d98ad987d8a720d8a7d984d8bad8b1d981d8a920d988d985d8a720d8a5d8b0d8a720d983d8a7d986d8aa20d987d986d8a7d98320d985d8b1d988d986d8a920d981d98a20d8aad985d8afd98ad8af20d8a7d984d8a5d982d8a7d985d8a92e3c2f703e0d0a3c68343e342e203c7374726f6e673ed8aad8acd8a7d987d98420d8a7d984d8aad8add982d98220d985d98620d8a7d984d985d8b1d8a7d981d9823c2f7374726f6e673e3c2f68343e0d0a3c703ed8aad8aed8aad984d98120d8a7d984d981d986d8a7d8afd98220d981d98a20d8a7d984d985d8b1d8a7d981d98220d8a7d984d8aad98a20d8aad982d8afd985d987d8a720d984d984d8add8acd988d8b2d8a7d8aa20d8a8d8a7d984d8b3d8a7d8b9d8a92e20d982d8af20d8aad8aad8b6d985d98620d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d8aed8afd985d8a7d8aa20d8a3d8b3d8a7d8b3d98ad8a920d985d8abd98420d8a7d984d988d8a7d98a20d981d8a7d98a20d988d8a7d984d985d8b4d8b1d988d8a8d8a7d8aa20d988d8a7d984d985d8b3d8aad984d8b2d985d8a7d8aa20d8a7d984d8b4d8aed8b5d98ad8a9d88c20d981d98a20d8add98ad98620d982d8af20d984d8a720d8aad988d981d8b1d987d8a720d8a3d8aed8b1d9892e20d8aad8add982d98220d985d985d8a720d98ad8aad98520d8aad8b6d985d98ad986d98720d981d98a20d8a7d984d8add8acd8b22e20d8b9d984d98920d8b3d8a8d98ad98420d8a7d984d985d8abd8a7d984d88c20d8a5d8b0d8a720d983d986d8aa20d981d98a20d8b1d8add984d8a920d8b9d985d984d88c20d981d8a5d98620d8a7d984d8a5d986d8aad8b1d986d8aa20d8a7d984d985d988d8abd988d98220d8a8d98720d988d985d8b3d8a7d8add8a920d987d8a7d8afd8a6d8a920d982d8af20d8aad983d988d98620d985d98620d8a7d984d8a3d988d984d988d98ad8a7d8aa2e3c2f703e0d0a3c68343e352e203c7374726f6e673ed8b9d8afd98520d8aad988d8b6d98ad8ad20d8a7d984d8b1d8b3d988d98520d8a7d984d985d8aed981d98ad8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed985d98620d8a3d983d8abd8b120d8a7d984d8a3d985d988d8b120d8a7d984d985d8b2d8b9d8acd8a920d984d984d985d8b3d8a7d981d8b1d98ad98620d987d98820d985d988d8a7d8acd987d8a920d8b1d8b3d988d98520d8a5d8b6d8a7d981d98ad8a920d8bad98ad8b120d985d8aad988d982d8b9d8a920d8b9d986d8af20d8a7d984d985d8bad8a7d8afd8b1d8a92e20d982d8af20d8aad981d8b1d8b620d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8b1d8b3d988d985d98bd8a720d8b9d984d98920d8aed8afd985d8a7d8aa20d8a5d8b6d8a7d981d98ad8a920d985d8abd98420d985d988d8a7d982d98120d8a7d984d8b3d98ad8a7d8b1d8a7d8aa20d8a3d98820d8aad8b3d8acd98ad98420d8a7d984d8aed8b1d988d8ac20d8a7d984d985d8aad8a3d8aed8b120d8a3d98820d8aad8b1d982d98ad8a920d8a7d984d8bad8b1d981d8a92e20d8a7d982d8b1d8a320d8a7d984d8aad981d8a7d8b5d98ad98420d8a7d984d8afd982d98ad982d8a920d988d8aad8a3d983d8af20d985d98620d8acd985d98ad8b920d8a7d984d8aad983d8a7d984d98ad98120d985d8b3d8a8d982d98bd8a720d984d8aad8acd986d8a820d8a7d984d985d981d8a7d8acd8a2d8aa2e3c2f703e0d0a3c68343e362e203c7374726f6e673ed8b9d8afd98520d8a7d984d8add8acd8b220d985d8b3d8a8d982d98bd8a73c2f7374726f6e673e3c2f68343e0d0a3c703ed8b9d984d98920d8a7d984d8b1d8bad98520d985d98620d8a3d98620d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d985d8b5d985d985d8a920d984d984d8add8acd988d8b2d8a7d8aa20d8a7d984d981d988d8b1d98ad8a9d88c20d981d8a5d98620d8add8acd8b220d8a7d984d8bad8b1d981d8a920d985d8b3d8a8d982d98bd8a720d8afd8a7d8a6d985d98bd8a720d8aed98ad8a7d8b120d8add983d98ad985d88c20d8aed8a7d8b5d8a920d981d98a20d8a3d988d982d8a7d8aa20d8a7d984d8b0d8b1d988d8a920d8a3d98820d8a7d984d985d8afd98620d8a7d984d985d8b2d8afd8add985d8a92e20d982d8af20d8aad8aad8b1d983d98320d8a7d984d8add8acd988d8b2d8a7d8aa20d8a7d984d984d8add8b8d98ad8a920d8a8d8aed98ad8a7d8b1d8a7d8aa20d8a3d982d98420d8a3d98820d8a3d8b3d8b9d8a7d8b120d8a3d8b9d984d9892e3c2f703e0d0a3c68343e372e203c7374726f6e673ed8a5d987d985d8a7d98420d8b9d988d8a7d985d98420d8a7d984d8b3d984d8a7d985d8a920d988d8a7d984d8aed8b5d988d8b5d98ad8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed98ad8acd8a820d8a3d984d8a720d98ad8aad98520d8a7d984d8aad987d8a7d988d98620d8a3d8a8d8afd98bd8a720d981d98a20d985d8b3d8a7d8a6d98420d8a7d984d8b3d984d8a7d985d8a92e20d8a7d8a8d8add8ab20d8b9d985d8a720d8a5d8b0d8a720d983d8a7d98620d8a7d984d981d986d8afd98220d98ad8add8aad988d98a20d8b9d984d98920d8aad8afd8a7d8a8d98ad8b120d8a3d985d986d98ad8a920d8acd98ad8afd8a9d88c20d985d8abd98420d983d8a7d985d98ad8b1d8a7d8aa20d8a7d984d985d8b1d8a7d982d8a8d8a9d88c20d988d8a3d982d981d8a7d98420d8a2d985d986d8a9d88c20d988d985d988d8b8d981d98ad98620d985d8add8aad8b1d981d98ad9862e20d8a8d8a7d984d8a5d8b6d8a7d981d8a920d8a5d984d98920d8b0d984d983d88c20d8aad8a3d983d8af20d985d98620d8a3d98620d8a7d984d981d986d8afd98220d98ad8add8aad8b1d98520d8aed8b5d988d8b5d98ad8aad983d88c20d8aed8a7d8b5d8a920d8a5d8b0d8a720d983d986d8aa20d8aad8add8acd8b220d984d8a7d8b3d8aad8b1d8a7d8add8a920d8b4d8aed8b5d98ad8a92e3c2f703e0d0a3c68343ed8a7d984d8aed8a7d8aad985d8a93c2f68343e0d0a3c703ed98ad985d983d98620d8a3d98620d8aad983d988d98620d8add8acd988d8b2d8a7d8aa20d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8aad8acd8b1d8a8d8a920d985d985d98ad8b2d8a920d984d984d985d8b3d8a7d981d8b1d98ad98620d8a7d984d8b0d98ad98620d98ad8a8d8add8abd988d98620d8b9d98620d8a7d984d985d8b1d988d986d8a920d988d8a7d984d8a7d982d8aad8b5d8a7d8afd98ad8a9d88c20d988d984d983d98620d981d982d8b720d8a5d8b0d8a720d8aad985d8aa20d8a8d8b4d983d98420d8b5d8add98ad8ad2e20d8a8d8aad8acd986d8a820d987d8b0d98720d8a7d984d8a3d8aed8b7d8a7d8a120d8a7d984d8b4d8a7d8a6d8b9d8a9d88c20d98ad985d983d986d98320d8b6d985d8a7d98620d8aad8acd8b1d8a8d8a920d985d8b1d98ad8add8a920d988d985d8b1d8b6d98ad8a92e20d8b3d988d8a7d8a120d983d986d8aa20d8aad8b3d8a7d981d8b120d984d984d8b9d985d98420d8a3d98820d8a7d984d8b1d8a7d8add8a920d8a3d98820d8a7d984d8aad8b1d981d98ad987d88c20d981d8a5d98620d8a7d984d8a7d8b3d8aad8b9d8afd8a7d8af20d988d8a7d984d988d8b9d98a20d8b3d98ad8acd8b9d984d8a7d98620d8a5d982d8a7d985d8aad98320d8a7d984d982d8b5d98ad8b1d8a920d985d985d8aad8b9d8a920d8a8d8a7d984d981d8b9d9843c2f703e, NULL, NULL, '2024-12-03 01:56:03', '2024-12-03 01:56:03'),
(56, 20, 44, 30, 'Romantic Ideas for Hourly Hotel Stays', 'romantic-ideas-for-hourly-hotel-stays', 'Admin', 0x3c703e496e2074686520687573746c6520616e6420627573746c65206f66206d6f6465726e206c6966652c2066696e64696e672074696d6520746f20636f6e6e656374207769746820796f757220706172746e65722063616e2062652061206368616c6c656e67652e20486f75726c7920686f74656c207374617973206f66666572206120756e6971756520616e6420636f6e76656e69656e742077617920746f207370656e64207175616c6974792074696d6520746f67657468657220776974686f75742074686520636f6d6d69746d656e74206f6620616e206f7665726e6967687420626f6f6b696e672e205768657468657220796f752772652063656c6562726174696e672061207370656369616c206f63636173696f6e206f722073696d706c79206c6f6f6b696e6720666f722061206272696566206573636170652c2074686573652073746179732063616e207475726e206f7264696e617279206d6f6d656e747320696e746f20636865726973686564206d656d6f726965732e20486572652061726520736f6d6520726f6d616e74696320696465617320746f206d616b6520796f757220686f75726c7920686f74656c2073746179207472756c7920756e666f726765747461626c652e3c2f703e0d0a3c68343e312e203c7374726f6e673e4372656174652061204d696e6920476574617761793c2f7374726f6e673e3c2f68343e0d0a3c703e5472616e73666f726d20796f75722073686f7274207374617920696e746f206120636f7a792072657472656174206279206465636f726174696e672074686520726f6f6d20776974682063616e646c65732c206661697279206c69676874732c20616e6420666c6f776572732e204d616e7920686f74656c73206f66666572206c757875727920616d656e69746965732c20737563682061732061204a6163757a7a69206f7220707269766174652062616c636f6e792c2077686963682063616e20656e68616e63652074686520726f6d616e74696320616d6269616e63652e205061636b206120736d616c6c207069636e6963206261736b6574207769746820796f757220706172746e6572e2809973206661766f7269746520736e61636b7320616e64206120626f74746c65206f662077696e6520746f20656e6a6f7920696e2074686520636f6d666f7274206f6620796f757220726f6f6d2e3c2f703e0d0a3c68343e322e203c7374726f6e673e506c616e206120537572707269736520446174653c2f7374726f6e673e3c2f68343e0d0a3c703e4e6f7468696e67207361797320726f6d616e6365206c696b6520616e20756e657870656374656420676573747572652e20426f6f6b20616e20686f75726c79207374617920776974686f75742074656c6c696e6720796f757220706172746e657220616e64207375727072697365207468656d207769746820612062656175746966756c6c7920617272616e67656420726f6f6d2c20636f6d706c6574652077697468206d757369632c2064657373657274732c20616e64206d61796265206576656e20612068616e647772697474656e206c6f7665206e6f74652e205468652074686f7567687466756c6e657373206f6620612073757270726973652064617465206973207375726520746f206d616b6520796f757220706172746e6572206665656c207370656369616c20616e642061707072656369617465642e3c2f703e0d0a3c68343e332e203c7374726f6e673e52656c617820616e64205265636f6e6e6563743c2f7374726f6e673e3c2f68343e0d0a3c703e496620626f7468206f6620796f752068617665206265656e206665656c696e672073747265737365642c2075736520796f75722074696d6520746f2072656c617820616e64207265636f6e6e6563742e204d616e7920686f75726c7920686f74656c73206f666665722073706120666163696c6974696573206f7220726f6f6d732077697468206d617373616765206368616972732e205370656e642074696d65206368617474696e672c206c61756768696e672c20616e6420656e6a6f79696e672065616368206f74686572e280997320636f6d70616e7920776974686f757420746865206469737472616374696f6e73206f66206461696c79206c6966652e204576656e20612073696d706c65206d6f6d656e742c206c696b65207761746368696e67207468652073756e7365742066726f6d20796f757220686f74656c20726f6f6d2c2063616e206265636f6d65206120747265617375726564206d656d6f72792e3c2f703e0d0a3c68343e342e203c7374726f6e673e43656c6562726174652061204d696c6573746f6e653c2f7374726f6e673e3c2f68343e0d0a3c703e486f75726c7920737461797320617265207065726665637420666f722063656c6562726174696e6720616e6e697665727361726965732c206269727468646179732c206f7220706572736f6e616c206d696c6573746f6e65732e20437573746f6d697a652074686520657870657269656e636520776974682061207468656d652074686174207265736f6e61746573207769746820796f75722072656c6174696f6e736869702e20466f72206578616d706c652c2072656c69766520796f7572206669727374206461746520776974682073696d696c6172206d757369632c2063756973696e652c206f72206576656e207468652073616d65206f75746669742e205468697320617474656e74696f6e20746f2064657461696c2077696c6c206d616b6520746865206f63636173696f6e20616c6c20746865206d6f7265206d65616e696e6766756c2e3c2f703e0d0a3c68343e352e203c7374726f6e673e4361707475726520746865204d6f6d656e743c2f7374726f6e673e3c2f68343e0d0a3c703e446f63756d656e7420796f7572207374617920776974682070686f746f73206f7220766964656f7320746f20637265617465206c617374696e67206d656d6f726965732e2057686574686572206974e280997320736e617070696e672073656c6669657320696e20612062656175746966756c6c792064657369676e656420726f6f6d206f72207265636f7264696e67206120686561727466656c74206d65737361676520666f7220796f757220706172746e65722c207468657365206b65657073616b65732077696c6c2072656d696e6420796f75206f6620796f7572207370656369616c2074696d6520746f6765746865722e3c2f703e0d0a3c68343e362e203c7374726f6e673e4578706c6f726520486f74656c20416d656e69746965733c2f7374726f6e673e3c2f68343e0d0a3c703e43686f6f7365206120686f74656c207769746820756e6971756520616d656e697469657320746f20656e68616e636520796f757220657870657269656e63652e204c757875727920686f74656c73206f6674656e206861766520726f6f66746f70206c6f756e6765732c207072697661746520706f6f6c732c206f722066696e652064696e696e67206f7074696f6e7320746861742063616e20656c657661746520796f757220726f6d616e7469632072656e64657a766f75732e204576656e206120636f75706c65206f6620686f7572732063616e206665656c206c696b652061206c6176697368207661636174696f6e207768656e207061697265642077697468207468652072696768742073657276696365732e3c2f703e0d0a3c68343e436f6e636c7573696f6e3c2f68343e0d0a3c703e486f75726c7920686f74656c2073746179732070726f76696465207468652070657266656374206f70706f7274756e69747920746f207265636f6e6e656374207769746820796f757220706172746e657220696e206120756e6971756520616e6420696e74696d6174652073657474696e672e20576974682061206c6974746c6520706c616e6e696e6720616e6420637265617469766974792c2074686573652073686f72742067657461776179732063616e2062726561746865206e6577206c69666520696e746f20796f75722072656c6174696f6e736869702e20536f2c20746865206e6578742074696d6520796f75e280997265206c6f6f6b696e6720746f20737061726b20726f6d616e63652c20636f6e736964657220626f6f6b696e6720616e20686f75726c79207374617920616e64206c6574206c6f76652074616b652063656e7465722073746167652e3c2f703e0d0a3c703e57686574686572206974e280997320612073757270726973652064617465206f7220612072656c6178696e6720726574726561742c207468657365206d6f6d656e74732077696c6c2072656d696e6420796f752077687920796f752066656c6c20696e206c6f766520696e2074686520666972737420706c6163652e3c2f703e, NULL, NULL, '2024-12-03 01:58:30', '2024-12-03 01:58:30');
INSERT INTO `blog_informations` (`id`, `language_id`, `blog_category_id`, `blog_id`, `title`, `slug`, `author`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(57, 21, 48, 30, 'أفكار رومانسية للإقامة الفندقية كل ساعة', 'أفكار-رومانسية-للإقامة-الفندقية-كل-ساعة', 'مسؤل', 0x3c68333ed8a3d981d983d8a7d8b120d8b1d988d985d8a7d986d8b3d98ad8a920d984d984d8a5d982d8a7d985d8a920d8a7d984d982d8b5d98ad8b1d8a920d981d98a20d8a7d984d981d986d8a7d8afd9823c2f68333e0d0a3c703ed981d98a20d8b8d98420d8a7d986d8b4d8bad8a7d984d8a7d8aa20d8a7d984d8add98ad8a7d8a920d8a7d984d98ad988d985d98ad8a9d88c20d982d8af20d98ad983d988d98620d985d98620d8a7d984d8b5d8b9d8a820d8a5d98ad8acd8a7d8af20d988d982d8aa20d984d982d8b6d8a7d8a120d984d8add8b8d8a7d8aa20d8aed8a7d8b5d8a920d985d8b920d8b4d8b1d98ad98320d8add98ad8a7d8aad9832e20d8aad988d981d8b120d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d982d8b5d98ad8b1d8a920d981d98a20d8a7d984d981d986d8a7d8afd98220d981d8b1d8b5d8a920d981d8b1d98ad8afd8a920d988d985d8b1d98ad8add8a920d984d984d8a7d8b3d8aad985d8aad8a7d8b920d8a8d988d982d8aa20d985d985d8aad8b920d985d8b9d98bd8a720d8afd988d98620d8a7d984d8add8a7d8acd8a920d8a5d984d98920d8a7d984d8a7d984d8aad8b2d8a7d98520d8a8d8a5d982d8a7d985d8a920d984d98ad984d98ad8a920d983d8a7d985d984d8a92e20d8b3d988d8a7d8a120d983d986d8aa20d8aad8add8aad981d98420d8a8d985d986d8a7d8b3d8a8d8a920d8aed8a7d8b5d8a920d8a3d98820d8aad8a8d8add8ab20d8b9d98620d8a7d8b3d8aad8b1d8a7d8add8a920d982d8b5d98ad8b1d8a9d88c20d98ad985d983d98620d984d987d8b0d98720d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a3d98620d8aad8add988d98420d8a7d984d984d8add8b8d8a7d8aa20d8a7d984d8b9d8a7d8afd98ad8a920d8a5d984d98920d8b0d983d8b1d98ad8a7d8aa20d984d8a720d8aad98fd986d8b3d9892e20d8a5d984d98ad98320d8a8d8b9d8b620d8a7d984d8a3d981d983d8a7d8b120d8a7d984d8b1d988d985d8a7d986d8b3d98ad8a920d984d8acd8b9d98420d8a5d982d8a7d985d8aad98320d8a7d984d982d8b5d98ad8b1d8a920d985d985d98ad8b2d8a92e3c2f703e0d0a3c68343e312e203c7374726f6e673ed8a7d8b5d986d8b920d8b9d8b7d984d8a920d8b5d8bad98ad8b1d8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed8add988d991d98420d8a5d982d8a7d985d8aad98320d8a7d984d982d8b5d98ad8b1d8a920d8a5d984d98920d985d984d8a7d8b020d8afd8a7d981d8a620d985d98620d8aed984d8a7d98420d8aad8b2d98ad98ad98620d8a7d984d8bad8b1d981d8a920d8a8d8a7d984d8b4d985d988d8b920d988d8a7d984d8a3d8b6d988d8a7d8a120d8a7d984d8aed8a7d981d8aad8a920d988d8a7d984d8b2d987d988d8b12e20d8aad982d8afd98520d8a7d984d8b9d8afd98ad8af20d985d98620d8a7d984d981d986d8a7d8afd98220d988d8b3d8a7d8a6d98420d8b1d8a7d8add8a920d981d8a7d8aed8b1d8a920d985d8abd98420d8a7d984d8acd8a7d983d988d8b2d98a20d8a3d98820d8a7d984d8b4d8b1d981d8a920d8a7d984d8aed8a7d8b5d8a9d88c20d985d985d8a720d98ad8b9d8b2d8b220d8a7d984d8a3d8acd988d8a7d8a120d8a7d984d8b1d988d985d8a7d986d8b3d98ad8a92e20d98ad985d983d986d98320d8a3d98ad8b6d98bd8a720d8a5d8add8b6d8a7d8b120d8b3d984d8a920d8b5d8bad98ad8b1d8a920d985d984d98ad8a6d8a920d8a8d8a7d984d988d8acd8a8d8a7d8aa20d8a7d984d8aed981d98ad981d8a920d8a7d984d985d981d8b6d984d8a920d984d8afd98ad98320d988d8b2d8acd8a7d8acd8a920d985d98620d8a7d984d986d8a8d98ad8b020d984d984d8a7d8b3d8aad985d8aad8a7d8b920d8a8d987d8a720d981d98a20d8acd98820d985d8b1d98ad8ad2e3c2f703e0d0a3c68343e322e203c7374726f6e673ed8aed8b7d8b720d984d985d988d8b9d8af20d985d981d8a7d8acd8a63c2f7374726f6e673e3c2f68343e0d0a3c703ed984d8a720d8b4d98ad8a120d98ad8b9d8a8d8b120d8b9d98620d8a7d984d8b1d988d985d8a7d986d8b3d98ad8a920d985d8abd98420d984d981d8aad8a920d8bad98ad8b120d985d8aad988d982d8b9d8a92e20d8a7d8add8acd8b220d8a5d982d8a7d985d8a920d982d8b5d98ad8b1d8a920d8afd988d98620d8a5d8aed8a8d8a7d8b120d8b4d8b1d98ad98320d8add98ad8a7d8aad98320d988d981d8a7d8acd8a6d98720d8a8d8bad8b1d981d8a920d985d8b1d8aad8a8d8a920d8a8d8b4d983d98420d8acd985d98ad98420d985d8b920d8a7d984d985d988d8b3d98ad982d98920d988d8a7d984d8add984d988d98920d988d8b1d8a8d985d8a720d8b1d8b3d8a7d984d8a920d8add8a820d985d983d8aad988d8a8d8a920d8a8d8aed8b720d8a7d984d98ad8af2e20d8b3d8aad8acd8b9d98420d987d8b0d98720d8a7d984d984d981d8aad8a920d8b4d8b1d98ad983d98320d98ad8b4d8b9d8b120d8a8d8a7d984d8aad982d8afd98ad8b120d988d8a7d984d8aad985d98ad8b22e3c2f703e0d0a3c68343e332e203c7374726f6e673ed8a7d8b3d8aad8b1d8aed99020d988d8aad982d8a7d8b1d8a83c2f7374726f6e673e3c2f68343e0d0a3c703ed8a5d8b0d8a720d983d986d8aad985d8a720d8aad8b4d8b9d8b1d8a7d98620d8a8d8a7d984d8a5d8acd987d8a7d8afd88c20d8a7d8b3d8aad8bad984d988d8a720d8a7d984d988d982d8aa20d984d984d8a7d8b3d8aad8b1d8aed8a7d8a120d988d8a7d984d8aad982d8a7d8b1d8a82e20d8aad982d8afd98520d8a7d984d8b9d8afd98ad8af20d985d98620d8a7d984d981d986d8a7d8afd98220d8aed8afd985d8a7d8aa20d985d8abd98420d8acd984d8b3d8a7d8aa20d8a7d984d985d8b3d8a7d8ac20d8a3d98820d8bad8b1d98120d985d8acd987d8b2d8a920d8a8d983d8b1d8a7d8b3d98a20d8aad8afd984d98ad9832e20d8a7d982d8b6d988d8a720d8a7d984d988d982d8aa20d981d98a20d8a7d984d8add8afd98ad8ab20d988d8a7d984d8b6d8add98320d988d8a7d984d8a7d8b3d8aad985d8aad8a7d8b920d8a8d8b5d8add8a8d8a920d8a8d8b9d8b6d983d98520d8a7d984d8a8d8b9d8b620d8a8d8b9d98ad8afd98bd8a720d8b9d98620d985d8b4d8aad8aad8a7d8aa20d8a7d984d8add98ad8a7d8a920d8a7d984d98ad988d985d98ad8a92e20d8add8aad98920d8a7d984d984d8add8b8d8a7d8aa20d8a7d984d8a8d8b3d98ad8b7d8a9d88c20d985d8abd98420d985d8b4d8a7d987d8afd8a920d8bad8b1d988d8a820d8a7d984d8b4d985d8b320d985d98620d986d8a7d981d8b0d8a920d8a7d984d981d986d8afd982d88c20d98ad985d983d98620d8a3d98620d8aad8b5d8a8d8ad20d8b0d983d8b1d98920d985d985d98ad8b2d8a92e3c2f703e0d0a3c68343e342e203c7374726f6e673ed8a7d8add8aad981d98420d8a8d985d986d8a7d8b3d8a8d8a920d8aed8a7d8b5d8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed8aad8b9d8aad8a8d8b120d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d982d8b5d98ad8b1d8a920d985d8abd8a7d984d98ad8a920d984d984d8a7d8add8aad981d8a7d98420d8a8d8a7d984d8b0d983d8b1d98920d8a7d984d8b3d986d988d98ad8a920d8a3d98820d8a3d8b9d98ad8a7d8af20d8a7d984d985d98ad984d8a7d8af20d8a3d98820d8a3d98a20d985d986d8a7d8b3d8a8d8a920d8aed8a7d8b5d8a92e20d98ad985d983d986d98320d8aad8aed8b5d98ad8b520d8a7d984d8aad8acd8b1d8a8d8a920d984d8aad8aad986d8a7d8b3d8a820d985d8b920d8b0d988d982d983d88c20d985d8abd98420d8a7d8b3d8aad8b1d8acd8a7d8b920d8b0d983d8b1d98ad8a7d8aa20d8a3d988d98420d985d988d8b9d8af20d985d98620d8aed984d8a7d98420d8aad8b4d8bad98ad98420d8a7d984d985d988d8b3d98ad982d98920d986d981d8b3d987d8a720d8a3d98820d8aad986d8a7d988d98420d8a7d984d8b7d8b9d8a7d98520d986d981d8b3d9872e20d987d8b0d98720d8a7d984d8aad981d8a7d8b5d98ad98420d8a7d984d8b5d8bad98ad8b1d8a920d8aad8b6d98ad98120d984d985d8b3d8a920d8aed8a7d8b5d8a920d984d984d985d986d8a7d8b3d8a8d8a92e3c2f703e0d0a3c68343e352e203c7374726f6e673ed988d8abd991d98220d8a7d984d984d8add8b8d8a7d8aa3c2f7374726f6e673e3c2f68343e0d0a3c703ed982d98520d8a8d8aad988d8abd98ad98220d8a5d982d8a7d985d8aad98320d985d98620d8aed984d8a7d98420d8a7d984d8b5d988d8b120d8a3d98820d985d982d8a7d8b7d8b920d8a7d984d981d98ad8afd98ad9882e20d8b3d988d8a7d8a120d983d8a7d986d8aa20d8b5d988d8b1d98bd8a720d8b0d8a7d8aad98ad8a92028d8b3d98ad984d981d98a2920d981d98a20d8bad8b1d981d8a920d985d8b2d98ad986d8a920d8a8d8b4d983d98420d8acd985d98ad98420d8a3d98820d8aad8b3d8acd98ad98420d8b1d8b3d8a7d984d8a920d8add8a820d984d8b4d8b1d98ad98320d8add98ad8a7d8aad983d88c20d8b3d8aad8b8d98420d987d8b0d98720d8a7d984d8b0d983d8b1d98ad8a7d8aa20d8aad8b0d983d98ad8b1d98bd8a720d8a8d984d8add8b8d8a7d8aad98320d8a7d984d8aed8a7d8b5d8a92e3c2f703e0d0a3c68343e362e203c7374726f6e673ed8a7d8b3d8aad985d8aad8b920d8a8d985d8b1d8a7d981d98220d8a7d984d981d986d8afd9823c2f7374726f6e673e3c2f68343e0d0a3c703ed8a7d8aed8aad8b120d981d986d8afd982d98bd8a720d98ad982d8afd98520d985d8b1d8a7d981d98220d981d8b1d98ad8afd8a920d984d8aad8b9d8b2d98ad8b220d8aad8acd8b1d8a8d8aad9832e20d8aad988d981d8b120d8a7d984d981d986d8a7d8afd98220d8a7d984d981d8a7d8aed8b1d8a920d8bad8a7d984d8a8d98bd8a720d8b5d8a7d984d8a7d8aa20d8b9d984d98920d8a7d984d8a3d8b3d8b7d8add88c20d8a3d98820d985d8b3d8a7d8a8d8ad20d8aed8a7d8b5d8a9d88c20d8a3d98820d8aed98ad8a7d8b1d8a7d8aa20d8aad986d8a7d988d98420d8b7d8b9d8a7d98520d8b1d8a7d982d98ad8a92e20d8add8aad98920d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d98ad985d983d98620d8a3d98620d8aad8b4d8b9d8b120d988d983d8a3d986d987d8a720d8b9d8b7d984d8a920d981d8a7d8aed8b1d8a920d8b9d986d8af20d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d8a7d984d8aed8afd985d8a7d8aa20d8a7d984d985d986d8a7d8b3d8a8d8a92e3c2f703e0d0a3c68343ed8a7d984d8aed8a7d8aad985d8a93c2f68343e0d0a3c703ed8aad988d981d8b120d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d982d8b5d98ad8b1d8a920d981d98a20d8a7d984d981d986d8a7d8afd98220d981d8b1d8b5d8a920d985d8abd8a7d984d98ad8a920d984d8a5d8b9d8a7d8afd8a920d8a7d984d8aad988d8a7d8b5d98420d985d8b920d8b4d8b1d98ad98320d8add98ad8a7d8aad98320d981d98a20d8a8d98ad8a6d8a920d985d985d98ad8b2d8a920d988d8add985d98ad985d8a92e20d985d8b920d8a7d984d982d984d98ad98420d985d98620d8a7d984d8aad8aed8b7d98ad8b720d988d8a7d984d8a5d8a8d8afd8a7d8b9d88c20d98ad985d983d98620d984d987d8b0d98720d8a7d984d8a7d8b3d8aad8b1d8a7d8add8a7d8aa20d8a7d984d982d8b5d98ad8b1d8a920d8a3d98620d8aad8b6d98ad98120d8b4d8b1d8a7d8b1d8a920d8acd8afd98ad8afd8a920d984d8b9d984d8a7d982d8aad9832e20d984d8b0d8a7d88c20d981d98a20d8a7d984d985d8b1d8a920d8a7d984d982d8a7d8afd985d8a920d8a7d984d8aad98a20d8aad8a8d8add8ab20d981d98ad987d8a720d8b9d98620d8b7d8b1d98ad982d8a920d984d8a5d8b6d981d8a7d8a120d8a3d8acd988d8a7d8a120d8b1d988d985d8a7d986d8b3d98ad8a9d88c20d981d983d8b120d981d98a20d8add8acd8b220d8a5d982d8a7d985d8a920d982d8b5d98ad8b1d8a920d988d8afd8b920d8a7d984d8add8a820d98ad983d988d98620d981d98a20d8a7d984d985d982d8afd985d8a92e3c2f703e0d0a3c703ed8b3d988d8a7d8a120d983d8a7d98620d8b0d984d98320d985d988d8b9d8afd98bd8a720d985d981d8a7d8acd8a6d98bd8a720d8a3d98820d8a7d8b3d8aad8b1d8a7d8add8a920d987d8a7d8afd8a6d8a9d88c20d8b3d8aad8b0d983d991d8b1d98320d987d8b0d98720d8a7d984d984d8add8b8d8a7d8aa20d8a8d8a3d8b3d8a8d8a7d8a820d988d982d988d8b9d98320d981d98a20d8a7d984d8add8a820d981d98a20d8a7d984d8a8d8afd8a7d98ad8a93c2f703e, NULL, NULL, '2024-12-03 01:58:30', '2024-12-03 01:58:30'),
(58, 20, 44, 31, 'Planning the Perfect Couple\'s Retreat with Hourly Hotels', 'planning-the-perfect-couple\'s-retreat-with-hourly-hotels', 'Admin', 0x3c703e496e20746f646179e280997320666173742d706163656420776f726c642c2066696e64696e67207175616c6974792074696d6520746f207370656e64207769746820796f757220706172746e65722063616e2062652061206368616c6c656e67652e204265747765656e20776f726b2c2066616d696c7920636f6d6d69746d656e74732c20616e6420706572736f6e616c206f626c69676174696f6e732c2063617276696e67206f7574206d6f6d656e7473206f6620696e74696d61637920616e642072656c61786174696f6e206973206d6f726520696d706f7274616e74207468616e20657665722e205468697320697320776865726520686f75726c7920686f74656c7320636f6d6520696e20617320612067616d652d6368616e67657220666f7220636f75706c6573206c6f6f6b696e6720746f207265636f6e6e65637420776974686f7574206e656564696e6720746f20706c616e20616e20656c61626f72617465207661636174696f6e2e3c2f703e0d0a3c703e486f75726c7920686f74656c73206f6666657220746865207065726665637420626c656e64206f6620636f6e76656e69656e63652c20707269766163792c20616e6420636f6d666f72742c206d616b696e67207468656d20616e20696465616c2063686f69636520666f7220612073706f6e74616e656f757320636f75706c65277320726574726561742e205768657468657220796f75e2809972652063656c6562726174696e672061207370656369616c206f63636173696f6e2c206573636170696e672074686520726f7574696e6520666f7220612066657720686f7572732c206f722073696d706c792077616e7420746f207370656e6420756e696e7465727275707465642074696d6520746f6765746865722c2074686573652073686f72742d73746179206163636f6d6d6f646174696f6e732070726f7669646520612072656672657368696e6720736f6c7574696f6e2e3c2f703e0d0a3c68343e3c7374726f6e673e5768792043686f6f736520486f75726c7920486f74656c7320666f7220596f757220526574726561743f3c2f7374726f6e673e3c2f68343e0d0a3c703e4f6e65206f6620746865206269676765737420616476616e7461676573206f6620686f75726c7920686f74656c7320697320666c65786962696c6974792e20556e6c696b6520747261646974696f6e616c20626f6f6b696e67732074686174206f6674656e20726571756972652066756c6c2d64617920636861726765732c20686f75726c7920686f74656c7320616c6c6f7720796f7520746f20706179206f6e6c7920666f72207468652074696d6520796f75206e6565642e2054686973206973207065726665637420666f7220636f75706c65732077686f2077616e7420746f20737465616c20612066657720686f75727320617761792066726f6d2074686569722062757379207363686564756c657320776974686f7574206f7665727370656e64696e672e3c2f703e0d0a3c703e4d616e7920686f75726c7920686f74656c732c20657370656369616c6c79206c757875727920616e6420626f757469717565206f6e65732c20636f6d65206571756970706564207769746820636f7a7920616d656e697469657320746861742063726561746520746865207065726665637420616d6269616e636520666f7220726f6d616e63652e205468696e6b20706c7573682062656464696e672c206d6f6f64206c69676874696e672c20696e2d726f6f6d2064696e696e672c20616e64206576656e2070726976617465204a6163757a7a697320696e20736f6d652063617365732e20596f752063616e20656e68616e636520796f757220657870657269656e63652062792063686f6f73696e6720686f74656c732074686174206f6666657220726f6d616e74696320736574757073207375636820617320726f736520706574616c732c2063616e646c65732c206f72206368616d7061676e65206f6e20726571756573742e3c2f703e0d0a3c68343e3c7374726f6e673e486f7720746f20506c616e20596f757220436f75706c65e280997320526574726561743c2f7374726f6e673e3c2f68343e0d0a3c703e506c616e6e696e672061207265747265617420646f65736ee2809974206861766520746f20626520636f6d706c6963617465642e2053746172742062792073656c656374696e67206120686f74656c207468617420616c69676e73207769746820796f757220707265666572656e63657320616e64206275646765742e204c6f6f6b20666f72206c6f636174696f6e732074686174206f66666572207363656e69632076696577732c2065617379206163636573736962696c6974792c20616e64206869676820726174696e677320666f7220636c65616e6c696e65737320616e6420736572766963652e3c2f703e0d0a3c703e4e6578742c20637573746f6d697a6520796f7572207374617920746f206d616b65206974206578747261207370656369616c2e20596f752063616e2063616c6c2074686520686f74656c20696e20616476616e636520746f2072657175657374207370656369616c20617272616e67656d656e7473206c696b65206120706572736f6e616c697a65642064696e6e65722073657475702c20736f6f7468696e67206d757369632c206f72207370612074726561746d656e74732e20536f6d6520686f74656c73206576656e206f66666572207468656d656420726f6f6d7320746f20656c657661746520796f757220657870657269656e63652e3c2f703e0d0a3c703e446f6ee280997420666f7267657420746f20756e706c756720647572696e6720796f75722074696d6520746f6765746865722e204b6565702070686f6e657320616e6420776f726b206469737472616374696f6e7320617369646520746f20666f63757320656e746972656c79206f6e2065616368206f746865722e20456e6761676520696e206d65616e696e6766756c20636f6e766572736174696f6e732c20656e6a6f792074686520636f6d666f7274206f66207468652073706163652c206f722073696d706c792072656c617820616e642072656a7576656e6174652e3c2f703e0d0a3c68343e3c7374726f6e673e5768656e20746f20436f6e736964657220486f75726c7920486f74656c7320666f7220436f75706c65733c2f7374726f6e673e3c2f68343e0d0a3c703e486f75726c7920686f74656c7320617265207065726665637420666f7220612076617269657479206f66206f63636173696f6e733a3c2f703e0d0a3c756c3e0d0a3c6c693e3c7374726f6e673e416e6e69766572736172696573206f72204269727468646179733a3c2f7374726f6e673e20537572707269736520796f757220706172746e65722077697468206120726f6d616e7469632065736361706520746f2063656c65627261746520796f7572207370656369616c206461792e3c2f6c693e0d0a3c6c693e3c7374726f6e673e4d69647765656b2052656368617267653a3c2f7374726f6e673e20427265616b20617761792066726f6d20746865206d6f6e6f746f6e79206f66206120776f726b7765656b20627920656e6a6f79696e672061206d69647765656b20726574726561742e3c2f6c693e0d0a3c6c693e3c7374726f6e673e506f73742d4576656e742052656c61786174696f6e3a3c2f7374726f6e673e20416674657220612077656464696e672c2070617274792c206f72206c6f6e672074726176656c206461792c20746865736520686f74656c73206f66666572206120636f7a792073706f7420746f20756e77696e642e3c2f6c693e0d0a3c2f756c3e0d0a3c68343e3c7374726f6e673e436f6e636c7573696f6e3c2f7374726f6e673e3c2f68343e0d0a3c703e57697468207468652067726f77696e6720706f70756c6172697479206f6620686f75726c7920686f74656c732c20706c616e6e696e67206120726f6d616e746963207265747265617420686173206e65766572206265656e206561736965722e205468657365206163636f6d6d6f646174696f6e732070726f7669646520616e206166666f726461626c652c20666c657869626c652c20616e6420696e74696d6174652073657474696e6720666f7220636f75706c657320746f207265636f6e6e65637420616e642072656b696e646c6520746865697220626f6e642e20536f2c2077687920776169743f20426f6f6b206120636f7a79206765746177617920746f64617920616e64206c657420746865206d6f6d656e7473206f66206c6f766520616e642072656c61786174696f6e20756e666f6c64206566666f72746c6573736c792e3c2f703e, NULL, NULL, '2024-12-03 02:00:46', '2024-12-03 02:00:46'),
(59, 21, 48, 31, 'التخطيط لملاذ مثالي للزوجين مع فنادق كل ساعة', 'التخطيط-لملاذ-مثالي-للزوجين-مع-فنادق-كل-ساعة', 'مسؤل', 0x3c703ed981d98a20d8b9d8a7d984d985d986d8a720d8a7d984d8b3d8b1d98ad8b920d8a7d984d98ad988d985d88c20d982d8af20d98ad983d988d98620d985d98620d8a7d984d8b5d8b9d8a820d8a7d984d8b9d8abd988d8b120d8b9d984d98920d988d982d8aa20d985d986d8a7d8b3d8a820d984d982d8b6d8a7d8a6d98720d985d8b920d8b4d8b1d98ad98320d8a7d984d8add98ad8a7d8a92e20d8a8d98ad98620d8a7d984d8b9d985d98420d988d8a7d984d8a7d984d8aad8b2d8a7d985d8a7d8aa20d8a7d984d8b9d8a7d8a6d984d98ad8a920d988d8a7d984d8a7d987d8aad985d8a7d985d8a7d8aa20d8a7d984d8b4d8aed8b5d98ad8a9d88c20d8a3d8b5d8a8d8ad20d985d98620d8a7d984d8a3d987d985d98ad8a920d8a8d985d983d8a7d98620d8a5d98ad8acd8a7d8af20d984d8add8b8d8a7d8aa20d985d98620d8a7d984d8aed8b5d988d8b5d98ad8a920d988d8a7d984d8a7d8b3d8aad8b1d8aed8a7d8a12e20d987d986d8a720d8aad8a3d8aad98a20d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d983d8add98420d985d8a8d8aad983d8b120d984d984d8b2d988d8acd98ad98620d8a7d984d8b0d98ad98620d98ad8b1d8bad8a8d988d98620d981d98a20d8a7d8b3d8aad8b9d8a7d8afd8a920d8b1d8a7d8a8d8b7d8aad987d98520d8afd988d98620d8a7d984d8add8a7d8acd8a920d8a5d984d98920d8a7d984d8aad8aed8b7d98ad8b720d984d8b1d8add984d8a920d8b7d988d98ad984d8a92e3c2f703e0d0a3c703ed8aad988d981d8b120d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d985d8b2d98ad8acd98bd8a720d985d8abd8a7d984d98ad98bd8a720d985d98620d8a7d984d8b1d8a7d8add8a920d988d8a7d984d8aed8b5d988d8b5d98ad8a9d88c20d985d985d8a720d98ad8acd8b9d984d987d8a720d8aed98ad8a7d8b1d98bd8a720d985d8abd8a7d984d98ad98bd8a720d984d984d8a7d8add8aad981d8a7d98420d8a8d985d986d8a7d8b3d8a8d8a920d8aed8a7d8b5d8a920d8a3d98820d984d984d987d8b1d988d8a820d985d98620d8a7d984d8b1d988d8aad98ad98620d8a3d98820d8a8d8a8d8b3d8a7d8b7d8a920d984d982d8b6d8a7d8a120d988d982d8aa20d8bad98ad8b120d985d986d982d8b7d8b920d985d8b9d98bd8a72e3c2f703e0d0a3c68343e3c7374726f6e673ed984d985d8a7d8b0d8a720d8aad8aed8aad8a7d8b120d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d984d8b1d8a7d8add8aad98320d8a7d984d8b2d988d8acd98ad8a9d89f3c2f7374726f6e673e3c2f68343e0d0a3c703ed985d98620d8a3d983d8a8d8b120d985d8b2d8a7d98ad8a720d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d987d98a20d8a7d984d985d8b1d988d986d8a92e20d8b9d984d98920d8b9d983d8b320d8a7d984d8add8acd988d8b2d8a7d8aa20d8a7d984d8aad982d984d98ad8afd98ad8a920d8a7d984d8aad98a20d8aad8aad8b7d984d8a820d8afd981d8b920d8abd985d98620d8a7d984d98ad988d98520d983d8a7d985d984d8a7d98bd88c20d8aad8aad98ad8ad20d984d98320d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d8afd981d8b920d8abd985d98620d8a7d984d988d982d8aa20d8a7d984d8b0d98a20d8aad8add8aad8a7d8acd98720d981d982d8b72e20d988d987d8b0d8a720d985d8abd8a7d984d98a20d984d984d8b2d988d8acd98ad98620d8a7d984d8b0d98ad98620d98ad8b1d98ad8afd988d98620d8a7d984d987d8b1d988d8a820d984d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d8a8d8b9d98ad8afd98bd8a720d8b9d98620d8acd8afd8a7d988d984d987d98520d8a7d984d985d8b2d8afd8add985d8a920d8afd988d98620d8afd981d8b920d985d8a8d8a7d984d8ba20d8a5d8b6d8a7d981d98ad8a92e3c2f703e0d0a3c703ed8aad8aad985d8aad8b920d8a7d984d8b9d8afd98ad8af20d985d98620d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a9d88c20d8aed8a7d8b5d8a920d8a7d984d981d8aed985d8a920d988d8a7d984d8a8d988d8aad98ad983d98ad8a9d88c20d8a8d8a7d984d8b9d8afd98ad8af20d985d98620d988d8b3d8a7d8a6d98420d8a7d984d8b1d8a7d8add8a920d8a7d984d8aad98a20d8aad8aed984d98220d8a7d984d8acd98820d8a7d984d985d8abd8a7d984d98a20d984d984d8b1d988d985d8a7d986d8b3d98ad8a92e20d8aad8aed98ad98420d8a7d984d981d8b1d8a7d8b420d8a7d984d981d8a7d8aed8b1d88c20d8a7d984d8a5d8b6d8a7d8a1d8a920d8a7d984d985d8b1d98ad8add8a9d88c20d8aed8afd985d8a920d8a7d984d8b7d8b9d8a7d98520d8afd8a7d8aed98420d8a7d984d8bad8b1d981d8a9d88c20d988d8add8aad98920d8a3d8add988d8a7d8b620d8a7d984d8a7d8b3d8aad8add985d8a7d98520d8a7d984d8aed8a7d8b5d8a920d981d98a20d8a8d8b9d8b620d8a7d984d8add8a7d984d8a7d8aa2e20d98ad985d983d986d98320d8aad8b9d8b2d98ad8b220d8aad8acd8b1d8a8d8aad98320d985d98620d8aed984d8a7d98420d8a7d8aed8aad98ad8a7d8b120d8a7d984d981d986d8a7d8afd98220d8a7d984d8aad98a20d8aad982d8afd98520d8aad8b1d8aad98ad8a8d8a7d8aa20d8b1d988d985d8a7d986d8b3d98ad8a920d985d8abd98420d8a8d8aad984d8a7d8aa20d8a7d984d988d8b1d8afd88c20d8a7d984d8b4d985d988d8b9d88c20d8a3d98820d8a7d984d8b4d985d8a8d8a7d986d98ad8a720d8b9d986d8af20d8a7d984d8b7d984d8a82e3c2f703e0d0a3c68343e3c7374726f6e673ed983d98ad981d98ad8a920d8a7d984d8aad8aed8b7d98ad8b720d984d8b1d8a7d8add8a920d8a7d984d8b2d988d8acd98ad98620d8a7d984d8aed8a7d8b5d8a920d8a8d9833c2f7374726f6e673e3c2f68343e0d0a3c703ed984d8a720d98ad8aad8b7d984d8a820d8a7d984d8aad8aed8b7d98ad8b720d984d8b1d8a7d8add8a920d8a7d984d8b2d988d8acd98ad98620d8aad8b9d982d98ad8afd98bd8a72e20d8a7d8a8d8afd8a320d8a8d8a7d8aed8aad98ad8a7d8b120d981d986d8afd98220d98ad8aad986d8a7d8b3d8a820d985d8b920d8aad981d8b6d98ad984d8a7d8aad98320d988d985d98ad8b2d8a7d986d98ad8aad9832e20d8a7d8a8d8add8ab20d8b9d98620d8a7d984d985d988d8a7d982d8b920d8a7d984d8aad98a20d8aad988d981d8b120d985d986d8a7d8b8d8b120d8b7d8a8d98ad8b9d98ad8a9d88c20d8b3d987d988d984d8a920d8a7d984d988d8b5d988d984d88c20d988d8aad982d98ad98ad985d8a7d8aa20d8b9d8a7d984d98ad8a920d985d98620d8add98ad8ab20d8a7d984d986d8b8d8a7d981d8a920d988d8a7d984d8aed8afd985d8a92e3c2f703e0d0a3c703ed8a8d8b9d8af20d8b0d984d983d88c20d8aed8b5d8b520d8a5d982d8a7d985d8aad98320d984d8acd8b9d984d987d8a720d985d985d98ad8b2d8a92e20d98ad985d983d986d98320d8a7d984d8a7d8aad8b5d8a7d98420d8a8d8a7d984d981d986d8afd98220d985d982d8afd985d98bd8a720d984d8b7d984d8a820d8aad8b1d8aad98ad8a8d8a7d8aa20d8aed8a7d8b5d8a920d985d8abd98420d8a5d8b9d8afd8a7d8af20d8b9d8b4d8a7d8a120d8b4d8aed8b5d98ad88c20d985d988d8b3d98ad982d98920d985d8b1d98ad8add8a9d88c20d8a3d98820d8acd984d8b3d8a7d8aa20d8b3d8a8d8a72e20d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d8aad982d8afd98520d8a3d98ad8b6d98bd8a720d8bad8b1d981d98bd8a720d8b0d8a7d8aa20d8b7d8a7d8a8d8b920d8aed8a7d8b520d984d8b1d981d8b920d985d8b3d8aad988d98920d8aad8acd8b1d8a8d8aad9832e3c2f703e0d0a3c703ed984d8a720d8aad986d8b3d98e20d8a3d98620d8aad981d8b5d98420d986d981d8b3d98320d8b9d98620d8a3d98a20d8aad8b4d8aad98ad8aad8a7d8aa20d8aed984d8a7d98420d988d982d8aad98320d985d8b9d98bd8a72e20d8b6d8b920d8a7d984d987d988d8a7d8aad98120d8acd8a7d986d8a8d98bd8a720d988d8a7d8a8d8aad8b9d8af20d8b9d98620d8a7d984d8b9d985d98420d984d984d8aad8b1d983d98ad8b220d8aad985d8a7d985d98bd8a720d8b9d984d98920d8a8d8b9d8b6d983d985d8a720d8a7d984d8a8d8b9d8b62e20d982d98520d8a8d8a5d8acd8b1d8a7d8a120d985d8add8a7d8afd8abd8a7d8aa20d987d8a7d8afd981d8a9d88c20d8a7d8b3d8aad985d8aad8b920d8a8d8b1d8a7d8add8a920d8a7d984d985d983d8a7d986d88c20d8a3d98820d8a8d8a8d8b3d8a7d8b7d8a920d8a7d8b3d8aad8b1d8aed99020d988d8aad8acd8afd8af2e3c2f703e0d0a3c68343e3c7374726f6e673ed985d8aad98920d98ad8acd8a820d8a7d984d8aad981d983d98ad8b120d981d98a20d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d984d984d8b2d988d8acd98ad986d89f3c2f7374726f6e673e3c2f68343e0d0a3c703ed8aad8b9d8af20d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d985d8abd8a7d984d98ad8a920d984d984d8b9d8afd98ad8af20d985d98620d8a7d984d985d986d8a7d8b3d8a8d8a7d8aa3a3c2f703e0d0a3c756c3e0d0a3c6c693e3c7374726f6e673ed8a7d984d8b0d983d8b1d98ad8a7d8aa20d8a7d984d8b3d986d988d98ad8a920d8a3d98820d8a3d8b9d98ad8a7d8af20d8a7d984d985d98ad984d8a7d8af3a3c2f7374726f6e673e20d981d8a7d8acd8a620d8b4d8b1d98ad98320d8add98ad8a7d8aad98320d8a8d987d8b1d988d8a820d8b1d988d985d8a7d986d8b3d98a20d984d984d8a7d8add8aad981d8a7d98420d8a8d98ad988d985d98320d8a7d984d8aed8a7d8b52e3c2f6c693e0d0a3c6c693e3c7374726f6e673ed8a7d8b3d8aad8b1d8a7d8add8a920d985d986d8aad8b5d98120d8a7d984d8a3d8b3d8a8d988d8b93a3c2f7374726f6e673e20d8a7d8aed8b1d8ac20d985d98620d8b1d988d8aad98ad98620d8a7d984d8b9d985d98420d988d8a7d8b3d8aad985d8aad8b920d8a8d8b9d8b7d984d8a920d982d8b5d98ad8b1d8a920d981d98a20d985d986d8aad8b5d98120d8a7d984d8a3d8b3d8a8d988d8b92e3c2f6c693e0d0a3c6c693e3c7374726f6e673ed8a7d984d8a7d8b3d8aad8b1d8aed8a7d8a120d8a8d8b9d8af20d8a7d984d8a3d8add8afd8a7d8ab3a3c2f7374726f6e673e20d8a8d8b9d8af20d8add981d98420d8b2d981d8a7d98120d8a3d98820d8add981d984d8a920d8a3d98820d98ad988d98520d8b3d981d8b120d8b7d988d98ad984d88c20d8aad982d8afd98520d987d8b0d98720d8a7d984d981d986d8a7d8afd98220d985d983d8a7d986d98bd8a720d985d8b1d98ad8add98bd8a720d984d984d8a7d8b3d8aad8b1d8aed8a7d8a12e3c2f6c693e0d0a3c2f756c3e0d0a3c68343e3c7374726f6e673ed8a7d984d8aed8a7d8aad985d8a93c2f7374726f6e673e3c2f68343e0d0a3c703ed985d8b920d8aad8b2d8a7d98ad8af20d8b4d8b9d8a8d98ad8a920d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a9d88c20d8a3d8b5d8a8d8ad20d8a7d984d8aad8aed8b7d98ad8b720d984d984d8b1d8a7d8add8a920d8a7d984d8b1d988d985d8a7d986d8b3d98ad8a920d8a3d8b3d987d98420d985d98620d8a3d98a20d988d982d8aa20d985d8b6d9892e20d8aad988d981d8b120d987d8b0d98720d8a7d984d8a5d982d8a7d985d8a920d8aed98ad8a7d8b1d98bd8a720d985d98ad8b3d988d8b1d98bd8a720d988d985d8b1d986d98bd8a720d988d8add985d98ad985d98bd8a720d984d984d8b2d988d8acd98ad98620d984d8a5d8b9d8a7d8afd8a920d8a7d984d8a7d8aad8b5d8a7d98420d988d8a5d8b9d8a7d8afd8a920d8a5d8b4d8b9d8a7d98420d8a7d984d8b9d984d8a7d982d8a92e20d981d985d8a720d8a7d984d8b0d98a20d8aad986d8aad8b8d8b1d987d89f20d8a7d8add8acd8b220d8a5d982d8a7d985d8aad98320d8a7d984d985d8b1d98ad8add8a920d8a7d984d98ad988d98520d988d8afd8b920d984d8add8b8d8a7d8aa20d8a7d984d8add8a820d988d8a7d984d8a7d8b3d8aad8b1d8aed8a7d8a120d8aad8aad983d8b4d98120d8a8d8b3d987d988d984d8a93c2f703e, NULL, NULL, '2024-12-03 02:00:46', '2024-12-03 02:00:46'),
(60, 20, 43, 32, 'Short Hotel Stays for Traveling Families: Tips and Tricks', 'short-hotel-stays-for-traveling-families:-tips-and-tricks', 'Admin', 0x3c703e54726176656c696e6720776974682066616d696c792063616e20626520616e206578636974696e6720657870657269656e63652c2062757420697420636f6d657320776974682069747320756e69717565206368616c6c656e6765732e20466f722066616d696c696573206f6e2074686520676f2c20657370656369616c6c792074686f73652077686f206e65656420746f2073746f7020666f7220612066657720686f75727320746f2072657374206f72207265667265736820647572696e67206c6f6e672074726970732c20686f75726c7920686f74656c2073746179732063616e20626520612067616d652d6368616e6765722e2054686573652073686f727420686f74656c207374617973206f66666572206120666c657869626c6520616e64206166666f726461626c652077617920666f722066616d696c69657320746f20656e6a6f79206120636f6d666f727461626c652073706163652c206576656e206966207468657920646f6e2774206e65656420616e206f7665726e6967687420737461792e20486572652061726520736f6d652076616c7561626c65207469707320616e6420747269636b7320746f2068656c702066616d696c696573206d616b6520746865206d6f7374206f6620746865697220686f75726c7920686f74656c2073746179732e3c2f703e0d0a3c68333e312e203c7374726f6e673e43686f6f73652046616d696c792d467269656e646c7920486f74656c733c2f7374726f6e673e3c2f68333e0d0a3c703e5768656e20626f6f6b696e6720616e20686f75726c7920686f74656c20737461792c206974e280997320657373656e7469616c20746f2063686f6f7365206163636f6d6d6f646174696f6e73207468617420636174657220746f2066616d696c6965732e204c6f6f6b20666f7220686f74656c7320776974682066616d696c792d667269656e646c7920616d656e6974696573206c696b652073706163696f757320726f6f6d732c206372696273206f7220726f6c6c6177617920626564732c206b69642d667269656e646c79205456206368616e6e656c732c20616e6420612076617269657479206f662064696e696e67206f7074696f6e732e20536f6d6520686f75726c7920686f74656c73206576656e206f66666572207370656369616c207061636b6167657320666f722066616d696c6965732c20776869636820696e636c75646520646973636f756e74656420726174657320666f7220626f6f6b696e67206120726f6f6d20666f7220612066657720686f757273206f72206164646974696f6e616c207365727669636573206c696b65206561726c7920636865636b2d696e206f72206c61746520636865636b2d6f75742e3c2f703e0d0a3c68333e322e203c7374726f6e673e506c616e20596f757220537461792041726f756e6420746865204b696473e28099205363686564756c653c2f7374726f6e673e3c2f68333e0d0a3c703e4f6e65206f66207468652062696767657374206368616c6c656e676573207768656e2074726176656c696e672077697468206368696c6472656e206973206d616e6167696e67207468656972207363686564756c652e20506c616e20796f757220686f75726c7920686f74656c20737461792061726f756e6420796f7572206b696473e28099206e617074696d65206f7220646f776e74696d6520746f20656e737572652074686579e2809972652077656c6c2d726573746564206265666f726520636f6e74696e75696e6720796f7572206a6f75726e65792e20546869732063616e206d616b65207468652074726970206d6f726520656e6a6f7961626c6520616e6420616c6c6f772065766572796f6e6520746f2072656368617267652c2077686574686572206974e2809973206120717569636b206e61702c20736f6d6520706c617974696d652c206f72206a757374206120706561636566756c20627265616b20696e206120636f6d666f727461626c6520656e7669726f6e6d656e742e3c2f703e0d0a3c68333e332e203c7374726f6e673e436865636b20666f722046616d696c792d467269656e646c7920416d656e69746965733c2f7374726f6e673e3c2f68333e0d0a3c703e486f75726c7920686f74656c73206f6674656e206f6666657220677265617420616d656e697469657320746f206d616b6520612073686f72742073746179206d6f726520656e6a6f7961626c6520666f722066616d696c6965732e204c6f6f6b20666f7220686f74656c7320746861742070726f7669646520636f6d706c696d656e7461727920736e61636b73206f7220627265616b666173742c2066616d696c7920737569746573207769746820736570617261746520736c656570696e672061726561732c206f72206f6e2d73697465206163746976697469657320666f72206368696c6472656e2e20496620796f75e2809972652074726176656c696e67207769746820796f756e676572206368696c6472656e2c20636865636b2069662074686520686f74656c2070726f76696465732068696768206368616972732c20626162792062617468747562732c206f7220616e79206f7468657220657373656e7469616c206974656d7320746861742077696c6c206d616b6520796f75722073746179206d6f726520636f6d666f727461626c652e3c2f703e0d0a3c68333e342e203c7374726f6e673e557365207468652054696d6520666f722046616d696c7920426f6e64696e673c2f7374726f6e673e3c2f68333e0d0a3c703e53686f727420686f74656c2073746179732070726f766964652061206772656174206f70706f7274756e69747920666f722066616d696c69657320746f20626f6e642c206576656e206966206974e2809973206a75737420666f7220612066657720686f7572732e2055736520746869732074696d6520746f2072656c617820746f6765746865722c20706c61792067616d65732c207761746368206d6f766965732c206f722073696d706c7920756e77696e642e2054616b696e6720616476616e74616765206f66206120636f6d666f727461626c652c20707269766174652073706163652063616e206769766520796f75722066616d696c7920746865206d7563682d6e656564656420646f776e74696d6520746f20636f6e6e65637420616e642072656672657368206265666f726520726573756d696e6720796f75722074726176656c732e3c2f703e0d0a3c68333e352e203c7374726f6e673e5061636b204c6967687420666f7220612053686f727420537461793c2f7374726f6e673e3c2f68333e0d0a3c703e53696e636520796f757220737461792077696c6c2062652073686f72742c207468657265e2809973206e6f206e65656420746f206f7665727061636b2e20466f637573206f6e207061636b696e67206f6e6c792074686520657373656e7469616c7320666f72207468652066657720686f75727320796f75e280996c6c207370656e6420696e2074686520686f74656c2e205468697320696e636c7564657320736e61636b732c206472696e6b732c2064696170657273206f7220776970657320666f7220796f756e67206368696c6472656e2c20616e6420616e7920656e7465727461696e6d656e74206974656d73206c696b6520626f6f6b732c20746f79732c206f7220656c656374726f6e6963732e2041206c69676874657220626167206d65616e73206c65737320737472657373207768656e20636865636b696e6720696e20616e64206d6f72652066726565646f6d20746f20656e6a6f7920796f75722073686f727420737461792e3c2f703e0d0a3c68333e362e203c7374726f6e673e54616b6520416476616e74616765206f6620416d656e6974696573204f7574736964652074686520486f74656c3c2f7374726f6e673e3c2f68333e0d0a3c703e4d616e7920686f75726c7920686f74656c7320617265206c6f636174656420696e20636f6e76656e69656e7420617265617320636c6f736520746f20746f75726973742061747472616374696f6e732c2073686f7070696e67206d616c6c732c206f72206c6f63616c207061726b732e20496620796f75206861766520612066657720686f75727320746f2073706172652c2074616b6520616476616e74616765206f6620746865206c6f636174696f6e20616e64206578706c6f7265206e65617262792061747472616374696f6e732e204120717569636b2066616d696c79206f7574696e6720746f2061207061726b206f722061206e656172627920636166c3a92063616e20626520612066756e2077617920746f206d616b6520746865206d6f7374206f6620796f75722073686f727420737461792e3c2f703e0d0a3c703e496e20636f6e636c7573696f6e2c20686f75726c7920686f74656c2073746179732070726f766964652066616d696c69657320776974682074686520666c65786962696c69747920616e6420636f6d666f72742074686579206e65656420647572696e672074686569722074726176656c732e2042792063686f6f73696e672066616d696c792d667269656e646c7920686f74656c732c20706c616e6e696e6720796f757220737461792061726f756e6420746865206b696473e28099207363686564756c652c20616e642074616b696e6720616476616e74616765206f6620616d656e69746965732c2066616d696c6965732063616e207475726e206120627269656620686f74656c2073746f7020696e746f2061206d656d6f7261626c6520616e642072656672657368696e672070617274206f66207468656972206a6f75726e65793c2f703e, NULL, NULL, '2024-12-03 02:04:44', '2024-12-03 02:04:44'),
(61, 21, 52, 32, 'إقامات فندقية قصيرة للعائلات المسافرة: نصائح وحيل', 'إقامات-فندقية-قصيرة-للعائلات-المسافرة:-نصائح-وحيل', 'مسؤل', 0x3c703ed98ad985d983d98620d8a3d98620d8aad983d988d98620d8a7d984d8b3d981d8b120d985d8b920d8a7d984d8b9d8a7d8a6d984d8a920d8aad8acd8b1d8a8d8a920d985d8abd98ad8b1d8a9d88c20d984d983d986d987d8a720d8aad8a3d8aad98a20d985d8b920d8aad8add8afd98ad8a7d8aad987d8a720d8a7d984d8aed8a7d8b5d8a92e20d8a8d8a7d984d986d8b3d8a8d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa20d8a7d984d8aad98a20d8aad983d988d98620d981d98a20d8b7d8b1d98ad982d987d8a7d88c20d988d8aed8a7d8b5d8a920d8aad984d98320d8a7d984d8aad98a20d8aad8add8aad8a7d8ac20d8a5d984d98920d8a7d984d8aad988d982d98120d984d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d984d984d8b1d8a7d8add8a920d8a3d98820d8a7d984d8a7d986d8aad8b9d8a7d8b420d8a3d8abd986d8a7d8a120d8a7d984d8b1d8add984d8a7d8aa20d8a7d984d8b7d988d98ad984d8a9d88c20d98ad985d983d98620d8a3d98620d8aad983d988d98620d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a920d985d8add988d8b1d98ad8a92e20d8aad988d981d8b120d987d8b0d98720d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d981d986d8afd982d98ad8a920d985d8b1d988d986d8a920d988d8b1d8a7d8add8a920d984d984d8b9d8a7d8a6d984d8a7d8aa20d984d984d8a7d8b3d8aad985d8aad8a7d8b920d8a8d985d8b3d8a7d8add8a920d985d8b1d98ad8add8a9d88c20d8add8aad98920d8a5d8b0d8a720d984d98520d98ad983d98620d987d986d8a7d98320d8add8a7d8acd8a920d984d984d8a5d982d8a7d985d8a920d8b7d988d8a7d98420d8a7d984d984d98ad9842e20d8a5d984d98ad98320d8a8d8b9d8b620d8a7d984d986d8b5d8a7d8a6d8ad20d988d8a7d984d8add98ad98420d8a7d984d982d98ad985d8a920d8a7d984d8aad98a20d8aad8b3d8a7d8b9d8af20d8a7d984d8b9d8a7d8a6d984d8a7d8aa20d8b9d984d98920d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d8a7d984d982d8b5d988d98920d985d98620d8a5d982d8a7d985d8a7d8aad987d98520d8a7d984d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a92e3c2f703e0d0a3c68333e312e203c7374726f6e673ed8a7d8aed8aad98ad8a7d8b120d8a7d984d981d986d8a7d8afd98220d8a7d984d985d986d8a7d8b3d8a8d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa3c2f7374726f6e673e3c2f68333e0d0a3c703ed8b9d986d8af20d8add8acd8b220d8a5d982d8a7d985d8a920d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a9d88c20d985d98620d8a7d984d8b6d8b1d988d8b1d98a20d8a7d8aed8aad98ad8a7d8b120d8a3d985d8a7d983d98620d8a7d984d8a5d982d8a7d985d8a920d8a7d984d8aad98a20d8aad984d8a8d98a20d8a7d8add8aad98ad8a7d8acd8a7d8aa20d8a7d984d8b9d8a7d8a6d984d8a7d8aa2e20d8a7d8a8d8add8ab20d8b9d98620d8a7d984d981d986d8a7d8afd98220d8a7d984d8aad98a20d8aad982d8afd98520d988d8b3d8a7d8a6d98420d8a7d984d8b1d8a7d8add8a920d8a7d984d985d986d8a7d8b3d8a8d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa20d985d8abd98420d8a7d984d8bad8b1d98120d8a7d984d988d8a7d8b3d8b9d8a9d88c20d8a7d984d8a3d8b3d8b1d8a920d8a7d984d982d8a7d8a8d984d8a920d984d984d8b7d98a20d8a3d98820d8a7d984d8a3d8b3d8b1d991d8a920d8a7d984d8a5d8b6d8a7d981d98ad8a9d88c20d982d986d988d8a7d8aa20d8aad984d981d8b2d98ad988d986d98ad8a920d984d984d8a3d8b7d981d8a7d984d88c20d988d8aad986d988d8b920d8aed98ad8a7d8b1d8a7d8aa20d8a7d984d8b7d8b9d8a7d9852e20d8aad982d8afd98520d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d8a7d984d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a920d8b9d8b1d988d8b6d98bd8a720d8aed8a7d8b5d8a920d984d984d8b9d8a7d8a6d984d8a7d8aad88c20d8aad8b4d985d98420d8aad8aed981d98ad8b6d8a7d8aa20d8b9d984d98920d8a7d984d8a3d8b3d8b9d8a7d8b120d8b9d986d8af20d8add8acd8b220d8bad8b1d981d8a920d984d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d8a3d98820d8aed8afd985d8a7d8aa20d8a5d8b6d8a7d981d98ad8a920d985d8abd98420d8aad8b3d8acd98ad98420d8a7d984d988d8b5d988d98420d8a7d984d985d8a8d983d8b120d8a3d98820d8aad8b3d8acd98ad98420d8a7d984d985d8bad8a7d8afd8b1d8a920d8a7d984d985d8aad8a3d8aed8b1d8a92e3c2f703e0d0a3c68333e322e203c7374726f6e673ed8aad986d8b8d98ad98520d8a7d984d8a5d982d8a7d985d8a920d988d981d982d98bd8a720d984d8acd8afd988d98420d8a7d984d8a3d8b7d981d8a7d9843c2f7374726f6e673e3c2f68333e0d0a3c703ed8aad8b9d8aad8a8d8b120d8a5d8afd8a7d8b1d8a920d8acd8afd988d98420d8a7d984d8a3d8b7d981d8a7d98420d985d98620d8a3d983d8a8d8b120d8a7d984d8aad8add8afd98ad8a7d8aa20d8b9d986d8af20d8a7d984d8b3d981d8b120d985d8b920d8a7d984d8a3d8b7d981d8a7d9842e20d982d98520d8a8d8aad8aed8b7d98ad8b720d8a5d982d8a7d985d8aad98320d8a7d984d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a920d8a8d8add98ad8ab20d8aad8aad988d8a7d981d98220d985d8b920d988d982d8aa20d982d98ad984d988d984d8a920d8a7d984d8a3d8b7d981d8a7d98420d8a3d98820d988d982d8aa20d8b1d8a7d8add8a920d984d987d98520d984d8b6d985d8a7d98620d8a3d986d987d98520d8b3d98ad983d988d986d988d98620d981d98a20d8add8a7d984d8a920d8acd98ad8afd8a920d984d8a7d8b3d8aad8a6d986d8a7d98120d8b1d8add984d8aad987d9852e20d98ad985d983d98620d8a3d98620d98ad8acd8b9d98420d8b0d984d98320d8a7d984d8b1d8add984d8a920d8a3d983d8abd8b120d985d8aad8b9d8a920d988d98ad8b3d985d8ad20d984d984d8acd985d98ad8b920d8a8d8a5d8b9d8a7d8afd8a920d8b4d8add98620d8b7d8a7d982d8aad987d985d88c20d8b3d988d8a7d8a120d983d8a7d98620d8b0d984d98320d985d98620d8aed984d8a7d98420d982d98ad984d988d984d8a920d8b3d8b1d98ad8b9d8a920d8a3d98820d988d982d8aa20d984d984d8b9d8a820d8a3d98820d985d8acd8b1d8af20d8a7d8b3d8aad8b1d8a7d8add8a920d987d8a7d8afd8a6d8a920d981d98a20d8a8d98ad8a6d8a920d985d8b1d98ad8add8a92e3c2f703e0d0a3c68333e332e203c7374726f6e673ed8a7d984d8aad8add982d98220d985d98620d988d8b3d8a7d8a6d98420d8a7d984d8b1d8a7d8add8a920d8a7d984d985d986d8a7d8b3d8a8d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa3c2f7374726f6e673e3c2f68333e0d0a3c703ed8bad8a7d984d8a8d98bd8a720d985d8a720d8aad982d8afd98520d8a7d984d981d986d8a7d8afd98220d8a7d984d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a920d988d8b3d8a7d8a6d98420d8b1d8a7d8add8a920d8b1d8a7d8a6d8b9d8a920d984d8acd8b9d98420d8a7d984d8a5d982d8a7d985d8a920d8a7d984d982d8b5d98ad8b1d8a920d8a3d983d8abd8b120d985d8aad8b9d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa2e20d8a7d8a8d8add8ab20d8b9d98620d8a7d984d981d986d8a7d8afd98220d8a7d984d8aad98a20d8aad982d8afd98520d988d8acd8a8d8a7d8aa20d8aed981d98ad981d8a920d8a3d98820d8a5d981d8b7d8a7d8b1d98bd8a720d985d8acd8a7d986d98ad98bd8a7d88c20d8a3d8acd986d8add8a920d8b9d8a7d8a6d984d98ad8a920d8aad8add8aad988d98a20d8b9d984d98920d985d986d8a7d8b7d98220d986d988d98520d985d986d981d8b5d984d8a9d88c20d8a3d98820d8a3d986d8b4d8b7d8a920d8afd8a7d8aed984d98ad8a920d984d984d8a3d8b7d981d8a7d9842e20d8a5d8b0d8a720d983d986d8aa20d8aad8b3d8a7d981d8b120d985d8b920d8a3d8b7d981d8a7d98420d8b5d8bad8a7d8b1d88c20d8aad8add982d98220d985d985d8a720d8a5d8b0d8a720d983d8a7d986d8aa20d8a7d984d981d986d8a7d8afd98220d8aad988d981d8b120d8a3d8b4d98ad8a7d8a120d8a3d8b3d8a7d8b3d98ad8a920d985d8abd98420d8a7d984d983d8b1d8a7d8b3d98a20d8a7d984d8b9d8a7d984d98ad8a9d88c20d8a3d98820d8add985d8a7d985d8a7d8aa20d984d984d8a3d8b7d981d8a7d984d88c20d8a3d98820d8a3d98a20d985d8b3d8aad984d8b2d985d8a7d8aa20d8a3d8aed8b1d98920d8b3d8aad8acd8b9d98420d8a5d982d8a7d985d8aad98320d8a3d983d8abd8b120d8b1d8a7d8add8a92e3c2f703e0d0a3c68333e342e203c7374726f6e673ed8a7d8b3d8aad8bad984d8a7d98420d8a7d984d988d982d8aa20d984d984d8aad988d8a7d8b5d98420d8a7d984d8b9d8a7d8a6d984d98a3c2f7374726f6e673e3c2f68333e0d0a3c703ed8aad988d981d8b120d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a920d981d8b1d8b5d8a920d8b1d8a7d8a6d8b9d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa20d984d984d8aad988d8a7d8b5d984d88c20d8add8aad98920d984d98820d983d8a7d986d8aa20d8a7d984d985d8afd8a920d982d8b5d98ad8b1d8a92e20d8a7d8b3d8aad8aed8afd98520d987d8b0d8a720d8a7d984d988d982d8aa20d984d984d8a7d8b3d8aad8b1d8aed8a7d8a120d985d8b9d98bd8a7d88c20d988d8a7d984d984d8b9d8a8d88c20d988d985d8b4d8a7d987d8afd8a920d8a7d984d8a3d981d984d8a7d985d88c20d8a3d98820d985d8acd8b1d8af20d8a7d984d8a7d8b3d8aad8b1d8aed8a7d8a12e20d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d985d8b3d8a7d8add8a920d8aed8a7d8b5d8a920d988d985d8b1d98ad8add8a920d98ad985d983d98620d8a3d98620d8aad988d981d8b120d984d8b9d8a7d8a6d984d8aad98320d981d8b1d8b5d8a920d984d984d8a7d8b3d8aad8b1d8aed8a7d8a120d988d8a7d984d8aad988d8a7d8b5d98420d982d8a8d98420d8a7d8b3d8aad8a6d986d8a7d98120d8a7d984d8b1d8add984d8a92e3c2f703e0d0a3c68333e352e203c7374726f6e673ed8add8b2d98520d8a7d984d8a3d985d8aad8b9d8a920d8a8d8b4d983d98420d8aed981d98ad98120d984d8a5d982d8a7d985d8a920d982d8b5d98ad8b1d8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed986d8b8d8b1d98bd8a720d984d8a3d98620d8a5d982d8a7d985d8aad98320d8b3d8aad983d988d98620d982d8b5d98ad8b1d8a9d88c20d981d984d8a720d8afd8a7d8b9d98a20d984d8aad8add985d98ad98420d986d981d8b3d98320d8a8d8a7d984d983d8abd98ad8b120d985d98620d8a7d984d8a3d985d8aad8b9d8a92e20d8b1d983d8b220d8b9d984d98920d8add8b2d98520d8a7d984d8b6d8b1d988d8b1d98ad8a7d8aa20d981d982d8b720d984d984d8b3d8a7d8b9d8a7d8aa20d8a7d984d982d984d98ad984d8a920d8a7d984d8aad98a20d8b3d8aad982d8b6d98ad987d8a720d981d98a20d8a7d984d981d986d8afd9822e20d98ad8b4d985d98420d8b0d984d98320d8a7d984d988d8acd8a8d8a7d8aa20d8a7d984d8aed981d98ad981d8a9d88c20d988d8a7d984d985d8b4d8b1d988d8a8d8a7d8aad88c20d988d8a7d984d8add981d8a7d8b6d8a7d8aa20d8a3d98820d8a7d984d985d986d8a7d8afd98ad98420d984d984d8a3d8b7d981d8a7d98420d8a7d984d8b5d8bad8a7d8b1d88c20d988d8a3d98a20d8b9d986d8a7d8b5d8b120d8aad8b1d981d98ad987d98ad8a920d985d8abd98420d8a7d984d983d8aad8a820d8a3d98820d8a7d984d8a3d984d8b9d8a7d8a820d8a3d98820d8a7d984d8a3d8acd987d8b2d8a920d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a92e20d8add982d98ad8a8d8a920d8a3d8aed98120d8aad8b9d986d98a20d982d984d8a920d8a7d984d8aad988d8aad8b120d8b9d986d8af20d8aad8b3d8acd98ad98420d8a7d984d988d8b5d988d98420d988d8a7d984d985d8b2d98ad8af20d985d98620d8a7d984d8add8b1d98ad8a920d984d984d8a7d8b3d8aad985d8aad8a7d8b920d8a8d8a5d982d8a7d985d8aad98320d8a7d984d982d8b5d98ad8b1d8a92e3c2f703e0d0a3c68333e362e203c7374726f6e673ed8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d988d8b3d8a7d8a6d98420d8a7d984d8b1d8a7d8add8a920d8aed8a7d8b1d8ac20d8a7d984d981d986d8afd9823c2f7374726f6e673e3c2f68333e0d0a3c703ed8aad982d8b920d8a7d984d8b9d8afd98ad8af20d985d98620d8a7d984d981d986d8a7d8afd98220d8a7d984d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a920d981d98a20d8a3d985d8a7d983d98620d985d984d8a7d8a6d985d8a920d8a8d8a7d984d982d8b1d8a820d985d98620d8a7d984d985d8b9d8a7d984d98520d8a7d984d8b3d98ad8a7d8add98ad8a920d8a3d98820d985d8b1d8a7d983d8b220d8a7d984d8aad8b3d988d98220d8a3d98820d8a7d984d8add8afd8a7d8a6d98220d8a7d984d985d8add984d98ad8a92e20d8a5d8b0d8a720d983d8a7d98620d984d8afd98ad98320d8a8d8b9d8b620d8a7d984d988d982d8aa20d8a7d984d985d8aad8a7d8add88c20d8a7d8b3d8aad981d8af20d985d98620d8a7d984d985d988d982d8b920d988d8a7d8b3d8aad983d8b4d98120d8a7d984d985d8b9d8a7d984d98520d8a7d984d982d8b1d98ad8a8d8a92e20d982d8af20d98ad983d988d98620d8a7d984d8aed8b1d988d8ac20d8a7d984d8b3d8b1d98ad8b920d985d8b920d8a7d984d8b9d8a7d8a6d984d8a920d8a5d984d98920d8a7d984d8add8afd98ad982d8a920d8a3d98820d8a7d984d985d982d987d98920d8a7d984d985d8acd8a7d988d8b120d988d8b3d98ad984d8a920d985d985d8aad8b9d8a920d984d984d8a7d8b3d8aad981d8a7d8afd8a920d8a7d984d982d8b5d988d98920d985d98620d8a5d982d8a7d985d8aad98320d8a7d984d982d8b5d98ad8b1d8a92e3c2f703e0d0a3c703ed981d98a20d8a7d984d8aed8aad8a7d985d88c20d8aad988d981d8b120d8a7d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d981d986d8afd982d98ad8a920d982d8b5d98ad8b1d8a920d8a7d984d985d8afd8a920d984d984d8b9d8a7d8a6d984d8a7d8aa20d8a7d984d985d8b1d988d986d8a920d988d8a7d984d8b1d8a7d8add8a920d8a7d984d8aad98a20d98ad8add8aad8a7d8acd988d986d987d8a720d8a3d8abd986d8a7d8a120d8b1d8add984d8a7d8aad987d9852e20d985d98620d8aed984d8a7d98420d8a7d8aed8aad98ad8a7d8b120d981d986d8a7d8afd98220d985d986d8a7d8b3d8a8d8a920d984d984d8b9d8a7d8a6d984d8a7d8aad88c20d988d8aad986d8b8d98ad98520d8a7d984d8a5d982d8a7d985d8a920d988d981d982d98bd8a720d984d8acd8afd988d98420d8a7d984d8a3d8b7d981d8a7d984d88c20d988d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d988d8b3d8a7d8a6d98420d8a7d984d8b1d8a7d8add8a920d8a7d984d985d8aad8a7d8add8a9d88c20d98ad985d983d98620d984d984d8b9d8a7d8a6d984d8a7d8aa20d8aad8add988d98ad98420d8aad988d982d98120d8a7d984d981d986d8afd98220d8a7d984d982d8b5d98ad8b120d8a5d984d98920d8acd8b2d8a120d984d8a720d98ad98fd986d8b3d98920d988d985d986d8b9d8b420d985d98620d8b1d8add984d8aad987d9853c2f703e, NULL, NULL, '2024-12-03 02:04:44', '2024-12-03 02:04:44');
INSERT INTO `blog_informations` (`id`, `language_id`, `blog_category_id`, `blog_id`, `title`, `slug`, `author`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(62, 20, 43, 33, 'Making the Most of a Family Room in Hourly Hotels', 'making-the-most-of-a-family-room-in-hourly-hotels', 'Admin', 0x3c703e5768656e2074726176656c696e67207769746820796f75722066616d696c792c2066696e64696e6720746865207269676874206163636f6d6d6f646174696f6e20697320657373656e7469616c2e20486f75726c7920686f74656c7320617265206265636f6d696e6720696e6372656173696e676c7920706f70756c61722c206f66666572696e6720666c657869626c6520626f6f6b696e67206f7074696f6e7320666f722073686f72742073746179732e20546869732063616e20626520657370656369616c6c792062656e6566696369616c20666f722066616d696c6965732077686f206d6179206e6f74206e65656420612066756c6c206e69676874e28099732073746179206f722070726566657220746f2068617665206120706c61636520746f207265737420616e6420726563686172676520647572696e67206c6f6e67206a6f75726e6579732e2042757420686f772063616e20796f75206d616b6520746865206d6f7374206f6620612066616d696c7920726f6f6d20696e20616e20686f75726c7920686f74656c3f20486572652061726520736f6d65207469707320746f20656e7375726520796f752068617665206120636f6d666f727461626c6520616e6420656e6a6f7961626c6520737461792e3c2f703e0d0a3c703e3c7374726f6e673e312e20506c616e20596f7572204172726976616c20616e64204465706172747572652054696d6573204361726566756c6c793c2f7374726f6e673e3c2f703e0d0a3c703e486f75726c7920686f74656c7320616c6c6f7720796f7520746f20626f6f6b20726f6f6d7320666f722073686f7274657220706572696f64732c206d616b696e67206974207065726665637420666f722066616d696c6965732077686f206d69676874206e656564206120627265616b207768696c652074726176656c696e672062757420646f6e27742077616e7420746f2070617920666f7220612066756c6c206e69676874e280997320737461792e20546f206d6178696d697a6520796f757220657870657269656e63652c206974e280997320696d706f7274616e7420746f20706c616e20796f7572206172726976616c20616e64206465706172747572652074696d657320746f20636f696e63696465207769746820746865206e65656473206f6620796f75722066616d696c792e20436f6e736964657220626f6f6b696e67206120726f6f6d20647572696e67206e617074696d65206f72207768656e20796f7572206368696c6472656e20617265206c696b656c7920746f20726573742c20736f20796f752063616e20656e6a6f792074686520706561636520616e64207175696574207468617420636f6d6573207769746820612073686f727420737461792e3c2f703e0d0a3c703e3c7374726f6e673e322e20436865636b20666f722046616d696c792d467269656e646c7920416d656e69746965733c2f7374726f6e673e3c2f703e0d0a3c703e5768656e20626f6f6b696e6720616e20686f75726c7920686f74656c2c206974e280997320696d706f7274616e7420746f20636865636b20666f7220616d656e697469657320746861742077696c6c20636174657220746f20796f75722066616d696c79e2809973206e656564732e204c6f6f6b20666f722066616d696c792d667269656e646c79206f7074696f6e732073756368206173206c617267657220726f6f6d732c20636f6d666f727461626c652062656464696e672c20616e64206576656e20696e2d726f6f6d20656e7465727461696e6d656e74206f7074696f6e732e20536f6d6520686f74656c73206d69676874206f6666657220616d656e6974696573206c696b65206368696c6472656ee280997320706c61792061726561732c2068696768206368616972732c206f72206576656e2063726962732e204d616b652073757265207468652066616d696c7920726f6f6d20796f752063686f6f73652068617320656e6f75676820737061636520746f20636f6d666f727461626c79206163636f6d6d6f646174652065766572796f6e652c20616e6420656e7375726520616e7920737065636966696320726571756573747320286c696b652065787472612062656464696e67206f72206120636f74292061726520617272616e67656420696e20616476616e63652e3c2f703e0d0a3c703e3c7374726f6e673e332e2054616b6520416476616e74616765206f6620466c657869626c6520426f6f6b696e673c2f7374726f6e673e3c2f703e0d0a3c703e4f6e65206f6620746865206269676765737420616476616e7461676573206f6620686f75726c7920686f74656c732069732074686520666c65786962696c6974792074686579206f666665722e20496620796f752772652074726176656c696e67206f6e2061207469676874207363686564756c65206f722068617665206368696c6472656e20776974682076617279696e6720726f7574696e65732c20796f752063616e207461696c6f7220796f7572207374617920746f206d6174636820796f7572206e656564732e2057686574686572206974277320626f6f6b696e67206120726f6f6d20666f7220612066657720686f75727320746f2072656c6178206265747765656e20666c6967687473206f7220726573657276696e6720697420647572696e67207468652061667465726e6f6f6e20746f2072657374206166746572206120646179206f66207369676874736565696e672c20686f75726c7920686f74656c7320616c6c6f7720796f7520746f20706c616e20796f7572206163636f6d6d6f646174696f6e2061726f756e6420796f75722066616d696c79e2809973207363686564756c652e205468697320697320657370656369616c6c792068656c7066756c20696620796f75206e656564206120737061636520666f72206368616e67696e6720646961706572732c2066656564696e67206368696c6472656e2c206f722073696d706c7920686176696e67206120627265616b20776974686f75742074686520636f6e73747261696e7473206f6620612066756c6c2d6e6967687420626f6f6b696e672e3c2f703e0d0a3c703e3c7374726f6e673e342e204b6565702049742046756e20666f7220746865204b6964733c2f7374726f6e673e3c2f703e0d0a3c703e412066616d696c7920726f6f6d2069736ee2809974206a7573742061626f757420636f6d666f72743b206974e280997320616c736f2061626f7574206d616b696e6720737572652065766572796f6e65206861732066756e20647572696e672074686520737461792e204d616e7920686f75726c7920686f74656c73206172652064657369676e656420776974682066616d696c69657320696e206d696e642c206f66666572696e6720737061636520666f7220616374697669746965732e204272696e6720736f6d6520746f79732c20626f6f6b732c206f72206d6f7669657320746f206b65657020796f7572206b69647320656e7465727461696e6564207768696c6520796f752072656c61782e204120717569636b20627265616b20696e206120636f6d666f727461626c652c20707269766174652073706163652063616e206d616b6520616c6c2074686520646966666572656e636520666f72206368696c6472656e2077686f206d61792067657420726573746c65737320647572696e67206c6f6e672074726176656c2074696d65732e3c2f703e0d0a3c703e3c7374726f6e673e352e20506c616e20666f7220466f6f6420616e6420536e61636b733c2f7374726f6e673e3c2f703e0d0a3c703e5768696c6520736f6d6520686f75726c7920686f74656c73206d6179206f6666657220696e2d726f6f6d2064696e696e672c2069742773206f6674656e206120676f6f64206964656120746f206272696e6720796f7572206f776e20736e61636b7320616e64206472696e6b732c20657370656369616c6c7920696620796f752068617665207069636b7920656174657273206f7220796f756e67206368696c6472656e2e20486176696e6720656173792061636365737320746f2066616d696c69617220666f6f64732063616e2068656c70206d616b6520796f75722073746179206d6f726520636f6d666f727461626c652e204164646974696f6e616c6c792c20696620796f7520706c616e20746f207374617920666f72207365766572616c20686f7572732c20796f75206d696768742077616e7420746f206272696e6720616c6f6e672061206c69676874206d65616c206f7220736e61636b73207468617420617265206561737920746f2065617420696e2074686520726f6f6d2c207265647563696e672074686520686173736c65206f662066696e64696e672064696e696e67206f7074696f6e73206f7574736964652e3c2f703e0d0a3c703e3c7374726f6e673e436f6e636c7573696f6e3c2f7374726f6e673e3c2f703e0d0a3c703e486f75726c7920686f74656c732070726f7669646520616e20657863656c6c656e74206f7074696f6e20666f722066616d696c696573206f6e2074686520676f2e2042792073656c656374696e6720612066616d696c792d667269656e646c7920726f6f6d20776974682074686520726967687420616d656e697469657320616e6420706c616e6e696e6720796f757220737461792061726f756e6420796f75722066616d696c79e2809973206e656564732c20796f752063616e20656e73757265206120636f6d666f727461626c652c207374726573732d6672656520657870657269656e63652e205768657468657220796f75e2809972652074726176656c696e6720666f7220627573696e6573732c206120717569636b20676574617761792c206f72206a757374206e65656420612072657374696e6720706c61636520647572696e672061206c6f6e67206a6f75726e65792c206d616b696e6720746865206d6f7374206f6620612066616d696c7920726f6f6d20696e20616e20686f75726c7920686f74656c20697320616c6c2061626f7574206265696e6720666c657869626c652c206f7267616e697a65642c20616e642074616b696e672066756c6c20616476616e74616765206f662074686520636f6e76656e69656e636520746861742073686f72742d7465726d20626f6f6b696e67732070726f766964652e3c2f703e, NULL, NULL, '2024-12-03 02:07:42', '2024-12-03 02:07:42'),
(63, 21, 52, 33, 'تحقيق أقصى استفادة من الغرفة العائلية في الفنادق التي تعمل بالساعة', 'تحقيق-أقصى-استفادة-من-الغرفة-العائلية-في-الفنادق-التي-تعمل-بالساعة', 'مسؤل', 0x3c703ed8b9d986d8af20d8a7d984d8b3d981d8b120d985d8b920d8b9d8a7d8a6d984d8aad983d88c20d98ad8b9d8aad8a8d8b120d8a7d984d8b9d8abd988d8b120d8b9d984d98920d985d983d8a7d98620d8a7d984d8a5d982d8a7d985d8a920d8a7d984d985d986d8a7d8b3d8a820d8a3d985d8b1d98bd8a720d8a8d8a7d984d8ba20d8a7d984d8a3d987d985d98ad8a92e20d8a3d8b5d8a8d8add8aa20d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d8aad8add8b8d98920d8a8d8b4d8b9d8a8d98ad8a920d985d8aad8b2d8a7d98ad8afd8a9d88c20d8add98ad8ab20d8aad982d8afd98520d8aed98ad8a7d8b1d8a7d8aa20d8add8acd8b220d985d8b1d986d8a920d984d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d982d8b5d98ad8b1d8a92e20d98ad985d983d98620d8a3d98620d8aad983d988d98620d987d8b0d98720d985d98ad8b2d8a920d8aed8a7d8b5d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa20d8a7d984d8aad98a20d982d8af20d984d8a720d8aad8add8aad8a7d8ac20d8a5d984d98920d8a5d982d8a7d985d8a920d984d984d98ad984d8a920d983d8a7d985d984d8a920d8a3d98820d8aad981d8b6d98420d8a7d984d8add8b5d988d98420d8b9d984d98920d985d983d8a7d98620d984d984d8a7d8b3d8aad8b1d8aed8a7d8a120d8a3d8abd986d8a7d8a120d8a7d984d8b1d8add984d8a7d8aa20d8a7d984d8b7d988d98ad984d8a92e20d988d984d983d98620d983d98ad98120d98ad985d983d986d98320d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d8a7d984d982d8b5d988d98920d985d98620d8bad8b1d981d8a920d8b9d8a7d8a6d984d98ad8a920d981d98a20d981d986d8afd98220d8b3d8a7d8b9d8a9d89f20d8a5d984d98ad98320d8a8d8b9d8b620d8a7d984d986d8b5d8a7d8a6d8ad20d984d8b6d985d8a7d98620d8a5d982d8a7d985d8a920d985d8b1d98ad8add8a920d988d985d985d8aad8b9d8a92e3c2f703e0d0a3c703e3c7374726f6e673e312e20d8aed8b7d8b720d984d985d988d8a7d8b9d98ad8af20d8a7d984d988d8b5d988d98420d988d8a7d984d985d8bad8a7d8afd8b1d8a920d8a8d8b9d986d8a7d98ad8a93c2f7374726f6e673e3c2f703e0d0a3c703ed8aad8aad98ad8ad20d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d984d98320d8add8acd8b220d8a7d984d8bad8b1d98120d984d981d8aad8b1d8a7d8aa20d8b2d985d986d98ad8a920d982d8b5d98ad8b1d8a9d88c20d985d985d8a720d98ad8acd8b9d984d987d8a720d985d8abd8a7d984d98ad8a920d984d984d8b9d8a7d8a6d984d8a7d8aa20d8a7d984d8aad98a20d982d8af20d8aad8add8aad8a7d8ac20d8a5d984d98920d8a7d8b3d8aad8b1d8a7d8add8a920d8a3d8abd986d8a7d8a120d8a7d984d8b3d981d8b120d984d983d986d987d8a720d984d8a720d8aad8b1d8bad8a820d981d98a20d8afd981d8b920d8aad983d984d981d8a920d8a5d982d8a7d985d8a920d984d98ad984d8a920d983d8a7d985d984d8a92e20d984d984d8a7d8b3d8aad981d8a7d8afd8a920d8a7d984d982d8b5d988d98920d985d98620d8aad8acd8b1d8a8d8aad983d88c20d985d98620d8a7d984d985d987d98520d8a3d98620d8aad8aed8b7d8b720d984d985d988d8a7d8b9d98ad8af20d988d8b5d988d984d98320d988d985d8bad8a7d8afd8b1d8aad98320d984d8aad8aad988d8a7d981d98220d985d8b920d8a7d8add8aad98ad8a7d8acd8a7d8aa20d8b9d8a7d8a6d984d8aad9832e20d982d8af20d98ad983d988d98620d985d98620d8a7d984d8a3d981d8b6d98420d8add8acd8b220d8bad8b1d981d8a920d8aed984d8a7d98420d988d982d8aa20d982d98ad984d988d984d8a920d8a7d984d8a3d8b7d981d8a7d98420d8a3d98820d8b9d986d8afd985d8a720d98ad983d988d98620d985d98620d8a7d984d985d8b1d8acd8ad20d8a3d98620d98ad8b3d8aad8b1d98ad8add988d8a7d88c20d8add8aad98920d8aad8aad985d983d98620d985d98620d8a7d984d8a7d8b3d8aad985d8aad8a7d8b920d8a8d8a7d984d987d8afd988d8a120d8a7d984d8b0d98a20d8aad988d981d8b1d98720d8a7d984d8a5d982d8a7d985d8a920d8a7d984d982d8b5d98ad8b1d8a92e3c2f703e0d0a3c703e3c7374726f6e673e322e20d8aad8add982d98220d985d98620d8a7d984d985d8b1d8a7d981d98220d8a7d984d985d986d8a7d8b3d8a8d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa3c2f7374726f6e673e3c2f703e0d0a3c703ed8b9d986d8af20d8add8acd8b220d981d986d8afd98220d8b3d8a7d8b9d8a9d88c20d985d98620d8a7d984d985d987d98520d8a7d984d8aad8add982d98220d985d98620d8a7d984d985d8b1d8a7d981d98220d8a7d984d8aad98a20d8b3d8aad984d8a8d98a20d8a7d8add8aad98ad8a7d8acd8a7d8aa20d8b9d8a7d8a6d984d8aad9832e20d8a7d8a8d8add8ab20d8b9d98620d8aed98ad8a7d8b1d8a7d8aa20d985d986d8a7d8b3d8a8d8a920d984d984d8b9d8a7d8a6d984d8a7d8aa20d985d8abd98420d8a7d984d8bad8b1d98120d8a7d984d983d8a8d98ad8b1d8a9d88c20d988d8a7d984d8a3d8b3d8b1d8a920d8a7d984d985d8b1d98ad8add8a9d88c20d988d8add8aad98920d8aed98ad8a7d8b1d8a7d8aa20d8a7d984d8aad8b1d981d98ad98720d8afd8a7d8aed98420d8a7d984d8bad8b1d981d8a92e20d982d8af20d8aad982d8afd98520d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d985d8b1d8a7d981d98220d985d8abd98420d985d986d8a7d8b7d98220d984d8b9d8a820d984d984d8a3d8b7d981d8a7d984d88c20d988d8a7d984d983d8b1d8a7d8b3d98a20d8a7d984d8b9d8a7d984d98ad8a9d88c20d8a3d98820d8add8aad98920d8a7d984d8a3d8b3d8b1d8a920d8a7d984d982d8a7d8a8d984d8a920d984d984d8b7d98a2e20d8aad8a3d983d8af20d985d98620d8a3d98620d8a7d984d8bad8b1d981d8a920d8a7d984d8b9d8a7d8a6d984d98ad8a920d8a7d984d8aad98a20d8aad8aed8aad8a7d8b1d987d8a720d8aad8add8aad988d98a20d8b9d984d98920d985d8b3d8a7d8add8a920d983d8a7d981d98ad8a920d984d8a7d8b3d8aad98ad8b9d8a7d8a820d8a7d984d8acd985d98ad8b920d8a8d8b4d983d98420d985d8b1d98ad8add88c20d988d8aad8a3d983d8af20d985d98620d8aad8b1d8aad98ad8a820d8a3d98a20d8b7d984d8a8d8a7d8aa20d8aed8a7d8b5d8a92028d985d8abd98420d8a5d8b6d8a7d981d8a920d8b3d8b1d98ad8b120d8a5d8b6d8a7d981d98a20d8a3d98820d985d987d8af2920d985d8b3d8a8d982d98bd8a72e3c2f703e0d0a3c703e3c7374726f6e673e332e20d8a7d8b3d8aad981d8af20d985d98620d8a7d984d8add8acd8b220d8a7d984d985d8b1d9863c2f7374726f6e673e3c2f703e0d0a3c703ed8a3d8add8af20d8a3d983d8a8d8b120d985d8b2d8a7d98ad8a720d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d987d98820d8a7d984d985d8b1d988d986d8a920d8a7d984d8aad98a20d8aad982d8afd985d987d8a72e20d8a5d8b0d8a720d983d986d8aa20d8aad8b3d8a7d981d8b120d988d981d982d98bd8a720d984d8acd8afd988d98420d8b2d985d986d98a20d8b6d98ad98220d8a3d98820d984d8afd98ad98320d8a3d8b7d981d8a7d98420d8a8d8b1d988d8aad98ad98620d985d8aed8aad984d981d88c20d98ad985d983d986d98320d8aad8aed8b5d98ad8b520d8a5d982d8a7d985d8aad98320d984d8aad8aad986d8a7d8b3d8a820d985d8b920d8a7d8add8aad98ad8a7d8acd8a7d8aad9832e20d8b3d988d8a7d8a120d983d8a7d98620d8b0d984d98320d8add8acd8b220d8bad8b1d981d8a920d984d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d984d984d8a7d8b3d8aad8b1d8aed8a7d8a120d8a8d98ad98620d8a7d984d8b1d8add984d8a7d8aa20d8a7d984d8acd988d98ad8a920d8a3d98820d8add8acd8b2d987d8a720d8aed984d8a7d98420d981d8aad8b1d8a920d8a8d8b9d8af20d8a7d984d8b8d987d8b120d984d984d8a7d8b3d8aad8b1d8a7d8add8a920d8a8d8b9d8af20d98ad988d98520d985d98620d985d8b4d8a7d987d8afd8a920d8a7d984d985d8b9d8a7d984d98520d8a7d984d8b3d98ad8a7d8add98ad8a9d88c20d8aad8aad98ad8ad20d984d98320d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d8aad8aed8b7d98ad8b720d8a5d982d8a7d985d8aad98320d8add988d98420d8acd8afd988d98420d8b9d8a7d8a6d984d8aad9832e20d987d8b0d8a720d985d981d98ad8af20d8a8d8b4d983d98420d8aed8a7d8b520d8a5d8b0d8a720d983d986d8aa20d8a8d8add8a7d8acd8a920d8a5d984d98920d985d8b3d8a7d8add8a920d984d8aad8bad98ad98ad8b120d8a7d984d8add981d8a7d8b6d8a7d8aa20d8a3d98820d8a5d8b7d8b9d8a7d98520d8a7d984d8a3d8b7d981d8a7d98420d8a3d98820d8a8d8a8d8b3d8a7d8b7d8a920d8a3d8aed8b020d8a7d8b3d8aad8b1d8a7d8add8a920d8afd988d98620d982d98ad988d8af20d8a7d984d8add8acd8b220d8a7d984d984d98ad984d98a20d8a7d984d983d8a7d985d9842e3c2f703e0d0a3c703e3c7374726f6e673e342e20d8a7d8acd8b9d984d987d8a720d985d985d8aad8b9d8a920d984d984d8a3d8b7d981d8a7d9843c2f7374726f6e673e3c2f703e0d0a3c703ed8a7d984d8bad8b1d981d8a920d8a7d984d8b9d8a7d8a6d984d98ad8a920d984d8a720d8aad982d8aad8b5d8b120d981d982d8b720d8b9d984d98920d8a7d984d8b1d8a7d8add8a9d89b20d8a8d98420d8a5d986d987d8a720d8a3d98ad8b6d98bd8a720d8b9d98620d8a7d984d8aad8a3d983d8af20d985d98620d8a3d98620d8a7d984d8acd985d98ad8b920d8b3d98ad8b3d8aad985d8aad8b920d8a8d8a7d984d8a5d982d8a7d985d8a92e20d8a7d984d8b9d8afd98ad8af20d985d98620d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d985d8b5d985d985d8a920d985d8b920d988d8b6d8b920d8a7d984d8b9d8a7d8a6d984d8a7d8aa20d981d98a20d8a7d984d8a7d8b9d8aad8a8d8a7d8b1d88c20d8add98ad8ab20d8aad988d981d8b120d985d8b3d8a7d8add8a920d984d984d8a3d986d8b4d8b7d8a92e20d98ad985d983d986d98320d8a5d8add8b6d8a7d8b120d8a8d8b9d8b620d8a7d984d8a3d984d8b9d8a7d8a820d8a3d98820d8a7d984d983d8aad8a820d8a3d98820d8a7d984d8a3d981d984d8a7d98520d984d8a5d8a8d982d8a7d8a120d8a7d984d8a3d8b7d981d8a7d98420d985d8b4d8bad988d984d98ad98620d8a8d98ad986d985d8a720d8aad8b3d8aad8b1d8aed98a20d8a3d986d8aa2e20d98ad985d983d98620d8a3d98620d98ad983d988d98620d8a7d984d8add8b5d988d98420d8b9d984d98920d8a7d8b3d8aad8b1d8a7d8add8a920d8b3d8b1d98ad8b9d8a920d981d98a20d985d983d8a7d98620d985d8b1d98ad8ad20d988d8aed8a7d8b520d981d8a7d8b1d982d98bd8a720d983d8a8d98ad8b1d98bd8a720d984d984d8a3d8b7d981d8a7d98420d8a7d984d8b0d98ad98620d982d8af20d98ad8b5d8a7d8a8d988d98620d8a8d8a7d984d985d984d98420d8a3d8abd986d8a7d8a120d8a7d984d8b3d981d8b120d8a7d984d8b7d988d98ad9842e3c2f703e0d0a3c703e3c7374726f6e673e352e20d8aed8b7d8b720d984d984d8b7d8b9d8a7d98520d988d8a7d984d988d8acd8a8d8a7d8aa20d8a7d984d8aed981d98ad981d8a93c2f7374726f6e673e3c2f703e0d0a3c703ed8a8d98ad986d985d8a720d982d8af20d8aad982d8afd98520d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d8aed8afd985d8a7d8aa20d8a7d984d8b7d8b9d8a7d98520d981d98a20d8a7d984d8bad8b1d981d8a9d88c20d985d98620d8a7d984d8a3d981d8b6d98420d981d98a20d983d8abd98ad8b120d985d98620d8a7d984d8a3d8add98ad8a7d98620d8a5d8add8b6d8a7d8b120d8a7d984d988d8acd8a8d8a7d8aa20d8a7d984d8aed981d98ad981d8a920d988d8a7d984d985d8b4d8b1d988d8a8d8a7d8aa20d8a7d984d8aed8a7d8b5d8a920d8a8d983d88c20d8aed8a7d8b5d8a920d8a5d8b0d8a720d983d8a7d98620d984d8afd98ad98320d8a3d8b7d981d8a7d98420d985d8aad8b7d984d8a8d98ad98620d8a3d98820d8b5d8bad8a7d8b120d8a7d984d8b3d9862e20d98ad985d983d98620d8a3d98620d98ad8b3d8a7d8b9d8af20d8a7d984d988d8b5d988d98420d8a7d984d8b3d987d98420d8a5d984d98920d8a7d984d8a3d8b7d8b9d985d8a920d8a7d984d985d8a3d984d988d981d8a920d981d98a20d8acd8b9d98420d8a5d982d8a7d985d8aad98320d8a3d983d8abd8b120d8b1d8a7d8add8a92e20d8a8d8a7d984d8a5d8b6d8a7d981d8a920d8a5d984d98920d8b0d984d983d88c20d8a5d8b0d8a720d983d986d8aa20d8aad8aed8b7d8b720d984d984d8a8d982d8a7d8a120d8b9d8afd8a920d8b3d8a7d8b9d8a7d8aad88c20d981d982d8af20d8aad8b1d8bad8a820d981d98a20d8a5d8add8b6d8a7d8b120d988d8acd8a8d8a920d8aed981d98ad981d8a920d8a3d98820d8b7d8b9d8a7d98520d8b3d987d98420d8aad986d8a7d988d984d98720d981d98a20d8a7d984d8bad8b1d981d8a920d984d8aad982d984d98ad98420d8b9d986d8a7d8a120d8a7d984d8a8d8add8ab20d8b9d98620d8aed98ad8a7d8b1d8a7d8aa20d8a7d984d8b7d8b9d8a7d98520d8aed8a7d8b1d8ac20d8a7d984d981d986d8afd9822e3c2f703e0d0a3c703e3c7374726f6e673ed8a7d984d8aed8a7d8aad985d8a93c2f7374726f6e673e3c2f703e0d0a3c703ed8aad988d981d8b120d8a7d984d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a920d8aed98ad8a7d8b1d98bd8a720d985d985d8aad8a7d8b2d98bd8a720d984d984d8b9d8a7d8a6d984d8a7d8aa20d8a7d984d8aad98a20d981d98a20d8a7d984d8b7d8b1d98ad9822e20d985d98620d8aed984d8a7d98420d8a7d8aed8aad98ad8a7d8b120d8bad8b1d981d8a920d8b9d8a7d8a6d984d98ad8a920d985d986d8a7d8b3d8a8d8a920d985d8b920d8a7d984d985d8b1d8a7d981d98220d8a7d984d985d986d8a7d8b3d8a8d8a920d988d8aad8aed8b7d98ad8b720d8a5d982d8a7d985d8aad98320d988d981d982d98bd8a720d984d8a7d8add8aad98ad8a7d8acd8a7d8aa20d8b9d8a7d8a6d984d8aad983d88c20d98ad985d983d986d98320d8b6d985d8a7d98620d8aad8acd8b1d8a8d8a920d985d8b1d98ad8add8a920d988d8aed8a7d984d98ad8a920d985d98620d8a7d984d8a5d8acd987d8a7d8af2e20d8b3d988d8a7d8a120d983d986d8aa20d8aad8b3d8a7d981d8b120d985d98620d8a3d8acd98420d8a7d984d8b9d985d984d88c20d8a3d98820d981d98a20d8b1d8add984d8a920d8b3d8b1d98ad8b9d8a9d88c20d8a3d98820d8aad8add8aad8a7d8ac20d981d982d8b720d8a5d984d98920d985d983d8a7d98620d984d984d8b1d8a7d8add8a920d8aed984d8a7d98420d8b1d8add984d8a920d8b7d988d98ad984d8a9d88c20d981d8a5d98620d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d8a7d984d982d8b5d988d98920d985d98620d8bad8b1d981d8a920d8b9d8a7d8a6d984d98ad8a920d981d98a20d981d986d8afd98220d8b3d8a7d8b9d8a920d8aad8b9d8aad985d8af20d8b9d984d98920d8a7d984d985d8b1d988d986d8a920d988d8a7d984d8aad986d8b8d98ad98520d988d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d8a7d984d983d8a7d985d984d8a920d985d98620d8a7d984d8b1d8a7d8add8a920d8a7d984d8aad98a20d8aad988d981d8b1d987d8a720d8a7d984d8add8acd988d8b2d8a7d8aa20d982d8b5d98ad8b1d8a920d8a7d984d8a3d8ac3c2f703e, NULL, NULL, '2024-12-03 02:07:42', '2024-12-03 02:07:42'),
(64, 20, 42, 34, 'How Hourly Hotels Benefit Business Travelers', 'how-hourly-hotels-benefit-business-travelers', 'Admin', 0x3c703e466f7220627573696e6573732074726176656c6572732c2066696e64696e6720746865207269676874206163636f6d6d6f646174696f6e2063616e2062652061206368616c6c656e67652c20657370656369616c6c79207768656e207468656972207363686564756c6520697320746967687420616e6420746865697220737461792069732073686f72742e20486f75726c7920686f74656c73206861766520656d657267656420617320612067616d652d6368616e6765722c206f66666572696e67206120666c657869626c6520616e64206166666f726461626c6520736f6c7574696f6e2074686174206d656574732074686520756e69717565206e65656473206f6620627573696e6573732070726f66657373696f6e616c732e20546865736520686f74656c732070726f766964652074686520706572666563742062616c616e6365206f6620636f6d666f72742c20636f6e76656e69656e63652c20616e6420656666696369656e63792c20616c6c6f77696e6720627573696e6573732074726176656c65727320746f206d616b6520746865206d6f7374206f66207468656972206c696d697465642074696d6520696e206120636974792e2048657265e280997320686f7720686f75726c7920686f74656c732063616e2062656e6566697420627573696e6573732074726176656c6572733a3c2f703e0d0a3c68333e312e203c7374726f6e673e436f73742d45666665637469766520666f722053686f72742053746179733c2f7374726f6e673e3c2f68333e0d0a3c703e547261646974696f6e616c20686f74656c7320757375616c6c79207265717569726520626f6f6b696e6720666f7220616e20656e74697265206e696768742c206576656e20696620796f75206f6e6c79206e65656420612066657720686f75727320746f2072657374206f72206672657368656e207570206265747765656e206d656574696e67732e205769746820686f75726c7920686f74656c732c20627573696e6573732074726176656c657273206f6e6c792070617920666f72207468652074696d6520746865792061637475616c6c79206e6565642c2077686963682063616e207369676e69666963616e746c7920726564756365206163636f6d6d6f646174696f6e20636f7374732e205768657468657220796f75206e65656420612066657720686f75727320746f20736c6565702c20726566726573682c206f72207072657061726520666f7220612070726573656e746174696f6e2c20686f75726c7920686f74656c73206f666665722061206d6f72652065636f6e6f6d6963616c2063686f69636520666f722074686f7365206f6e2074696768742062756467657473206f7220776974682061207469676874207363686564756c652e3c2f703e0d0a3c68333e322e203c7374726f6e673e466c65786962696c69747920746f204d617463682042757379205363686564756c65733c2f7374726f6e673e3c2f68333e0d0a3c703e427573696e6573732074726176656c657273206f6674656e2066696e64207468656d73656c76657320696e2063697469657320666f72206f6e6c7920612066657720686f757273206f72206f7665726e696768742e20547261646974696f6e616c20686f74656c20626f6f6b696e6773207769746820666978656420636865636b2d696e20616e6420636865636b2d6f75742074696d657320646f6ee280997420616c7761797320616c69676e207769746820746865697220686563746963207363686564756c65732e20486f75726c7920686f74656c73206f6666657220666c65786962696c69747920696e20636865636b2d696e20616e6420636865636b2d6f75742074696d65732c207768696368206d65616e732074726176656c6572732063616e20626f6f6b2074686569722073746179206261736564206f6e207468656972206578616374206e656564732c2077686574686572206974277320666f7220612066657720686f75727320696e20746865206d6f726e696e67206f7220616e2061667465726e6f6f6e206e6170206265666f72652061206c617465206d656574696e672e205468697320666c65786962696c69747920616c6c6f777320627573696e6573732074726176656c65727320746f207461696c6f72207468656972206163636f6d6d6f646174696f6e20746f2066697420746865697220776f726b2064656d616e64732c206d616b696e67206974206120686967686c7920636f6e76656e69656e74206f7074696f6e2e3c2f703e0d0a3c68333e332e203c7374726f6e673e436f6e76656e69656e74204c6f636174696f6e3c2f7374726f6e673e3c2f68333e0d0a3c703e486f75726c7920686f74656c7320617265206f6674656e20737472617465676963616c6c79206c6f6361746564206e656172206d616a6f72207472616e73706f72746174696f6e20687562732c20616972706f7274732c20616e6420627573696e657373206469737472696374732c206d616b696e67207468656d20616e20696465616c2063686f69636520666f7220627573696e6573732074726176656c6572732077686f206e65656420717569636b2061636365737320746f206d656574696e67732c20636f6e666572656e6365732c206f7220666c69676874732e205468652063656e7472616c206c6f636174696f6e2072656475636573207468652074696d65207370656e7420696e207472616e7369742c207768696368206973206372756369616c207768656e20627573696e6573732070726f66657373696f6e616c732061726520776f726b696e672077697468207469676874207363686564756c65732e20486176696e67206120636f6e76656e69656e7420706c61636520746f2072656c6178206f72207072657061726520666f72206d656574696e67732063616e20616c736f20626f6f73742070726f64756374697669747920616e64207265647563652073747265737320647572696e672061206275737920747269702e3c2f703e0d0a3c68333e342e203c7374726f6e673e5072697661637920616e6420436f6d666f72743c2f7374726f6e673e3c2f68333e0d0a3c703e447572696e6720627573696e6573732074726970732c20686176696e67206120636f6d666f727461626c652c207072697661746520737061636520746f20756e77696e64206f7220776f726b20697320657373656e7469616c2e20486f75726c7920686f74656c732070726f7669646520616e206f70706f7274756e69747920746f206573636170652066726f6d2074686520687573746c6520616e6420627573746c65206f662074726176656c2c206f66666572696e6720717569657420726f6f6d732077697468206e656365737361727920616d656e6974696573206c696b652057692d46692c20636f6d666f727461626c652073656174696e672c20616e6420776f726b7370616365732e205768657468657220796f75206e65656420746f2074616b65206120717569636b2063616c6c2c207265766973652070726573656e746174696f6e732c206f722073696d706c792072656c6178206265666f726520796f7572206e657874206d656574696e672c20686f75726c7920686f74656c73206f66666572206120706561636566756c20616e64207072697661746520656e7669726f6e6d656e7420666f7220627573696e6573732070726f66657373696f6e616c7320746f2072656368617267652e3c2f703e0d0a3c68333e352e203c7374726f6e673e41636365737320746f205072656d69756d20416d656e69746965733c2f7374726f6e673e3c2f68333e0d0a3c703e44657370697465206265696e67206275646765742d667269656e646c792c206d616e7920686f75726c7920686f74656c73206f66666572207072656d69756d20616d656e6974696573207375636820617320686967682d737065656420696e7465726e65742c2077656c6c2d657175697070656420776f726b73746174696f6e732c206d656574696e6720726f6f6d732c20616e6420636f6d666f727461626c65206c6f756e67652061726561732e20546865736520616d656e697469657320616c6c6f7720627573696e6573732074726176656c65727320746f20737461792070726f647563746976652c206576656e207768656e206f6e20612073686f727420737461792e20536f6d6520686f75726c7920686f74656c7320616c736f206f6666657220636f6e666572656e636520726f6f6d7320616e64206576656e742073706163657320746861742063616e2062652072656e7465642062792074686520686f75722c2077686963682063616e20626520696e6372656469626c792075736566756c20666f7220686f7374696e6720736d616c6c206d656574696e6773206f7220627261696e73746f726d696e672073657373696f6e7320776974686f757420636f6d6d697474696e6720746f20616e20656e7469726520646179e28099732072656e74616c2e3c2f703e0d0a3c68333e436f6e636c7573696f6e3c2f68333e0d0a3c703e486f75726c7920686f74656c73206f6666657220627573696e6573732074726176656c6572732074686520666c65786962696c6974792c20636f6d666f72742c20616e64206166666f72646162696c6974792074686579206e65656420746f206d6178696d697a652074686569722074696d65206f6e2074686520676f2e205768657468657220796f75e280997265206f6e206120717569636b206c61796f7665722c206265747765656e206d656574696e67732c206f72206a757374206e656564206120706c61636520746f20726566726573682c20686f75726c7920686f74656c732070726f766964652061207461696c6f72656420736f6c7574696f6e207468617420737570706f7274732070726f64756374697669747920616e6420636f6e76656e69656e63652e20417320627573696e6573732074726176656c20636f6e74696e75657320746f2065766f6c76652c20686f75726c7920686f74656c73206172652070726f76696e6720746f20626520612076616c7561626c65207265736f7572636520666f722070726f66657373696f6e616c732077686f206e656564206120736d61727420616e6420656666696369656e742077617920746f20626f6f6b206163636f6d6d6f646174696f6e732e3c2f703e, NULL, NULL, '2024-12-03 02:09:30', '2024-12-03 02:09:30'),
(65, 21, 51, 34, 'كيف تفيد الفنادق كل ساعة المسافرين من رجال الأعمال', 'كيف-تفيد-الفنادق-كل-ساعة-المسافرين-من-رجال-الأعمال', 'مسؤل', 0x3c703ed8a8d8a7d984d986d8b3d8a8d8a920d984d984d985d8b3d8a7d981d8b1d98ad98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d984d88c20d982d8af20d98ad983d988d98620d8a7d984d8b9d8abd988d8b120d8b9d984d98920d8a7d984d8a5d982d8a7d985d8a920d8a7d984d985d986d8a7d8b3d8a8d8a920d8aad8add8afd98ad98bd8a7d88c20d8aed8a7d8b5d8a920d8b9d986d8afd985d8a720d98ad983d988d98620d8acd8afd988d984d987d98520d8b6d98ad982d98bd8a720d988d8a5d982d8a7d985d8aad987d98520d982d8b5d98ad8b1d8a92e20d984d982d8af20d8b8d987d8b1d8aa20d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d983d8add98420d985d8a8d8aad983d8b120d988d985d8b1d98620d98ad982d8afd98520d8add984d8a7d98b20d8a7d982d8aad8b5d8a7d8afd98ad98bd8a720d98ad984d8a8d98a20d8a7d8add8aad98ad8a7d8acd8a7d8aa20d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d98420d8a7d984d981d8b1d98ad8afd8a92e20d8aad988d981d8b120d987d8b0d98720d8a7d984d981d986d8a7d8afd98220d8a7d984d8aad988d8a7d8b2d98620d8a7d984d985d8abd8a7d984d98a20d8a8d98ad98620d8a7d984d8b1d8a7d8add8a920d988d8a7d984d8b1d8a7d8add8a920d988d8a7d984d983d981d8a7d8a1d8a9d88c20d985d985d8a720d98ad8aad98ad8ad20d984d984d985d8b3d8a7d981d8b1d98ad98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d98420d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d8a7d984d982d8b5d988d98920d985d98620d988d982d8aad987d98520d8a7d984d985d8add8afd988d8af20d981d98a20d8a7d984d985d8afd98ad986d8a92e20d8a5d984d98ad983d98520d983d98ad98120d98ad985d983d98620d8a3d98620d8aad8b3d8aad981d98ad8af20d981d986d8a7d8afd98220d8a7d984d8b3d8a7d8b9d8a7d8aa20d985d98620d8a7d984d985d8b3d8a7d981d8b1d98ad98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d9843a3c2f703e0d0a3c68333e312e203c7374726f6e673ed981d8b9d991d8a7d984d8a920d985d98620d8add98ad8ab20d8a7d984d8aad983d984d981d8a920d984d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d982d8b5d98ad8b1d8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed8aad8aad8b7d984d8a820d8a7d984d981d986d8a7d8afd98220d8a7d984d8aad982d984d98ad8afd98ad8a920d8b9d8a7d8afd8a9d98b20d8add8acd8b2d98bd8a720d984d984d98ad984d8a920d983d8a7d985d984d8a9d88c20d8add8aad98920d8a5d8b0d8a720d983d986d8aa20d8a8d8add8a7d8acd8a920d984d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d981d982d8b720d984d984d8b1d8a7d8add8a920d8a3d98820d8a7d984d8a7d8b3d8aad8acd985d8a7d98520d8a8d98ad98620d8a7d984d8a7d8acd8aad985d8a7d8b9d8a7d8aa2e20d985d8b920d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a9d88c20d98ad8afd981d8b920d8a7d984d985d8b3d8a7d981d8b1d988d98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d98420d981d982d8b720d985d982d8a7d8a8d98420d8a7d984d988d982d8aa20d8a7d984d8b0d98a20d98ad8add8aad8a7d8acd988d98620d981d98ad98720d981d8b9d984d98ad98bd8a7d88c20d985d985d8a720d98ad8b3d8a7d8b9d8af20d981d98a20d8aad982d984d98ad98420d8aad983d8a7d984d98ad98120d8a7d984d8a5d982d8a7d985d8a920d8a8d8b4d983d98420d983d8a8d98ad8b12e20d8b3d988d8a7d8a120d983d986d8aa20d8a8d8add8a7d8acd8a920d8a5d984d98920d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d984d984d986d988d98520d8a3d98820d984d984d8aad8acd8afd98ad8af20d8a3d98820d984d984d8aad8add8b6d98ad8b120d984d8b9d8b1d8b620d8aad982d8afd98ad985d98ad88c20d8aad982d8afd98520d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8aed98ad8a7d8b1d98bd8a720d8a3d983d8abd8b120d8a7d982d8aad8b5d8a7d8afd98ad8a920d984d8a3d988d984d8a6d98320d8a7d984d8b0d98ad98620d984d8afd98ad987d98520d985d98ad8b2d8a7d986d98ad8a920d8b6d98ad982d8a920d8a3d98820d8acd8afd988d98420d8b2d985d986d98a20d985d8add985d988d9852e3c2f703e0d0a3c68333e322e203c7374726f6e673ed985d8b1d988d986d8a920d8aad8aad986d8a7d8b3d8a820d985d8b920d8a7d984d8acd8afd8a7d988d98420d8a7d984d8b2d985d986d98ad8a920d8a7d984d985d8b2d8afd8add985d8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed8bad8a7d984d8a8d98bd8a720d985d8a720d98ad8acd8af20d8a7d984d985d8b3d8a7d981d8b1d988d98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d98420d8a3d986d981d8b3d987d98520d981d98a20d985d8afd98620d984d985d8acd8b1d8af20d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d8a3d98820d984d984d98ad984d8a920d988d8a7d8add8afd8a92e20d982d8af20d984d8a720d8aad8aad986d8a7d8b3d8a820d8add8acd988d8b2d8a7d8aa20d8a7d984d981d986d8a7d8afd98220d8a7d984d8aad982d984d98ad8afd98ad8a920d8a7d984d8aad98a20d8aad8aad98520d8a8d8a3d988d982d8a7d8aa20d8aad8b3d8acd98ad98420d8a7d984d988d8b5d988d98420d988d8a7d984d985d8bad8a7d8afd8b1d8a920d8a7d984d8abd8a7d8a8d8aad8a920d985d8b920d8acd8afd8a7d988d984d987d98520d8a7d984d985d8b2d8afd8add985d8a92e20d8aad982d8afd98520d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d985d8b1d988d986d8a920d981d98a20d8a3d988d982d8a7d8aa20d8aad8b3d8acd98ad98420d8a7d984d988d8b5d988d98420d988d8a7d984d985d8bad8a7d8afd8b1d8a9d88c20d985d985d8a720d98ad8b9d986d98a20d8a3d98620d8a7d984d985d8b3d8a7d981d8b1d98ad98620d98ad985d983d986d987d98520d8add8acd8b220d8a5d982d8a7d985d8aad987d98520d8a8d986d8a7d8a1d98b20d8b9d984d98920d8a7d8add8aad98ad8a7d8acd8a7d8aad987d98520d8a7d984d8afd982d98ad982d8a9d88c20d8b3d988d8a7d8a120d983d8a7d986d8aa20d984d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d981d98a20d8a7d984d8b5d8a8d8a7d8ad20d8a3d98820d982d98ad984d988d984d8a920d981d98a20d981d8aad8b1d8a920d985d8a720d8a8d8b9d8af20d8a7d984d8b8d987d8b120d982d8a8d98420d8a7d8acd8aad985d8a7d8b920d985d8aad8a3d8aed8b12e20d8aad8aad98ad8ad20d987d8b0d98720d8a7d984d985d8b1d988d986d8a920d984d984d985d8b3d8a7d981d8b1d98ad98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d98420d8aad8aed8b5d98ad8b520d8a5d982d8a7d985d8aad987d98520d984d8aad986d8a7d8b3d8a820d8a7d8add8aad98ad8a7d8acd8a7d8aa20d8a7d984d8b9d985d984d88c20d985d985d8a720d98ad8acd8b9d984d987d8a720d8aed98ad8a7d8b1d98bd8a720d985d986d8a7d8b3d8a8d98bd8a720d984d984d8bad8a7d98ad8a92e3c2f703e0d0a3c68333e332e203c7374726f6e673ed985d988d982d8b920d985d986d8a7d8b3d8a83c2f7374726f6e673e3c2f68333e0d0a3c703ed8bad8a7d984d8a8d98bd8a720d985d8a720d8aad983d988d98620d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8aad982d8b920d8a8d8a7d984d982d8b1d8a820d985d98620d985d8add8a7d988d8b120d8a7d984d986d982d98420d8a7d984d8b1d8a6d98ad8b3d98ad8a920d988d8a7d984d985d8b7d8a7d8b1d8a7d8aa20d988d8a7d984d985d986d8a7d8b7d98220d8a7d984d8aad8acd8a7d8b1d98ad8a9d88c20d985d985d8a720d98ad8acd8b9d984d987d8a720d8aed98ad8a7d8b1d98bd8a720d985d8abd8a7d984d98ad98bd8a720d984d984d985d8b3d8a7d981d8b1d98ad98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d98420d8a7d984d8b0d98ad98620d98ad8add8aad8a7d8acd988d98620d8a5d984d98920d8a7d984d988d8b5d988d98420d8a7d984d8b3d8b1d98ad8b920d8a5d984d98920d8a7d984d8a7d8acd8aad985d8a7d8b9d8a7d8aa20d8a3d98820d8a7d984d985d8a4d8aad985d8b1d8a7d8aa20d8a3d98820d8a7d984d8b1d8add984d8a7d8aa20d8a7d984d8acd988d98ad8a92e20d98ad982d984d98420d8a7d984d985d988d982d8b920d8a7d984d985d8b1d983d8b2d98a20d985d98620d8a7d984d988d982d8aa20d8a7d984d8b0d98a20d98ad8aad98520d982d8b6d8a7d8a4d98720d981d98a20d8a7d984d8aad986d982d984d88c20d988d987d98820d8a3d985d8b120d8add8a7d8b3d98520d8b9d986d8afd985d8a720d98ad8b9d985d98420d8a7d984d985d8add8aad8b1d981d988d98620d985d8b920d8acd8afd8a7d988d98420d8b2d985d986d98ad8a920d8b6d98ad982d8a92e20d8a5d98620d988d8acd988d8af20d985d983d8a7d98620d985d986d8a7d8b3d8a820d984d984d8a7d8b3d8aad8b1d8aed8a7d8a120d8a3d98820d8a7d984d8aad8add8b6d98ad8b120d984d984d8a7d8acd8aad985d8a7d8b9d8a7d8aa20d98ad985d983d98620d8a3d98620d98ad8b9d8b2d8b220d8a7d984d8a5d986d8aad8a7d8acd98ad8a920d988d98ad982d984d98420d985d98620d8a7d984d8aad988d8aad8b120d8a3d8abd986d8a7d8a120d8a7d984d8b1d8add984d8a920d8a7d984d985d8b2d8afd8add985d8a92e3c2f703e0d0a3c68333e342e203c7374726f6e673ed8a7d984d8aed8b5d988d8b5d98ad8a920d988d8a7d984d8b1d8a7d8add8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed8a3d8abd986d8a7d8a120d8b1d8add984d8a7d8aa20d8a7d984d8b9d985d984d88c20d98ad8b9d8aad8a8d8b120d988d8acd988d8af20d985d8b3d8a7d8add8a920d985d8b1d98ad8add8a920d988d8aed8a7d8b5d8a920d984d984d8a7d8b3d8aad8b1d8aed8a7d8a120d8a3d98820d8a7d984d8b9d985d98420d8a3d985d8b1d98bd8a720d8a3d8b3d8a7d8b3d98ad98bd8a72e20d8aad988d981d8b120d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d981d8b1d8b5d8a920d984d984d987d8b1d988d8a820d985d98620d8b6d8bad988d8b720d8a7d984d8b3d981d8b1d88c20d985d8b920d8aad982d8afd98ad98520d8bad8b1d98120d987d8a7d8afd8a6d8a920d985d8b2d988d8afd8a920d8a8d8a7d984d8b6d8b1d988d8b1d98ad8a7d8aa20d985d8abd98420d8a7d984d8a5d986d8aad8b1d986d8aa20d8a7d984d984d8a7d8b3d984d983d98ad88c20d988d8a7d984d983d8b1d8a7d8b3d98a20d8a7d984d985d8b1d98ad8add8a9d88c20d988d985d8b3d8a7d8add8a7d8aa20d8a7d984d8b9d985d9842e20d8b3d988d8a7d8a120d983d986d8aa20d8a8d8add8a7d8acd8a920d984d8a3d8aed8b020d985d983d8a7d984d985d8a920d8b3d8b1d98ad8b9d8a920d8a3d98820d8aad8b9d8afd98ad98420d8a7d984d8b9d8b1d988d8b620d8a7d984d8aad982d8afd98ad985d98ad8a920d8a3d98820d8a8d8a8d8b3d8a7d8b7d8a920d8a7d984d8a7d8b3d8aad8b1d8aed8a7d8a120d982d8a8d98420d8a7d984d8a7d8acd8aad985d8a7d8b920d8a7d984d8aad8a7d984d98ad88c20d8aad988d981d8b120d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8a8d98ad8a6d8a920d987d8a7d8afd8a6d8a920d988d8aed8a7d8b5d8a920d984d984d985d8add8aad8b1d981d98ad98620d984d8a5d8b9d8a7d8afd8a920d8b4d8add98620d8b7d8a7d982d8aad987d9852e3c2f703e0d0a3c68333e352e203c7374726f6e673ed8a7d984d988d8b5d988d98420d8a5d984d98920d988d8b3d8a7d8a6d98420d8a7d984d8b1d8a7d8add8a920d8a7d984d981d8a7d8aed8b1d8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed8b9d984d98920d8a7d984d8b1d8bad98520d985d98620d983d988d986d987d8a720d8a7d982d8aad8b5d8a7d8afd98ad8a9d88c20d8aad982d8afd98520d8a7d984d8b9d8afd98ad8af20d985d98620d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d988d8b3d8a7d8a6d98420d8b1d8a7d8add8a920d981d8a7d8aed8b1d8a920d985d8abd98420d8a7d984d8a5d986d8aad8b1d986d8aa20d8b9d8a7d984d98a20d8a7d984d8b3d8b1d8b9d8a9d88c20d985d8add8b7d8a7d8aa20d8a7d984d8b9d985d98420d8a7d984d985d8b2d988d8afd8a920d8aad8acd987d98ad8b2d8a7d8aad88c20d988d8bad8b1d98120d8a7d984d8a7d8acd8aad985d8a7d8b9d8a7d8aad88c20d988d985d8b3d8a7d8add8a7d8aa20d8a7d8b3d8aad8b1d8a7d8add8a920d985d8b1d98ad8add8a92e20d8aad8aad98ad8ad20d987d8b0d98720d8a7d984d988d8b3d8a7d8a6d98420d984d984d985d8b3d8a7d981d8b1d98ad98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d98420d8a7d984d8a8d982d8a7d8a120d985d986d8aad8acd98ad98620d8add8aad98920d8a3d8abd986d8a7d8a120d8a7d984d8a5d982d8a7d985d8a920d8a7d984d982d8b5d98ad8b1d8a92e20d983d985d8a720d8a3d98620d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8aad988d981d8b120d982d8a7d8b9d8a7d8aa20d985d8a4d8aad985d8b1d8a7d8aa20d988d985d8b3d8a7d8add8a7d8aa20d984d984d981d8b9d8a7d984d98ad8a7d8aa20d98ad985d983d98620d8a7d8b3d8aad8a6d8acd8a7d8b1d987d8a720d8a8d8a7d984d8b3d8a7d8b9d8a9d88c20d988d987d98820d985d8a720d98ad985d983d98620d8a3d98620d98ad983d988d98620d985d981d98ad8afd98bd8a720d984d984d8bad8a7d98ad8a920d984d8a7d8b3d8aad8b6d8a7d981d8a920d8a7d8acd8aad985d8a7d8b9d8a7d8aa20d8b5d8bad98ad8b1d8a920d8a3d98820d8acd984d8b3d8a7d8aa20d8b9d8b5d98120d8b0d987d986d98a20d8afd988d98620d8a7d984d8add8a7d8acd8a920d984d8add8acd8b220d983d8a7d985d98420d8a7d984d98ad988d9852e3c2f703e0d0a3c68333ed8a7d984d8aed8a7d8aad985d8a93c2f68333e0d0a3c703ed8aad988d981d8b120d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d984d984d985d8b3d8a7d981d8b1d98ad98620d985d98620d8b1d8acd8a7d98420d8a7d984d8a3d8b9d985d8a7d98420d8a7d984d985d8b1d988d986d8a920d988d8a7d984d8b1d8a7d8add8a920d988d8a7d984d982d8afd8b1d8a920d8b9d984d98920d8aad8add985d98420d8a7d984d8aad983d8a7d984d98ad98120d8a7d984d8aad98a20d98ad8add8aad8a7d8acd988d986d987d8a720d984d984d8a7d8b3d8aad981d8a7d8afd8a920d8a7d984d982d8b5d988d98920d985d98620d988d982d8aad987d98520d8a3d8abd986d8a7d8a120d8a7d984d8aad986d982d9842e20d8b3d988d8a7d8a120d983d986d8aa20d981d98a20d8aad988d982d98120d8b3d8b1d98ad8b9d88c20d8a3d98820d8a8d98ad98620d8a7d984d8a7d8acd8aad985d8a7d8b9d8a7d8aad88c20d8a3d98820d8a8d8add8a7d8acd8a920d981d982d8b720d8a5d984d98920d985d983d8a7d98620d984d984d8a7d8b3d8aad8acd985d8a7d985d88c20d8aad982d8afd98520d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8add984d8a7d98b20d985d8aed8b5d8b5d98bd8a720d98ad8afd8b9d98520d8a7d984d8a5d986d8aad8a7d8acd98ad8a920d988d8a7d984d8b1d8a7d8add8a92e20d985d8b920d8a7d8b3d8aad985d8b1d8a7d8b120d8aad8b7d988d8b120d8a7d984d8b3d981d8b120d984d984d8a3d8b9d985d8a7d984d88c20d8aad8abd8a8d8aa20d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8a3d986d987d8a720d985d8b5d8afd8b120d982d98ad98520d984d984d985d8add8aad8b1d981d98ad98620d8a7d984d8b0d98ad98620d98ad8add8aad8a7d8acd988d98620d8a5d984d98920d8b7d8b1d98ad982d8a920d8b0d983d98ad8a920d988d981d8b9d991d8a7d984d8a920d984d8add8acd8b220d8a7d984d8a5d982d8a7d9853c2f703e, NULL, NULL, '2024-12-03 02:09:30', '2024-12-03 02:09:30'),
(66, 20, 42, 35, 'Tips for Booking Last-Minute Stays', 'tips-for-booking-last-minute-stays', 'Admin', 0x3c703e426f6f6b696e67206120686f74656c20617420746865206c617374206d696e7574652063616e207365656d206c696b6520612073747265737366756c20657870657269656e63652c2062757420697420646f65736e2774206861766520746f2062652e205768657468657220796f75277265206120627573696e6573732074726176656c65722c20612073706f6e74616e656f757320616476656e74757265722c206f7220696e206e656564206f6620612073686f7274206573636170652c20746865726520617265207365766572616c207374726174656769657320796f752063616e2075736520746f20656e73757265207468617420796f7520676574207468652062657374206465616c20616e64206120636f6d666f727461626c6520737461792e20486572652061726520736f6d652068656c7066756c207469707320666f7220626f6f6b696e67206c6173742d6d696e75746520686f74656c2073746179732c20657370656369616c6c7920666f7220686f75726c7920686f74656c20626f6f6b696e67732e3c2f703e0d0a3c68333e312e203c7374726f6e673e557365204c6173742d4d696e75746520426f6f6b696e6720417070733c2f7374726f6e673e3c2f68333e0d0a3c703e4f6e65206f6620746865206d6f737420636f6e76656e69656e74207761797320746f20626f6f6b2061206c6173742d6d696e7574652073746179206973207468726f7567682061707073206f72207765627369746573207370656369666963616c6c792064657369676e656420666f722073706f6e74616e656f757320626f6f6b696e67732e20506c6174666f726d73206c696b6520486f74656c546f6e696768742c20426f6f6b696e672e636f6d2c20616e642045787065646961206f66666572206772656174206465616c7320666f722074686f73652077686f206e656564206120726f6f6d20717569636b6c792e20546865736520706c6174666f726d73206f6674656e2068617665207370656369616c20726174657320666f72206c6173742d6d696e7574652073746179732c20616c6c6f77696e6720796f7520746f2066696e6420646973636f756e74656420707269636573206f6e207175616c69747920726f6f6d732e204d616b65207375726520746f20646f776e6c6f6164207468652061707020696e20616476616e636520616e64207369676e20757020666f72206e6f74696669636174696f6e732c20736f20796f752063616e2074616b6520616476616e74616765206f6620666c617368206465616c7320616e6420646973636f756e74732e3c2f703e0d0a3c68333e322e203c7374726f6e673e436f6e736964657220486f75726c7920486f74656c733c2f7374726f6e673e3c2f68333e0d0a3c703e486f75726c7920686f74656c7320617265207065726665637420666f72206c6173742d6d696e757465207374617973207768656e20796f75206f6e6c79206e656564206120726f6f6d20666f7220612073686f727420706572696f642e205768657468657220796f75206e656564206120706c61636520746f207265737420666f7220612066657720686f757273206265747765656e206d656574696e6773206f7220796f75277265206c6f6f6b696e6720666f72206120717569636b206765746177617920776974686f757420636f6d6d697474696e6720746f20616e206f7665726e6967687420737461792c20686f75726c7920686f74656c732063616e206f66666572206120677265617420736f6c7574696f6e2e204d616e7920686f74656c73206f6666657220666c657869626c6520626f6f6b696e67206f7074696f6e732c20616c6c6f77696e6720796f7520746f20706179206f6e6c7920666f722074686520686f75727320796f75206e6565642e2054686973206973206e6f74206f6e6c7920636f73742d6566666563746976652062757420616c736f20696465616c20666f722074686f7365207769746820756e7072656469637461626c652074726176656c207363686564756c65732e3c2f703e0d0a3c68333e332e203c7374726f6e673e436865636b20666f7220466c657869626c652043616e63656c6c6174696f6e20506f6c69636965733c2f7374726f6e673e3c2f68333e0d0a3c703e5768656e20626f6f6b696e672061206c6173742d6d696e75746520686f74656c20737461792c206c6f6f6b20666f722070726f70657274696573207769746820666c657869626c652063616e63656c6c6174696f6e20706f6c69636965732e204d616e7920686f74656c7320616e6420626f6f6b696e6720706c6174666f726d73206e6f77206f6666657220667265652063616e63656c6c6174696f6e20757020746f2061206365727461696e20706f696e742c2077686963682063616e206769766520796f75207065616365206f66206d696e6420696e206361736520796f757220706c616e73206368616e676520617420746865206c617374206d696e7574652e20466c657869626c652063616e63656c6c6174696f6e20706f6c69636965732061726520706172746963756c61726c792062656e6566696369616c20666f722074686f73652077686f206861766520756e6365727461696e2074726176656c206461746573206f72206e65656420746f206368616e676520746865697220706c616e732064756520746f20756e666f72657365656e2063697263756d7374616e6365732e3c2f703e0d0a3c68333e342e203c7374726f6e673e426520466c657869626c65207769746820596f757220526f6f6d2043686f6963653c2f7374726f6e673e3c2f68333e0d0a3c703e5768656e20626f6f6b696e67206c6173742d6d696e7574652c20666c65786962696c6974792063616e2068656c7020796f752066696e64207468652062657374206465616c732e20496620796f75277265206e6f74207069636b792061626f757420726f6f6d2074797065732c20796f75206d61792062652061626c6520746f207365637572652061206c6173742d6d696e75746520646973636f756e74206f6e206120726f6f6d207468617420776f756c64206f746865727769736520626520756e617661696c61626c652e20536f6d6520686f74656c73206d6179206f66666572207468656972206265737420726f6f6d7320617420646973636f756e74656420726174657320696e20616e20617474656d707420746f2066696c6c20757020656d70747920726f6f6d732e20436f6e736964657220626f6f6b696e672061207374616e6461726420726f6f6d206f72206120726f6f6d207769746820666577657220616d656e697469657320696620796f75277265206c6f6f6b696e6720746f2073617665206d6f6e65792e3c2f703e0d0a3c68333e352e203c7374726f6e673e43616c6c2074686520486f74656c204469726563746c793c2f7374726f6e673e3c2f68333e0d0a3c703e496620796f752066696e64206120686f74656c207468617420737569747320796f7572206e65656473206f6e6c696e652c20646f6ee280997420686573697461746520746f2063616c6c2074686520686f74656c206469726563746c7920746f20696e71756972652061626f757420616e79206c6173742d6d696e757465206465616c73206f7220617661696c6162696c6974792e20486f74656c207374616666206d61792062652061626c6520746f206f6666657220646973636f756e7473206f72207370656369616c207061636b61676573207468617420617265206e6f7420617661696c61626c65207468726f7567682074686972642d706172747920626f6f6b696e672073697465732e2054686579206d6967687420616c736f206f66666572207570677261646573206f72206f74686572207065726b7320696620796f7520626f6f6b206469726563746c792077697468207468656d2c20617320746865792061766f696420636f6d6d697373696f6e20666565732066726f6d20626f6f6b696e6720706c6174666f726d732e3c2f703e0d0a3c68333e362e203c7374726f6e673e436865636b20666f72204c6f63616c204465616c7320616e642050726f6d6f74696f6e733c2f7374726f6e673e3c2f68333e0d0a3c703e4c6173742d6d696e75746520626f6f6b696e6720736974657320616e642061707073206172652067726561742c2062757420646f6ee280997420666f7267657420746f20636865636b20666f72206c6f63616c206465616c73206f722070726f6d6f74696f6e732e20536f6d6520686f74656c73206f66666572206578636c757369766520646973636f756e747320746f2070656f706c6520696e207468652061726561206f7220666f72207370656369666963207479706573206f662073746179732c207375636820617320627573696e657373207472697073206f722073686f7274207669736974732e204c6f63616c2070726f6d6f74696f6e73206d69676874206e6f742062652061647665727469736564206f6e6c696e652c20736f206974e280997320776f7274682061736b696e672074686520686f74656c2073746166662061626f757420616e79206f6e676f696e67206465616c732e3c2f703e0d0a3c68333e372e203c7374726f6e673e506c616e20416865616420666f7220746865204675747572653c2f7374726f6e673e3c2f68333e0d0a3c703e416c74686f75676820746869732061727469636c6520666f6375736573206f6e206c6173742d6d696e75746520626f6f6b696e67732c20696620796f75206672657175656e746c79206e65656420746f20626f6f6b206c6173742d6d696e7574652073746179732c20636f6e736964657220706c616e6e696e6720616865616420666f72206675747572652074726970732e205369676e696e6720757020666f72206c6f79616c74792070726f6772616d73206f7220626f6f6b696e6720696e20616476616e63652063616e2068656c7020796f752073617665206d6f6e657920616e642073656375726520626574746572206465616c7320696e20746865206c6f6e672072756e2e3c2f703e0d0a3c703e496e20636f6e636c7573696f6e2c20626f6f6b696e672061206c6173742d6d696e757465207374617920646f65736ee2809974206861766520746f206265206f7665727768656c6d696e672e20576974682074686520726967687420746f6f6c732c2061206c6974746c6520666c65786962696c6974792c20616e64206120626974206f662073747261746567696320706c616e6e696e672c20796f752063616e2066696e64206166666f726461626c6520616e6420636f6e76656e69656e74206163636f6d6d6f646174696f6e732c206576656e207768656e2074696d65206973206f662074686520657373656e63652e3c2f703e, NULL, NULL, '2024-12-03 02:12:43', '2024-12-03 02:12:43');
INSERT INTO `blog_informations` (`id`, `language_id`, `blog_category_id`, `blog_id`, `title`, `slug`, `author`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(67, 21, 51, 35, 'نصائح لحجز إقامات اللحظة الأخيرة', 'نصائح-لحجز-إقامات-اللحظة-الأخيرة', 'مسؤل', 0x3c703ed982d8af20d98ad8a8d8afd98820d8add8acd8b220d981d986d8afd98220d981d98a20d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a920d8aad8acd8b1d8a8d8a920d985d8b1d987d982d8a9d88c20d984d983d98620d984d8a720d98ad8acd8a820d8a3d98620d98ad983d988d98620d8a7d984d8a3d985d8b120d983d8b0d984d9832e20d8b3d988d8a7d8a120d983d986d8aa20d985d8b3d8a7d981d8b1d98bd8a720d984d984d8b9d985d98420d8a3d98820d985d8bad8a7d985d8b1d98bd8a720d8b9d981d988d98ad98bd8a720d8a3d98820d8a8d8add8a7d8acd8a920d8a5d984d98920d8a7d8b3d8aad8b1d8a7d8add8a920d982d8b5d98ad8b1d8a9d88c20d987d986d8a7d98320d8b9d8afd8a920d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad8a7d8aa20d98ad985d983d986d98320d8a7d8b3d8aad8aed8afd8a7d985d987d8a720d984d8b6d985d8a7d98620d8a7d984d8add8b5d988d98420d8b9d984d98920d8a3d981d8b6d98420d8b5d981d982d8a920d988d8a5d982d8a7d985d8a920d985d8b1d98ad8add8a92e20d8a5d984d98ad98320d8a8d8b9d8b620d8a7d984d986d8b5d8a7d8a6d8ad20d8a7d984d985d981d98ad8afd8a920d984d8add8acd8b220d8a7d984d8a5d982d8a7d985d8a7d8aa20d981d98a20d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a9d88c20d8aed8a7d8b5d8a920d8b9d986d8af20d8add8acd8b220d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a92e3c2f703e0d0a3c68333e312e203c7374726f6e673ed8a7d8b3d8aad8aed8afd8a7d98520d8aad8b7d8a8d98ad982d8a7d8aa20d8a7d984d8add8acd8b220d8a7d984d984d8add8b8d98a3c2f7374726f6e673e3c2f68333e0d0a3c703ed8a5d8add8afd98920d8a3d8b3d987d98420d8a7d984d8b7d8b1d98220d984d8add8acd8b220d8a5d982d8a7d985d8a920d981d98a20d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a920d987d98a20d985d98620d8aed984d8a7d98420d8a7d984d8aad8b7d8a8d98ad982d8a7d8aa20d8a3d98820d8a7d984d985d988d8a7d982d8b920d8a7d984d8aad98a20d8aad98520d8aad8b5d985d98ad985d987d8a720d8aed8b5d98ad8b5d98bd8a720d984d984d8add8acd988d8b2d8a7d8aa20d8a7d984d8b9d981d988d98ad8a92e20d985d986d8b5d8a7d8aa20d985d8abd98420486f74656c546f6e6967687420d988426f6f6b696e672e636f6d20d9884578706564696120d8aad982d8afd98520d8b9d8b1d988d8b620d8b1d8a7d8a6d8b9d8a920d984d8a3d988d984d8a6d98320d8a7d984d8b0d98ad98620d98ad8add8aad8a7d8acd988d98620d8a5d984d98920d8bad8b1d981d8a920d8a8d8b3d8b1d8b9d8a92e20d987d8b0d98720d8a7d984d985d986d8b5d8a7d8aa20d8bad8a7d984d8a8d98bd8a720d985d8a720d8aad988d981d8b120d8a3d8b3d8b9d8a7d8b1d98bd8a720d8aed8a7d8b5d8a920d984d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d984d8add8b8d98ad8a9d88c20d985d985d8a720d98ad8b3d985d8ad20d984d98320d8a8d8a7d984d8b9d8abd988d8b120d8b9d984d98920d8a3d8b3d8b9d8a7d8b120d985d8aed981d8b6d8a920d984d8bad8b1d98120d8b0d8a7d8aa20d8acd988d8afd8a920d8b9d8a7d984d98ad8a92e20d8aad8a3d983d8af20d985d98620d8aad8add985d98ad98420d8a7d984d8aad8b7d8a8d98ad98220d985d8b3d8a8d982d98bd8a720d988d8a7d984d8aad8b3d8acd98ad98420d984d984d8add8b5d988d98420d8b9d984d98920d8a5d8b4d8b9d8a7d8b1d8a7d8aad88c20d8add8aad98920d8aad8aad985d983d98620d985d98620d8a7d984d8a7d8b3d8aad981d8a7d8afd8a920d985d98620d8a7d984d8b9d8b1d988d8b620d8a7d984d981d984d8a7d8b420d988d8a7d984d8aed8b5d988d985d8a7d8aa2e3c2f703e0d0a3c68333e322e203c7374726f6e673ed981d983d8b120d981d98a20d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d987d98a20d8a7d984d8aed98ad8a7d8b120d8a7d984d985d8abd8a7d984d98a20d984d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d984d8add8b8d98ad8a920d8b9d986d8afd985d8a720d8aad8add8aad8a7d8ac20d981d982d8b720d8a5d984d98920d8bad8b1d981d8a920d984d981d8aad8b1d8a920d982d8b5d98ad8b1d8a92e20d8b3d988d8a7d8a120d983d986d8aa20d8a8d8add8a7d8acd8a920d8a5d984d98920d985d983d8a7d98620d984d984d8b1d8a7d8add8a920d984d8a8d8b6d8b920d8b3d8a7d8b9d8a7d8aa20d8a8d98ad98620d8a7d984d8a7d8acd8aad985d8a7d8b9d8a7d8aa20d8a3d98820d8aad8a8d8add8ab20d8b9d98620d8a7d8b3d8aad8b1d8a7d8add8a920d8b3d8b1d98ad8b9d8a920d8afd988d98620d8a7d984d8add8a7d8acd8a920d8a5d984d98920d8a7d984d8a5d982d8a7d985d8a920d8b7d988d8a7d98420d8a7d984d984d98ad984d88c20d98ad985d983d98620d8a3d98620d8aad988d981d8b120d984d98320d8a7d984d981d986d8a7d8afd98220d8a8d8a7d984d8b3d8a7d8b9d8a920d8add984d8a7d98b20d985d985d8aad8a7d8b2d98bd8a72e20d8aad982d8afd98520d8a7d984d8b9d8afd98ad8af20d985d98620d8a7d984d981d986d8a7d8afd98220d8aed98ad8a7d8b1d8a7d8aa20d8add8acd8b220d985d8b1d986d8a9d88c20d985d985d8a720d98ad8b3d985d8ad20d984d98320d8a8d8afd981d8b920d981d982d8b720d985d982d8a7d8a8d98420d8a7d984d8b3d8a7d8b9d8a7d8aa20d8a7d984d8aad98a20d8aad8add8aad8a7d8acd987d8a72e20d987d8b0d8a720d984d98ad8b320d981d982d8b720d985d8b1d98ad8add98bd8a720d985d98620d8a7d984d986d8a7d8add98ad8a920d8a7d984d8a7d982d8aad8b5d8a7d8afd98ad8a9d88c20d8a8d98420d987d98820d8a3d98ad8b6d98bd8a720d985d8abd8a7d984d98a20d984d8a3d988d984d8a6d98320d8a7d984d8b0d98ad98620d984d8afd98ad987d98520d8acd8afd8a7d988d98420d8b3d981d8b120d8bad98ad8b120d982d8a7d8a8d984d8a920d984d984d8aad986d8a8d8a42e3c2f703e0d0a3c68333e332e203c7374726f6e673ed8aad8add982d98220d985d98620d8a7d984d8b3d98ad8a7d8b3d8a7d8aa20d8a7d984d985d8b1d986d8a920d984d984d8a5d984d8bad8a7d8a13c2f7374726f6e673e3c2f68333e0d0a3c703ed8b9d986d8af20d8add8acd8b220d8a5d982d8a7d985d8a920d981d98a20d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a9d88c20d8a7d8a8d8add8ab20d8b9d98620d981d986d8a7d8afd98220d8aad982d8afd98520d8b3d98ad8a7d8b3d8a7d8aa20d8a5d984d8bad8a7d8a120d985d8b1d986d8a92e20d8a7d984d8b9d8afd98ad8af20d985d98620d8a7d984d981d986d8a7d8afd98220d988d985d986d8b5d8a7d8aa20d8a7d984d8add8acd8b220d8a7d984d8a2d98620d8aad982d8afd98520d8a5d984d8bad8a7d8a120d985d8acd8a7d986d98a20d8add8aad98920d986d982d8b7d8a920d985d8b9d98ad986d8a9d88c20d985d985d8a720d98ad985d986d8add98320d8b1d8a7d8add8a920d8a7d984d8a8d8a7d98420d981d98a20d8add8a7d98420d8aad8bad98ad8b1d8aa20d8aed8b7d8b7d98320d981d98a20d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a92e20d8aad8b9d8aad8a8d8b120d8a7d984d8b3d98ad8a7d8b3d8a7d8aa20d8a7d984d985d8b1d986d8a920d984d984d8a5d984d8bad8a7d8a120d985d981d98ad8afd8a920d8a8d8b4d983d98420d8aed8a7d8b520d984d8a3d988d984d8a6d98320d8a7d984d8b0d98ad98620d984d8afd98ad987d98520d8aad988d8a7d8b1d98ad8ae20d8b3d981d8b120d8bad98ad8b120d8abd8a7d8a8d8aad8a920d8a3d98820d98ad8add8aad8a7d8acd988d98620d8a5d984d98920d8aad8bad98ad98ad8b120d8aed8b7d8b7d987d98520d8a8d8b3d8a8d8a820d8b8d8b1d988d98120d8bad98ad8b120d985d8aad988d982d8b9d8a92e3c2f703e0d0a3c68333e342e203c7374726f6e673ed983d98620d985d8b1d986d98bd8a720d985d8b920d8a7d8aed8aad98ad8a7d8b120d8a7d984d8bad8b1d9813c2f7374726f6e673e3c2f68333e0d0a3c703ed8b9d986d8af20d8a7d984d8add8acd8b220d981d98a20d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a9d88c20d98ad985d983d98620d8a3d98620d8aad8b3d8a7d8b9d8afd98320d8a7d984d985d8b1d988d986d8a920d981d98a20d8a7d984d8b9d8abd988d8b120d8b9d984d98920d8a3d981d8b6d98420d8a7d984d8b9d8b1d988d8b62e20d8a5d8b0d8a720d984d98520d8aad983d98620d985d981d8b1d8b7d98bd8a720d981d98a20d8a7d8aed8aad98ad8a7d8b120d986d988d8b920d8a7d984d8bad8b1d981d8a9d88c20d98ad985d983d986d98320d8a3d98620d8aad8aad985d983d98620d985d98620d8aad8a3d985d98ad98620d8aed8b5d98520d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a920d8b9d984d98920d8bad8b1d981d8a920d983d8a7d986d8aa20d8b3d8aad8b8d98420d8bad98ad8b120d985d8aad8a7d8add8a92e20d982d8af20d8aad8b9d8b1d8b620d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d8a3d981d8b6d98420d8bad8b1d981d987d8a720d8a8d8a3d8b3d8b9d8a7d8b120d985d8aed981d8b6d8a920d981d98a20d985d8add8a7d988d984d8a920d984d985d984d8a120d8a7d984d8bad8b1d98120d8a7d984d981d8a7d8b1d8bad8a92e20d981d983d8b120d981d98a20d8add8acd8b220d8bad8b1d981d8a920d8b9d8a7d8afd98ad8a920d8a3d98820d8bad8b1d981d8a920d8aad8add8aad988d98a20d8b9d984d98920d8b9d8afd8af20d8a3d982d98420d985d98620d988d8b3d8a7d8a6d98420d8a7d984d8b1d8a7d8add8a920d8a5d8b0d8a720d983d986d8aa20d8aad8b1d8bad8a820d981d98a20d8aad988d981d98ad8b120d8a7d984d985d8a7d9842e3c2f703e0d0a3c68333e352e203c7374726f6e673ed8a7d8aad8b5d98420d8a8d8a7d984d981d986d8afd98220d985d8a8d8a7d8b4d8b1d8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed8a5d8b0d8a720d988d8acd8afd8aa20d981d986d8afd982d98bd8a720d98ad986d8a7d8b3d8a820d8a7d8add8aad98ad8a7d8acd8a7d8aad98320d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aad88c20d984d8a720d8aad8aad8b1d8afd8af20d981d98a20d8a7d984d8a7d8aad8b5d8a7d98420d8a8d8a7d984d981d986d8afd98220d985d8a8d8a7d8b4d8b1d8a920d984d984d8a7d8b3d8aad981d8b3d8a7d8b120d8b9d98620d8a3d98a20d8b5d981d982d8a7d8aa20d8a3d98820d8aad988d8a7d981d8b120d984d984d8a5d982d8a7d985d8a7d8aa20d8a7d984d984d8add8b8d98ad8a92e20d982d8af20d98ad8aad985d983d98620d985d988d8b8d981d98820d8a7d984d981d986d8afd98220d985d98620d8aad982d8afd98ad98520d8aed8b5d988d985d8a7d8aa20d8a3d98820d8b9d8b1d988d8b620d8aed8a7d8b5d8a920d8bad98ad8b120d985d8aad8a7d8add8a920d8b9d8a8d8b120d985d988d8a7d982d8b920d8a7d984d8add8acd8b220d8a7d984d8aed8a7d8b1d8acd98ad8a92e20d982d8af20d98ad8b9d8b1d8b6d988d98620d8a3d98ad8b6d98bd8a720d8aad8b1d982d98ad8a7d8aa20d8a3d98820d985d8b2d8a7d98ad8a720d8a3d8aed8b1d98920d8a5d8b0d8a720d982d985d8aa20d8a8d8a7d984d8add8acd8b220d985d8b9d987d98520d985d8a8d8a7d8b4d8b1d8a9d88c20d8add98ad8ab20d98ad8aad8acd986d8a8d988d98620d8b1d8b3d988d98520d8a7d984d8b9d985d988d984d8a7d8aa20d985d98620d985d986d8b5d8a7d8aa20d8a7d984d8add8acd8b22e3c2f703e0d0a3c68333e362e203c7374726f6e673ed8aad8add982d98220d985d98620d8a7d984d8b9d8b1d988d8b620d8a7d984d985d8add984d98ad8a920d988d8a7d984d8aed8b5d988d985d8a7d8aa3c2f7374726f6e673e3c2f68333e0d0a3c703ed985d986d8b5d8a7d8aa20d8a7d984d8add8acd8b220d8a7d984d984d8add8b8d98ad8a920d988d8a7d984d8aad8b7d8a8d98ad982d8a7d8aa20d8b1d8a7d8a6d8b9d8a9d88c20d984d983d98620d984d8a720d8aad986d8b3d98e20d8a7d984d8aad8add982d98220d985d98620d8a7d984d8b9d8b1d988d8b620d8a3d98820d8a7d984d8aed8b5d988d985d8a7d8aa20d8a7d984d985d8add984d98ad8a92e20d8aad982d8afd98520d8a8d8b9d8b620d8a7d984d981d986d8a7d8afd98220d8aed8b5d988d985d8a7d8aa20d8add8b5d8b1d98ad8a920d984d984d8a3d8b4d8aed8a7d8b520d981d98a20d8a7d984d985d986d8b7d982d8a920d8a3d98820d984d8a3d986d988d8a7d8b920d985d8b9d98ad986d8a920d985d98620d8a7d984d8a5d982d8a7d985d8a7d8aad88c20d985d8abd98420d8b1d8add984d8a7d8aa20d8a7d984d8b9d985d98420d8a3d98820d8a7d984d8b2d98ad8a7d8b1d8a7d8aa20d8a7d984d982d8b5d98ad8b1d8a92e20d982d8af20d984d8a720d98ad8aad98520d8a7d984d8a5d8b9d984d8a7d98620d8b9d98620d8a7d984d8b9d8b1d988d8b620d8a7d984d985d8add984d98ad8a920d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aad88c20d984d8b0d8a720d985d98620d8a7d984d985d981d98ad8af20d8a3d98620d8aad8b3d8a3d98420d985d988d8b8d981d98a20d8a7d984d981d986d8afd98220d8b9d98620d8a3d98a20d8b9d8b1d988d8b620d8acd8a7d8b1d98ad8a92e3c2f703e0d0a3c68333e372e203c7374726f6e673ed8aed8b7d8b720d984d984d985d8b3d8aad982d8a8d9843c2f7374726f6e673e3c2f68333e0d0a3c703ed8b9d984d98920d8a7d984d8b1d8bad98520d985d98620d8a3d98620d987d8b0d8a720d8a7d984d985d982d8a7d98420d98ad8b1d983d8b220d8b9d984d98920d8a7d984d8add8acd988d8b2d8a7d8aa20d8a7d984d984d8add8b8d98ad8a9d88c20d8a5d8b0d8a720d983d986d8aa20d8a8d8add8a7d8acd8a920d8a5d984d98920d8add8acd8b220d8a5d982d8a7d985d8a7d8aa20d981d98a20d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a920d8a8d8b4d983d98420d985d8aad983d8b1d8b1d88c20d981d983d8b120d981d98a20d8a7d984d8aad8aed8b7d98ad8b720d8a7d984d985d8b3d8a8d98220d984d8b1d8add984d8a7d8aad98320d8a7d984d985d8b3d8aad982d8a8d984d98ad8a92e20d8a7d984d8a7d8b4d8aad8b1d8a7d98320d981d98a20d8a8d8b1d8a7d985d8ac20d8a7d984d988d984d8a7d8a120d8a3d98820d8a7d984d8add8acd8b220d985d8b3d8a8d982d98bd8a720d98ad985d983d98620d8a3d98620d98ad8b3d8a7d8b9d8afd98320d981d98a20d8aad988d981d98ad8b120d8a7d984d985d8a7d98420d988d8a7d984d8add8b5d988d98420d8b9d984d98920d8b5d981d982d8a7d8aa20d8a3d981d8b6d98420d8b9d984d98920d8a7d984d985d8afd98920d8a7d984d8b7d988d98ad9842e3c2f703e0d0a3c703ed981d98a20d8a7d984d8aed8aad8a7d985d88c20d984d8a720d98ad8acd8a820d8a3d98620d98ad983d988d98620d8add8acd8b220d8a7d984d8a5d982d8a7d985d8a920d981d98a20d8a7d984d984d8add8b8d8a920d8a7d984d8a3d8aed98ad8b1d8a920d8a3d985d8b1d98bd8a720d985d8b1d987d982d98bd8a72e20d8a8d8a7d8b3d8aad8aed8afd8a7d98520d8a7d984d8a3d8afd988d8a7d8aa20d8a7d984d8b5d8add98ad8add8a9d88c20d988d985d8b1d988d986d8a920d8a8d8b3d98ad8b7d8a9d88c20d988d8a8d8b9d8b620d8a7d984d8aad8aed8b7d98ad8b720d8a7d984d8a7d8b3d8aad8b1d8a7d8aad98ad8acd98ad88c20d98ad985d983d986d98320d8a7d984d8b9d8abd988d8b120d8b9d984d98920d8a3d985d8a7d983d98620d8a5d982d8a7d985d8a920d985d8b1d98ad8add8a920d988d8a8d8a3d8b3d8b9d8a7d8b120d985d8b9d982d988d984d8a920d8add8aad98920d8b9d986d8afd985d8a720d98ad983d988d98620d8a7d984d988d982d8aa20d8b6d98ad982d98bd8a73c2f703e, NULL, NULL, '2024-12-03 02:12:43', '2024-12-03 02:12:43');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint UNSIGNED NOT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `membership_id` int DEFAULT NULL,
  `adult` int DEFAULT NULL,
  `children` int DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_in_time` time DEFAULT NULL,
  `check_in_date_time` datetime DEFAULT NULL,
  `hour` int DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `check_out_time` time DEFAULT NULL,
  `preparation_time` bigint DEFAULT NULL,
  `next_booking_time` time DEFAULT NULL,
  `check_out_date_time` datetime DEFAULT NULL,
  `booking_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `booking_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `service_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `roomPrice` double DEFAULT NULL,
  `serviceCharge` double DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `discount` decimal(8,2) DEFAULT NULL,
  `tax` decimal(8,2) DEFAULT NULL,
  `grand_total` decimal(8,2) DEFAULT NULL,
  `currency_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_text_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_symbol_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conversation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `booking_hours`
--

CREATE TABLE `booking_hours` (
  `id` bigint UNSIGNED NOT NULL,
  `hour` bigint DEFAULT NULL,
  `serial_number` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking_hours`
--

INSERT INTO `booking_hours` (`id`, `hour`, `serial_number`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2024-12-02 02:32:02', '2024-12-02 02:32:02'),
(2, 6, 2, '2024-12-02 02:32:10', '2024-12-02 02:32:10'),
(3, 9, 3, '2024-12-02 02:32:24', '2024-12-02 02:32:24'),
(4, 12, 4, '2024-12-02 02:32:37', '2024-12-02 02:32:37');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `country_id` bigint DEFAULT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `language_id`, `country_id`, `feature_image`, `state_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 20, 4, '674ea7298bfdb.jpg', 4, 'Melbourne', '2024-11-30 23:30:29', '2024-12-03 00:37:29'),
(2, 20, 3, '674ea6f8a88ef.jpg', 3, 'Guntur', '2024-11-30 23:30:53', '2025-01-02 01:14:13'),
(3, 20, 2, '674ea6ee08213.jpg', NULL, 'Cox\'s Bazar', '2024-11-30 23:31:12', '2024-12-03 00:36:30'),
(4, 20, 2, '674ea6e59837c.jpg', NULL, 'Chittagong', '2024-11-30 23:31:41', '2025-01-03 21:05:14'),
(5, 20, 1, '674ea6dab4919.jpg', 2, 'Irvine', '2024-11-30 23:31:59', '2025-01-02 01:07:51'),
(6, 20, 1, '674ea6bea532d.jpg', 1, 'Jacksonville', '2024-11-30 23:32:31', '2024-12-03 00:35:42'),
(7, 20, 2, '674ea61e5f1f0.jpg', NULL, 'Dhaka', '2024-11-30 23:32:56', '2024-12-03 00:33:02'),
(8, 20, 1, '674ea5c3b47e0.jpg', 2, 'Diego', '2024-11-30 23:33:16', '2024-12-03 00:31:31'),
(9, 21, 8, '674ea8420cb9d.jpg', 8, 'ملبورن', '2024-11-30 23:30:29', '2025-01-03 21:07:09'),
(10, 21, 7, '674ea816c79e0.jpg', 7, 'جونتور', '2024-11-30 23:30:53', '2025-01-03 21:06:42'),
(11, 21, 6, '674ea7f89deb7.jpg', NULL, 'كوكس بازار', '2024-11-30 23:31:12', '2025-01-03 21:06:09'),
(12, 21, 6, '674ea7e9e8f88.jpg', NULL, 'شيتاغونغ', '2024-11-30 23:31:41', '2025-01-03 21:05:40'),
(13, 21, 5, '674ea7debf9b5.jpg', 6, 'ايرفين', '2024-11-30 23:31:59', '2025-01-03 20:57:21'),
(14, 21, 5, '674ea7cf4b190.jpg', 5, 'جاكسونفيل', '2024-11-30 23:32:31', '2025-01-03 20:57:07'),
(15, 21, 6, '674ea7c0b6e33.jpg', NULL, 'دكا', '2024-11-30 23:32:56', '2025-01-03 20:56:53'),
(16, 21, 5, '674ea7a05b718.jpg', 6, 'دييغو', '2024-11-30 23:33:16', '2025-01-03 20:56:33'),
(17, 20, 3, '674ea5bc2e0ec.jpg', 9, 'Kolkata', '2024-12-01 23:20:14', '2024-12-03 00:31:24'),
(18, 21, 7, '674ea7977728e.jpg', 10, 'كولكاتا', '2024-12-01 23:20:31', '2025-01-03 20:55:55');

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int DEFAULT NULL,
  `type` tinyint DEFAULT NULL COMMENT '1=user, 2=admin, 3=vendor',
  `support_ticket_id` int DEFAULT NULL,
  `reply` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `cookie_alerts`
--

CREATE TABLE `cookie_alerts` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `cookie_alert_status` tinyint UNSIGNED NOT NULL,
  `cookie_alert_btn_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cookie_alert_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `cookie_alerts`
--

INSERT INTO `cookie_alerts` (`id`, `language_id`, `cookie_alert_status`, `cookie_alert_btn_text`, `cookie_alert_text`, `created_at`, `updated_at`) VALUES
(3, 20, 0, 'I Agree', 'We use cookies to give you the best online experience.\r\nBy continuing to browse the site you are agreeing to our use of cookies.', '2023-08-29 02:35:44', '2024-01-31 21:05:04'),
(4, 21, 0, 'أنا موافق', 'نحن نستخدم ملفات تعريف الارتباط لنمنحك أفضل تجربة عبر الإنترنت. من خلال الاستمرار في تصفح الموقع فإنك توافق على استخدامنا لملفات تعريف الارتباط.', '2023-08-29 02:36:53', '2024-02-07 01:00:30');

-- --------------------------------------------------------

--
-- Table structure for table `counter_informations`
--

CREATE TABLE `counter_informations` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `counter_informations`
--

INSERT INTO `counter_informations` (`id`, `language_id`, `icon`, `image`, `amount`, `title`, `serial_number`, `created_at`, `updated_at`) VALUES
(1, 20, NULL, '674bd152c23cb.png', 24000, 'Business Meting Done', 1, '2024-11-30 21:00:34', '2024-12-06 22:49:47'),
(2, 20, NULL, '674bd182388d3.png', 28000, 'Happy Customers', 2, '2024-11-30 21:01:22', '2024-12-06 22:50:00'),
(3, 20, NULL, '674bd1a67aac8.png', 27000, 'Modern Room Available', 3, '2024-11-30 21:01:58', '2024-12-06 22:50:07'),
(4, 20, NULL, '674bd1bd7859a.png', 1000, 'CCTV for Security', 4, '2024-11-30 21:02:21', '2024-12-06 22:50:14'),
(5, 21, NULL, '6753d45d807c4.png', 24000, 'تم عقد اجتماع الأعمال', 1, '2024-12-06 22:51:41', '2024-12-06 22:51:41'),
(6, 21, NULL, '6753d47fd0408.png', 28000, 'عملاء سعداء', 2, '2024-12-06 22:52:15', '2024-12-06 22:52:15'),
(7, 21, NULL, '6753d4a3c81c7.png', 27000, 'غرفة حديثة متاحة', 3, '2024-12-06 22:52:51', '2024-12-06 22:52:51'),
(8, 21, NULL, '6753d4bf3f1db.png', 100, 'الدوائر التلفزيونية المغلقة للأمن', 4, '2024-12-06 22:53:19', '2024-12-06 22:53:19');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `language_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 20, 'United States', '2024-11-30 23:28:19', '2024-11-30 23:28:19'),
(2, 20, 'Bangladesh', '2024-11-30 23:28:33', '2024-11-30 23:28:33'),
(3, 20, 'India', '2024-11-30 23:28:42', '2024-11-30 23:28:42'),
(4, 20, 'Australia', '2024-11-30 23:28:50', '2024-11-30 23:28:50'),
(5, 21, 'الولايات المتحدة', '2024-11-30 23:28:19', '2025-01-03 20:53:09'),
(6, 21, 'بنغلاديش', '2024-11-30 23:28:33', '2025-01-03 20:52:51'),
(7, 21, 'الهند', '2024-11-30 23:28:42', '2025-01-03 20:52:39'),
(8, 21, 'أستراليا', '2024-11-30 23:28:50', '2025-01-03 20:52:27');

-- --------------------------------------------------------

--
-- Table structure for table `custom_sections`
--

CREATE TABLE `custom_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `order` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_section_contents`
--

CREATE TABLE `custom_section_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint NOT NULL,
  `custom_section_id` bigint NOT NULL,
  `section_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `language_id`, `question`, `answer`, `serial_number`, `created_at`, `updated_at`) VALUES
(1, 20, 'What is hourly hotel booking?', 'Hourly hotel booking allows you to book a room for a few hours, rather than a full day or night. This is ideal for short stays, meetings, or rest periods.', 1, '2024-11-30 23:39:44', '2024-11-30 23:39:44'),
(2, 20, 'Can I book a room for less than a full day?', 'Yes, you can book a room for a few hours, depending on your needs. Our platform allows flexible booking for hourly stays.', 2, '2024-11-30 23:40:04', '2024-11-30 23:40:04'),
(3, 20, 'How do I book a room for a few hours?', 'Simply select the desired date and time for your booking on our website or app. Choose the duration of your stay and complete the payment process.', 3, '2024-11-30 23:40:21', '2024-11-30 23:40:21'),
(4, 20, 'Is hourly booking available for all hotel rooms?', 'Hourly booking availability depends on the hotel and room type. Some hotels may offer hourly bookings for specific rooms or during certain hours of the day.', 4, '2024-11-30 23:40:41', '2024-11-30 23:40:41'),
(5, 20, 'Can I book a room for a few hours if I want to stay overnight?', 'Yes, you can book for a few hours during the day and then extend your stay overnight, subject to availability.', 5, '2024-11-30 23:40:58', '2024-11-30 23:40:58'),
(6, 20, 'Are the prices for hourly bookings different from full-day bookings?', 'Yes, hourly bookings are typically priced lower than full-day bookings, allowing you to pay only for the time you need.', 6, '2024-11-30 23:41:18', '2024-11-30 23:41:18'),
(7, 20, 'Can I cancel or modify my hourly booking?', 'Yes, cancellation or modification of your booking is allowed depending on the hotel\'s cancellation policy. Please check the specific hotel\'s terms and conditions.', 7, '2024-11-30 23:41:35', '2024-11-30 23:41:35'),
(8, 20, 'Is there any minimum duration for an hourly booking?', 'The minimum duration for an hourly booking may vary depending on the hotel’s policy. Typically, a minimum of 2 hours is required.', 8, '2024-11-30 23:41:56', '2024-11-30 23:41:56'),
(9, 20, 'Can I book a hotel room for a few hours for a business meeting or event?', 'Yes, hourly hotel bookings are perfect for business meetings, conferences, or events. Choose a room with the necessary amenities for your needs.', 9, '2024-11-30 23:42:12', '2024-11-30 23:42:12'),
(10, 20, 'Do I need to provide identification when booking a room by the hour?', 'Yes, a valid identification and payment method are required to confirm your hourly booking, just as with a full-day booking.', 10, '2024-11-30 23:42:30', '2024-11-30 23:42:30'),
(11, 21, 'ما هو حجز الفندق بالساعة؟', 'يتيح لك حجز الفندق بالساعة حجز غرفة لبضع ساعات، بدلاً من يوم كامل أو ليلة كاملة. يعد هذا مثاليًا للإقامات القصيرة أو الاجتماعات أو فترات الراحة.', 1, '2024-11-30 23:39:44', '2024-11-30 23:47:30'),
(12, 21, 'هل يمكنني حجز غرفة لمدة تقل عن يوم كامل؟', 'نعم، يمكنك حجز غرفة لبضع ساعات، حسب احتياجاتك. تسمح منصتنا بالحجز المرن للإقامات كل ساعة.', 2, '2024-11-30 23:40:04', '2024-11-30 23:47:12'),
(13, 21, 'كيف أحجز غرفة لبضع ساعات؟', 'ما عليك سوى تحديد التاريخ والوقت المطلوبين لحجزك على موقعنا الإلكتروني أو تطبيقنا. اختر مدة إقامتك وأكمل عملية الدفع.', 3, '2024-11-30 23:40:21', '2024-11-30 23:46:54'),
(14, 21, 'هل الحجز بالساعة متاح لجميع غرف الفندق؟', 'يعتمد توفر الحجز بالساعة على الفندق ونوع الغرفة. قد تقدم بعض الفنادق حجوزات كل ساعة لغرف معينة أو خلال ساعات معينة من اليوم.', 4, '2024-11-30 23:40:41', '2024-11-30 23:46:33'),
(15, 21, 'هل يمكنني حجز غرفة لبضع ساعات إذا كنت أرغب في المبيت طوال الليل؟', 'نعم، يمكنك الحجز لبضع ساعات خلال النهار ثم تمديد إقامتك لليلة واحدة، رهنًا بالتوافر.', 5, '2024-11-30 23:40:58', '2024-11-30 23:46:11'),
(16, 21, 'هل تختلف أسعار الحجوزات بالساعة عن حجوزات اليوم الكامل؟', 'نعم، عادةً ما يكون سعر الحجوزات بالساعة أقل من حجوزات اليوم الكامل، مما يسمح لك بالدفع مقابل الوقت الذي تحتاجه فقط.', 6, '2024-11-30 23:41:18', '2024-11-30 23:45:51'),
(17, 21, 'هل يمكنني إلغاء أو تعديل حجزي للساعة؟', 'نعم، يُسمح بإلغاء حجزك أو تعديله حسب سياسة الإلغاء الخاصة بالفندق. يرجى التحقق من الشروط والأحكام الخاصة بالفندق المحدد.', 7, '2024-11-30 23:41:35', '2024-11-30 23:45:32'),
(18, 21, 'هل هناك حد أدنى لمدة الحجز بالساعة؟', 'قد يختلف الحد الأدنى لمدة الحجز بالساعة حسب سياسة الفندق. عادة، مطلوب ما لا يقل عن ساعتين.', 8, '2024-11-30 23:41:56', '2024-11-30 23:45:12'),
(19, 21, 'هل يمكنني حجز غرفة في فندق لبضع ساعات لحضور اجتماع عمل أو حدث؟', 'نعم، تعد حجوزات الفنادق بالساعة مثالية لاجتماعات العمل أو المؤتمرات أو الأحداث. اختر غرفة بها وسائل الراحة اللازمة لاحتياجاتك.', 9, '2024-11-30 23:42:12', '2024-11-30 23:44:50'),
(20, 21, 'هل أحتاج إلى تقديم إثبات هوية عند حجز غرفة بالساعة؟', 'نعم، يلزم تقديم بطاقة هوية صالحة وطريقة دفع لتأكيد حجزك بالساعة، تمامًا كما هو الحال مع حجز اليوم الكامل.', 10, '2024-11-30 23:42:30', '2024-11-30 23:44:31');

-- --------------------------------------------------------

--
-- Table structure for table `featured_hotel_charges`
--

CREATE TABLE `featured_hotel_charges` (
  `id` bigint UNSIGNED NOT NULL,
  `days` bigint DEFAULT NULL,
  `price` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `featured_hotel_charges`
--

INSERT INTO `featured_hotel_charges` (`id`, `days`, `price`, `created_at`, `updated_at`) VALUES
(1, 100, 150, '2024-12-01 20:32:06', '2024-12-01 20:32:06'),
(2, 500, 699, '2024-12-01 20:32:20', '2024-12-01 20:32:43'),
(3, 700, 799, '2024-12-01 20:32:36', '2024-12-01 20:32:36'),
(4, 900, 999, '2024-12-01 20:33:08', '2024-12-01 20:33:08');

-- --------------------------------------------------------

--
-- Table structure for table `featured_room_charges`
--

CREATE TABLE `featured_room_charges` (
  `id` bigint UNSIGNED NOT NULL,
  `days` bigint DEFAULT NULL,
  `price` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `featured_room_charges`
--

INSERT INTO `featured_room_charges` (`id`, `days`, `price`, `created_at`, `updated_at`) VALUES
(1, 100, 99, '2024-12-01 20:35:00', '2024-12-01 20:35:00'),
(2, 300, 249, '2024-12-01 20:35:09', '2024-12-01 20:35:34'),
(3, 500, 419, '2024-12-01 20:35:26', '2024-12-01 20:35:45'),
(4, 1000, 799, '2024-12-01 20:35:59', '2024-12-01 20:35:59');

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `features`
--

INSERT INTO `features` (`id`, `language_id`, `title`, `image`, `subtitle`, `text`, `serial_number`, `created_at`, `updated_at`) VALUES
(1, 20, 'Flexible Hourly Booking', '674bd0644f391.png', 'Hourly booking spent per month', '10+', 1, '2024-11-30 20:56:36', '2024-12-26 00:10:19'),
(2, 20, '1k+ Customer Feedback', '674bd082171ad.png', 'Trusted registered happy customer', '50+', 2, '2024-11-30 20:57:06', '2024-12-26 00:10:11'),
(3, 20, 'Modern Room Facility', '674bd09f2d204.png', 'Hotel room always available hourly', '30+', 3, '2024-11-30 20:57:35', '2024-12-26 00:10:03'),
(4, 21, '1k+ تعليقات العملاء', '6753cf632f96f.png', 'عميل سعيد مسجل موثوق به', '50+', 2, '2024-12-06 22:19:47', '2024-12-26 00:10:53'),
(5, 21, 'الحجز المرن لكل ساعة', '6753d013a24b1.png', 'الحجز بالساعة ينفق شهريا', '10+', 1, '2024-12-06 22:21:07', '2024-12-26 00:10:47'),
(6, 21, 'مرافق الغرفة الحديثة', '6753cdb232c13.png', 'غرفة الفندق متاحة دائما كل ساعة', '30+', 3, '2024-12-06 22:23:14', '2024-12-26 00:10:38');

-- --------------------------------------------------------

--
-- Table structure for table `footer_contents`
--

CREATE TABLE `footer_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `about_company` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `copyright_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `footer_contents`
--

INSERT INTO `footer_contents` (`id`, `language_id`, `about_company`, `copyright_text`, `created_at`, `updated_at`) VALUES
(5, 20, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.', '<p>Copyright ©2024. All Rights Reserved..</p>', '2023-08-19 23:40:53', '2024-07-16 01:52:25'),
(6, 21, 'في قائمة سيارة ، نقدم مجموعة واسعة من السيارات المستعملة عالية الجودة لتلبية احتياجات قيادتك وميزانيتك. مع سنوات من الخبرة في صناعة السيارات ، نفخر بتقديم خدمة عملاء استثنائية والتأكد من أن كل سيارة في قطعتنا تلبي معاييرنا الصارمة للجودة والموثوقية.', '<div class=\"tw-ta-container F0azHf tw-lfl\">\r\n<pre class=\"tw-data-text tw-text-large tw-ta\" dir=\"rtl\"><span class=\"Y2IQFc\" lang=\"ar\" xml:lang=\"ar\">حقوق النشر © 2024. كل الحقوق محفوظة.</span></pre>\r\n</div>\r\n<div class=\"tw-target-rmn tw-ta-container F0azHf tw-nfl\"> </div>', '2023-08-19 23:43:21', '2024-01-24 21:46:50');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `id` bigint UNSIGNED NOT NULL,
  `endpoint` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`id`, `vendor_id`, `hotel_id`, `date`, `created_at`, `updated_at`) VALUES
(1, 0, 7, '2025-03-12', '2025-01-03 21:07:52', '2025-01-03 21:07:52'),
(2, 0, 12, '2025-01-09', '2025-01-03 21:08:00', '2025-01-03 21:08:00'),
(3, 1, 8, '2025-01-21', '2025-01-03 21:08:17', '2025-01-03 21:08:17'),
(4, 1, 13, '2025-01-23', '2025-01-03 21:08:24', '2025-01-03 21:08:24'),
(5, 1, 22, '2025-01-29', '2025-01-03 21:08:30', '2025-01-03 21:08:30'),
(6, 2, 5, '2025-01-28', '2025-01-03 21:08:39', '2025-01-03 21:08:39'),
(7, 2, 6, '2025-01-18', '2025-01-03 21:08:45', '2025-01-03 21:08:45'),
(8, 3, 3, '2025-01-22', '2025-01-03 21:08:53', '2025-01-03 21:08:53'),
(9, 3, 4, '2025-01-31', '2025-01-03 21:09:00', '2025-01-03 21:09:00'),
(10, 3, 10, '2025-02-10', '2025-01-03 21:09:08', '2025-01-03 21:09:08'),
(11, 4, 1, '2025-01-21', '2025-01-03 21:09:20', '2025-01-03 21:09:20'),
(12, 4, 2, '2025-02-06', '2025-01-03 21:09:26', '2025-01-03 21:09:26'),
(13, 0, 7, '2025-02-20', '2025-01-04 02:55:04', '2025-01-04 02:55:04'),
(14, 0, 7, '2025-03-19', '2025-01-04 02:55:29', '2025-01-04 02:55:29'),
(15, 0, 7, '2025-03-20', '2025-01-04 02:55:39', '2025-01-04 02:55:39'),
(16, 0, 7, '2025-04-30', '2025-01-04 02:55:49', '2025-01-04 02:55:49'),
(17, 1, 8, '2025-02-20', '2025-01-04 02:56:11', '2025-01-04 02:56:11'),
(18, 1, 8, '2025-03-27', '2025-01-04 02:56:19', '2025-01-04 02:56:19');

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `average_rating` double DEFAULT '0',
  `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` bigint DEFAULT NULL,
  `min_price` double DEFAULT '0',
  `max_price` double DEFAULT '0',
  `stars` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`id`, `vendor_id`, `logo`, `average_rating`, `latitude`, `longitude`, `status`, `min_price`, `max_price`, `stars`, `created_at`, `updated_at`) VALUES
(1, 0, '1735365636.png', 0, '32.715738', '-117.1610838', 1, 30, 150, 4, '2024-12-01 00:40:30', '2025-01-02 01:10:12'),
(2, 0, '1735365656.png', 0, '23.7970072', '90.4085834', 1, 100, 1200, 5, '2024-12-01 20:50:41', '2024-12-28 00:00:56'),
(3, 0, '1735365699.png', 4, '14.690627', '77.5980307', 1, 50, 220, 4, '2024-12-01 21:08:50', '2025-01-04 01:56:01'),
(4, 0, '1735365713.png', 0, '33.6845673', '-117.8265049', 1, 60, 270, 4, '2024-12-01 21:15:54', '2025-01-02 01:10:42'),
(5, 0, '1735365724.png', 0, '-37.8137019', '144.9696086', 1, 45, 190, 5, '2024-12-01 21:25:49', '2024-12-28 00:02:04'),
(6, 0, '1735365733.png', 0, '22.3219872', '91.8112304', 1, 200, 900, 2, '2024-12-01 21:31:22', '2024-12-28 00:02:13'),
(7, 0, '1735365742.png', 5, '33.5670716', '-117.7253566', 1, 80, 300, 3, '2024-12-01 21:41:54', '2024-12-28 00:02:22'),
(8, 0, '1735365754.png', 0, '22.3659866', '91.8275668', 1, 55, 225, 5, '2024-12-01 22:02:34', '2024-12-28 00:02:34'),
(9, 0, '1735365766.png', 0, '-37.81823999999999', '144.9623945', 1, 90, 350, 5, '2024-12-01 22:24:27', '2024-12-28 00:02:46'),
(10, 0, '1735365776.png', 3.5, '23.804093', '90.4152376', 1, 25, 100, 4, '2024-12-01 23:12:49', '2025-01-04 02:25:01'),
(11, 0, '1735365786.png', 0, '22.5383472', '88.3464169', 1, 120, 430, 4, '2024-12-01 23:24:06', '2024-12-28 00:03:06'),
(12, 0, '1735365797.png', 0, '21.2995399', '92.0518233', 1, 150, 550, 5, '2024-12-01 23:35:18', '2024-12-28 00:03:17'),
(13, 0, '1735365809.png', 0, '22.55788579999999', '88.3511268', 1, 20, 180, 1, '2024-12-01 23:45:43', '2024-12-28 00:03:29'),
(14, 0, '1735365819.png', 2, '-37.9802008', '145.0677112', 1, 50, 240, 5, '2024-12-01 23:59:54', '2025-01-04 03:23:48'),
(15, 0, '1735365831.png', 0, '23.7913985', '90.40715639999999', 1, 300, 1500, 1, '2024-12-02 00:31:25', '2024-12-28 00:03:51'),
(21, 0, '1735703717.png', 0, '41.8905025', '-87.65917619999999', 1, 50, 220, 3, '2024-12-31 21:55:17', '2024-12-31 22:26:56'),
(22, 0, '1735704191.png', 0, '-37.8136276', '144.9630576', 1, 250, 750, 5, '2024-12-31 22:03:11', '2024-12-31 22:49:26'),
(23, 0, '1735705103.png', 0, '34.0549076', '-118.242643', 1, 200, 550, 4, '2024-12-31 22:18:23', '2024-12-31 22:56:11');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_categories`
--

CREATE TABLE `hotel_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` bigint DEFAULT NULL,
  `status` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotel_categories`
--

INSERT INTO `hotel_categories` (`id`, `language_id`, `name`, `slug`, `serial_number`, `status`, `created_at`, `updated_at`) VALUES
(1, 20, 'Luxury Hotels', 'luxury-hotels', 1, 1, '2024-11-30 22:27:02', '2024-11-30 22:31:03'),
(2, 20, 'Business Hotels', 'business-hotels', 2, 1, '2024-11-30 22:27:18', '2024-11-30 22:30:14'),
(3, 20, 'Family Hotels', 'family-hotels', 3, 1, '2024-11-30 22:27:36', '2024-11-30 22:29:32'),
(4, 20, 'Event Hotels', 'event-hotels', 4, 1, '2024-11-30 22:27:56', '2024-11-30 22:28:37'),
(5, 21, 'فنادق فاخرة', 'فنادق-فاخرة', 1, 1, '2024-11-30 22:27:02', '2025-01-03 20:44:18'),
(6, 21, 'فنادق الأعمال', 'فنادق-الأعمال', 2, 1, '2024-11-30 22:27:18', '2025-01-03 20:44:04'),
(7, 21, 'فنادق عائلية', 'فنادق-عائلية', 3, 1, '2024-11-30 22:27:36', '2025-01-03 20:43:40'),
(8, 21, 'فنادق المناسبات', 'فنادق-المناسبات', 4, 1, '2024-11-30 22:27:56', '2025-01-03 20:43:20'),
(9, 20, 'Boutique Hotels', 'boutique-hotels', 5, 1, '2024-12-01 23:39:15', '2024-12-25 23:21:59'),
(10, 21, 'فنادق بوتيك', 'فنادق-بوتيك', 5, 1, '2024-12-01 23:39:41', '2025-01-03 20:43:03');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_contents`
--

CREATE TABLE `hotel_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `country_id` bigint DEFAULT NULL,
  `state_id` bigint DEFAULT NULL,
  `city_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `amenities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keyword` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotel_contents`
--

INSERT INTO `hotel_contents` (`id`, `language_id`, `hotel_id`, `category_id`, `country_id`, `state_id`, `city_id`, `title`, `slug`, `address`, `amenities`, `description`, `meta_keyword`, `meta_description`, `created_at`, `updated_at`) VALUES
(1, 20, 1, 1, 1, 2, 8, 'Rapid Relax Hotel', 'rapid-relax-hotel', 'San Diego, CA, USA', '[\"2\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\"]', '<p><strong>Rapid Relax Hotel – Your Ideal Getaway in Jacksonville Beach, Florida</strong></p>\r\n<p>Welcome to <strong>Rapid Relax Hotel</strong>, your perfect retreat for a quick, yet luxurious escape in the heart of Jacksonville Beach, Florida. Designed to meet the needs of travelers who value convenience, comfort, and affordability, our hotel offers hourly bookings tailored to your schedule. Whether you\'re in town for a brief business trip, a layover, or simply need a peaceful spot to unwind, Rapid Relax is the ideal destination for both short stays and longer retreats.</p>\r\n<p>Located just minutes from the pristine coastline of Jacksonville Beach, our hotel provides easy access to all that the vibrant city has to offer. Whether you\'re here to explore the stunning beaches, visit local attractions, or enjoy the dynamic downtown scene, you\'ll find everything within reach. Guests can enjoy the best of both worlds—serene relaxation in a peaceful, modern environment, while still being just a stone’s throw away from the area\'s lively nightlife, shopping, and dining.</p>\r\n<p>Each of our well-appointed rooms has been carefully designed with your comfort in mind. Featuring contemporary decor, plush bedding, and thoughtful amenities, our rooms provide the perfect space for unwinding. Whether you\'re in need of a few hours of rest or a day of relaxation, our hourly booking system allows you to tailor your stay to your needs. All rooms come equipped with high-speed Wi-Fi, flat-screen TVs, air conditioning, and minibars for your convenience.</p>\r\n<p>For those who prefer to work while away, Rapid Relax Hotel offers a dedicated business center, equipped with all the necessary tools to help you stay productive on the go. If you’re looking to relax and recharge, take advantage of our cozy lounge area, or enjoy a peaceful walk along the nearby beach. Our team is committed to delivering exceptional service, ensuring that every guest experiences a stay that is comfortable, hassle-free, and memorable.</p>\r\n<p>At Rapid Relax, we understand that your time is valuable. That’s why we offer flexible booking options, including hourly and daily rates, so you can enjoy a stay that fits your schedule. Whether you\'re looking for a short escape, a quiet place to rest, or a convenient base for exploring Jacksonville Beach, Rapid Relax Hotel promises a comfortable, enjoyable experience.</p>\r\n<p>Book your stay today and discover why Rapid Relax Hotel is the perfect destination for travelers who value convenience, comfort, and exceptional service.</p>', NULL, NULL, '2024-12-01 00:40:32', '2025-01-02 01:10:12'),
(2, 21, 1, 5, 5, 6, 16, 'فندق رابيد ريلاكس', 'فندق-رابيد-ريلاكس', 'أوشن بريز درايف، جاكسونفيل، فلوريدا، الولايات المتحدة الأمريكية', '[\"13\",\"14\",\"18\",\"19\",\"20\",\"21\"]', '<div class=\"flex max-w-full flex-col flex-grow\">\r\n<div class=\"min-h-8 text-message flex w-full flex-col items-end gap-2 whitespace-normal break-words [.text-message+&amp;]:mt-5\">\r\n<div class=\"flex w-full flex-col gap-1 empty:hidden first:pt-[3px]\">\r\n<div class=\"markdown prose w-full break-words dark:prose-invert light\">\r\n<p><strong>فندق رابيد ريلاكس – وجهتك المثالية في شاطئ جاكسونفيل، فلوريدا</strong></p>\r\n<p>مرحبًا بك في <strong>فندق رابيد ريلاكس</strong>، ملاذك المثالي للهروب السريع والفاخر في قلب شاطئ جاكسونفيل، فلوريدا. تم تصميم فندقنا ليلبي احتياجات المسافرين الذين يقدرون الراحة والملاءمة وال affordability، حيث نقدم خدمات الحجز بالساعة التي تتناسب مع جدولك الزمني. سواء كنت في المدينة في رحلة عمل قصيرة، أو لتوقف مؤقت، أو ببساطة بحاجة إلى مكان هادئ للاسترخاء، يعتبر فندق رابيد ريلاكس الوجهة المثالية للإقامات القصيرة أو الطويلة.</p>\r\n<p>يقع فندقنا على بعد دقائق فقط من الشواطئ الخلابة لشاطئ جاكسونفيل، ويقدم لك وصولاً سهلاً إلى جميع ما تقدمه المدينة النابضة بالحياة. سواء كنت هنا لاستكشاف الشواطئ الجميلة، أو زيارة المعالم المحلية، أو الاستمتاع بالحياة الليلية الديناميكية، ستجد كل شيء في متناول اليد. يمكن للضيوف الاستمتاع بأفضل ما في العالمين — الاسترخاء الهادئ في بيئة حديثة وسلمية، مع كونك على مقربة من أماكن التسوق والمطاعم في المنطقة.</p>\r\n<p>تم تصميم كل من غرفنا المجهزة جيدًا بعناية لراحتك. تحتوي الغرف على ديكور عصري، وأسرّة مريحة، ووسائل راحة مدروسة توفر لك المساحة المثالية للاسترخاء. سواء كنت بحاجة إلى بضع ساعات من الراحة أو يوم من الاستجمام، يتيح لك نظام الحجز بالساعة لدينا تخصيص إقامتك بما يتناسب مع احتياجاتك. جميع الغرف مجهزة بخدمة الواي فاي عالية السرعة، وأجهزة تلفزيون بشاشة مسطحة، وتكييف هواء، وبار صغير لراحتك.</p>\r\n<p>لمن يفضلون العمل أثناء السفر، يوفر فندق رابيد ريلاكس مركز أعمال مخصص، مزود بكافة الأدوات اللازمة لمساعدتك على البقاء منتجًا أثناء التنقل. إذا كنت تبحث عن الاسترخاء وإعادة شحن طاقتك، يمكنك الاستفادة من منطقة الاستراحة المريحة لدينا، أو التمتع بنزهة هادئة على الشاطئ القريب. فريقنا ملتزم بتقديم خدمة استثنائية، مما يضمن أن كل ضيف سيحظى بإقامة مريحة وخالية من المتاعب وذكرى لا تُنسى.</p>\r\n<p>في فندق رابيد ريلاكس، نفهم أن وقتك ثمين. لهذا السبب نقدم خيارات حجز مرنة، بما في ذلك الأسعار بالساعة واليومية، حتى تتمكن من الاستمتاع بإقامة تناسب جدولك الزمني. سواء كنت تبحث عن هروب قصير، أو مكان هادئ للاسترخاء، أو قاعدة مريحة لاستكشاف شاطئ جاكسونفيل، يعد فندق رابيد ريلاكس بتقديم تجربة مريحة وممتعة.</p>\r\n<p>احجز إقامتك اليوم واكتشف لماذا يعد فندق رابيد ريلاكس الوجهة المثالية للمسافرين الذين يقدرون الراحة، والملاءمة، والخدمة الاستثنائية.</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"mb-2 flex gap-3 empty:hidden -ml-2\">\r\n<div class=\"items-center justify-start rounded-xl p-1 flex\">\r\n<div class=\"flex items-center\">\r\n<div class=\"flex\"> </div>\r\n<div class=\"flex items-center pb-0\"><span class=\"overflow-hidden text-clip whitespace-nowrap text-sm\">4o mini</span></div>\r\n</div>\r\n</div>\r\n</div>', NULL, NULL, '2024-12-01 00:40:32', '2025-01-02 01:10:12'),
(3, 20, 2, 3, 2, NULL, 7, 'Cityscape Lodge', 'cityscape-lodge', '123 Gulshan Lake Walk Way, Gulshan, Dhaka 1212, Bangladesh', '[\"1\",\"3\",\"6\",\"8\",\"9\"]', '<p><strong>Cityscape Lodge: A Luxurious Urban Retreat in Dhaka</strong></p>\r\n<p>Nestled in the heart of Dhaka, <strong>Cityscape Lodge</strong> offers an unparalleled experience of luxury, comfort, and breathtaking views of the bustling metropolis. Designed for both business travelers and leisure seekers, this exquisite hotel provides a harmonious blend of modern amenities and warm Bangladeshi hospitality.</p>\r\n<p>The hotel\'s prime location places guests in close proximity to Dhaka\'s major attractions, including vibrant shopping districts, cultural landmarks, and thriving business hubs. Overlooking the city skyline, <strong>Cityscape Lodge</strong> boasts a collection of elegantly designed rooms and suites, each thoughtfully curated to ensure a memorable stay. Guests can wake up to panoramic views of Dhaka\'s iconic cityscape, framed by floor-to-ceiling windows, and indulge in a serene escape amidst the urban buzz.</p>\r\n<p>At the heart of the lodge is its renowned rooftop restaurant, where gourmet cuisine meets an unforgettable dining experience. Savor an array of local and international delicacies while soaking in the twinkling city lights. For those seeking relaxation, the hotel\'s spa and wellness center offer a tranquil sanctuary, complete with rejuvenating treatments and a state-of-the-art fitness facility.</p>\r\n<p>Business travelers will appreciate the hotel’s well-equipped meeting rooms and conference facilities, designed to accommodate corporate events of all sizes. With high-speed Wi-Fi, cutting-edge technology, and dedicated staff, every detail is tailored to ensure seamless productivity.</p>\r\n<p><strong>Cityscape Lodge</strong> is more than just a place to stay; it’s a gateway to discovering the charm and vibrancy of Dhaka. From its warm and attentive service to its unbeatable location, the lodge redefines urban luxury, making it an ideal choice for discerning travelers.</p>\r\n<p>Whether you’re in town for business, leisure, or a mix of both, <strong>Cityscape Lodge</strong> promises an experience that combines the best of Dhaka with the comforts of a world-class hotel.</p>', NULL, NULL, '2024-12-01 20:50:41', '2024-12-01 20:50:41'),
(4, 21, 2, 7, 6, NULL, 15, 'سيتي سكيب لودج', 'سيتي-سكيب-لودج', '123 جولشان ليك ووك واي، جولشان، دكا 1212، بنجلاديش', '[\"13\",\"15\",\"16\",\"20\"]', '<div class=\"flex-1 overflow-hidden\">\r\n<div class=\"h-full\">\r\n<div class=\"react-scroll-to-bottom--css-xpyag-79elbk h-full\">\r\n<div class=\"react-scroll-to-bottom--css-xpyag-1n7m0yu\">\r\n<div class=\"flex flex-col text-sm md:pb-9\">\r\n<article class=\"w-full scroll-mb-[var(--thread-trailing-height,150px)] text-token-text-primary focus-visible:outline-2 focus-visible:outline-offset-[-4px]\">\r\n<div class=\"m-auto text-base py-[18px] px-3 md:px-4 w-full md:px-5 lg:px-4 xl:px-5\">\r\n<div class=\"mx-auto flex flex-1 gap-4 text-base md:gap-5 lg:gap-6 md:max-w-3xl lg:max-w-[40rem] xl:max-w-[48rem]\">\r\n<div class=\"group/conversation-turn relative flex w-full min-w-0 flex-col agent-turn\">\r\n<div class=\"flex-col gap-1 md:gap-3\">\r\n<div class=\"flex max-w-full flex-col flex-grow\">\r\n<div class=\"min-h-8 text-message flex w-full flex-col items-end gap-2 whitespace-normal break-words [.text-message+&amp;]:mt-5\">\r\n<div class=\"flex w-full flex-col gap-1 empty:hidden first:pt-[3px]\">\r\n<div class=\"markdown prose w-full break-words dark:prose-invert light\">\r\n<p><strong>سيتي سكيب لودج: ملاذ فاخر في قلب مدينة دكا</strong></p>\r\n<p>يقع <strong>سيتي سكيب لودج</strong> في قلب مدينة دكا، حيث يقدم تجربة فريدة تجمع بين الفخامة والراحة وإطلالات خلابة على أفق المدينة النابض بالحياة. صُمم الفندق ليلبي احتياجات المسافرين من رجال الأعمال والسياح على حد سواء، حيث يجمع بين وسائل الراحة الحديثة وحسن الضيافة البنغلاديشية الدافئة.</p>\r\n<p>يتميز الفندق بموقعه المثالي الذي يضع الضيوف بالقرب من أبرز معالم دكا، بما في ذلك مناطق التسوق النابضة بالحياة والمعالم الثقافية ومراكز الأعمال المزدهرة. تطل الغرف والأجنحة المصممة بأناقة في <strong>سيتي سكيب لودج</strong> على أفق المدينة المذهل، وتحتوي على نوافذ ممتدة من الأرض إلى السقف توفر إطلالات بانورامية، مما يجعل إقامتك تجربة لا تُنسى.</p>\r\n<p>في قلب الفندق، يقع المطعم الشهير على السطح، حيث تلتقي المأكولات الفاخرة بتجربة تناول الطعام الساحرة. استمتع بتذوق مجموعة متنوعة من الأطباق المحلية والعالمية بينما تستمتع بمشهد أضواء المدينة المتلألئة. ولمزيد من الاسترخاء، يقدم الفندق مركز سبا وعافية يوفر ملاذًا هادئًا مع علاجات مميزة ومرافق لياقة بدنية حديثة.</p>\r\n<p>لرجال الأعمال، يوفر الفندق غرف اجتماعات ومرافق مؤتمرات مجهزة بأحدث التقنيات، مصممة لاستضافة الفعاليات بكفاءة عالية. مع خدمة واي فاي فائقة السرعة وتقنيات متقدمة وفريق عمل متفانٍ، يتم ضمان إنتاجية متميزة.</p>\r\n<p><strong>سيتي سكيب لودج</strong> ليس مجرد مكان للإقامة، بل هو بوابتك لاستكشاف سحر وحيوية مدينة دكا. من الخدمة الودية والمتميزة إلى الموقع المثالي، يعيد الفندق تعريف الفخامة الحضرية، مما يجعله الخيار المثالي للمسافرين الباحثين عن تجربة استثنائية.</p>\r\n<p>سواء كنت في المدينة لأغراض العمل أو الترفيه أو كليهما، يعدك <strong>سيتي سكيب لودج</strong> بتجربة تجمع بين أفضل ما تقدمه دكا وراحة الفنادق العالمية</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</article>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', NULL, NULL, '2024-12-01 20:50:41', '2024-12-01 20:50:41'),
(5, 20, 3, 2, 3, 3, 2, 'SwiftStay Suites', 'swiftstay-suites', '123, Main Road, Revenue Colony, Ramachandra Nagar, Anantapur, Andhra Pradesh 515001, India', '[\"1\",\"2\",\"5\",\"6\",\"7\",\"9\",\"11\",\"12\"]', '<p><strong>SwiftStay Suites: Your Premier Business Destination</strong></p>\r\n<p>Located in the bustling commercial district of Dhaka, <strong>SwiftStay Suites</strong> is a contemporary hotel designed with the modern business traveler in mind. Combining convenience, comfort, and cutting-edge facilities, SwiftStay Suites ensures that every stay is productive and stress-free.</p>\r\n<p>The hotel’s strategic location offers easy access to major corporate hubs, government offices, and key city landmarks. This makes it the perfect choice for professionals attending conferences, meetings, or simply seeking a comfortable retreat after a day of business engagements. Each suite at SwiftStay is thoughtfully designed to cater to the unique needs of its guests, featuring ergonomic workstations, high-speed internet, and plush furnishings to ensure relaxation and efficiency.</p>\r\n<p>Dining at <strong>SwiftStay Suites</strong> is a seamless blend of flavor and convenience. The on-site restaurant, \"The Executive Table,\" offers a curated menu of local and international dishes, prepared to satisfy diverse palates. Start your day with a hearty breakfast, grab a quick lunch between meetings, or unwind over dinner after a productive day. For those who prefer working while dining, the lounge area provides a relaxed yet professional setting to meet colleagues or clients.</p>\r\n<p>The hotel also boasts state-of-the-art meeting rooms and conference facilities, equipped with modern technology, ensuring that your events run smoothly. Dedicated staff are on hand to assist with everything from audiovisual setup to catering arrangements.</p>\r\n<p>For relaxation, guests can visit the wellness center, which features a fitness studio and spa treatments tailored to rejuvenate both body and mind. The 24-hour concierge service ensures that every need is met promptly, allowing guests to focus on their priorities.</p>\r\n<p><strong>SwiftStay Suites</strong> prides itself on offering more than just a stay; it provides a professional yet welcoming environment that adapts to your pace. Whether you’re in town for a quick meeting or an extended business trip, SwiftStay Suites is committed to delivering excellence, helping you achieve your goals with ease and comfort.</p>\r\n<p>Experience the perfect balance of work and leisure at SwiftStay Suites – where business meets sophistication.</p>', NULL, NULL, '2024-12-01 21:08:50', '2024-12-01 21:08:50'),
(6, 21, 3, 6, 7, 7, 10, 'أجنحة سويفت ستاي', 'أجنحة-سويفت-ستاي', '123، الطريق الرئيسي، مستعمرة الإيرادات، راماتشاندرا ناجار، أنانتابور، ولاية اندرا براديش 515001، الهند', '[\"13\",\"14\",\"18\",\"22\",\"23\",\"24\"]', '<p><strong>سويفت ستاي سويتس: وجهتك المثلى للأعمال</strong></p>\r\n<p>يقع <strong>سويفت ستاي سويتس</strong> في قلب المنطقة التجارية النابضة في دكا، وهو فندق عصري مصمم خصيصًا لتلبية احتياجات المسافر العصري من رجال الأعمال. يجمع الفندق بين الراحة والحداثة والمرافق المتطورة، لضمان إقامة منتجة وخالية من التوتر.</p>\r\n<p>يتميز الفندق بموقع استراتيجي يتيح سهولة الوصول إلى المراكز التجارية الرئيسية والمكاتب الحكومية والمعالم البارزة في المدينة. مما يجعله الخيار الأمثل للمحترفين الذين يحضرون المؤتمرات والاجتماعات، أو الباحثين عن مكان مريح للاستجمام بعد يوم طويل من الأعمال. تم تصميم كل جناح في <strong>سويفت ستاي</strong> بعناية لتلبية احتياجات الضيوف، حيث يوفر محطات عمل مريحة، وإنترنت عالي السرعة، وأثاث فاخر لضمان الراحة والكفاءة.</p>\r\n<p>يقدم مطعم الفندق، \"The Executive Table\"، تجربة طعام تجمع بين النكهات المحلية والعالمية. ابدأ يومك بوجبة إفطار شهية، واستمتع بغداء سريع بين الاجتماعات، أو استرخِ مع عشاء فاخر بعد يوم عمل منتج. ولمن يفضل العمل أثناء تناول الطعام، يوفر ركن الصالة أجواء مريحة ومهنية للقاء الزملاء أو العملاء.</p>\r\n<p>يضم الفندق أيضًا غرف اجتماعات ومرافق مؤتمرات مجهزة بأحدث التقنيات، لضمان سير الفعاليات بسلاسة. كما يتوفر فريق متخصص للمساعدة في إعداد الأنظمة السمعية والبصرية وترتيبات الضيافة.</p>\r\n<p>للاسترخاء، يمكن للضيوف زيارة مركز العافية الذي يضم استوديو للياقة البدنية وعلاجات سبا مصممة لتجديد النشاط الجسدي والعقلي. كما يضمن فريق الكونسيرج المتوفر على مدار الساعة تلبية جميع احتياجات الضيوف بسرعة، مما يتيح لهم التركيز على أولوياتهم.</p>\r\n<p>يتميز <strong>سويفت ستاي سويتس</strong> بتقديم أكثر من مجرد إقامة؛ إنه يوفر بيئة مهنية ومرحبة تتكيف مع احتياجاتك. سواء كنت في المدينة لحضور اجتماع سريع أو رحلة عمل طويلة، يلتزم الفندق بتقديم تجربة استثنائية تساعدك على تحقيق أهدافك بسهولة وراحة.</p>\r\n<p>اختبر التوازن المثالي بين العمل والاستجمام في <strong>سويفت ستاي سويتس</strong> – حيث يلتقي العمل بالرقي</p>', NULL, NULL, '2024-12-01 21:08:50', '2024-12-01 21:08:50'),
(7, 20, 4, 3, 1, 2, 5, 'PrimePoint Inn', 'primepoint-inn', 'Irvine, CA, USA', '[\"1\",\"2\",\"4\",\"7\",\"8\",\"9\",\"10\",\"11\"]', '<p><strong>PrimePoint Inn: Your Family’s Home Away From Home</strong></p>\r\n<p>Situated in the vibrant city of Jacksonville, Florida, <strong>PrimePoint Inn</strong> offers a welcoming and comfortable retreat for families seeking a memorable getaway. Designed with family needs in mind, this charming hotel combines modern amenities with a warm and inviting atmosphere, making it the perfect choice for travelers of all ages.</p>\r\n<p>Located just minutes away from Jacksonville’s iconic attractions, <strong>PrimePoint Inn</strong> provides convenient access to family-friendly destinations such as the Jacksonville Zoo and Gardens, Adventure Landing, and the scenic Jacksonville Beach. Whether your family is looking to explore the city\'s culture, enjoy outdoor adventures, or relax by the ocean, this hotel serves as the ideal base for your vacation.</p>\r\n<p>The hotel features a variety of spacious room options, from standard accommodations to family suites equipped with extra sleeping arrangements and kitchenettes. Thoughtfully designed, each room includes plush bedding, complimentary Wi-Fi, and flat-screen TVs to ensure everyone in the family feels right at home.</p>\r\n<p>At <strong>PrimePoint Inn</strong>, dining is made simple and enjoyable. Start your day with a complimentary breakfast buffet offering a selection of kid-approved favorites and healthy options. The on-site café provides quick snacks and beverages throughout the day, perfect for families on the go. For those who prefer to dine in, nearby local restaurants offer delicious meals just a short walk away.</p>\r\n<p>The hotel also boasts amenities tailored to family entertainment, including a sparkling outdoor pool, a children’s play area, and a cozy lounge with board games and books. Parents can unwind while kids play, creating moments of relaxation and bonding for everyone.</p>\r\n<p>For convenience, <strong>PrimePoint Inn</strong> offers ample parking, a 24-hour front desk, and friendly staff ready to assist with local recommendations or special requests. Whether it’s arranging tickets to local attractions or providing tips on family-friendly dining, the team is dedicated to ensuring your stay is hassle-free.</p>\r\n<p>Experience the perfect blend of comfort, fun, and hospitality at <strong>PrimePoint Inn</strong>. Here, every detail is designed to make your family vacation unforgettable. Your adventure starts at PrimePoint Inn – the place where family memories are made.</p>', NULL, NULL, '2024-12-01 21:15:54', '2025-01-02 01:10:42'),
(8, 21, 4, 7, 5, 5, 14, 'برايم بوينت إن', 'برايم-بوينت-إن', 'حياة ريجنسي جاكسونفيل ريفرفرونت، إيست كوستلاين درايف، جاكسونفيل، فلوريدا 32202، الولايات المتحدة الأمريكية', '[\"13\",\"16\",\"19\",\"20\",\"21\",\"22\",\"24\"]', '<p><strong>برايم بوينت إن: منزلك العائلي بعيدًا عن المنزل</strong></p>\r\n<p>يقع <strong>برايم بوينت إن</strong> في مدينة جاكسونفيل الحيوية بولاية فلوريدا، وهو يوفر ملاذًا مريحًا ومرحّبًا للعائلات الباحثة عن إجازة لا تُنسى. صُمم هذا الفندق بعناية لتلبية احتياجات العائلات، حيث يجمع بين وسائل الراحة الحديثة والأجواء الدافئة، مما يجعله الخيار المثالي للمسافرين من جميع الأعمار.</p>\r\n<p>يقع الفندق على بُعد دقائق قليلة من أشهر معالم جاكسونفيل، مثل حديقة حيوان جاكسونفيل، وأدفنتشر لاندينغ، والشاطئ الجميل في جاكسونفيل. سواء كانت عائلتك ترغب في استكشاف الثقافة المحلية، أو الاستمتاع بالمغامرات الخارجية، أو الاسترخاء على الشاطئ، فإن <strong>برايم بوينت إن</strong> هو القاعدة المثالية لقضاء إجازتكم.</p>\r\n<p>يوفر الفندق مجموعة متنوعة من الغرف الفسيحة، بدءًا من الغرف العادية وحتى الأجنحة العائلية المجهزة بمساحات إضافية للنوم ومطابخ صغيرة. تم تصميم كل غرفة بعناية لتشمل أسرّة مريحة، وإنترنت مجاني، وتلفزيونات بشاشات مسطحة لضمان أن يشعر الجميع وكأنهم في منزلهم.</p>\r\n<p>يقدم <strong>برايم بوينت إن</strong> تجربة طعام بسيطة وممتعة. ابدأ يومك ببوفيه إفطار مجاني يضم مجموعة من الأطباق المفضلة للأطفال وخيارات صحية. كما يقدم المقهى الموجود في الموقع وجبات خفيفة ومشروبات طوال اليوم، مثالية للعائلات التي تتحرك بسرعة. بالإضافة إلى ذلك، تقع العديد من المطاعم المحلية الشهيرة على بُعد مسافة قصيرة سيرًا على الأقدام، لتجربة طعام ممتعة.</p>\r\n<p>يتميز الفندق أيضًا بمرافق مخصصة للترفيه العائلي، بما في ذلك مسبح خارجي متلألئ، ومنطقة لعب للأطفال، وصالة مريحة مزودة بألعاب لوحية وكتب. يمكن للآباء الاسترخاء بينما يستمتع الأطفال، مما يخلق لحظات من الراحة والتواصل لجميع أفراد العائلة.</p>\r\n<p>لتوفير الراحة، يقدم <strong>برايم بوينت إن</strong> مواقف سيارات واسعة، ومكتب استقبال يعمل على مدار الساعة، وفريق عمل ودود على استعداد للمساعدة في تقديم توصيات محلية أو تلبية الطلبات الخاصة. سواء كان الأمر يتعلق بترتيب تذاكر للمعالم السياحية أو تقديم نصائح حول المطاعم المناسبة للعائلات، فإن الفريق ملتزم بضمان إقامة خالية من المتاعب.</p>\r\n<p>استمتع بالمزيج المثالي من الراحة والمرح وحسن الضيافة في <strong>برايم بوينت إن</strong>. هنا، تم تصميم كل التفاصيل لجعل إجازة عائلتك لا تُنسى. تبدأ مغامرتك في برايم بوينت إن – المكان الذي تُصنع فيه ذكريات العائلة</p>', NULL, NULL, '2024-12-01 21:15:54', '2024-12-01 21:15:54'),
(9, 20, 5, 1, 4, 4, 1, 'Comfort Luxe Suites', 'comfort-luxe-suites', '123 Little Collins Street, Melbourne VIC 3000, Australia', '[\"1\",\"2\",\"3\",\"4\",\"8\",\"9\",\"10\",\"11\"]', '<h3>Welcome to Comfort Luxe Suites</h3>\r\n<p>Nestled in the heart of your dream destination, <strong>Comfort Luxe Suites</strong> is a sanctuary of elegance, sophistication, and unparalleled comfort. Designed to cater to discerning travelers who seek the finer things in life, our hotel offers an exquisite blend of modern luxury and timeless charm. Whether you are visiting for leisure, business, or a special occasion, Comfort Luxe Suites promises an unforgettable experience.</p>\r\n<h3>Accommodations That Redefine Luxury</h3>\r\n<p>Our spacious suites are thoughtfully crafted to provide the ultimate retreat. Each room features contemporary furnishings, premium bedding, and floor-to-ceiling windows that flood the space with natural light while offering breathtaking views of the cityscape or serene landscapes. From state-of-the-art amenities to personalized services, every detail is designed with your comfort in mind.</p>\r\n<h3>World-Class Dining</h3>\r\n<p>Indulge your palate at our signature restaurant, where culinary artistry meets global flavors. Our chefs use only the freshest ingredients to create a menu that caters to diverse tastes. For a more relaxed setting, our rooftop lounge offers handcrafted cocktails, fine wines, and a mesmerizing ambiance under the stars.</p>\r\n<h3>Amenities That Pamper You</h3>\r\n<p>At Comfort Luxe Suites, we go above and beyond to ensure your stay is nothing short of extraordinary. Relax and rejuvenate at our full-service spa, take a refreshing dip in our infinity pool, or stay active in our state-of-the-art fitness center. For business travelers, our hotel features fully equipped meeting rooms and high-speed internet to keep you connected.</p>\r\n<h3>An Oasis of Elegance</h3>\r\n<p>Our prime location ensures that you are never far from the city\'s top attractions, cultural landmarks, and shopping districts. However, the tranquil atmosphere within Comfort Luxe Suites makes it hard to leave. From the moment you step into our grand lobby, adorned with luxurious décor and warm lighting, you will feel a sense of belonging.</p>\r\n<p>At <strong>Comfort Luxe Suites</strong>, we don\'t just offer a place to stay; we provide an experience to cherish forever. Your comfort is our commitment, and your satisfaction is our guarantee.</p>', NULL, NULL, '2024-12-01 21:25:50', '2025-01-03 20:47:06'),
(10, 21, 5, 5, 8, 8, 9, 'أجنحة كومفورت لوكس', 'أجنحة-كومفورت-لوكس', '123 شارع ليتل كولينز، ملبورن VIC 3000، أستراليا', '[\"14\",\"15\",\"16\",\"18\",\"19\",\"21\",\"23\"]', '<h3>مرحبًا بكم في كومفورت لوكس سويتس</h3>\r\n<p>يقع <strong>كومفورت لوكس سويتس</strong> في قلب وجهتك المثالية، وهو ملاذ من الأناقة والرقي والراحة التي لا مثيل لها. تم تصميم الفندق خصيصًا لتلبية احتياجات المسافرين الذين يبحثون عن أرقى مستويات الرفاهية، حيث يجمع بين الفخامة العصرية والسحر الكلاسيكي. سواء كنت تزورنا للاستجمام أو العمل أو للاحتفال بمناسبة خاصة، فإن كومفورت لوكس سويتس يعدك بتجربة لا تُنسى.</p>\r\n<h3>إقامة تُعيد تعريف الفخامة</h3>\r\n<p>تم تصميم أجنحتنا الفسيحة بعناية لتوفير ملاذ مثالي. تتميز كل غرفة بأثاث عصري وأسرّة فاخرة ونوافذ ممتدة من الأرض إلى السقف تُغمر الغرفة بالضوء الطبيعي، وتوفر إطلالات خلابة على أفق المدينة أو المناظر الطبيعية الهادئة. من المرافق الحديثة إلى الخدمات الشخصية، يتم الاهتمام بكل تفصيلة لتلبية راحتك.</p>\r\n<h3>تجربة طعام عالمية المستوى</h3>\r\n<p>دلّل حواسك في مطعمنا المميز، حيث يلتقي فن الطهي بنكهات عالمية مميزة. يستخدم طهاتنا أفضل المكونات الطازجة لإعداد قائمة طعام تُرضي مختلف الأذواق. وللحصول على أجواء أكثر استرخاءً، يمكنك الاستمتاع بالمشروبات الفاخرة والكوكتيلات في صالة السطح التي توفر أجواء ساحرة تحت النجوم.</p>\r\n<h3>مرافق تدللك</h3>\r\n<p>في كومفورت لوكس سويتس، نعمل جاهدين لضمان أن تكون إقامتك استثنائية بكل المقاييس. استرخِ واستعد نشاطك في السبا الخاص بنا، استمتع بالسباحة في حمام السباحة اللامتناهي، أو حافظ على لياقتك في مركز اللياقة البدنية الحديث. ولرجال الأعمال، نوفر غرف اجتماعات مجهزة بالكامل وإنترنت عالي السرعة لإبقائك متصلاً.</p>\r\n<h3>واحة من الأناقة</h3>\r\n<p>يضمن موقعنا المتميز أنك قريب دائمًا من أبرز معالم المدينة الثقافية والسياحية ومناطق التسوق. ومع ذلك، فإن الأجواء الهادئة داخل كومفورت لوكس سويتس تجعل مغادرة الفندق أمرًا صعبًا. من اللحظة التي تخطو فيها إلى بهونا الكبير، المزدان بديكورات فاخرة وإضاءة دافئة، ستشعر وكأنك في منزلك.</p>\r\n<p>في <strong>كومفورت لوكس سويتس</strong>، لا نوفر فقط مكانًا للإقامة، بل نقدم تجربة ستبقى في ذاكرتك إلى الأبد. راحتك هي التزامنا، ورضاك هو هدفن</p>', NULL, NULL, '2024-12-01 21:25:50', '2025-01-03 20:47:06'),
(11, 20, 6, 4, 2, NULL, 4, 'Elite Rendezvous', 'elite-rendezvous', 'Bangladesh Agricultural Development Corporation (BADC), Chattogram, Bangladesh', '[\"3\",\"4\",\"7\",\"8\",\"9\"]', '<h3><strong>Elite Rendezvous</strong> at Comfort Luxe Suites</h3>\r\n<p><strong>Elite Rendezvous</strong> is an exclusive gathering designed for the distinguished few who appreciate the finer things in life. Hosted at the luxurious <strong>Comfort Luxe Suites</strong>, this event brings together influential individuals, thought leaders, and professionals in an intimate setting where networking, collaboration, and celebration flourish. Whether you\'re looking to form new connections, celebrate milestones, or indulge in an evening of elegance, <strong>Elite Rendezvous</strong> promises an unforgettable experience.</p>\r\n<p>From the moment you step into the venue, you are transported into a world of sophistication. The chic decor, featuring modern art, plush furnishings, and ambient lighting, sets the perfect tone for an evening of refined luxury. Guests are treated to an evening that blends gourmet dining, fine wines, and bespoke entertainment, all curated to ensure a memorable time for every attendee.</p>\r\n<h3><strong>A Night of Unparalleled Luxury</strong></h3>\r\n<p>The event features a selection of curated experiences, including personalized service from dedicated hosts, a selection of exquisite dishes prepared by world-class chefs, and hand-crafted cocktails that reflect the latest trends in mixology. The atmosphere is set to encourage meaningful conversations, fostering networking opportunities among the elite guests in attendance. Whether you\'re in the mood to unwind with a glass of champagne or participate in a lively discussion, the ambiance at <strong>Elite Rendezvous</strong> offers something for everyone.</p>\r\n<h3><strong>An Experience Tailored to You</strong></h3>\r\n<p>For those seeking a more private and intimate experience, VIP lounges and exclusive spaces are available, providing an extra level of luxury and discretion. Our luxury suites are available for those who wish to continue the evening in style, ensuring the experience extends well beyond the event itself.</p>\r\n<h3><strong>Why Attend?</strong></h3>\r\n<p><strong>Elite Rendezvous</strong> is more than just an event—it’s a celebration of success, culture, and connection. It’s where high-level professionals, entrepreneurs, and creative minds come together to exchange ideas and experiences in an exclusive, luxury setting. At <strong>Comfort Luxe Suites</strong>, we pride ourselves on creating an environment where elegance and exclusivity meet, making <strong>Elite Rendezvous</strong> the must-attend event for the discerning guest.</p>\r\n<p>Join us for an evening that celebrates the exceptional</p>', NULL, NULL, '2024-12-01 21:31:22', '2024-12-01 21:31:22'),
(12, 21, 6, 8, 6, NULL, 12, 'لقاء النخبة', 'لقاء-النخبة', 'مؤسسة بنغلاديش للتنمية الزراعية (BADC)، تشاتوجرام، بنغلاديش', '[\"13\",\"15\",\"19\",\"20\",\"21\",\"22\"]', '<h3><strong>اللقاء الراقي</strong> في كومفورت لوكس سويتس</h3>\r\n<p><strong>اللقاء الراقي</strong> هو تجمع حصري مصمم للعدد القليل المميز من الأشخاص الذين يقدرون الفخامة والرفاهية. يُقام هذا الحدث في <strong>كومفورت لوكس سويتس</strong> الفاخر، حيث يجمع بين الشخصيات المؤثرة، وقادة الفكر، والمحترفين في بيئة حميمية تشجع على التواصل، والتعاون، والاحتفال. سواء كنت ترغب في إقامة علاقات جديدة، أو الاحتفال بالإنجازات، أو التمتع بأمسية مليئة بالأناقة، فإن <strong>اللقاء الراقي</strong> يعدك بتجربة لا تُنسى.</p>\r\n<p>من اللحظة التي تخطو فيها إلى المكان، ستجد نفسك في عالم من sophistication (الرقي). الديكور العصري، والفن الحديث، والأثاث الفاخر، والإضاءة المحيطية تخلق أجواء مثالية لأمسية من الفخامة الرفيعة. يتمتع الضيوف بأمسية تمزج بين المأكولات الراقية، والنبيذ الفاخر، والترفيه المخصص، وكل ذلك مصمم لضمان تجربة مميزة لكل الحاضرين.</p>\r\n<h3><strong>ليلة من الفخامة اللامتناهية</strong></h3>\r\n<p>يشمل الحدث مجموعة من التجارب المميزة، بما في ذلك خدمة شخصية من مضيفين مكرسين، واختيار من الأطباق الراقية التي أعدها طهاتنا العالميون، وكوكتيلات مصممة خصيصًا تعكس أحدث اتجاهات فنون صناعة المشروبات. تم تصميم الأجواء لتشجيع المحادثات ذات المغزى، مما يتيح فرصًا للتواصل بين الضيوف الرفيعين الحاضرين. سواء كنت ترغب في الاسترخاء مع كأس من الشمبانيا أو المشاركة في نقاش حي، فإن الأجواء في <strong>اللقاء الراقي</strong> توفر شيئًا للجميع.</p>\r\n<h3><strong>تجربة مخصصة لك</strong></h3>\r\n<p>لمن يبحثون عن تجربة أكثر خصوصية وحميمية، تتوفر صالات VIP والمساحات الخاصة، التي توفر مستوى إضافيًا من الفخامة والسرية. كما تتوفر أجنحتنا الفاخرة لأولئك الذين يرغبون في استكمال الأمسية بأناقة، مما يضمن أن تمتد التجربة بعيدًا عن الحدث ذاته.</p>\r\n<h3><strong>لماذا يجب عليك الحضور؟</strong></h3>\r\n<p><strong>اللقاء الراقي</strong> هو أكثر من مجرد حدث، إنه احتفال بالنجاح، والثقافة، والاتصال. إنه المكان الذي يجتمع فيه المحترفون، ورجال الأعمال، والعقول المبدعة لتبادل الأفكار والخبرات في بيئة فاخرة وحصرية. في <strong>كومفورت لوكس سويتس</strong>، نفخر بخلق بيئة حيث يلتقي الأناقة بالحصريّة، مما يجعل <strong>اللقاء الراقي</strong> الحدث الذي يجب أن يحضره الضيوف المميزون.</p>\r\n<p>انضم إلينا في أمسية تحتفل بالاستثنائي</p>', NULL, NULL, '2024-12-01 21:31:22', '2024-12-01 21:31:22'),
(13, 20, 7, 3, 1, 2, 8, 'Family Nest Inn', 'family-nest-inn', '30 Journey, Aliso Viejo, CA 92656, USA', '[\"1\",\"2\",\"7\",\"8\",\"9\",\"10\"]', '<p><strong>Family Nest Inn</strong> offers a warm, welcoming environment for families seeking a cozy and relaxing getaway. Nestled in a serene location, this family-friendly hotel is designed with comfort and convenience in mind, providing a perfect retreat for guests of all ages. Whether you\'re planning a vacation, a weekend getaway, or a special family celebration, Family Nest Inn offers an unforgettable experience for everyone.</p>\r\n<p>Our spacious rooms are thoughtfully appointed to cater to families, featuring comfortable beds, modern amenities, and plenty of room to relax and unwind. We offer family suites that provide extra space and convenient access to all hotel facilities. For younger guests, we offer child-friendly amenities such as cribs, high chairs, and family-friendly room setups to ensure a comfortable stay for little ones.</p>\r\n<p>At Family Nest Inn, we understand the importance of quality time spent together. Our on-site dining options include a family-friendly restaurant with a variety of delicious meals suitable for all tastes. We also offer a children’s menu, ensuring that even the pickiest eaters can find something they love.</p>\r\n<p>The hotel features a range of activities designed to keep the whole family entertained. Kids can enjoy our dedicated play area, while parents can relax by the pool or explore the nearby attractions. For those looking for more adventure, we offer family tours and outdoor activities, allowing you to explore the local area together.</p>\r\n<p>Family Nest Inn is also equipped with modern conveniences like free Wi-Fi, meeting spaces for family events, and excellent customer service to ensure that your stay is as enjoyable and stress-free as possible. With its cozy atmosphere and family-focused amenities, Family Nest Inn is the ideal choice for your next family vacation.</p>', NULL, NULL, '2024-12-01 21:41:54', '2024-12-01 21:41:54'),
(14, 21, 7, 7, 5, 6, 16, 'فاميلي نيست إن', 'فاميلي-نيست-إن', '30 جيرني، أليسو فيجو، كاليفورنيا 92656، الولايات المتحدة الأمريكية', '[\"14\",\"18\",\"20\",\"21\",\"24\"]', '<p><strong>فاميلي نيست إن</strong> هو فندق يقدم بيئة دافئة ومرحبة للعائلات التي تبحث عن مكان مريح وهادئ للاسترخاء. يقع في مكان هادئ، تم تصميم هذا الفندق العائلي مع الراحة والسهولة في الاعتبار، مما يجعله المكان المثالي للضيوف من جميع الأعمار. سواء كنت تخطط لقضاء عطلة، أو إجازة نهاية أسبوع، أو احتفال عائلي خاص، يوفر فندق فاميلي نيست إن تجربة لا تُنسى للجميع.</p>\r\n<p>تتميز غرفنا بالمساحات الواسعة والتصميم المدروس لتلبية احتياجات العائلات، مع أسرة مريحة، ووسائل الراحة الحديثة، ومساحة واسعة للاسترخاء. نقدم أيضًا أجنحة عائلية توفر مزيدًا من المساحة والوصول المريح إلى جميع مرافق الفندق. ولضيوفنا الصغار، نوفر وسائل راحة صديقة للأطفال مثل الأسرة القابلة للطي، والكراسي العالية، وترتيبات الغرف العائلية لضمان إقامة مريحة للأطفال.</p>\r\n<p>في فاميلي نيست إن، نحن نفهم أهمية قضاء وقت ممتع معًا كعائلة. تشمل خيارات الطعام في الفندق مطعمًا عائليًا يقدم مجموعة متنوعة من الوجبات الشهية التي تناسب جميع الأذواق. كما نقدم قائمة طعام للأطفال لضمان أن يجد الأطفال من جميع الأعمار ما يحبونه.</p>\r\n<p>يتميز الفندق أيضًا بمجموعة من الأنشطة التي تهدف إلى إبقاء العائلة بأكملها مستمتعة. يمكن للأطفال الاستمتاع بمنطقة اللعب المخصصة، بينما يمكن للآباء الاسترخاء بجانب المسبح أو استكشاف المعالم السياحية القريبة. لأولئك الذين يبحثون عن المزيد من المغامرة، نقدم جولات وأنشطة عائلية في الهواء الطلق لاستكشاف المنطقة معًا.</p>\r\n<p>يضم فاميلي نيست إن أيضًا وسائل راحة حديثة مثل الواي فاي المجاني، ومساحات للاجتماعات للأحداث العائلية، وخدمة عملاء ممتازة لضمان أن تكون إقامتك مريحة وخالية من الإجهاد. مع أجوائه المريحة ووسائل الراحة الموجهة نحو العائلة، يعد فاميلي نيست إن الخيار المثالي لعطلتك العائلية القادمة</p>', NULL, NULL, '2024-12-01 21:41:54', '2024-12-01 21:41:54'),
(15, 20, 8, 2, 2, NULL, 4, 'Hourly Haven', 'hourly-haven', 'Nasirabad Housing Society, Panchlaish, Chittagong, Bangladesh', '[\"2\",\"4\",\"6\",\"8\",\"9\",\"10\"]', '<p>Hourly Haven is a premier business hotel designed to cater to the unique needs of corporate travelers. Conveniently located in the heart of the city, it offers a flexible and efficient accommodation solution for professionals who need a comfortable space to rest, work, or host meetings without the commitment of traditional overnight stays. Whether you\'re in town for a few hours or a day, Hourly Haven provides a variety of services tailored to your schedule.</p>\r\n<p>Our rooms are equipped with modern amenities, including high-speed internet, ergonomic workstations, and comfortable seating areas to ensure that you can stay productive and relaxed throughout your visit. Each room is designed with a sleek, contemporary aesthetic that fosters an environment conducive to both business and relaxation. With options to book rooms by the hour, Hourly Haven offers unmatched flexibility, making it ideal for professionals in between meetings, travelers with long layovers, or those looking for a quiet space to concentrate.</p>\r\n<p>Hourly Haven also features fully-equipped meeting rooms that can be booked for brief corporate events or team collaborations. Our staff is dedicated to providing exceptional service, from offering business support services to organizing catering for your meetings. For those looking to unwind, the hotel offers a range of recreational facilities, including a fitness center and a lounge area where you can relax and rejuvenate.</p>\r\n<p>In addition, Hourly Haven provides easy access to major business hubs, transportation links, and local dining options, ensuring that your time in the city is both productive and enjoyable. Whether you need a quick break between meetings or a temporary office space, Hourly Haven is the perfect place to recharge and stay on top of your business commitments.</p>', NULL, NULL, '2024-12-01 22:02:34', '2024-12-01 23:29:29'),
(16, 21, 8, 6, 6, NULL, 12, 'كل ساعة ملاذ', 'كل-ساعة-ملاذ', 'جمعية ناصر آباد للإسكان، بانشليش، شيتاغونغ، بنغلاديش', '[\"14\",\"16\",\"18\",\"20\",\"21\"]', '<p>Hourly Haven هو فندق مخصص للأعمال، تم تصميمه لتلبية احتياجات المسافرين من رجال الأعمال الذين يبحثون عن تجربة إقامة مرنة ومريحة. يقع الفندق في قلب المدينة، ويوفر حلًّا مريحًا وفعالًا للمحترفين الذين يحتاجون إلى مساحة للراحة أو العمل أو لعقد الاجتماعات دون الالتزام بالإقامة التقليدية طوال الليل. سواء كنت في المدينة لبضع ساعات أو ليوم كامل، يقدم Hourly Haven مجموعة من الخدمات التي تناسب جدول أعمالك.</p>\r\n<p>غرفنا مجهزة بأحدث وسائل الراحة، بما في ذلك الإنترنت عالي السرعة، ومحطات العمل المريحة، ومساحات للجلوس تسمح لك بالبقاء منتجًا ومسترخيًا طوال زيارتك. تم تصميم كل غرفة بأسلوب عصري وأنيق يعزز بيئة مثالية للعمل والراحة في الوقت نفسه. مع خيار حجز الغرف بالساعة، يوفر Hourly Haven مرونة لا مثيل لها، مما يجعله مثاليًا للمهنيين بين الاجتماعات أو المسافرين الذين لديهم فترة انتظار طويلة أو أولئك الذين يحتاجون إلى مساحة هادئة للتركيز.</p>\r\n<p>كما يقدم Hourly Haven أيضًا غرف اجتماعات مجهزة بالكامل يمكن حجزها لإقامة الفعاليات القصيرة أو التعاون الجماعي. يكرس فريق العمل لدينا جهوده لتقديم خدمة استثنائية، من تقديم خدمات الدعم التجاري إلى تنظيم خدمات الطعام لاجتماعاتك. ولمن يرغب في الاسترخاء، يوفر الفندق مجموعة من المرافق الترفيهية، بما في ذلك مركز للياقة البدنية ومنطقة صالة حيث يمكنك الاستمتاع بالراحة وتجديد نشاطك.</p>\r\n<p>بالإضافة إلى ذلك، يوفر Hourly Haven سهولة الوصول إلى المراكز التجارية الرئيسية ووسائل النقل وخيارات الطعام المحلية، مما يضمن لك تجربة عمل ممتعة ومنتجة في المدينة. سواء كنت بحاجة إلى استراحة سريعة بين الاجتماعات أو إلى مساحة عمل مؤقتة، يعد Hourly Haven المكان المثالي للاسترخاء والبقاء على قمة التزاماتك المهنية.</p>', NULL, NULL, '2024-12-01 22:02:34', '2024-12-01 22:03:23'),
(17, 20, 9, 2, 4, 4, 1, 'QuickStop Hotel', 'quickstop-hotel', 'Australian Institute of Higher Education (AIH), Queen Street, Melbourne Victoria 3000, Australia', '[\"1\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\"]', '<p><strong>QuickStop Hotel</strong>: Where Business Meets Convenience</p>\r\n<p>Welcome to <strong>QuickStop Hotel</strong>, your ultimate destination for efficient, comfortable, and flexible stays tailored to the modern business traveler. Located in the heart of the city’s bustling business district, QuickStop Hotel is designed with a perfect blend of professionalism, luxury, and practicality, offering an unparalleled experience for those on the go.</p>\r\n<p>At QuickStop Hotel, we understand the dynamic nature of business life. Whether you need a few hours to relax between meetings, host a quick conference, or catch up on some much-needed rest during a layover, we are here to accommodate your every need. With our hourly booking options, you only pay for the time you need, ensuring both affordability and convenience.</p>\r\n<p>Our elegantly designed rooms are equipped with high-speed Wi-Fi, ergonomic workspaces, and plush bedding to help you stay productive and rejuvenated. Each room also features modern amenities such as smart TVs, a minibar, and power outlets thoughtfully placed for seamless functionality.</p>\r\n<p>QuickStop Hotel boasts state-of-the-art meeting rooms and co-working spaces, making it an ideal choice for professionals looking to collaborate or finalize deals in a comfortable yet professional environment. Additionally, our business lounge provides a tranquil space for casual networking over a cup of gourmet coffee.</p>\r\n<p>For guests seeking relaxation, our on-site fitness center and spa facilities offer a refreshing escape from the day\'s stress. Savor delicious meals at our in-house restaurant, which serves an array of international cuisines prepared by top chefs, or grab a quick bite from our 24/7 café.</p>\r\n<p>Strategically located near major transportation hubs, corporate offices, and key city attractions, QuickStop Hotel ensures you’re always well-connected. Our efficient and friendly staff are available around the clock to assist with bookings, travel arrangements, and any special requests to make your stay seamless and hassle-free.</p>\r\n<p>Experience the perfect synergy of convenience, comfort, and productivity at QuickStop Hotel — the preferred choice for business professionals who value their time and demand excellence. Whether for a fleeting visit or a longer stay, we are committed to meeting your needs with precision and style.</p>', NULL, NULL, '2024-12-01 22:24:27', '2024-12-01 22:24:27'),
(18, 21, 9, 6, 8, 8, 9, 'فندق كويك ستوب', 'فندق-كويك-ستوب', 'المعهد الأسترالي للتعليم العالي (AIH)، شارع كوين، ملبورن فيكتوريا 3000، أستراليا', '[\"14\",\"15\",\"16\",\"18\",\"20\",\"21\",\"22\",\"23\"]', '<p><strong>فندق كويك ستوب: حيث تلتقي الأعمال بالراحة</strong></p>\r\n<p>مرحبًا بكم في <strong>فندق كويك ستوب</strong>، وجهتكم المثالية للإقامة المريحة والمرنة المصممة خصيصًا لتلبية احتياجات المسافرين من رجال الأعمال العصريين. يقع الفندق في قلب المنطقة التجارية النابضة بالحياة، ويجمع بين الاحترافية والفخامة والعملية ليقدم تجربة لا مثيل لها لمن هم دائمًا في حركة مستمرة.</p>\r\n<p>في <strong>فندق كويك ستوب</strong>، ندرك الطبيعة الديناميكية لحياة رجال الأعمال. سواء كنت بحاجة إلى بضع ساعات للاسترخاء بين الاجتماعات، أو عقد مؤتمر سريع، أو الحصول على قسط من الراحة خلال فترة توقف، نحن هنا لتلبية كل احتياجاتك. مع خيارات الحجز بالساعة، تدفع فقط مقابل الوقت الذي تحتاجه، مما يضمن لك الراحة والتوفير.</p>\r\n<p>تم تصميم غرفنا بأناقة وتجهزت بخدمة الواي فاي عالية السرعة، ومساحات عمل مريحة، وأسرة فاخرة لمساعدتك على البقاء منتجًا ومستريحًا. كما تحتوي كل غرفة على وسائل راحة حديثة مثل تلفزيونات ذكية، ميني بار، ومنافذ طاقة موضوعة بعناية لتوفير سهولة الاستخدام.</p>\r\n<p>يضم <strong>فندق كويك ستوب</strong> غرف اجتماعات حديثة ومساحات عمل مشتركة، مما يجعله الخيار المثالي للمهنيين الذين يبحثون عن بيئة مريحة ومهنية في الوقت نفسه. بالإضافة إلى ذلك، يوفر الصالون الخاص برجال الأعمال مساحة هادئة للتواصل الاجتماعي أو الاستمتاع بفنجان من القهوة الفاخرة.</p>\r\n<p>للنزلاء الباحثين عن الاسترخاء، نقدم مركزًا للياقة البدنية ومنتجعًا صحيًا يوفران ملاذًا منعشًا بعيدًا عن ضغوط اليوم. استمتع بوجبات شهية في مطعمنا الذي يقدم مجموعة متنوعة من المأكولات العالمية المحضرة على يد أمهر الطهاة، أو احصل على وجبة سريعة من المقهى الذي يعمل على مدار الساعة.</p>\r\n<p>بموقع استراتيجي بالقرب من مراكز النقل الرئيسية والمكاتب التجارية والمعالم السياحية في المدينة، يضمن لك <strong>فندق كويك ستوب</strong> البقاء دائمًا على اتصال. كما أن فريق عملنا الكفؤ والصديق متوفر على مدار الساعة للمساعدة في الحجوزات، وترتيبات السفر، وأي طلبات خاصة لضمان إقامة مريحة وخالية من المتاعب.</p>\r\n<p>اختبر التوازن المثالي بين الراحة والإنتاجية في <strong>فندق كويك ستوب</strong>، الخيار المفضل للمحترفين الذين يقدرون وقتهم ويبحثون عن التميز. سواء كنت تقيم لفترة قصيرة أو طويلة، نحن ملتزمون بتلبية احتياجاتك بدقة وأناقة</p>', NULL, NULL, '2024-12-01 22:24:27', '2024-12-01 22:24:27'),
(19, 20, 10, 1, 2, NULL, 7, 'Starlight Royale', 'starlight-royale', 'Dhaka, Bangladesh', '[\"1\",\"2\",\"3\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\"]', '<p><strong>Starlight Royale</strong> is a premier luxury hotel nestled in the heart of a vibrant city, offering an unparalleled experience for those seeking indulgence, comfort, and opulence. The hotel stands as a beacon of elegance, designed to captivate with its modern yet timeless architecture, where every corner exudes sophistication. With a name that reflects its enchanting allure, <strong>Starlight Royale</strong> provides a sanctuary where guests can escape into a world of luxury and tranquility.</p>\r\n<p>From the moment you step into the grand lobby, you’re welcomed by a sense of refinement. The design is a seamless blend of contemporary style and classic opulence, featuring marble floors, shimmering chandeliers, and tasteful artwork that embodies grace. The hotel boasts a selection of exquisitely designed rooms and suites, each tailored for ultimate comfort. Whether it\'s the panoramic city views, plush bedding, or state-of-the-art amenities, every detail has been meticulously crafted to offer an extraordinary stay.</p>\r\n<p>Guests at <strong>Starlight Royale</strong> can enjoy an array of world-class dining options, from gourmet fine dining restaurants to casual cafes offering delectable treats. The signature restaurant, <strong>Celestial Dining</strong>, serves a fusion of international flavors, prepared by master chefs who elevate every dish to an art form. For those seeking relaxation, the <strong>Starlight Spa</strong> provides a serene retreat with rejuvenating treatments, while the rooftop pool offers sweeping views of the skyline, perfect for unwinding under the stars.</p>\r\n<p>In addition to luxury accommodations, <strong>Starlight Royale</strong> is equipped with a full range of services designed to cater to the needs of every guest. Whether hosting a business conference in one of the modern meeting rooms or celebrating a special occasion in the grand ballroom, the hotel offers unparalleled event planning services.</p>\r\n<p>With a reputation for exceptional service and attention to detail, <strong>Starlight Royale</strong> is the perfect destination for discerning travelers seeking a lavish escape. The hotel promises an unforgettable experience, where every stay is marked by unparalleled elegance, comfort, and grace.</p>', NULL, NULL, '2024-12-01 23:12:49', '2024-12-28 21:25:08'),
(20, 21, 10, 5, 6, NULL, 15, 'ستارلايت رويال', 'ستارلايت-رويال', 'بناني، دكا-1213، طريق 8، دكا، بنغلاديش', '[\"14\",\"15\",\"19\",\"20\",\"21\"]', '<p><strong>ستارلايت رويال</strong> هو فندق فاخر يقع في قلب مدينة نابضة بالحياة، يقدم تجربة لا مثيل لها لأولئك الذين يبحثون عن الرفاهية والراحة والفخامة. يقف الفندق كمنارة للأناقة، مصمم ليأسر الأنظار بهندسته المعمارية العصرية التي تمزج بين الكلاسيكية والتصميم الحديث، حيث ينبعث من كل زاوية شعور بالفخامة. مع اسمه الذي يعكس جاذبيته الساحرة، يوفر <strong>ستارلايت رويال</strong> ملاذًا حيث يمكن للضيوف الهروب إلى عالم من الفخامة والهدوء.</p>\r\n<p>من اللحظة التي تطأ فيها قدماك الردهة الكبرى، يتم استقبالك بشعور من الرقي. التصميم هو مزيج سلس من الأسلوب المعاصر والفخامة الكلاسيكية، مع أرضيات من الرخام، وثريات لامعة، وأعمال فنية ذات ذوق رفيع تعكس الأناقة. يضم الفندق مجموعة من الغرف والأجنحة المصممة بشكل استثنائي، حيث يتم تخصيص كل واحدة لتوفير أقصى درجات الراحة. سواء كانت الإطلالات على المدينة البانورامية أو الأسرة الفاخرة أو وسائل الراحة الحديثة، فقد تم الاهتمام بكل تفاصيل لتقديم إقامة استثنائية.</p>\r\n<p>يمكن للضيوف في <strong>ستارلايت رويال</strong> الاستمتاع بمجموعة من خيارات الطعام العالمية، من المطاعم الفاخرة إلى المقاهي العصرية التي تقدم أطباقًا لذيذة. يقدم المطعم المميز، <strong>سيلستيال داينينغ</strong>، مزيجًا من النكهات العالمية التي يعدها طهاة ماهرون يرفعون كل طبق إلى فن بديع. لأولئك الذين يبحثون عن الاسترخاء، يوفر <strong>سبا ستارلايت</strong> ملاذًا هادئًا مع علاجات تجميلية وتجديدية، في حين أن المسبح الموجود على السطح يقدم إطلالات ساحرة على الأفق، مما يجعله المكان المثالي للاسترخاء تحت النجوم.</p>\r\n<p>بالإضافة إلى الإقامة الفاخرة، يوفر <strong>ستارلايت رويال</strong> مجموعة كاملة من الخدمات التي تلبي احتياجات كل ضيف. سواء كنت تستضيف مؤتمرًا تجاريًا في أحد الغرف الحديثة للاجتماعات أو تحتفل بمناسبة خاصة في القاعة الكبرى، يوفر الفندق خدمات تخطيط فعاليات استثنائية.</p>\r\n<p>بسمعة استثنائية في تقديم الخدمة والانتباه للتفاصيل، يعد <strong>ستارلايت رويال</strong> الوجهة المثالية للمسافرين المميزين الذين يبحثون عن هروب فاخر. يضمن الفندق تجربة لا تُنسى، حيث تتميز كل إقامة بالأناقة والراحة والرفاهية التي لا مثيل لها</p>', NULL, NULL, '2024-12-01 23:12:49', '2024-12-01 23:12:49');
INSERT INTO `hotel_contents` (`id`, `language_id`, `hotel_id`, `category_id`, `country_id`, `state_id`, `city_id`, `title`, `slug`, `address`, `amenities`, `description`, `meta_keyword`, `meta_description`, `created_at`, `updated_at`) VALUES
(21, 20, 11, 4, 3, 9, 17, 'Majestic Events Hotel', 'majestic-events-hotel', 'indian restaurant near Victoria Memorial Eastern Garden, 1, Queens Way, Maidan, Kolkata, West Bengal 700071, India', '[\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\"]', '<p><strong>Majestic Events Hotel</strong> offers a luxurious and sophisticated venue for all your event needs. Whether you\'re hosting a corporate conference, a grand wedding, a private celebration, or a community gathering, our hotel provides the perfect setting for any occasion. Located in a prime location with easy access to the city’s main attractions, the hotel combines elegance with convenience to create an unforgettable experience for both hosts and guests.</p>\r\n<p>The hotel features a range of versatile event spaces, from spacious ballrooms to intimate meeting rooms, each designed to cater to different group sizes and styles. Our state-of-the-art audiovisual equipment and high-speed internet ensure that every presentation, seminar, or live performance is a success. Our professional event planning team is dedicated to helping you with every detail—from selecting the right space to coordinating catering, decor, and entertainment, ensuring that your event is seamless and stress-free.</p>\r\n<p>The hotel’s luxurious accommodations provide a comfortable and restful retreat for guests attending events. Whether you\'re in town for a day or staying for an extended period, our spacious rooms are equipped with modern amenities, offering the perfect balance of comfort and style. For larger events, our suites and executive rooms offer premium services to ensure an elevated experience.</p>\r\n<p>In addition to our exceptional event facilities, <strong>Majestic Events Hotel</strong> offers a variety of dining options, with a choice of gourmet restaurants and bars that can cater to different tastes and preferences. Our catering team is also available to create customized menus for your event, whether you’re looking for a formal sit-down dinner or a casual buffet-style meal.</p>\r\n<p>At <strong>Majestic Events Hotel</strong>, we take pride in offering unparalleled service and an extraordinary setting that makes every event, big or small, truly majestic. Let us help you create memories that will last a lifetime</p>', NULL, NULL, '2024-12-01 23:24:06', '2024-12-01 23:24:06'),
(22, 21, 11, 8, 7, 10, 18, 'فندق ماجستيك للمناسبات', 'فندق-ماجستيك-للمناسبات', 'مطعم هندي بالقرب من فيكتوريا ميموريال الحديقة الشرقية، 1، طريق كوينز، ماييدان، كولكاتا، ولاية البنغال الغربية 700071، الهند', '[\"13\",\"14\",\"16\",\"18\",\"19\",\"20\"]', '<p><strong>فندق الفعاليات المهيب</strong> يقدم لك مكانًا فاخرًا وأنيقًا لجميع احتياجاتك من الفعاليات. سواء كنت تستضيف مؤتمرًا تجاريًا، حفل زفاف فخمًا، احتفالًا خاصًا، أو تجمعًا مجتمعيًا، يوفر فندقنا البيئة المثالية لأي مناسبة. يقع الفندق في موقع متميز مع سهولة الوصول إلى أبرز معالم المدينة، ويجمع بين الأناقة والراحة لتوفير تجربة لا تُنسى لكل من المضيفين والضيوف.</p>\r\n<p>يتميز الفندق بمجموعة من المساحات متعددة الاستخدامات للفعاليات، من قاعات الرقص الفسيحة إلى غرف الاجتماعات الحميمة، كل منها مصمم لتلبية احتياجات المجموعات المختلفة والأساليب المتنوعة. تضمن المعدات الصوتية والمرئية الحديثة لدينا والإنترنت عالي السرعة أن كل عرض تقديمي أو ندوة أو عرض حي سيكون ناجحًا. فريقنا المحترف في تنظيم الفعاليات ملتزم بمساعدتك في كل التفاصيل، من اختيار المكان المناسب إلى تنسيق خدمات الطعام، الديكور، والترفيه، لضمان أن تكون فعاليتك سلسة وخالية من التوتر.</p>\r\n<p>تقدم غرف الفندق الفاخرة مكان إقامة مريح ومريح للضيوف الذين يحضرون الفعاليات. سواء كنت في المدينة لمدة يوم أو مبيت لفترة أطول، فإن غرفنا الواسعة مجهزة بأحدث وسائل الراحة، مما يوفر توازنًا مثاليًا بين الراحة والأناقة. وللفعاليات الكبيرة، تقدم الأجنحة والغرف التنفيذية خدمات متميزة لضمان تجربة استثنائية.</p>\r\n<p>بالإضافة إلى مرافق الفعاليات الاستثنائية، يقدم <strong>فندق الفعاليات المهيب</strong> مجموعة متنوعة من خيارات الطعام، مع اختيار من المطاعم الراقية والحانات التي يمكنها تلبية مختلف الأذواق والتفضيلات. كما يتوفر فريق خدمات الطعام لدينا لإعداد قوائم طعام مخصصة لفعالياتك، سواء كنت تبحث عن عشاء رسمي أو بوفيه غير رسمي.</p>\r\n<p>في <strong>فندق الفعاليات المهيب</strong>، نحرص على تقديم خدمة لا مثيل لها وإعداد استثنائي يجعل كل فعالية، كبيرة أو صغيرة، رائعة بكل معنى الكلمة. دعنا نساعدك في خلق ذكريات تدوم إلى الأبد</p>', NULL, NULL, '2024-12-01 23:24:06', '2024-12-01 23:24:06'),
(23, 20, 12, 1, 2, NULL, 3, 'Opulent Oasis', 'opulent-oasis', 'Bangladesh Oceanographic Research Institute (BORI), Z1098, Pechardwip, Cox\'s Bazar District, Chittagong Division, Bangladesh', '[\"1\",\"2\",\"6\",\"7\",\"8\",\"10\"]', '<p><strong>Opulent Oasis</strong> is an exquisite luxury hotel designed to offer an unparalleled experience of comfort, elegance, and world-class hospitality. Nestled in a serene location, this opulent haven is a perfect retreat for those seeking relaxation, rejuvenation, and an indulgent escape from the stresses of daily life.</p>\r\n<p>As soon as you step into the grand lobby of Opulent Oasis, you\'re greeted by a stunning blend of contemporary design and timeless luxury. The high ceilings, elegant chandeliers, and plush furnishings create a warm, inviting atmosphere, setting the tone for your stay. Each room is thoughtfully designed to offer the utmost in comfort, featuring luxurious bedding, modern amenities, and breathtaking views of the surrounding landscape.</p>\r\n<p>Opulent Oasis takes pride in providing guests with an array of exceptional services and facilities. Whether you\'re looking to unwind by the pristine pool, indulge in a spa treatment, or savor gourmet cuisine at one of the hotel’s fine dining restaurants, there is something to suit every taste. The hotel also offers exclusive suites for those who seek even more privacy and space, featuring expansive living areas, private balconies, and premium services.</p>\r\n<p>The hotel’s state-of-the-art conference and event facilities make it an ideal destination for business travelers, while its stunning location and services cater to those seeking an unforgettable vacation. Guests can enjoy personalized concierge services, arrange for private excursions, or simply relax in the tranquil ambiance of this luxurious retreat.</p>\r\n<p>With impeccable attention to detail and an unwavering commitment to excellence, Opulent Oasis promises to provide an extraordinary experience that redefines luxury and creates memories that last a lifetime.</p>', NULL, NULL, '2024-12-01 23:35:18', '2024-12-10 21:42:41'),
(24, 21, 12, 5, 6, NULL, 11, 'الواحة الفخمة', 'الواحة-الفخمة', 'معهد بنغلاديش لبحوث علوم المحيطات (BORI)، Z1098، Pechardwip، منطقة كوكس بازار، قسم شيتاغونغ، بنغلاديش', '[\"13\",\"14\",\"16\",\"18\",\"21\",\"23\"]', '<p><strong>واحة الرفاهية</strong> هو فندق فاخر مصمم لتقديم تجربة لا مثيل لها من الراحة والأناقة والضيافة العالمية. يقع في موقع هادئ، ويعد ملاذًا مثاليًا لأولئك الذين يبحثون عن الاسترخاء والتجديد والهروب الفاخر من ضغوط الحياة اليومية.</p>\r\n<p>منذ اللحظة التي تدخل فيها اللوبي الكبير لفندق واحة الرفاهية، يتم استقبالك بمزيج رائع من التصميم المعاصر والفخامة الخالدة. الأسقف العالية، والثريات الأنيقة، والأثاث الفاخر تخلق جوًا دافئًا وترحيبيًا، مما يحدد نغمة إقامتك. تم تصميم كل غرفة بعناية لتقديم أقصى درجات الراحة، مع سرير فاخر، ووسائل راحة حديثة، وإطلالات مذهلة على المناظر الطبيعية المحيطة.</p>\r\n<p>تفتخر واحة الرفاهية بتقديم مجموعة من الخدمات والمرافق الاستثنائية لضيوفها. سواء كنت ترغب في الاسترخاء بجانب المسبح النقي، أو التمتع بعلاج في السبا، أو تذوق المأكولات الفاخرة في أحد مطاعم الفندق الراقية، هناك دائمًا ما يناسب كل ذوق. كما يقدم الفندق أجنحة حصرية لأولئك الذين يبحثون عن المزيد من الخصوصية والمساحة، والتي تضم مناطق معيشة واسعة، وشرفات خاصة، وخدمات متميزة.</p>\r\n<p>تجعل مرافق المؤتمرات والفعاليات المتطورة في الفندق من واحة الرفاهية وجهة مثالية للمسافرين من رجال الأعمال، بينما تلبي خدماته الرائعة وموقعه المميز احتياجات أولئك الذين يبحثون عن عطلة لا تُنسى. يمكن للضيوف الاستمتاع بخدمات الكونسيرج الشخصية، وتنظيم الرحلات الخاصة، أو ببساطة الاسترخاء في الأجواء الهادئة لهذا المنتجع الفاخر.</p>\r\n<p>مع الانتباه الدقيق للتفاصيل والالتزام الثابت بالتميز، يعد فندق واحة الرفاهية بتقديم تجربة استثنائية تعيد تعريف الفخامة وتخلق ذكريات تدوم مدى الحياة.</p>', NULL, NULL, '2024-12-01 23:35:18', '2025-01-03 20:46:29'),
(25, 20, 13, 9, 3, 9, 17, 'Lavender & Lace', 'lavender-&-lace', 'Indian Museum, Jawaharlal Nehru Road, Colootola, New Market, Dharmatala, Taltala, Kolkata, West Bengal 700016, India', '[\"1\",\"3\",\"4\",\"7\",\"8\",\"9\",\"10\",\"11\"]', '<p><strong>Lavender &amp; Lace Boutique Hotel</strong></p>\r\n<p>Nestled in a serene corner of the city, <strong>Lavender &amp; Lace Boutique Hotel</strong> is a charming sanctuary that offers a blend of timeless elegance and modern comfort. The name itself evokes images of delicate lavender fields and soft, intricate lace, setting the tone for a truly unique experience. As you step into the hotel, you are immediately enveloped by an atmosphere of tranquility, where every corner whispers sophistication and warmth.</p>\r\n<p>The hotel’s design features a harmonious fusion of vintage-inspired decor with contemporary touches. Each room is carefully curated with lush lavender accents, lace curtains, and soft, inviting furniture that exude both luxury and comfort. Whether you choose a cozy room or one of our spacious suites, you will find yourself surrounded by calming hues, plush textiles, and thoughtful amenities that cater to your every need.</p>\r\n<p>Lavender &amp; Lace is more than just a place to stay; it is an escape. Begin your day with a relaxing breakfast in the beautifully decorated lounge area, where you can enjoy fresh pastries, aromatic coffee, and a variety of local delights. In the evening, unwind in the tranquil garden, where the sweet scent of lavender fills the air, creating a peaceful retreat from the hustle and bustle of everyday life.</p>\r\n<p>Our attentive staff is dedicated to providing personalized service, ensuring that every guest feels like royalty. Whether you\'re here for a romantic getaway, a special occasion, or a relaxing retreat, Lavender &amp; Lace offers an unforgettable experience that combines the luxury of a five-star hotel with the intimate feel of a home away from home.</p>\r\n<p>For those seeking a little extra indulgence, the hotel features a spa offering rejuvenating treatments, and our exclusive boutique shop provides a selection of fine handcrafted items, making Lavender &amp; Lace the perfect blend of relaxation, elegance, and style.</p>', NULL, NULL, '2024-12-01 23:45:43', '2025-01-03 20:46:09'),
(26, 21, 13, 10, 7, 10, 18, 'الخزامى والدانتيل', 'الخزامى-والدانتيل', 'شارع جواهر لال نهرو، كولوتولا، السوق الجديد، درماتالا، تالطالا، كولكاتا، ولاية البنغال الغربية 700016، الهند.', '[\"14\",\"16\",\"18\",\"20\",\"21\",\"23\"]', '<p><strong>فندق لافندر آند لايس البوتيكي</strong></p>\r\n<p>مخبأ في زاوية هادئة من المدينة، يُعتبر <strong>فندق لافندر آند لايس البوتيكي</strong> ملاذًا ساحرًا يقدم مزيجًا من الأناقة الخالدة والراحة الحديثة. الاسم نفسه يثير صورًا من حقول اللافندر الرقيقة والدانتيل الناعم والمعقد، مما يحدد نغمة تجربة فريدة حقًا. عند دخولك الفندق، يتم احتضانك على الفور بجو من الهدوء، حيث يهمس كل زاوية بالأناقة والدفء.</p>\r\n<p>تصميم الفندق يتميز بمزيج متناغم من الديكور المستوحى من الطراز الكلاسيكي مع لمسات معاصرة. تم تزيين كل غرفة بعناية مع لمسات من اللافندر الفاخر، وستائر دانتيل، وأثاث ناعم ودافئ يعكس الفخامة والراحة في آن واحد. سواء اخترت غرفة دافئة أو واحدة من الأجنحة الفسيحة، ستجد نفسك محاطًا بالألوان الهادئة، والأقمشة الفاخرة، والمرافق المدروسة التي تلبي جميع احتياجاتك.</p>\r\n<p>يعد فندق لافندر آند لايس أكثر من مجرد مكان للإقامة؛ إنه هروب حقيقي. ابدأ يومك بتناول الإفطار في منطقة الاستراحة المزينة بشكل جميل، حيث يمكنك الاستمتاع بالمخبوزات الطازجة، والقهوة العطرية، ومجموعة متنوعة من الأطباق المحلية الشهية. في المساء، استرخِ في الحديقة الهادئة حيث يملأ الهواء برائحة اللافندر الحلوة، مما يوفر ملاذًا هادئًا من ضغوط الحياة اليومية.</p>\r\n<p>فريق العمل المخلص لدينا يكرس جهوده لتقديم خدمة شخصية، مما يضمن أن يشعر كل ضيف وكأنه ملكي. سواء كنت هنا لقضاء عطلة رومانسية، أو مناسبة خاصة، أو مجرد استراحة مريحة، يقدم لافندر آند لايس تجربة لا تُنسى تجمع بين فخامة الفنادق ذات الخمس نجوم والشعور الحميمي للمنزل بعيدًا عن المنزل.</p>\r\n<p>لمن يسعون إلى مزيد من الرفاهية، يضم الفندق منتجعًا صحيًا يقدم علاجات تجديدية، كما يوفر متجر البوتيك الحصري مجموعة من العناصر المصنوعة يدويًا، مما يجعل لافندر آند لايس المزيج المثالي من الاسترخاء والأناقة والذوق الرفيع</p>', NULL, NULL, '2024-12-01 23:45:43', '2025-01-03 20:46:09'),
(27, 20, 14, 9, 4, 4, 1, 'Vintage Charm', 'vintage-charm', '123 Collins Street, Mentone VIC, Australia', '[\"3\",\"4\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\"]', '<p><strong>Vintage Charm Boutique Hotel</strong></p>\r\n<p>Nestled in the heart of a vibrant city, <strong>Vintage Charm Boutique Hotel</strong> offers an elegant retreat that transports guests back in time while providing the utmost in modern luxury. With its name evoking a sense of nostalgia and classic beauty, the hotel captures the essence of vintage design with a contemporary twist. Every detail, from the carefully selected furnishings to the soft, ambient lighting, has been curated to create an atmosphere of timeless elegance.</p>\r\n<p>As you step through the doors, you\'re greeted by a blend of vintage-inspired décor, antique accents, and luxurious comfort. The hotel\'s interior features rich, warm tones, plush velvet furnishings, and intricate woodwork, all reminiscent of a bygone era. The rooms are designed to provide an inviting and restful escape, offering a fusion of old-world charm and modern amenities. Whether it\'s the antique brass bed frames or the contemporary touches like flat-screen TVs and high-speed Wi-Fi, every room is designed with your comfort and convenience in mind.</p>\r\n<p>The hotel’s commitment to luxury extends beyond its accommodations. Guests are invited to start their day with a delicious breakfast served in the vintage-styled dining room, where they can enjoy freshly brewed coffee, baked goods, and a selection of local specialties. For those who prefer to relax, the charming lounge area offers a cozy ambiance, perfect for enjoying a book or simply unwinding with a cocktail.</p>\r\n<p>Vintage Charm Boutique Hotel also boasts a beautifully landscaped garden, providing a peaceful retreat where guests can enjoy a quiet afternoon. The lush greenery, paired with the hotel’s vintage-inspired design, creates a serene environment perfect for relaxation or reflection.</p>\r\n<p>Whether you’re here for a romantic getaway, a special celebration, or a business trip, <strong>Vintage Charm Boutique Hotel</strong> offers an unforgettable experience that marries the allure of the past with the comforts of the present. With exceptional service and attention to detail, it’s the perfect destination for anyone seeking a stay filled with character, elegance, and timeless appeal.</p>', NULL, NULL, '2024-12-01 23:59:54', '2024-12-01 23:59:54'),
(28, 21, 14, 10, 8, 8, 9, 'سحر خمر', 'سحر-خمر', '123 شارع كولينز، منتون فيكتوريا، أستراليا', '[\"14\",\"16\",\"18\",\"20\",\"21\"]', '<p><strong>فندق فينتاج تشارم البوتيكي</strong></p>\r\n<p>يقع <strong>فندق فينتاج تشارم البوتيكي</strong> في قلب مدينة نابضة بالحياة، ويقدم ملاذًا أنيقًا ينقل الضيوف إلى الماضي بينما يوفر أقصى درجات الرفاهية الحديثة. يحمل اسمه إشارة إلى الحنين والجمال الكلاسيكي، حيث يجسد الفندق جوهر التصميم العتيق مع لمسة معاصرة. تم اختيار كل تفصيل بعناية، من الأثاث المميز إلى الإضاءة الخافتة، لخلق أجواء من الأناقة الخالدة.</p>\r\n<p>عند دخولك الفندق، تستقبلك مزيج من الديكور المستوحى من الطراز العتيق، واللمسات الأثرية، والراحة الفاخرة. يتميز داخل الفندق بألوان دافئة وغنية، وأثاث مخملي فاخر، وأعمال خشبية معقدة، مما يذكرك بعصر مضى. تم تصميم الغرف لتوفير ملاذ دافئ ومريح، حيث تجمع بين سحر العالم القديم ووسائل الراحة الحديثة. سواء كانت الأسرة النحاسية القديمة أو اللمسات المعاصرة مثل شاشات التلفزيون المسطحة والإنترنت عالي السرعة، فإن كل غرفة تم تصميمها لتوفير الراحة والراحة.</p>\r\n<p>تتجاوز التزام الفندق بالفخامة الإقامة فقط. يُدعى الضيوف لبدء يومهم مع إفطار لذيذ يُقدم في غرفة الطعام ذات الطراز العتيق، حيث يمكنهم الاستمتاع بالقهوة الطازجة والمخبوزات واختيار من الأطباق المحلية الخاصة. لأولئك الذين يفضلون الاسترخاء، توفر منطقة الصالة الساحرة أجواءً دافئة، مثالية للاستمتاع بكتاب أو ببساطة الاسترخاء مع مشروب كوكتيل.</p>\r\n<p>يضم فندق فينتاج تشارم أيضًا حديقة مزخرفة بشكل جميل، مما يوفر ملاذًا هادئًا حيث يمكن للضيوف الاستمتاع بعد ظهر مريح. يخلق اللون الأخضر الفاتن، جنبًا إلى جنب مع التصميم المستوحى من الطراز العتيق للفندق، بيئة هادئة مثالية للاسترخاء أو التأمل.</p>\r\n<p>سواء كنت هنا لقضاء عطلة رومانسية، أو للاحتفال بمناسبة خاصة، أو لرحلة عمل، يقدم <strong>فندق فينتاج تشارم البوتيكي</strong> تجربة لا تُنسى تمزج بين سحر الماضي وراحة الحاضر. مع خدمة استثنائية واهتمام بأدق التفاصيل، يعد المكان المثالي لأي شخص يبحث عن إقامة مليئة بالشخصية والأناقة والجاذبية الخالد</p>', NULL, NULL, '2024-12-01 23:59:54', '2024-12-01 23:59:54'),
(29, 20, 15, 4, 2, NULL, 7, 'Eventide Plaza', 'eventide-plaza', '72 Road No 13, Gulshan, Dhaka 1212, Bangladesh', '[\"1\",\"4\",\"6\",\"8\",\"9\",\"10\"]', '<p><strong>Eventide Plaza</strong> is an exquisite event-focused hotel designed to create unforgettable experiences. Located in the heart of the city, Eventide Plaza offers a luxurious and versatile venue for a wide range of occasions, from corporate conferences to weddings and social gatherings. With its modern architecture and elegant interiors, the hotel provides a sophisticated backdrop for any event.</p>\r\n<p>Boasting a selection of spacious, well-equipped event rooms, Eventide Plaza can accommodate both intimate meetings and large-scale celebrations. The grand ballroom is perfect for weddings and gala dinners, featuring state-of-the-art audiovisual technology, customizable lighting, and ample space for guests. Smaller meeting rooms are available for business events and workshops, with flexible layouts to suit various needs.</p>\r\n<p>The hotel offers premium services, including a dedicated event planning team that ensures every detail is executed to perfection. From catering options that cater to diverse tastes and dietary requirements to expert event coordinators who assist with everything from logistics to decor, Eventide Plaza provides an all-encompassing event experience.</p>\r\n<p>In addition to its event facilities, Eventide Plaza offers luxurious accommodations, fine dining restaurants, a well-equipped fitness center, and relaxing lounges for guests to unwind. Whether you’re hosting a corporate retreat, a wedding, or a special celebration, Eventide Plaza promises a seamless and memorable experience tailored to your needs</p>', NULL, NULL, '2024-12-02 00:31:25', '2024-12-02 00:31:25'),
(30, 21, 15, 8, 6, NULL, 15, 'إيفنتيد بلازا', 'إيفنتيد-بلازا', '72 شارع رقم 13، جُلشان، دكا 1212، بنغلاديش', '[\"14\",\"15\",\"16\",\"18\",\"20\",\"21\",\"22\",\"23\"]', '<p><strong>إيفينتايد بلازا</strong> هو فندق متميز مخصص لإقامة الفعاليات، تم تصميمه لخلق تجارب لا تُنسى. يقع في قلب المدينة، ويوفر إيفينتايد بلازا مكانًا فاخرًا ومتعدد الاستخدامات لمجموعة واسعة من المناسبات، من المؤتمرات التجارية إلى حفلات الزفاف والتجمعات الاجتماعية. مع معمارها العصري وديكوراتها الأنيقة، يقدم الفندق خلفية راقية لأي فعالية.</p>\r\n<p>يضم الفندق مجموعة من الغرف الواسعة والمجهزة تجهيزًا جيدًا لاستضافة الفعاليات، حيث يمكنه استيعاب الاجتماعات الحميمة وكذلك الاحتفالات الكبيرة. قاعة الاحتفالات الكبرى مثالية لحفلات الزفاف والعشاء الفاخر، حيث تتميز بتقنيات سمعية وبصرية متطورة، وإضاءة قابلة للتخصيص، ومساحة واسعة للضيوف. كما تتوفر غرف اجتماعات أصغر للمناسبات التجارية وورش العمل، مع تخطيطات مرنة تناسب مختلف الاحتياجات.</p>\r\n<p>يقدم الفندق خدمات فاخرة، بما في ذلك فريق تخطيط الفعاليات المتخصص الذي يضمن تنفيذ كل التفاصيل بشكل مثالي. من خيارات الطعام التي تلبي الأذواق والمتطلبات الغذائية المتنوعة إلى منسقي الفعاليات الخبراء الذين يساعدون في كل شيء من اللوجستيات إلى الزخرفة، يوفر إيفينتايد بلازا تجربة فعاليات شاملة.</p>\r\n<p>بالإضافة إلى مرافق الفعاليات، يقدم إيفينتايد بلازا أماكن إقامة فاخرة، ومطاعم راقية، ومركز لياقة بدنية مجهز جيدًا، وصالات للاسترخاء للضيوف. سواء كنت تستضيف اجتماعًا تجاريًا، أو حفل زفاف، أو احتفالًا خاصًا، يعدك إيفينتايد بلازا بتجربة سلسة ولا تُنسى مصممة حسب احتياجاتك</p>', NULL, NULL, '2024-12-02 00:31:25', '2024-12-02 00:31:25'),
(35, 20, 21, 3, 1, 2, 8, 'Great Hotel', 'great-hotel', 'Diego, North Ogden Avenue, Chicago, IL, United States', '[\"2\",\"3\",\"6\",\"7\",\"9\",\"10\",\"11\"]', '<h3>Welcome to Great Hotels: Your Home Away from Home</h3>\r\n<p>At <strong>Great Hotels</strong>, we specialize in creating memorable experiences for families looking for comfort, fun, and relaxation. Nestled in a serene location, our family-friendly hotel is designed to cater to every member of your household, ensuring that your stay is nothing short of exceptional.</p>\r\n<p>From the moment you step into our warm and welcoming lobby, you’ll feel the difference. Our spacious rooms and suites are thoughtfully equipped with modern amenities and cozy interiors, providing the perfect sanctuary for parents and children alike. With options ranging from interconnected family suites to deluxe rooms, every space is tailored to accommodate families of all sizes.</p>\r\n<p>Our hotel is more than just a place to stay; it’s a hub for togetherness and joy. Children will love our dedicated play areas, kids’ activities, and a family pool, while adults can unwind at our on-site spa or enjoy a leisurely evening at our family-friendly restaurant. Our chefs craft a menu that satisfies all palates, offering everything from hearty breakfasts to indulgent dinners, with special options for our little guests.</p>\r\n<p>Conveniently located near popular attractions and local family hotspots, <strong>Great Hotels</strong> is the perfect starting point for your adventures. Whether you’re exploring nearby theme parks, enjoying a day at the beach, or simply strolling through vibrant local markets, our concierge service is always ready to help plan the perfect outing.</p>\r\n<p>At <strong>Great Hotels</strong>, we understand the value of family moments. That’s why we go above and beyond to ensure your stay is filled with smiles, laughter, and cherished memories. Come experience the ultimate blend of comfort, convenience, and care—because your family deserves nothing less.</p>\r\n<p><strong>Great Hotels: Where Every Stay Feels Like Coming Home.</strong></p>', NULL, NULL, '2024-12-31 21:55:17', '2024-12-31 21:55:17'),
(36, 21, 21, 7, 5, 6, 16, 'فندق رائع', 'فندق-رائع', 'دييغو، شارع شمال أوغدن، شيكاغو، إلينوي، الولايات المتحدة', '[\"14\",\"15\",\"16\",\"18\",\"21\",\"23\"]', '<h3>مرحبًا بكم في فندق جريت هوتيل: منزلكم بعيدًا عن المنزل</h3>\r\n<p>في <strong>فندق جريت هوتيل</strong>، نُخصص تجربتنا لإنشاء ذكريات لا تُنسى للعائلات التي تبحث عن الراحة والمتعة والاسترخاء. يقع فندقنا العائلي في موقع هادئ ومميز، وهو مصمم لتلبية احتياجات جميع أفراد الأسرة، لضمان إقامة استثنائية لكم.</p>\r\n<p>منذ اللحظة التي تخطون فيها إلى ردهة الفندق الدافئة والمُرحبة، ستشعرون بالفرق. غرفنا وأجنحتنا الفسيحة مجهزة بعناية بأحدث وسائل الراحة والتصميمات المريحة، مما يوفر ملاذًا مثاليًا للآباء والأطفال على حد سواء. مع خيارات تتنوع بين الأجنحة العائلية المتصلة والغرف الفاخرة، كل مساحة لدينا مصممة لاستيعاب العائلات من جميع الأحجام.</p>\r\n<p>فندقنا ليس مجرد مكان للإقامة؛ بل هو مركز للبهجة واللحظات العائلية السعيدة. سيحب الأطفال مناطق اللعب المخصصة والأنشطة الممتعة والمسبح العائلي، بينما يمكن للبالغين الاسترخاء في السبا الخاص بنا أو الاستمتاع بأمسية هادئة في مطعمنا العائلي. يقوم طهاتنا بإعداد قائمة طعام تُرضي جميع الأذواق، مع تقديم خيارات خاصة لضيوفنا الصغار.</p>\r\n<p>يقع فندق <strong>جريت هوتيل</strong> في موقع مثالي بالقرب من المعالم السياحية الشهيرة والمواقع العائلية المحلية، مما يجعله نقطة انطلاق مثالية لمغامراتكم. سواء كنتم تستكشفون الحدائق الترفيهية القريبة، أو تقضون يومًا على الشاطئ، أو تتجولون في الأسواق المحلية الحيوية، فإن خدمة الكونسيرج لدينا جاهزة دائمًا لمساعدتكم في التخطيط ليوم مثالي.</p>\r\n<p>في <strong>فندق جريت هوتيل</strong>، نفهم قيمة اللحظات العائلية. لهذا السبب نحرص على أن تكون إقامتكم مليئة بالابتسامات والضحك والذكريات الجميلة. تعالوا لتجربة مزيج فريد من الراحة والراحة والعناية—لأن عائلتكم تستحق الأفضل.</p>\r\n<p><strong>فندق جريت هوتيل: حيث كل إقامة تشعركم وكأنكم في المنزل</strong></p>', NULL, NULL, '2024-12-31 21:57:03', '2025-01-03 20:45:29'),
(37, 20, 22, 1, 4, 4, 1, 'Arova Hotel', 'arova-hotel', 'Melbourne VIC, Australia', '[\"1\",\"2\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\"]', '<h3>Welcome to Arova Hotel: Where Elegance Meets Excellence</h3>\r\n<p>At <strong>Arova Hotel</strong>, luxury is not just a promise; it’s a way of life. Located in the heart of sophistication, our hotel redefines opulence by blending timeless elegance with modern comforts, creating an unparalleled experience for our discerning guests.</p>\r\n<p>From the moment you arrive, our meticulously designed interiors will captivate your senses. The grand lobby, adorned with exquisite details, sets the tone for the exceptional stay that awaits you. Each of our rooms and suites is a sanctuary of comfort and style, featuring lavish furnishings, premium amenities, and breathtaking views that promise to make every moment extraordinary.</p>\r\n<p><strong>Arova Hotel</strong> is dedicated to offering world-class hospitality. Our team of professionals is committed to providing personalized service, ensuring that every detail of your stay is flawless. Whether you are here for business or leisure, we cater to your every need with unmatched attention to detail.</p>\r\n<p>Indulge your palate at our gourmet restaurants, where award-winning chefs craft culinary masterpieces from the finest ingredients. From decadent breakfasts to exquisite dinners, every meal is a celebration of flavor and artistry. For those seeking relaxation, our luxurious spa offers a range of rejuvenating treatments, while our rooftop infinity pool provides the perfect spot to unwind and soak in the stunning skyline views.</p>\r\n<p>Conveniently located near major attractions and cultural landmarks, <strong>Arova Hotel</strong> serves as the ideal base for exploring the city in style. Whether you are attending high-profile events or simply seeking a tranquil retreat, our hotel offers the perfect balance of grandeur and serenity.</p>\r\n<p>Experience a world where sophistication meets comfort, and every stay is a celebration of luxury.</p>\r\n<p><strong>Arova Hotel: The Pinnacle of Elegance and Comfort.</strong></p>', NULL, NULL, '2024-12-31 22:03:12', '2025-01-03 20:47:32'),
(38, 21, 22, 5, 8, 8, 9, 'فندق أروفا', 'فندق-أروفا', 'ملبورن في سي، أستراليا', '[\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"20\",\"22\",\"23\"]', '<h3>مرحبًا بكم في فندق أروفا: حيث تلتقي الأناقة بالتميز</h3>\r\n<p>في <strong>فندق أروفا</strong>، الفخامة ليست مجرد وعد، بل هي أسلوب حياة. يقع الفندق في قلب الرقي، حيث يُعيد تعريف الفخامة من خلال مزج الأناقة الكلاسيكية مع الراحة العصرية، مما يوفر تجربة لا تُضاهى لضيوفنا المميزين.</p>\r\n<p>منذ لحظة وصولكم، ستأسر تصميماتنا الداخلية المصممة بعناية حواسكم. اللوبي الفخم، المزدان بالتفاصيل الرائعة، يُعطي لمحة عما ينتظركم من إقامة استثنائية. تتميز كل غرفة وجناح لدينا بأنها ملاذ من الراحة والأناقة، مع أثاث فاخر، ومرافق حديثة، وإطلالات خلابة تجعل كل لحظة لا تُنسى.</p>\r\n<p>يُكرس <strong>فندق أروفا</strong> جهوده لتقديم ضيافة عالمية المستوى. يعمل فريقنا من المهنيين على تقديم خدمة شخصية تضمن أن تكون كل تفاصيل إقامتكم مثالية. سواء كنتم هنا للعمل أو الترفيه، فإننا نُلبي جميع احتياجاتكم بأقصى درجات الاهتمام.</p>\r\n<p>دللوا حواسكم في مطاعمنا الفاخرة، حيث يقوم الطهاة الحائزون على جوائز بإعداد روائع الطهي باستخدام أفضل المكونات. من وجبات الإفطار الشهية إلى العشاء الفاخر، كل وجبة هي احتفال بالنكهات والفن. ولمن يبحث عن الاسترخاء، يقدم السبا الفاخر لدينا مجموعة من العلاجات المُجددة، بينما يوفر حوض السباحة اللامتناهي على السطح المكان المثالي للاسترخاء والاستمتاع بإطلالات خلابة على أفق المدينة.</p>\r\n<p>يقع <strong>فندق أروفا</strong> في موقع مثالي بالقرب من المعالم الرئيسية والمعالم الثقافية، مما يجعله القاعدة المثالية لاستكشاف المدينة بأناقة. سواء كنتم تحضرون فعاليات رفيعة المستوى أو تبحثون عن ملاذ هادئ، يوفر الفندق التوازن المثالي بين العظمة والهدوء.</p>\r\n<p>اختبروا عالمًا تلتقي فيه الأناقة بالراحة، حيث كل إقامة هي احتفال بالفخامة.</p>\r\n<p><strong>فندق أروفا: قمة الأناقة والراحة.</strong></p>', NULL, NULL, '2024-12-31 22:11:45', '2025-01-03 20:47:32'),
(39, 20, 23, 9, 1, 2, 5, 'Celeste Manor', 'celeste-manor', 'Los Angeles, CA, USA', '[\"1\",\"2\",\"3\",\"4\",\"8\",\"9\"]', '<p>Nestled in the heart of a picturesque town, Celeste Manor is a sanctuary for travelers seeking elegance, comfort, and a touch of timeless charm. This boutique hotel combines modern luxury with a classic aesthetic, offering an unforgettable experience that captures the essence of sophistication.</p>\r\n<p>Upon arrival, guests are greeted by the Manor’s striking façade, a harmonious blend of vintage architecture and contemporary design. The grand entrance, adorned with cascading greenery and soft, ambient lighting, sets the tone for an enchanting stay. Inside, the warm and inviting interiors feature handpicked furnishings, plush textiles, and curated artwork, creating a cozy yet opulent atmosphere.</p>\r\n<p>Each room at Celeste Manor is a masterpiece of design, thoughtfully curated to provide the perfect blend of style and functionality. From the sumptuous bedding and spa-inspired bathrooms to the state-of-the-art amenities, every detail is tailored to ensure the utmost comfort. Many rooms offer private balconies with stunning views of the surrounding landscape, perfect for unwinding with a morning coffee or an evening glass of wine.</p>\r\n<p>The on-site restaurant, <strong>Luna’s Table</strong>, is a culinary haven, serving a menu inspired by seasonal, locally sourced ingredients. Guests can indulge in expertly crafted dishes that pay homage to the region’s flavors while enjoying a refined dining experience in a serene setting.</p>\r\n<p>For those seeking relaxation, the Manor’s tranquil garden and rooftop lounge provide idyllic spots to unwind. Whether sipping cocktails under the stars or basking in the soft sunlight, every moment feels magical.</p>\r\n<p>Celeste Manor also caters to special events and intimate gatherings, offering elegant spaces for weddings, anniversaries, and corporate retreats. The dedicated staff is committed to curating personalized experiences that leave lasting memories.</p>\r\n<p>At Celeste Manor, luxury meets intimacy, creating an unparalleled escape for discerning travelers.</p>', NULL, NULL, '2024-12-31 22:18:23', '2025-01-03 20:45:02'),
(40, 21, 23, 10, 5, 6, 13, 'سيليست مانور', 'سيليست-مانور', 'لوس أنجلوس، كاليفورنيا، الولايات المتحدة الأمريكية', '[\"13\",\"14\",\"15\",\"18\",\"20\",\"22\",\"23\"]', '<p>تقع \"سيليست مانور\" في قلب مدينة ذات مناظر خلابة، وهي ملاذ للمسافرين الذين يبحثون عن الأناقة والراحة ولمسة من السحر الخالد. يجمع هذا الفندق البوتيكي بين الفخامة الحديثة والجمال الكلاسيكي، ليقدم تجربة لا تُنسى تجسد جوهر الرقي.</p>\r\n<p>عند الوصول، يستقبل الضيوف واجهة الفندق الرائعة، التي تمزج بين العمارة العتيقة والتصميم المعاصر. المدخل الكبير، المزخرف بالنباتات المتدلية والإضاءة الخافتة، يخلق جوًا ساحرًا يواكب التجربة. أما داخل الفندق، فتتميز الديكورات الداخلية بالدفء والترحاب، مع أثاث مختار بعناية وأقمشة فاخرة وفن مميز، مما يخلق جوًا مريحًا ولكنه أنيق.</p>\r\n<p>كل غرفة في \"سيليست مانور\" هي تحفة فنية من التصميم، حيث تم اختيار كل تفصيل بعناية ليوفر مزيجًا مثاليًا من الأناقة والوظيفية. من الأسرة الفاخرة والحمامات المستوحاة من المنتجعات الصحية، إلى أحدث وسائل الراحة، تم تصميم كل شيء لضمان أقصى درجات الراحة. كما أن العديد من الغرف تحتوي على شرفات خاصة تطل على المناظر الطبيعية الخلابة، مما يجعلها مكانًا مثاليًا للاستمتاع بفنجان قهوة صباحي أو كأس من النبيذ في المساء.</p>\r\n<p>أما المطعم الموجود في الفندق، <strong>طاولة لونا</strong>، فهو جنة للطعام، حيث يقدم قائمة طعام مستوحاة من المكونات الموسمية والمحلية. يمكن للضيوف الاستمتاع بأطباق مبتكرة تعكس نكهات المنطقة بينما يتمتعون بتجربة تناول طعام راقية في بيئة هادئة.</p>\r\n<p>لمن يبحث عن الاسترخاء، توفر حديقة الفندق الهادئة ومنطقة السطح أماكن مثالية للاسترخاء. سواء كان ذلك بشرب الكوكتيلات تحت النجوم أو الاستمتاع بأشعة الشمس الناعمة، كل لحظة في \"سيليست مانور\" هي لحظة سحرية.</p>\r\n<p>كما يقدم \"سيليست مانور\" خدمات للفعاليات الخاصة والاحتفالات الحميمة، مع توفير مساحات أنيقة لحفلات الزفاف والذكريات السنوية والفعاليات التجارية. يلتزم الفريق بتقديم تجارب مخصصة تترك ذكريات دائمة.</p>\r\n<p>في \"سيليست مانور\"، يلتقي الفخامة بالحميمية، مما يوفر للزوار الهاربين من صخب الحياة تجربة لا مثيل لها</p>', NULL, NULL, '2024-12-31 22:19:50', '2025-01-03 20:45:02');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_counters`
--

CREATE TABLE `hotel_counters` (
  `id` bigint UNSIGNED NOT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `key` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotel_counters`
--

INSERT INTO `hotel_counters` (`id`, `hotel_id`, `key`, `created_at`, `updated_at`) VALUES
(9, 1, 0, '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(10, 1, 1, '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(11, 1, 2, '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(12, 1, 3, '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(13, 2, 0, '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(14, 2, 1, '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(15, 2, 2, '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(16, 2, 3, '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(21, 3, 0, '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(22, 3, 1, '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(23, 3, 2, '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(24, 3, 3, '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(33, 4, 0, '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(34, 4, 1, '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(35, 4, 2, '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(36, 4, 3, '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(41, 5, 0, '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(42, 5, 1, '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(43, 5, 2, '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(44, 5, 3, '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(49, 6, 0, '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(50, 6, 1, '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(51, 6, 2, '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(52, 6, 3, '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(57, 7, 0, '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(58, 7, 1, '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(59, 7, 2, '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(60, 7, 3, '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(65, 8, 0, '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(66, 8, 1, '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(67, 8, 2, '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(68, 8, 3, '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(77, 9, 0, '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(78, 9, 1, '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(79, 9, 2, '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(80, 9, 3, '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(89, 10, 0, '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(90, 10, 1, '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(91, 10, 2, '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(92, 10, 3, '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(105, 11, 0, '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(106, 11, 1, '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(107, 11, 2, '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(108, 11, 3, '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(117, 12, 0, '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(118, 12, 1, '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(119, 12, 2, '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(120, 12, 3, '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(133, 13, 0, '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(134, 13, 1, '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(135, 13, 2, '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(136, 13, 3, '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(145, 14, 0, '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(146, 14, 1, '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(147, 14, 2, '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(148, 14, 3, '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(157, 15, 0, '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(158, 15, 1, '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(159, 15, 2, '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(160, 15, 3, '2024-12-02 01:11:12', '2024-12-02 01:11:12');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_counter_contents`
--

CREATE TABLE `hotel_counter_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `hotel_counter_id` bigint DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotel_counter_contents`
--

INSERT INTO `hotel_counter_contents` (`id`, `language_id`, `hotel_counter_id`, `label`, `value`, `created_at`, `updated_at`) VALUES
(17, 20, 9, 'Free Cancellation', '100%', '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(18, 20, 10, 'New Guests', '2470+', '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(19, 20, 11, 'New Room', '100+', '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(20, 20, 12, 'Customer Support', '24/7', '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(21, 21, 9, 'إلغاء مجاني', '100%', '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(22, 21, 10, 'ضيوف جدد', '2470+', '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(23, 21, 11, 'غرفة جديدة', '100+', '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(24, 21, 12, 'دعم العملاء', '24/7', '2024-12-02 00:38:33', '2024-12-02 00:38:33'),
(25, 20, 13, 'Free Cancellation', '100%', '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(26, 20, 14, 'New Guests', '2470+', '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(27, 20, 15, 'New Room', '100+', '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(28, 20, 16, 'Customer Support', '24/7', '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(29, 21, 13, 'إلغاء مجاني', '100%', '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(30, 21, 14, 'ضيوف جدد', '2470+', '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(31, 21, 15, 'غرفة جديدة', '100+', '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(32, 21, 16, 'دعم العملاء', '24/7', '2024-12-02 00:41:26', '2024-12-02 00:41:26'),
(41, 20, 21, 'Free Cancellation', '100%', '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(42, 20, 22, 'New Guests', '2470+', '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(43, 20, 23, 'New Room', '100+', '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(44, 20, 24, 'Customer Support', '24/7', '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(45, 21, 21, 'إلغاء مجاني', '100%', '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(46, 21, 22, 'ضيوف جدد', '2470+', '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(47, 21, 23, 'غرفة جديدة', '100+', '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(48, 21, 24, 'دعم العملاء', '24/7', '2024-12-02 00:42:46', '2024-12-02 00:42:46'),
(65, 20, 33, 'Free Cancellation', '100%', '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(66, 20, 34, 'New Guests', '2470+', '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(67, 20, 35, 'New Room', '100+', '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(68, 20, 36, 'Customer Support', '24/7', '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(69, 21, 33, 'إلغاء مجاني', '100%', '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(70, 21, 34, 'ضيوف جدد', '2470+', '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(71, 21, 35, 'غرفة جديدة', '100+', '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(72, 21, 36, 'دعم العملاء', '24/7', '2024-12-02 00:44:09', '2024-12-02 00:44:09'),
(81, 20, 41, 'Free Cancellation', '100%', '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(82, 20, 42, 'New Guests', '2470+', '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(83, 20, 43, 'New Room', '100%', '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(84, 20, 44, 'Customer Support', '24/7', '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(85, 21, 41, 'إلغاء مجاني', '100%', '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(86, 21, 42, 'ضيوف جدد', '2470+', '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(87, 21, 43, 'غرفة جديدة', '100%', '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(88, 21, 44, 'دعم العملاء', '24/7', '2024-12-02 00:45:25', '2024-12-02 00:45:25'),
(97, 20, 49, 'Free Cancellation', '100%', '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(98, 20, 50, 'New Guests', '2470+', '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(99, 20, 51, 'New Room', '100+', '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(100, 20, 52, 'Customer Support', '24/7', '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(101, 21, 49, 'إلغاء مجاني', '100%', '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(102, 21, 50, 'ضيوف جدد', '2470+', '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(103, 21, 51, 'غرفة جديدة', '100+', '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(104, 21, 52, 'دعم العملاء', '24/7', '2024-12-02 00:52:09', '2024-12-02 00:52:09'),
(113, 20, 57, 'Free Cancellation', '100%', '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(114, 20, 58, 'New Guests', '2470+', '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(115, 20, 59, 'New Room', '100+', '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(116, 20, 60, 'Customer Support', '24/7', '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(117, 21, 57, 'إلغاء مجاني', '100%', '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(118, 21, 58, 'ضيوف جدد', '2470+', '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(119, 21, 59, 'غرفة جديدة', '100+', '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(120, 21, 60, 'دعم العملاء', '24/7', '2024-12-02 00:53:30', '2024-12-02 00:53:30'),
(129, 20, 65, 'Free Cancellation', '100%', '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(130, 20, 66, 'New Guests', '2470+', '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(131, 20, 67, 'New Room', '100+', '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(132, 20, 68, 'Customer Support', '24/7', '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(133, 21, 65, 'إلغاء مجاني', NULL, '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(134, 21, 66, 'ضيوف جدد', '2470+', '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(135, 21, 67, 'غرفة جديدة', '100+', '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(136, 21, 68, 'دعم العملاء', '24/7', '2024-12-02 00:54:38', '2024-12-02 00:54:38'),
(153, 20, 77, 'Free Cancellation', '100%', '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(154, 20, 78, 'New Guests', '2470+', '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(155, 20, 79, 'New Room', '100+', '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(156, 20, 80, 'Customer Support', '24/7', '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(157, 21, 77, 'إلغاء مجاني', '100%', '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(158, 21, 78, 'ضيوف جدد', '2470+', '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(159, 21, 79, 'غرفة جديدة', '100+', '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(160, 21, 80, 'دعم العملاء', '24/7', '2024-12-02 00:55:39', '2024-12-02 00:55:39'),
(177, 20, 89, 'Free Cancellation', '100%', '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(178, 20, 90, 'New Guests', '2470+', '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(179, 20, 91, 'New Room', '100+', '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(180, 20, 92, 'Customer Support', '24/7', '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(181, 21, 89, 'إلغاء مجاني', '100%', '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(182, 21, 90, 'ضيوف جدد', '2470+', '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(183, 21, 91, 'غرفة جديدة', '100+', '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(184, 21, 92, 'دعم العملاء', '24/7', '2024-12-02 00:58:25', '2024-12-02 00:58:25'),
(209, 20, 105, 'Free Cancellation', '100%', '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(210, 20, 106, 'New Guests', '2470+', '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(211, 20, 107, 'New Room', '100+', '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(212, 20, 108, 'Customer Support', '24/7', '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(213, 21, 105, 'إلغاء مجاني', '100%', '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(214, 21, 106, 'ضيوف جدد', '2470+', '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(215, 21, 107, 'غرفة جديدة', '100+', '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(216, 21, 108, 'دعم العملاء', '24/7', '2024-12-02 00:59:39', '2024-12-02 00:59:39'),
(233, 20, 117, 'Free Cancellation', '100%', '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(234, 20, 118, 'New Guests', '2470+', '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(235, 20, 119, 'New Room', '100+', '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(236, 20, 120, 'Customer Support', '24/7', '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(237, 21, 117, 'إلغاء مجاني', '100%', '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(238, 21, 118, 'ضيوف جدد', '2470+', '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(239, 21, 119, 'غرفة جديدة', '100+', '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(240, 21, 120, 'دعم العملاء', '24/7', '2024-12-02 01:00:41', '2024-12-02 01:00:41'),
(265, 20, 133, 'Free Cancellation', '100%', '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(266, 20, 134, 'New Guests', '2470+', '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(267, 20, 135, 'New Room', '100+', '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(268, 20, 136, 'Customer Support', '24/7', '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(269, 21, 133, 'إلغاء مجاني', '100%', '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(270, 21, 134, 'ضيوف جدد', '2470+', '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(271, 21, 135, 'غرفة جديدة', '100+', '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(272, 21, 136, 'دعم العملاء', '24/7', '2024-12-02 01:09:09', '2024-12-02 01:09:09'),
(289, 20, 145, 'Free Cancellation', '100%', '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(290, 20, 146, 'New Guests', '2470+', '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(291, 20, 147, 'New Room', '100+', '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(292, 20, 148, 'Customer Support', '24/7', '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(293, 21, 145, 'إلغاء مجاني', '100%', '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(294, 21, 146, 'ضيوف جدد', '2470+', '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(295, 21, 147, 'غرفة جديدة', '100+', '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(296, 21, 148, 'دعم العملاء', '24/7', '2024-12-02 01:10:14', '2024-12-02 01:10:14'),
(313, 20, 157, 'Free Cancellation', '100%', '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(314, 20, 158, 'New Guests', '2470+', '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(315, 20, 159, 'New Room', '100+', '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(316, 20, 160, 'Customer Support', '24/7', '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(317, 21, 157, 'إلغاء مجاني', '100%', '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(318, 21, 158, 'ضيوف جدد', '2470+', '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(319, 21, 159, 'ضيوف جدد', '100+', '2024-12-02 01:11:12', '2024-12-02 01:11:12'),
(320, 21, 160, 'دعم العملاء', '24/7', '2024-12-02 01:11:12', '2024-12-02 01:11:12');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_features`
--

CREATE TABLE `hotel_features` (
  `id` bigint UNSIGNED NOT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `vendor_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_symbol_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `conversation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotel_features`
--

INSERT INTO `hotel_features` (`id`, `hotel_id`, `vendor_id`, `vendor_mail`, `order_number`, `total`, `currency_symbol`, `currency_symbol_position`, `payment_method`, `gateway_type`, `payment_status`, `order_status`, `attachment`, `invoice`, `days`, `start_date`, `end_date`, `conversation_id`, `created_at`, `updated_at`) VALUES
(1, 11, 1, 'test@example.com', '6753c56dec7f7', 999.00, '$', 'right', 'Paypal', 'online', 'completed', 'apporved', NULL, '1.pdf', '900', '2024-12-07', '2027-05-26', NULL, '2024-12-06 21:47:57', '2024-12-06 21:49:41'),
(2, 14, 1, 'test@example.com', '6753c59f39837', 999.00, '$', 'right', 'Citibank', 'offline', 'rejected', 'rejected', NULL, NULL, '900', '2024-12-07', '2027-05-26', NULL, '2024-12-06 21:48:47', '2024-12-06 21:50:52'),
(3, 12, 0, 'test@example.com', '6753c5bba140d', 999.00, NULL, NULL, 'flutterwave', 'online', 'completed', 'apporved', NULL, NULL, '900', '2024-12-07', '2027-05-26', NULL, '2024-12-06 21:49:15', '2024-12-06 21:49:15'),
(4, 8, 1, 'test@example.com', '6753c60cc8b61', 999.00, '$', 'right', 'Bank of America', 'offline', 'pending', 'pending', '6753c60cc8216.jpg', NULL, '900', '2024-12-07', '2027-05-26', NULL, '2024-12-06 21:50:36', '2024-12-06 21:50:36'),
(5, 5, 2, 'test@example.com', '6753c700ce6e2', 999.00, '$', 'right', 'Paypal', 'online', 'completed', 'apporved', NULL, '5.pdf', '900', '2024-12-07', '2027-05-26', NULL, '2024-12-06 21:54:40', '2024-12-06 21:57:52'),
(6, 10, 3, 'test@example.com', '6753c7339e916', 999.00, '$', 'right', 'Paypal', 'online', 'completed', 'apporved', NULL, '6.pdf', '900', '2024-12-07', '2027-05-26', NULL, '2024-12-06 21:55:31', '2024-12-06 21:57:50'),
(7, 1, 4, 'test@example.com', '6753c792afe60', 999.00, '$', 'right', 'Citibank', 'offline', 'pending', 'pending', NULL, NULL, '900', '2024-12-07', '2027-05-26', NULL, '2024-12-06 21:57:06', '2024-12-06 21:57:06'),
(8, 13, 1, 'test@example.com', '6778c410ced22', 999.00, '$', 'right', 'Iyzico', 'online', 'completed', 'pending', NULL, '8.pdf', '900', '2025-01-04', '2027-06-23', '99996778c3e1cc4b70.77247906', '2025-01-03 23:16:00', '2025-01-03 23:22:04');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_images`
--

CREATE TABLE `hotel_images` (
  `id` bigint UNSIGNED NOT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hotel_images`
--

INSERT INTO `hotel_images` (`id`, `hotel_id`, `image`, `created_at`, `updated_at`) VALUES
(5, 1, '674d1e2668c79.jpg', '2024-12-01 20:40:38', '2024-12-01 20:40:49'),
(6, 1, '674d1e292ced1.jpg', '2024-12-01 20:40:41', '2024-12-01 20:40:49'),
(7, 1, '674d1e2b9f1a1.jpg', '2024-12-01 20:40:43', '2024-12-01 20:40:49'),
(8, 1, '674d1e2e0cac2.jpg', '2024-12-01 20:40:46', '2024-12-01 20:40:49'),
(9, 2, '674d1f277cd90.jpg', '2024-12-01 20:44:55', '2024-12-01 20:50:41'),
(10, 2, '674d1f277cd44.jpg', '2024-12-01 20:44:55', '2024-12-01 20:50:41'),
(11, 2, '674d1f27a0229.jpg', '2024-12-01 20:44:55', '2024-12-01 20:50:41'),
(12, 2, '674d1f27a05c9.jpg', '2024-12-01 20:44:55', '2024-12-01 20:50:41'),
(13, 3, '674d223665884.jpg', '2024-12-01 20:57:58', '2024-12-01 21:08:50'),
(14, 3, '674d22366f84c.jpg', '2024-12-01 20:57:58', '2024-12-01 21:08:50'),
(15, 3, '674d223688fe4.jpg', '2024-12-01 20:57:58', '2024-12-01 21:08:50'),
(16, 3, '674d223692c05.jpg', '2024-12-01 20:57:58', '2024-12-01 21:08:50'),
(18, 4, '674d2540c596c.jpg', '2024-12-01 21:10:56', '2024-12-01 21:15:54'),
(19, 4, '674d2540ce4a5.jpg', '2024-12-01 21:10:56', '2024-12-01 21:15:54'),
(20, 4, '674d2540f2661.jpg', '2024-12-01 21:10:56', '2024-12-01 21:15:54'),
(21, 4, '674d2540f40e6.jpg', '2024-12-01 21:10:57', '2024-12-01 21:15:54'),
(22, 5, '674d28b779a88.jpg', '2024-12-01 21:25:43', '2024-12-01 21:25:49'),
(23, 5, '674d28b78b3d8.jpg', '2024-12-01 21:25:43', '2024-12-01 21:25:49'),
(24, 5, '674d28b7a1b54.jpg', '2024-12-01 21:25:43', '2024-12-01 21:25:49'),
(25, 5, '674d28b7b259a.jpg', '2024-12-01 21:25:43', '2024-12-01 21:25:49'),
(26, 6, '674d29b6712ce.jpg', '2024-12-01 21:29:58', '2024-12-01 21:31:22'),
(27, 6, '674d29b67680c.jpg', '2024-12-01 21:29:58', '2024-12-01 21:31:22'),
(28, 6, '674d29b696473.jpg', '2024-12-01 21:29:58', '2024-12-01 21:31:22'),
(29, 6, '674d29b69b8cd.jpg', '2024-12-01 21:29:58', '2024-12-01 21:31:22'),
(30, 7, '674d2ae130968.jpg', '2024-12-01 21:34:57', '2024-12-01 21:41:54'),
(31, 7, '674d2ae13a7c3.jpg', '2024-12-01 21:34:57', '2024-12-01 21:41:54'),
(32, 7, '674d2ae15811a.jpg', '2024-12-01 21:34:57', '2024-12-01 21:41:54'),
(33, 7, '674d2ae15dee0.jpg', '2024-12-01 21:34:57', '2024-12-01 21:41:54'),
(34, 8, '674d2f76efeeb.jpg', '2024-12-01 21:54:30', '2024-12-01 22:02:34'),
(35, 8, '674d2f7703a03.jpg', '2024-12-01 21:54:31', '2024-12-01 22:02:34'),
(36, 8, '674d2f77226c7.jpg', '2024-12-01 21:54:31', '2024-12-01 22:02:34'),
(37, 8, '674d2f77290e0.jpg', '2024-12-01 21:54:31', '2024-12-01 22:02:34'),
(38, 9, '674d34dd11e49.jpg', '2024-12-01 22:17:33', '2024-12-01 22:24:27'),
(39, 9, '674d34dd19c7f.jpg', '2024-12-01 22:17:33', '2024-12-01 22:24:27'),
(40, 9, '674d34dd35700.jpg', '2024-12-01 22:17:33', '2024-12-01 22:24:27'),
(41, 9, '674d34dd3d142.jpg', '2024-12-01 22:17:33', '2024-12-01 22:24:27'),
(42, 10, '674d3ed24a968.jpg', '2024-12-01 23:00:02', '2024-12-01 23:12:49'),
(43, 10, '674d3ed2537f9.jpg', '2024-12-01 23:00:02', '2024-12-01 23:12:49'),
(44, 10, '674d3ed283b47.jpg', '2024-12-01 23:00:02', '2024-12-01 23:12:49'),
(45, 10, '674d3ed2893d4.jpg', '2024-12-01 23:00:02', '2024-12-01 23:12:49'),
(46, 11, '674d428a5e033.jpg', '2024-12-01 23:15:54', '2024-12-01 23:24:06'),
(47, 11, '674d428a6088a.jpg', '2024-12-01 23:15:54', '2024-12-01 23:24:06'),
(48, 11, '674d428a84f85.jpg', '2024-12-01 23:15:54', '2024-12-01 23:24:06'),
(49, 11, '674d428a86882.jpg', '2024-12-01 23:15:54', '2024-12-01 23:24:06'),
(50, 12, '674d4604c39de.jpg', '2024-12-01 23:30:44', '2024-12-01 23:35:18'),
(51, 12, '674d4604c8274.jpg', '2024-12-01 23:30:44', '2024-12-01 23:35:18'),
(52, 12, '674d4604edcf3.jpg', '2024-12-01 23:30:44', '2024-12-01 23:35:18'),
(53, 12, '674d4604ef59a.jpg', '2024-12-01 23:30:44', '2024-12-01 23:35:18'),
(54, 13, '674d48aea0070.jpg', '2024-12-01 23:42:06', '2024-12-01 23:45:43'),
(55, 13, '674d48aead4fa.jpg', '2024-12-01 23:42:06', '2024-12-01 23:45:43'),
(56, 13, '674d48aecd4e4.jpg', '2024-12-01 23:42:06', '2024-12-01 23:45:43'),
(57, 13, '674d48aed81b7.jpg', '2024-12-01 23:42:06', '2024-12-01 23:45:43'),
(58, 14, '674d4b8c34298.jpg', '2024-12-01 23:54:20', '2024-12-01 23:59:54'),
(59, 14, '674d4b8c39611.jpg', '2024-12-01 23:54:20', '2024-12-01 23:59:54'),
(60, 14, '674d4b8c5a45e.jpg', '2024-12-01 23:54:20', '2024-12-01 23:59:54'),
(61, 14, '674d4b8c6073b.jpg', '2024-12-01 23:54:20', '2024-12-01 23:59:54'),
(62, 15, '674d537b19265.jpg', '2024-12-02 00:28:11', '2024-12-02 00:31:25'),
(63, 15, '674d537b19399.jpg', '2024-12-02 00:28:11', '2024-12-02 00:31:25'),
(64, 15, '674d537b41197.jpg', '2024-12-02 00:28:11', '2024-12-02 00:31:25'),
(65, 15, '674d537b45018.jpg', '2024-12-02 00:28:11', '2024-12-02 00:31:25'),
(68, NULL, '676ba90eea95c.jpg', '2024-12-25 00:41:18', '2024-12-25 00:41:18'),
(72, NULL, '6774c0d0bc869.jpg', '2024-12-31 22:13:04', '2024-12-31 22:13:04'),
(74, 21, '67762f4057c7f.jpg', '2025-01-02 00:16:32', '2025-01-02 00:16:35'),
(75, 21, '67762f40599fe.jpg', '2025-01-02 00:16:32', '2025-01-02 00:16:35'),
(76, 21, '67762f408d32f.jpg', '2025-01-02 00:16:32', '2025-01-02 00:16:35'),
(77, 21, '67762f4090952.jpg', '2025-01-02 00:16:32', '2025-01-02 00:16:35'),
(78, 22, '67762f5456dbc.jpg', '2025-01-02 00:16:52', '2025-01-02 00:16:54'),
(79, 22, '67762f54571eb.jpg', '2025-01-02 00:16:52', '2025-01-02 00:16:54'),
(80, 22, '67762f5480a79.jpg', '2025-01-02 00:16:52', '2025-01-02 00:16:54'),
(81, 22, '67762f5485337.jpg', '2025-01-02 00:16:52', '2025-01-02 00:16:54'),
(82, 23, '67762f6431b70.jpg', '2025-01-02 00:17:08', '2025-01-02 00:17:11'),
(83, 23, '67762f6432cdf.jpg', '2025-01-02 00:17:08', '2025-01-02 00:17:11'),
(84, 23, '67762f6467dd2.jpg', '2025-01-02 00:17:08', '2025-01-02 00:17:11'),
(85, 23, '67762f64698f2.jpg', '2025-01-02 00:17:08', '2025-01-02 00:17:11');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_wishlists`
--

CREATE TABLE `hotel_wishlists` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint NOT NULL,
  `hotel_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `hotel_wishlists`
--

INSERT INTO `hotel_wishlists` (`id`, `user_id`, `hotel_id`, `created_at`, `updated_at`) VALUES
(6, 1, 22, '2025-01-04 00:02:32', '2025-01-04 00:02:32'),
(7, 1, 14, '2025-01-04 00:02:36', '2025-01-04 00:02:36'),
(8, 1, 10, '2025-01-04 00:02:39', '2025-01-04 00:02:39'),
(13, 4, 12, '2025-01-04 03:29:28', '2025-01-04 03:29:28'),
(14, 4, 21, '2025-01-04 03:29:31', '2025-01-04 03:29:31'),
(15, 4, 14, '2025-01-04 03:29:35', '2025-01-04 03:29:35');

-- --------------------------------------------------------

--
-- Table structure for table `hourly_room_prices`
--

CREATE TABLE `hourly_room_prices` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  `hour_id` bigint DEFAULT NULL,
  `hour` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hourly_room_prices`
--

INSERT INTO `hourly_room_prices` (`id`, `vendor_id`, `hotel_id`, `room_id`, `hour_id`, `hour`, `price`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 1, 1, 2, 30, '2024-12-02 02:55:10', '2024-12-02 02:55:10'),
(2, 4, 1, 1, 2, 6, 70, '2024-12-02 02:55:10', '2024-12-02 02:55:10'),
(3, 4, 1, 1, 3, 9, 120, '2024-12-02 02:55:10', '2024-12-02 02:55:10'),
(4, 4, 1, 1, 4, 12, 150, '2024-12-02 02:55:10', '2024-12-02 02:55:10'),
(5, 4, 2, 2, 1, 2, 100, '2024-12-02 03:06:23', '2024-12-02 03:06:23'),
(6, 4, 2, 2, 2, 6, 280, '2024-12-02 03:06:23', '2024-12-02 03:06:23'),
(7, 4, 2, 2, 3, 9, 590, '2024-12-02 03:06:23', '2024-12-02 03:06:23'),
(8, 4, 2, 2, 4, 12, 1200, '2024-12-02 03:06:23', '2024-12-02 03:06:23'),
(9, 3, 3, 3, 1, 2, 50, '2024-12-02 20:55:43', '2024-12-02 20:56:40'),
(10, 3, 3, 3, 2, 6, 130, '2024-12-02 20:55:43', '2024-12-02 20:56:40'),
(11, 3, 3, 3, 3, 9, 180, '2024-12-02 20:55:43', '2024-12-02 20:56:40'),
(12, 3, 3, 3, 4, 12, 220, '2024-12-02 20:55:43', '2024-12-02 20:56:40'),
(13, 3, 4, 4, 1, 2, 60, '2024-12-02 21:06:42', '2024-12-02 21:07:02'),
(14, 3, 4, 4, 2, 6, 150, '2024-12-02 21:06:42', '2024-12-02 21:07:02'),
(15, 3, 4, 4, 3, 9, 210, '2024-12-02 21:06:42', '2024-12-02 21:07:02'),
(16, 3, 4, 4, 4, 12, 270, '2024-12-02 21:06:42', '2024-12-02 21:07:02'),
(17, 2, 5, 5, 1, 2, 45, '2024-12-02 21:12:35', '2024-12-12 02:26:21'),
(18, 2, 5, 5, 2, 6, 110, '2024-12-02 21:12:35', '2024-12-12 02:26:21'),
(19, 2, 5, 5, 3, 9, 150, '2024-12-02 21:12:35', '2024-12-12 02:26:21'),
(20, 2, 5, 5, 4, 12, 190, '2024-12-02 21:12:35', '2024-12-12 02:26:21'),
(21, 2, 6, 6, 1, 2, 200, '2024-12-02 21:29:53', '2024-12-02 21:30:02'),
(22, 2, 6, 6, 2, 6, 500, '2024-12-02 21:29:53', '2024-12-02 21:30:02'),
(23, 2, 6, 6, 3, 9, 700, '2024-12-02 21:29:53', '2024-12-02 21:30:02'),
(24, 2, 6, 6, 4, 12, 900, '2024-12-02 21:29:53', '2024-12-02 21:30:02'),
(25, 0, 7, 7, 1, 2, 80, '2024-12-02 21:36:07', '2024-12-02 21:37:42'),
(26, 0, 7, 7, 2, 6, 160, '2024-12-02 21:36:07', '2024-12-02 21:37:42'),
(27, 0, 7, 7, 3, 9, 220, '2024-12-02 21:36:07', '2024-12-02 21:37:42'),
(28, 0, 7, 7, 4, 12, 300, '2024-12-02 21:36:07', '2024-12-02 21:37:42'),
(29, 1, 8, 8, 1, 2, 55, '2024-12-02 22:30:02', '2024-12-02 22:30:52'),
(30, 1, 8, 8, 2, 6, 135, '2024-12-02 22:30:02', '2024-12-02 22:30:52'),
(31, 1, 8, 8, 3, 9, 180, '2024-12-02 22:30:02', '2024-12-02 22:30:52'),
(32, 1, 8, 8, 4, 12, 225, '2024-12-02 22:30:02', '2024-12-02 22:30:52'),
(33, 0, 9, 9, 1, 2, 90, '2024-12-02 22:35:36', '2024-12-02 22:37:29'),
(34, 0, 9, 9, 2, 6, 200, '2024-12-02 22:35:36', '2024-12-02 22:37:29'),
(35, 0, 9, 9, 3, 9, 280, '2024-12-02 22:35:36', '2024-12-02 22:37:29'),
(36, 0, 9, 9, 4, 12, 350, '2024-12-02 22:35:36', '2024-12-02 22:37:29'),
(37, 3, 10, 10, 1, 2, 25, '2024-12-02 23:06:15', '2024-12-02 23:06:48'),
(38, 3, 10, 10, 2, 6, 60, '2024-12-02 23:06:15', '2024-12-02 23:06:48'),
(39, 3, 10, 10, 3, 9, 80, '2024-12-02 23:06:15', '2024-12-02 23:06:48'),
(40, 3, 10, 10, 4, 12, 100, '2024-12-02 23:06:15', '2024-12-02 23:06:48'),
(41, 1, 11, 11, 1, 2, 120, '2024-12-02 23:19:41', '2024-12-02 23:20:29'),
(42, 1, 11, 11, 2, 6, 250, '2024-12-02 23:19:41', '2024-12-02 23:20:29'),
(43, 1, 11, 11, 3, 9, 350, '2024-12-02 23:19:41', '2024-12-02 23:20:29'),
(44, 1, 11, 11, 4, 12, 430, '2024-12-02 23:19:41', '2024-12-02 23:20:29'),
(45, 0, 12, 12, 1, 2, 150, '2024-12-02 23:24:55', '2024-12-02 23:25:30'),
(46, 0, 12, 12, 2, 6, 350, '2024-12-02 23:24:55', '2024-12-02 23:25:30'),
(47, 0, 12, 12, 3, 9, 460, '2024-12-02 23:24:55', '2024-12-02 23:25:30'),
(48, 0, 12, 12, 4, 12, 550, '2024-12-02 23:24:55', '2024-12-02 23:25:30'),
(49, 1, 13, 13, 1, 2, 20, '2024-12-06 20:57:32', '2024-12-12 02:27:33'),
(50, 1, 13, 13, 2, 6, 100, '2024-12-06 20:57:32', '2024-12-12 02:27:33'),
(51, 1, 13, 13, 3, 9, 140, '2024-12-06 20:57:32', '2024-12-12 02:27:33'),
(52, 1, 13, 13, 4, 12, 180, '2024-12-06 20:57:32', '2024-12-12 02:27:33'),
(53, 1, 14, 14, 1, 2, 50, '2024-12-06 21:16:23', '2024-12-12 02:27:43'),
(54, 1, 14, 14, 2, 6, 120, '2024-12-06 21:16:23', '2024-12-12 02:27:43'),
(55, 1, 14, 14, 3, 9, 180, '2024-12-06 21:16:23', '2024-12-12 02:27:43'),
(56, 1, 14, 14, 4, 12, 240, '2024-12-06 21:16:23', '2024-12-12 02:27:43'),
(57, 0, 15, 15, 1, 2, 300, '2024-12-06 21:27:45', '2024-12-12 02:27:53'),
(58, 0, 15, 15, 2, 6, 800, '2024-12-06 21:27:45', '2024-12-12 02:27:53'),
(59, 0, 15, 15, 3, 9, 1200, '2024-12-06 21:27:45', '2024-12-12 02:27:53'),
(60, 0, 15, 15, 4, 12, 1500, '2024-12-06 21:27:45', '2024-12-12 02:27:53'),
(80, 0, 21, 17, 1, 2, 50, '2024-12-31 22:26:56', '2024-12-31 22:26:56'),
(81, 0, 21, 17, 2, 6, 130, '2024-12-31 22:26:56', '2024-12-31 22:26:56'),
(82, 0, 21, 17, 3, 9, 180, '2024-12-31 22:26:56', '2024-12-31 22:26:56'),
(83, 0, 21, 17, 4, 12, 220, '2024-12-31 22:26:56', '2024-12-31 22:26:56'),
(84, 1, 22, 18, 1, 2, 250, '2024-12-31 22:49:26', '2024-12-31 22:49:26'),
(85, 1, 22, 18, 2, 6, 450, '2024-12-31 22:49:26', '2024-12-31 22:49:26'),
(86, 1, 22, 18, 3, 9, 600, '2024-12-31 22:49:26', '2024-12-31 22:49:26'),
(87, 1, 22, 18, 4, 12, 750, '2024-12-31 22:49:26', '2024-12-31 22:49:26'),
(88, 3, 23, 19, 1, 2, 200, '2024-12-31 22:56:11', '2024-12-31 22:56:11'),
(89, 3, 23, 19, 2, 6, 350, '2024-12-31 22:56:11', '2024-12-31 22:56:11'),
(90, 3, 23, 19, 3, 9, 450, '2024-12-31 22:56:11', '2024-12-31 22:56:11'),
(91, 3, 23, 19, 4, 12, 550, '2024-12-31 22:56:11', '2024-12-31 22:56:11');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` char(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `direction` tinyint NOT NULL,
  `is_default` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `direction`, `is_default`, `created_at`, `updated_at`) VALUES
(20, 'English', 'en', 0, 1, '2023-08-17 03:19:12', '2024-12-25 22:03:12'),
(21, 'عربي', 'ar', 1, 0, '2023-08-17 03:19:32', '2024-12-01 00:02:27');

-- --------------------------------------------------------

--
-- Table structure for table `mail_templates`
--

CREATE TABLE `mail_templates` (
  `id` int NOT NULL,
  `mail_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_subject` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_body` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `mail_templates`
--

INSERT INTO `mail_templates` (`id`, `mail_type`, `mail_subject`, `mail_body`) VALUES
(1, 'verify_email', 'Verify Your Email Address', 0x3c703e44656172203c7374726f6e673e7b757365726e616d657d3c2f7374726f6e673e2c3c2f703e0d0a3c703e5765206a757374206e65656420746f2076657269667920796f757220656d61696c2061646472657373206265666f726520796f752063616e2061636365737320746f20796f75722064617368626f6172642e3c2f703e0d0a3c703e56657269667920796f757220656d61696c20616464726573732c207b766572696669636174696f6e5f6c696e6b7d2e3c2f703e0d0a3c703e5468616e6b20796f752e3c62723e7b776562736974655f7469746c657d3c2f703e),
(2, 'reset_password', 'Recover Password of Your Account', 0x3c703e4869207b637573746f6d65725f6e616d657d2c3c2f703e3c703e576520686176652072656365697665642061207265717565737420746f20726573657420796f75722070617373776f72642e20496620796f7520646964206e6f74206d616b652074686520726571756573742c2069676e6f7265207468697320656d61696c2e204f74686572776973652c20796f752063616e20726573657420796f75722070617373776f7264207573696e67207468652062656c6f77206c696e6b2e3c2f703e3c703e7b70617373776f72645f72657365745f6c696e6b7d3c2f703e3c703e5468616e6b732c3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(4, 'subscription_package_purchase', 'Your Package Purchase is successful.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7520686176652050757263686173656420796f7572206d656d626572736869702e3c6272202f3e3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(5, 'membership_expiry_reminder', 'Your membership will be expired soon', 0x4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a596f7572206d656d626572736869702077696c6c206265206578706972656420736f6f6e2e3c6272202f3e0d0a596f7572206d656d626572736869702069732076616c69642074696c6c203c7374726f6e673e7b6c6173745f6461795f6f665f6d656d626572736869707d3c2f7374726f6e673e3c6272202f3e0d0a506c6561736520636c69636b2068657265202d207b6c6f67696e5f6c696e6b7d20746f206c6f6720696e746f207468652064617368626f61726420746f2070757263686173652061206e6577207061636b616765202f20657874656e64207468652063757272656e74207061636b61676520746f20657874656e6420796f7572206d656d626572736869702e3c6272202f3e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e),
(6, 'membership_expired', 'Your membership is expired', 0x4869207b757365726e616d657d2c3c62723e3c62723e0d0a0d0a596f7572206d656d6265727368697020697320657870697265642e3c62723e0d0a506c6561736520636c69636b2068657265202d207b6c6f67696e5f6c696e6b7d20746f206c6f6720696e746f207468652064617368626f61726420746f2070757263686173652061206e6577207061636b616765202f20657874656e64207468652063757272656e74207061636b61676520746f20636f6e74696e756520746865206d656d626572736869702e3c62723e3c62723e0d0a0d0a4265737420526567617264732c3c62723e0d0a7b776562736974655f7469746c657d2e),
(7, 'payment_accepted_for_membership_(_offline_gateway_)', 'Your payment for registration is approved', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f7720796f752063616e206c6f67696e20746f20796f757220757365722064617368626f61726420746f206275696c6420796f757220706f7274666f6c696f20776562736974652e3c6272202f3e3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(8, 'payment_rejected_for_membership_(_offline_gateway_)', 'Your payment for membership extension is rejected', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a57652061726520736f72727920746f20696e666f726d20796f75207468617420796f7572207061796d656e7420686173206265656e2072656a65637465643c6272202f3e0d0a0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(9, 'admin_changed_current_package', 'Admin has changed your current package', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206368616e67656420796f75722063757272656e74207061636b616765203c623e287b7265706c616365645f7061636b6167657d293c2f623e3c2f703e0d0a3c703e3c623e4e6577205061636b61676520496e666f726d6174696f6e3a3c2f623e3c2f703e0d0a3c703e0d0a3c7374726f6e673e5061636b6167653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(10, 'admin_added_current_package', 'Admin has added current package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e206861732061646465642063757272656e74207061636b61676520666f7220796f753c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e43757272656e74204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(11, 'admin_changed_next_package', 'Admin has changed your next package', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206368616e67656420796f7572206e657874207061636b616765203c623e287b7265706c616365645f7061636b6167657d293c2f623e3c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e4e657874204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(12, 'admin_added_next_package', 'Admin has added next package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206164646564206e657874207061636b61676520666f7220796f753c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e4e657874204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(13, 'admin_removed_current_package', 'Admin has removed current package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e41646d696e206861732072656d6f7665642063757272656e74207061636b616765202d203c7374726f6e673e7b72656d6f7665645f7061636b6167655f7469746c657d3c2f7374726f6e673e3c6272202f3e4265737420526567617264732c3c2f703e0d0a3c703e3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(14, 'admin_removed_next_package', 'Admin has removed next package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e206861732072656d6f766564206e657874207061636b616765202d203c7374726f6e673e7b72656d6f7665645f7061636b6167655f7469746c657d3c2f7374726f6e673e3c62723e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e),
(15, 'payment_accepted_for_featured_online_gateway', 'Your payment to Feature your business is successful.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f77207761697420666f722073746174757320617070726f76652e3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c2f703e0d0a3c703e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e),
(16, 'room_booking', 'Your Booking Has Been Placed', 0x3c703e3c7374726f6e673e4869c2a07b637573746f6d65725f6e616d657d2c3c2f7374726f6e673e3c2f703e0d0a3c703e596f757220626f6f6b696e6720686173206265656e20706c61636564207375636365737366756c6c792e205765206861766520617474616368656420616e20696e766f69636520696e2074686973206d61696c2e3c6272202f3e4f72646572204e6f3a20237b6f726465725f6e756d6265727d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e3c7374726f6e673e4265737420726567617264732e3c2f7374726f6e673e3c6272202f3e3c7374726f6e673e7b776562736974655f7469746c657d3c2f7374726f6e673e3c2f703e),
(17, 'inform_vendor_about_room_booking', 'Someone booked your room', 0x3c703e3c7374726f6e673e4869207b757365726e616d657d2c3c2f7374726f6e673e3c2f703e0d0a3c703e3c7374726f6e673e7b637573746f6d65725f6e616d657d3c2f7374726f6e673e20626f6f6b656420796f757220726f6f6d207375636365737366756c6c792e205765206861766520617474616368656420616e20696e766f69636520696e2074686973206d61696c2e3c6272202f3e4f72646572204e6f3a20237b6f726465725f6e756d6265727d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e3c7374726f6e673e4265737420726567617264732e3c2f7374726f6e673e3c6272202f3e3c7374726f6e673e7b776562736974655f7469746c657d3c2f7374726f6e673e3c2f703e),
(18, 'withdrawal_request_approved', 'Confirmation of Withdraw Approve', 0x3c70207374796c653d22666f6e742d66616d696c793a4c61746f2c2073616e732d73657269663b666f6e742d73697a653a313470783b6c696e652d6865696768743a312e38323b636f6c6f723a72676228302c302c30293b666f6e742d7374796c653a6e6f726d616c3b666f6e742d7765696768743a3430303b746578742d616c69676e3a6c6566743b223e4869207b757365726e616d657d2c3c2f703e0d0a3c70207374796c653d22666f6e742d66616d696c793a4c61746f2c2073616e732d73657269663b666f6e742d73697a653a313470783b6c696e652d6865696768743a312e38323b636f6c6f723a72676228302c302c30293b666f6e742d7374796c653a6e6f726d616c3b666f6e742d7765696768743a3430303b746578742d616c69676e3a6c6566743b223e5468697320656d61696c20636f6e6669726d73207468617420796f7572207769746864726177616c2072657175657374c2a0207b77697468647261775f69647d20697320617070726f7665642ec2a03c2f703e0d0a3c70207374796c653d22666f6e742d66616d696c793a4c61746f2c2073616e732d73657269663b666f6e742d73697a653a313470783b6c696e652d6865696768743a312e38323b636f6c6f723a72676228302c302c30293b666f6e742d7374796c653a6e6f726d616c3b666f6e742d7765696768743a3430303b746578742d616c69676e3a6c6566743b223e596f75722063757272656e742062616c616e6365206973207b63757272656e745f62616c616e63657d2c20776974686472617720616d6f756e74207b77697468647261775f616d6f756e747d2c20636861726765203a207b6368617267657d2c70617961626c6520616d6f756e74207b70617961626c655f616d6f756e747d3c2f703e0d0a3c70207374796c653d22666f6e742d66616d696c793a4c61746f2c2073616e732d73657269663b666f6e742d73697a653a313470783b6c696e652d6865696768743a312e38323b636f6c6f723a72676228302c302c30293b666f6e742d7374796c653a6e6f726d616c3b666f6e742d7765696768743a3430303b746578742d616c69676e3a6c6566743b223ec2a03c2f703e0d0a3c70207374796c653d22666f6e742d66616d696c793a4c61746f2c2073616e732d73657269663b666f6e742d73697a653a313470783b6c696e652d6865696768743a312e38323b636f6c6f723a72676228302c302c30293b666f6e742d7374796c653a6e6f726d616c3b666f6e742d7765696768743a3430303b746578742d616c69676e3a6c6566743b223e4265737420526567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(19, 'withdrawal_request_rejected', 'Withdraw Request Rejected', 0x3c703e4869207b757365726e616d657d2c3c2f703e0d0a3c703e5468697320656d61696c20636f6e6669726d73207468617420796f7572207769746864726177616c2072657175657374c2a0207b77697468647261775f69647d2069732072656a656374656420616e64207468652062616c616e636520616464656420746f20796f7572206163636f756e742ec2a03c2f703e0d0a3c703e596f75722063757272656e742062616c616e6365206973207b63757272656e745f62616c616e63657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e4265737420526567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(20, 'payment_cancelled_for_room_booking', 'Booking Request is Rejected', 0x3c703e44656172207b637573746f6d65725f6e616d657d2c3c2f703e3c703e536f7272792c20776520686176652072656a656374656420796f757220426f6f6b696e6720526571756573742e3c2f703e3c703e5468616e6b20796f752e3c62723e7b776562736974655f7469746c657d3c2f703e),
(21, 'payment_received_for_room_booking', 'Confirmation of Payment Received', 0x3c703e44656172207b637573746f6d65725f6e616d657d2c3c2f703e3c703e54686973206973206120636f6e6669726d6174696f6e20746861742077652068617665206a75737420726563656976656420796f7572207061796d656e742e2048657265206973206120636f7079206f6620796f75722064657461696c656420696e766f6963652e20446f6e277420686573697461746520746f20636f6e7461637420757320666f7220616e79207175657374696f6e73206f7220636f6e6365726e732e3c2f703e3c703e5468616e6b20796f752e3c62723e7b776562736974655f7469746c657d3c2f703e),
(22, 'room_feature_request_approved', 'Your request to feature room is approved.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e5765206861766520617070726f76656420796f757220726571756573742e3c2f703e0d0a3c703e596f757220526f6f6d20697320666561747572656420666f72207b646179737d20646179732e20c2a03c2f703e0d0a3c703e3c7374726f6e673e526f6f6d5469746c653c2f7374726f6e673e3a207b726f6f6d5f7469746c657d2e3c2f703e0d0a3c703e3c7374726f6e673e53746172742044617465203a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e456e6420446174653a3c2f7374726f6e673e207b656e645f646174657d3c2f703e0d0a3c703e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(23, 'room_feature_request_rejected', 'Your Request to Feature Room is Rejected.', 0x3c703e4869207b757365726e616d657d2c3c2f703e0d0a3c703e57652061726520736f727279202e3c2f703e0d0a3c703e596f7572207265717565737420686173206265656e2072656a65637465643c2f703e0d0a3c703e506c6561736520637265617465206120737570706f7274207469636b65742e3c2f703e0d0a3c703e3c7374726f6e673e526f6f6d205469746c653c2f7374726f6e673e3a207b726f6f6d5f7469746c657d2e3c2f703e0d0a3c703e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(24, 'payment_to_feature_room_accepted_(_offline_payment_gateway_)', 'Your payment for Feature is approved', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f77207761697420666f722073746174757320617070726f76652e3c2f703e0d0a3c703e3c7374726f6e673e526f6f6d205469746c653a3c2f7374726f6e673e207b726f6f6d5f7469746c657d3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c2f703e0d0a3c703e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e),
(25, 'payment_to_feature_room_rejected_(_offline_payment_gateway_)', 'Your payment for Active Room Feature  is rejected', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e57652061726520736f72727920746f20696e666f726d20796f75207468617420796f7572207061796d656e7420686173206265656e2072656a65637465642e3c2f703e0d0a3c703e3c7374726f6e673e526f6f6d205469746c65203a3c2f7374726f6e673e207b726f6f6d5f7469746c657d3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(26, 'payment_to_feature_hotel_accepted_(_offline_payment_gateway_)', 'Your payment for Active Hotel Feature is approved.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f77207761697420666f722073746174757320617070726f76652e3c2f703e0d0a3c703e3c7374726f6e673e486f74656c205469746c653a3c2f7374726f6e673e207b686f74656c5f7469746c657d3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c2f703e0d0a3c703e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e),
(27, 'payment_to_feature_hotel_rejected_(_offline_payment_gateway_)', 'Your payment for Active Hotel Feature is rejected', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e57652061726520736f72727920746f20696e666f726d20796f75207468617420796f7572207061796d656e7420686173206265656e2072656a65637465642e3c2f703e0d0a3c703e3c7374726f6e673e486f74656c205469746c65203a3c2f7374726f6e673e207b686f74656c5f7469746c657d3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(28, 'hotel_feature_request_approved', 'Your request to feature hotel is approved.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e5765206861766520617070726f76656420796f757220726571756573742e3c2f703e0d0a3c703e596f757220526f6f6d20697320666561747572656420666f72207b646179737d20646179732e20c2a03c2f703e0d0a3c703e3c7374726f6e673e486f74656c205469746c653c2f7374726f6e673e3a207b686f74656c5f7469746c657d2e3c2f703e0d0a3c703e3c7374726f6e673e53746172742044617465203a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e456e6420446174653a3c2f7374726f6e673e207b656e645f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(29, 'hotel_feature_request_rejected', 'Your Request to Feature Hotel is Rejected.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e3c2f703e0d0a3c703e57652061726520736f727279202e3c2f703e0d0a3c703e596f7572207265717565737420686173206265656e2072656a65637465643c2f703e0d0a3c703e506c6561736520637265617465206120737570706f7274207469636b65742e3c2f703e0d0a3c703e3c7374726f6e673e486f74656c205469746c653c2f7374726f6e673e3a207b686f74656c5f7469746c657d2e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e);

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

CREATE TABLE `memberships` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `price` double DEFAULT NULL,
  `currency` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `is_trial` tinyint NOT NULL DEFAULT '0',
  `trial_days` int NOT NULL DEFAULT '0',
  `receipt` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `transaction_details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `settings` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `package_id` bigint DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `modified` tinyint DEFAULT NULL COMMENT '1 - modified by Admin, 0 - not modified by Admin',
  `conversation_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menu_builders`
--

CREATE TABLE `menu_builders` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `menus` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `menu_builders`
--

INSERT INTO `menu_builders` (`id`, `language_id`, `menus`, `created_at`, `updated_at`) VALUES
(7, 20, '[{\"text\":\"Home\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"text\":\"Hotels\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"hotels\"},{\"text\":\"Rooms\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"rooms\"},{\"type\":\"vendors\",\"text\":\"Vendors\",\"target\":\"_self\"},{\"text\":\"Pricing\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"FAQ\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"Contact\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"},{\"text\":\"Pages\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"custom\",\"children\":[{\"text\":\"Blog\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"About Us\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"},{\"text\":\"Terms & Condition\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"terms-&-condition\"},{\"text\":\"Privacy Policy\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"privacy-policy\"}]}]', '2023-08-17 03:19:12', '2024-12-09 21:37:55'),
(8, 21, '[{\"text\":\"بيت\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"text\":\"الفنادق\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"hotels\"},{\"text\":\"الغرف\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"rooms\"},{\"text\":\"الباعة\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"التسعير\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"التعليمات\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"اتصال\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"},{\"type\":\"custom\",\"text\":\"الصفحات\",\"href\":\"\",\"target\":\"_self\",\"children\":[{\"type\":\"blog\",\"text\":\"مدونة\",\"target\":\"_self\"},{\"type\":\"about-us\",\"text\":\"معلومات عنا\",\"target\":\"_self\"},{\"type\":\"الأحكام-والشروط\",\"text\":\"الأحكام والشروط\",\"target\":\"_self\"},{\"type\":\"سياسة-الخصوصية\",\"text\":\"سياسة الخصوصية\",\"target\":\"_self\"}]}]', '2023-08-17 03:19:32', '2025-01-03 22:00:25');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2023_10_19_031727_create_listing_sections_table', 1),
(2, '2023_10_19_035156_pacakge_section', 2),
(3, '2023_11_13_042845_v', 3),
(4, '2023_11_13_042942_listing_category', 3),
(5, '2023_11_13_044154_create_settings_table', 3),
(6, '2023_11_13_071453_aminites', 4),
(7, '2023_11_14_025059_listing_images', 5),
(8, '2023_11_15_025019_listings', 6),
(9, '2023_11_15_025156_listing_contents', 6),
(10, '2023_11_16_033741_listing_features', 7),
(11, '2023_11_20_062648_listing_reviews', 8),
(12, '2023_11_21_090259_messages', 9),
(13, '2023_11_21_091821_listing_messages', 10),
(14, '2023_11_22_040920_listing_social_media', 11),
(15, '2023_11_23_034340_listing_products', 12),
(16, '2023_11_23_034430_listing_products_content', 12),
(17, '2023_11_23_034512_listingproductimages', 12),
(18, '2023_11_26_031913_business_hours', 13),
(19, '2023_12_02_045705_listing_faq', 14),
(20, '2023_12_05_033837_listing_feature_charges', 15),
(21, '2023_12_05_081415_feature_orders', 16),
(22, '2023_12_13_050545_video_sections', 17),
(23, '2023_12_13_095353_location_section', 18),
(24, '2023_12_17_033638_countries', 19),
(25, '2023_12_17_044738_states', 20),
(26, '2023_12_17_064230_cities', 21),
(27, '2023_12_24_031950_product_messages', 22),
(28, '2024_01_10_033406_listingspecificationcontents', 23),
(29, '2024_02_11_091538_hotel_category', 24),
(30, '2024_02_12_032148_amenities', 25),
(31, '2024_02_12_052806_hotels', 26),
(32, '2024_02_12_054705_hotel_contents', 27),
(33, '2024_02_12_061448_hotel_images', 28),
(34, '2024_02_13_051930_hotel_counters', 29),
(35, '2024_02_13_052020_hotel_counter_contents', 29),
(36, '2024_02_13_083258_room_images', 30),
(37, '2024_02_14_033448_rooms', 31),
(38, '2024_02_14_033527_room_contents', 31),
(39, '2024_02_14_053144_room_types', 32),
(40, '2024_02_14_071057_booking_hours', 33),
(41, '2024_02_14_085702_hourly_room_price', 34),
(42, '2024_02_17_035139_bookings', 35),
(43, '2024_02_25_044724_additional_services', 36),
(44, '2024_03_10_030955_additionalservicecontents', 37),
(45, '2024_03_11_055218_roomcoupons', 38),
(46, '2024_05_18_050043_herosections', 39),
(47, '2021_02_01_030511_create_payment_invoices_table', 40),
(48, '2024_07_14_031544_feature_sections', 41),
(49, '2024_09_23_033657_holidays', 42),
(50, '2024_10_19_060553_add_a_colum_blogs_tabel', 43),
(51, '2024_10_29_052622_section_contents', 44);

-- --------------------------------------------------------

--
-- Table structure for table `offline_gateways`
--

CREATE TABLE `offline_gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `short_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `instructions` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 -> gateway is deactive, 1 -> gateway is active.',
  `has_attachment` tinyint(1) NOT NULL COMMENT '0 -> do not need attachment, 1 -> need attachment.',
  `serial_number` mediumint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `offline_gateways`
--

INSERT INTO `offline_gateways` (`id`, `name`, `short_description`, `instructions`, `status`, `has_attachment`, `serial_number`, `created_at`, `updated_at`) VALUES
(1, 'Citibank', 'A pioneer of both the credit card industry and automated teller machines, Citibank – formerly the City Bank of New York.', '', 1, 0, 1, '2024-11-30 23:51:37', '2024-11-30 23:51:37'),
(2, 'Bank of America', 'Bank of America has 4,265 branches in the country, only about 700 fewer than Chase. It started as a small institution serving immigrants in San Francisco.', '', 1, 1, 2, '2024-11-30 23:51:55', '2024-11-30 23:51:55');

-- --------------------------------------------------------

--
-- Table structure for table `online_gateways`
--

CREATE TABLE `online_gateways` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `keyword` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `information` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `online_gateways`
--

INSERT INTO `online_gateways` (`id`, `name`, `keyword`, `information`, `status`) VALUES
(1, 'PayPal', 'paypal', '{\"sandbox_status\":\"0\",\"client_id\":\"1\",\"client_secret\":\"1\"}', 0),
(2, 'Instamojo', 'instamojo', '{\"sandbox_status\":\"0\",\"key\":\"1\",\"token\":\"1\"}', 0),
(3, 'Paystack', 'paystack', '{\"key\":\"1\"}', 0),
(4, 'Flutterwave', 'flutterwave', '{\"public_key\":\"1\",\"secret_key\":\"1\"}', 0),
(5, 'Razorpay', 'razorpay', '{\"key\":\"1\",\"secret\":\"1\"}', 0),
(6, 'MercadoPago', 'mercadopago', '{\"sandbox_status\":\"0\",\"token\":\"1\"}', 0),
(7, 'Mollie', 'mollie', '{\"key\":\"1\"}', 0),
(10, 'Stripe', 'stripe', '{\"key\":\"1\",\"secret\":\"1\"}', 0),
(11, 'Paytm', 'paytm', '{\"environment\":\"production\",\"merchant_key\":\"1\",\"merchant_mid\":\"1\",\"merchant_website\":\"1\",\"industry_type\":\"1\"}', 0),
(21, 'Authorize.net', 'authorize.net', '{\"login_id\":\"1\",\"transaction_key\":\"1\",\"public_key\":\"1\",\"sandbox_check\":\"0\",\"text\":\"Pay via your Authorize.net account.\"}', 0),
(22, 'Midtrans', 'midtrans', '{\"server_key\":\"1\",\"midtrans_mode\":\"1\"}', 0),
(23, 'Iyzico', 'iyzico', '{\"api_key\":\"1\",\"secrect_key\":\"1\",\"iyzico_mode\":\"0\"}', 0),
(24, 'Paytabs', 'paytabs', '{\"server_key\":\"1\",\"profile_id\":\"1\",\"country\":\"global\",\"api_endpoint\":\"1\"}', 0),
(25, 'Toyyibpay', 'toyyibpay', '{\"sandbox_status\":\"0\",\"secret_key\":\"1\",\"category_code\":\"1\"}', 0),
(26, 'Phonepe', 'phonepe', '{\"merchant_id\":\"1\",\"sandbox_status\":\"0\",\"salt_key\":\"1\",\"salt_index\":\"1\"}', 0),
(27, 'Yoco', 'yoco', '{\"secret_key\":\"1\"}', 0),
(28, 'Myfatoorah', 'myfatoorah', '{\"token\":\"1\",\"sandbox_status\":\"0\"}', 0),
(29, 'Xendit', 'xendit', '{\"secret_key\":\"1\"}', 0),
(30, 'Perfect Money', 'perfect_money', '{\"perfect_money_wallet_id\":\"1\"}', 0);

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` double NOT NULL DEFAULT '0',
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `term` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `number_of_hotel` int DEFAULT '0',
  `number_of_room` int DEFAULT '0',
  `recommended` int DEFAULT NULL,
  `number_of_images_per_hotel` int DEFAULT '0',
  `number_of_images_per_room` int DEFAULT '0',
  `number_of_amenities_per_hotel` int NOT NULL DEFAULT '0',
  `number_of_amenities_per_room` int NOT NULL DEFAULT '0',
  `number_of_bookings` int NOT NULL DEFAULT '0',
  `custom_features` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '1',
  `features` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `title`, `slug`, `price`, `icon`, `term`, `number_of_hotel`, `number_of_room`, `recommended`, `number_of_images_per_hotel`, `number_of_images_per_room`, `number_of_amenities_per_hotel`, `number_of_amenities_per_room`, `number_of_bookings`, `custom_features`, `status`, `features`, `created_at`, `updated_at`) VALUES
(1, 'Silver', 'silver', 9, 'fas fa-gift iconpicker-component', 'monthly', 3, 3, 0, 3, 3, 3, 3, 100, NULL, 1, '[\"Add Booking From Dashboard\"]', '2024-11-30 21:51:04', '2024-11-30 22:00:29'),
(2, 'Gold', 'gold', 19.99, 'fas fa-gift iconpicker-component', 'monthly', 5, 5, 1, 5, 5, 5, 5, 500, NULL, 1, '[\"Add Booking From Dashboard\",\"Edit Booking From Dashboard\"]', '2024-11-30 21:52:19', '2024-11-30 22:00:38'),
(3, 'Platinum', 'platinum', 29.99, 'fas fa-gift iconpicker-component', 'monthly', 10, 10, 0, 10, 10, 10, 10, 999999, NULL, 1, '[\"Add Booking From Dashboard\",\"Edit Booking From Dashboard\",\"Support Tickets\"]', '2024-11-30 21:53:20', '2024-11-30 21:59:40'),
(4, 'Silver', 'silver', 99, 'fas fa-gift iconpicker-component', 'yearly', 3, 3, 0, 3, 3, 3, 3, 100, NULL, 1, '[\"Add Booking From Dashboard\"]', '2024-11-30 21:51:04', '2024-11-30 22:04:34'),
(5, 'Gold', 'gold', 199, 'fas fa-gift iconpicker-component', 'yearly', 5, 5, 1, 5, 5, 5, 5, 500, NULL, 1, '[\"Add Booking From Dashboard\",\"Edit Booking From Dashboard\"]', '2024-11-30 21:52:19', '2024-11-30 22:00:48'),
(6, 'Platinum', 'platinum', 299, 'fas fa-gift iconpicker-component', 'yearly', 10, 10, 0, 10, 10, 10, 10, 999999, NULL, 1, '[\"Add Booking From Dashboard\",\"Edit Booking From Dashboard\",\"Support Tickets\"]', '2024-11-30 21:53:20', '2024-11-30 21:59:25'),
(7, 'Silver', 'silver', 399, 'fas fa-gift iconpicker-component', 'lifetime', 3, 3, 0, 3, 3, 3, 3, 100, NULL, 1, '[\"Add Booking From Dashboard\"]', '2024-11-30 21:51:04', '2024-11-30 22:00:09'),
(8, 'Gold', 'gold', 699, 'fas fa-gift iconpicker-component', 'lifetime', 5, 5, 1, 5, 5, 5, 5, 500, NULL, 1, '[\"Add Booking From Dashboard\",\"Edit Booking From Dashboard\"]', '2024-11-30 21:52:19', '2024-11-30 22:03:29'),
(9, 'Platinum', 'platinum', 999, 'fas fa-gift iconpicker-component', 'lifetime', 10, 10, 0, 10, 10, 10, 10, 999999, NULL, 1, '[\"Add Booking From Dashboard\",\"Edit Booking From Dashboard\",\"Support Tickets\"]', '2024-11-30 21:53:20', '2024-11-30 22:03:47');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint UNSIGNED NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `status`, `created_at`, `updated_at`) VALUES
(21, 1, '2023-08-19 23:52:10', '2023-08-19 23:52:10'),
(22, 1, '2023-08-19 23:56:10', '2023-08-19 23:56:10');

-- --------------------------------------------------------

--
-- Table structure for table `page_contents`
--

CREATE TABLE `page_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `page_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `content` blob,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `page_contents`
--

INSERT INTO `page_contents` (`id`, `language_id`, `page_id`, `title`, `slug`, `content`, `created_at`, `updated_at`) VALUES
(45, 20, 21, 'Terms & Condition', 'terms-&-condition', 0x3c703e3c7374726f6e673e5465726d7320616e6420436f6e646974696f6e7320666f722054696d65537461793c2f7374726f6e673e3c2f703e0d0a3c703e5468657365207465726d7320616e6420636f6e646974696f6e73206f75746c696e65207468652072756c657320616e6420726567756c6174696f6e7320666f722074686520757365206f662054696d6553746179277320576562736974652e3c2f703e0d0a3c703e427920616363657373696e67207468697320776562736974652c20796f7520616772656520746f20636f6d706c792077697468207468657365207465726d7320616e6420636f6e646974696f6e732e20446f206e6f7420636f6e74696e756520746f207573652054696d655374617920696620796f7520646f206e6f7420616772656520746f20616269646520627920616c6c206f6620746865207465726d7320616e6420636f6e646974696f6e7320737461746564206f6e207468697320706167652e3c2f703e0d0a3c703e54686520666f6c6c6f77696e67207465726d696e6f6c6f6779206170706c69657320746f207468657365205465726d7320616e6420436f6e646974696f6e732c20507269766163792053746174656d656e742c20446973636c61696d6572204e6f746963652c20616e6420616c6c2041677265656d656e74733a2022436c69656e742c222022596f752c2220616e642022596f75722220726566657220746f20796f752c2074686520706572736f6e206c6f6767696e67206f6e746f2074686973207765627369746520616e64206167726565696e6720746f2074686520436f6d70616e79e2809973207465726d7320616e6420636f6e646974696f6e732e202254686520436f6d70616e792c2220224f757273656c7665732c22202257652c2220224f75722c2220616e64202255732c2220726566657220746f2054696d65537461792e202250617274792c222022506172746965732c22206f7220225573222072656665727320746f20626f74682074686520436c69656e7420616e64206f757273656c7665732e20416c6c207465726d7320726566657220746f20746865206f666665722c20616363657074616e63652c20616e6420636f6e73696465726174696f6e206f66207061796d656e74206e656365737361727920746f20756e64657274616b65207468652070726f63657373206f66206f757220617373697374616e636520746f2074686520436c69656e7420696e20746865206d6f737420617070726f707269617465206d616e6e657220666f7220746865206578707265737320707572706f7365206f66206d656574696e672074686520436c69656e742773206e6565647320696e207265737065637420746f207468652070726f766973696f6e206f662054696d65537461792773207374617465642073657276696365732c20696e206163636f7264616e6365207769746820616e64207375626a65637420746f207072657661696c696e67206c61772e3c2f703e0d0a3c6872202f3e0d0a3c68333e436f6f6b6965733c2f68333e0d0a3c703e576520656d706c6f792074686520757365206f6620636f6f6b6965732e20427920616363657373696e672054696d65537461792c20796f7520616772656520746f2075736520636f6f6b69657320696e206163636f7264616e636520776974682054696d65537461792773205072697661637920506f6c6963792e3c2f703e0d0a3c703e4d6f737420696e7465726163746976652077656273697465732075736520636f6f6b69657320746f20616c6c6f7720757320746f20726574726965766520746865207573657227732064657461696c7320666f7220656163682076697369742e20436f6f6b696573206172652075736564206f6e206f7572207765627369746520746f20656e61626c65207468652066756e6374696f6e616c697479206f66206365727461696e20617265617320746f206d616b652069742065617369657220666f722070656f706c65207669736974696e67206f757220776562736974652e20536f6d65206f66206f757220616666696c696174652f6164766572746973696e6720706172746e657273206d617920616c736f2075736520636f6f6b6965732e3c2f703e0d0a3c6872202f3e0d0a3c68333e4c6963656e73653c2f68333e0d0a3c703e556e6c657373206f7468657277697365207374617465642c2054696d655374617920616e642f6f7220697473206c6963656e736f7273206f776e2074686520696e74656c6c65637475616c2070726f70657274792072696768747320666f7220616c6c206d6174657269616c206f6e2054696d65537461792e20416c6c20696e74656c6c65637475616c2070726f706572747920726967687473206172652072657365727665642e20596f75206d61792061636365737320746869732066726f6d2054696d655374617920666f7220796f7572206f776e20706572736f6e616c207573652c207375626a65637420746f207265737472696374696f6e732073657420696e207468657365207465726d7320616e6420636f6e646974696f6e732e3c2f703e0d0a3c703e596f75206d757374206e6f743a3c2f703e0d0a3c756c3e0d0a3c6c693e52657075626c697368206d6174657269616c2066726f6d2054696d65537461793c2f6c693e0d0a3c6c693e53656c6c2c2072656e742c206f72207375622d6c6963656e7365206d6174657269616c2066726f6d2054696d65537461793c2f6c693e0d0a3c6c693e526570726f647563652c206475706c69636174652c206f7220636f7079206d6174657269616c2066726f6d2054696d65537461793c2f6c693e0d0a3c6c693e52656469737472696275746520636f6e74656e742066726f6d2054696d65537461793c2f6c693e0d0a3c2f756c3e0d0a3c703e546869732041677265656d656e74207368616c6c20626567696e206f6e20746865206461746520686572656f662e204f7572205465726d7320616e6420436f6e646974696f6e73207765726520637265617465642077697468207468652068656c70206f6620612046726565205465726d7320616e6420436f6e646974696f6e732047656e657261746f722e3c2f703e0d0a3c6872202f3e0d0a3c68333e436f6d6d656e74733c2f68333e0d0a3c703e5061727473206f6620746869732077656273697465206f6666657220616e206f70706f7274756e69747920666f7220757365727320746f20706f737420616e642065786368616e6765206f70696e696f6e7320616e6420696e666f726d6174696f6e20696e206365727461696e206172656173206f662074686520776562736974652e2054696d655374617920646f6573206e6f742066696c7465722c20656469742c207075626c6973682c206f722072657669657720436f6d6d656e7473207072696f7220746f2074686569722070726573656e6365206f6e2074686520776562736974652e20436f6d6d656e7473207265666c6563742074686520766965777320616e64206f70696e696f6e73206f662074686520706572736f6e2077686f20706f737473207468656d2e2054696d6553746179206973206e6f74206c6961626c6520666f7220616e792064616d61676573206f7220657870656e73657320636175736564206173206120726573756c74206f6620616e7920757365206f6620616e642f6f7220706f7374696e67206f6620436f6d6d656e7473206f6e207468697320776562736974652e3c2f703e0d0a3c703e54696d65537461792072657365727665732074686520726967687420746f206d6f6e69746f7220616c6c20436f6d6d656e747320616e642072656d6f766520616e792074686174206d617920626520636f6e7369646572656420696e617070726f7072696174652c206f6666656e736976652c206f72206361757365206120627265616368206f66207468657365205465726d7320616e6420436f6e646974696f6e732e3c2f703e0d0a3c6872202f3e0d0a3c68333e48797065726c696e6b696e6720746f204f757220436f6e74656e743c2f68333e0d0a3c703e54686520666f6c6c6f77696e67206f7267616e697a6174696f6e73206d6179206c696e6b20746f206f7572205765627369746520776974686f7574207072696f72207772697474656e20617070726f76616c3a3c2f703e0d0a3c756c3e0d0a3c6c693e476f7665726e6d656e74206167656e636965733c2f6c693e0d0a3c6c693e53656172636820656e67696e65733c2f6c693e0d0a3c6c693e4e657773206f7267616e697a6174696f6e733c2f6c693e0d0a3c6c693e4f6e6c696e65206469726563746f7279206469737472696275746f72733c2f6c693e0d0a3c2f756c3e0d0a3c703e5765206d617920636f6e736964657220616e6420617070726f7665206f74686572206c696e6b2072657175657374732066726f6d2074686520666f6c6c6f77696e67207479706573206f66206f7267616e697a6174696f6e733a3c2f703e0d0a3c756c3e0d0a3c6c693e436f6d6d6f6e6c792d6b6e6f776e20636f6e73756d657220616e642f6f7220627573696e65737320696e666f726d6174696f6e20736f75726365733c2f6c693e0d0a3c6c693e456475636174696f6e616c20696e737469747574696f6e7320616e64207472616465206173736f63696174696f6e733c2f6c693e0d0a3c2f756c3e0d0a3c6872202f3e0d0a3c68333e694672616d65733c2f68333e0d0a3c703e576974686f7574207072696f7220617070726f76616c20616e64207772697474656e207065726d697373696f6e2c20796f75206d6179206e6f7420637265617465206672616d65732061726f756e64206f7572205765627061676573207468617420616c746572207468652076697375616c2070726573656e746174696f6e206f7220617070656172616e6365206f66206f757220576562736974652e3c2f703e0d0a3c6872202f3e0d0a3c68333e436f6e74656e74204c696162696c6974793c2f68333e0d0a3c703e5765207368616c6c206e6f742062652068656c6420726573706f6e7369626c6520666f7220616e7920636f6e74656e7420746861742061707065617273206f6e20796f757220576562736974652e20596f7520616772656520746f2070726f7465637420616e6420646566656e6420757320616761696e737420616c6c20636c61696d732061726973696e67206f6e20796f757220576562736974652e3c2f703e0d0a3c6872202f3e0d0a3c68333e5265736572766174696f6e206f66205269676874733c2f68333e0d0a3c703e576520726573657276652074686520726967687420746f2072657175657374207468617420796f752072656d6f766520616c6c206c696e6b73206f7220616e79207370656369666963206c696e6b20746f206f757220576562736974652e20596f7520616772656520746f20696d6d6564696174656c792072656d6f766520616c6c206c696e6b732075706f6e20726571756573742e3c2f703e0d0a3c6872202f3e0d0a3c68333e52656d6f76616c206f66204c696e6b732066726f6d204f757220576562736974653c2f68333e0d0a3c703e496620796f752066696e6420616e79206c696e6b206f6e206f757220576562736974652074686174206973206f6666656e7369766520666f7220616e7920726561736f6e2c206665656c206672656520746f20636f6e746163742075732e2057652077696c6c20636f6e736964657220726571756573747320746f2072656d6f7665206c696e6b732062757420617265206e6f74206f626c69676174656420746f20646f20736f2e3c2f703e0d0a3c6872202f3e0d0a3c68333e446973636c61696d65723c2f68333e0d0a3c703e546f20746865206d6178696d756d20657874656e74207065726d6974746564206279206170706c696361626c65206c61772c207765206578636c75646520616c6c20726570726573656e746174696f6e732c2077617272616e746965732c20616e6420636f6e646974696f6e732072656c6174696e6720746f206f7572207765627369746520616e6420697473207573652e204e6f7468696e6720696e207468697320646973636c61696d65722077696c6c3a3c2f703e0d0a3c756c3e0d0a3c6c693e4c696d6974206f72206578636c756465206f7572206f7220796f7572206c696162696c69747920666f72206465617468206f7220706572736f6e616c20696e6a7572793c2f6c693e0d0a3c6c693e4c696d6974206f72206578636c756465206f7572206f7220796f7572206c696162696c69747920666f72206672617564206f72206672617564756c656e74206d6973726570726573656e746174696f6e3c2f6c693e0d0a3c6c693e4c696d697420616e79206f66206f7572206f7220796f7572206c696162696c697469657320696e20616e7920776179206e6f74207065726d697474656420756e646572206170706c696361626c65206c61773c2f6c693e0d0a3c2f756c3e, '2023-08-19 23:52:10', '2025-01-03 21:52:03'),
(46, 21, 21, 'الأحكام والشروط', 'الأحكام-والشروط', 0x3c703e3c7374726f6e673ed8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d98520d8a7d984d8aed8a7d8b5d8a920d8a8d985d988d982d8b920d8aad8a7d98ad98520d8b3d8aad8a7d98a3c2f7374726f6e673e3c2f703e0d0a3c703ed8aad8add8afd8af20d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d98520d8a7d984d982d988d8a7d8b9d8af20d988d8a7d984d984d988d8a7d8a6d8ad20d984d8a7d8b3d8aad8aed8afd8a7d98520d985d988d982d8b92054696d65537461792e3c2f703e0d0a3c703ed985d98620d8aed984d8a7d98420d8a7d984d988d8b5d988d98420d8a5d984d98920d987d8b0d8a720d8a7d984d985d988d982d8b9d88c20d981d8a5d986d98320d8aad988d8a7d981d98220d8b9d984d98920d8a7d984d8a7d985d8aad8abd8a7d98420d984d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d9852e20d984d8a720d8aad988d8a7d8b5d98420d8a7d8b3d8aad8aed8afd8a7d9852054696d655374617920d8a5d8b0d8a720d983d986d8aa20d984d8a720d8aad988d8a7d981d98220d8b9d984d98920d8a7d984d8a7d984d8aad8b2d8a7d98520d8a8d8acd985d98ad8b920d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d98520d8a7d984d985d8b0d983d988d8b1d8a920d981d98a20d987d8b0d98720d8a7d984d8b5d981d8add8a92e3c2f703e0d0a3c703ed8aad8b4d98ad8b120d8a7d984d985d8b5d8b7d984d8add8a7d8aa20d8a7d984d8aad8a7d984d98ad8a920d8a5d984d98920d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d985d88c20d988d8a8d98ad8a7d98620d8a7d984d8aed8b5d988d8b5d98ad8a9d88c20d988d8a5d8b4d8b9d8a7d8b120d8a7d984d8a5d8aed984d8a7d8a120d985d98620d8a7d984d985d8b3d8a4d988d984d98ad8a920d988d8acd985d98ad8b920d8a7d984d8a7d8aad981d8a7d982d98ad8a7d8aa3a2022d8a7d984d8b9d985d98ad98422d88c2022d8a3d986d8aa2220d98822d984d9832220d8aad8b4d98ad8b120d8a5d984d98920d8a7d984d8b4d8aed8b520d8a7d984d8b0d98a20d98ad8afd8aed98420d8b9d984d98920d987d8b0d8a720d8a7d984d985d988d982d8b920d988d98ad988d8a7d981d98220d8b9d984d98920d8b4d8b1d988d8b720d988d8a3d8add983d8a7d98520d8a7d984d8b4d8b1d983d8a92e2022d8a7d984d8b4d8b1d983d8a922d88c2022d986d8add98622d88c2022d984d986d8a72220d8aad8b4d98ad8b120d8a5d984d9892054696d65537461792e2022d8a7d984d8b7d8b1d9812220d98822d8a7d984d8a3d8b7d8b1d8a7d9812220d8a3d9882022d986d8add9862220d8aad8b4d98ad8b120d8a5d984d98920d983d98420d985d98620d8a7d984d8b9d985d98ad98420d988d8a7d984d8b4d8b1d983d8a92e20d8acd985d98ad8b920d8a7d984d985d8b5d8b7d984d8add8a7d8aa20d8aad8b4d98ad8b120d8a5d984d98920d8a7d984d8b9d8b1d8b6d88c20d988d8a7d984d982d8a8d988d984d88c20d988d8a7d984d986d8b8d8b120d981d98a20d8a7d984d8afd981d8b920d8a7d984d984d8a7d8b2d98520d984d984d982d98ad8a7d98520d8a8d985d8b3d8a7d8b9d8afd8aad986d8a720d984d984d8b9d985d98ad98420d8a8d8a3d981d8b6d98420d8b7d8b1d98ad982d8a920d984d8aad984d8a8d98ad8a920d8a7d8add8aad98ad8a7d8acd8a7d8aa20d8a7d984d8b9d985d98ad98420d8a8d8a7d984d986d8b3d8a8d8a920d984d8aad982d8afd98ad98520d8aed8afd985d8a7d8aa20d8a7d984d8b4d8b1d983d8a920d988d981d982d98bd8a720d984d984d982d8a7d986d988d98620d8a7d984d8b3d8a7d8a6d8af2e3c2f703e0d0a3c6872202f3e0d0a3c68333ed985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b72028d983d988d983d98ad8b2293c2f68333e0d0a3c703ed986d8b3d8aad8aed8afd98520d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b72028d983d988d983d98ad8b2292e20d985d98620d8aed984d8a7d98420d8a7d984d988d8b5d988d98420d8a5d984d9892054696d6553746179d88c20d981d8a5d986d98320d8aad988d8a7d981d98220d8b9d984d98920d8a7d8b3d8aad8aed8afd8a7d98520d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b720d988d981d982d98bd8a720d984d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d9802054696d65537461792e3c2f703e0d0a3c703ed8aad8b3d8aad8aed8afd98520d985d8b9d8b8d98520d8a7d984d985d988d8a7d982d8b920d8a7d984d8aad981d8a7d8b9d984d98ad8a920d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b720d984d8a7d8b3d8aad8b1d8acd8a7d8b920d8aad981d8a7d8b5d98ad98420d8a7d984d985d8b3d8aad8aed8afd98520d981d98a20d983d98420d8b2d98ad8a7d8b1d8a92e20d98ad8aad98520d8a7d8b3d8aad8aed8afd8a7d98520d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b720d981d98a20d985d988d982d8b9d986d8a720d984d8aad985d983d98ad98620d988d8b8d98ad981d8a920d8a8d8b9d8b620d8a7d984d985d986d8a7d8b7d98220d984d8acd8b9d98420d8aad8acd8b1d8a8d8a920d8a7d984d8b2d988d8a7d8b120d8a3d8b3d987d9842e20d982d8af20d98ad8b3d8aad8aed8afd98520d8a8d8b9d8b620d8b4d8b1d983d8a7d8a6d986d8a720d981d98a20d8a7d984d8a5d8b9d984d8a7d98620d8a3d98ad8b6d98bd8a720d985d984d981d8a7d8aa20d8aad8b9d8b1d98ad98120d8a7d984d8a7d8b1d8aad8a8d8a7d8b72e3c2f703e0d0a3c6872202f3e0d0a3c68333ed8a7d984d8aad8b1d8aed98ad8b53c2f68333e0d0a3c703ed985d8a720d984d98520d98ad98fd8b0d983d8b120d8aed984d8a7d98120d8b0d984d983d88c20d981d8a5d9862054696d655374617920d9882fd8a3d98820d8a7d984d985d8a7d984d983d98ad98620d8a7d984d985d8b1d8aed8b5d98ad98620d984d987d8a720d98ad985d8aad984d983d988d98620d8add982d988d98220d8a7d984d985d984d983d98ad8a920d8a7d984d981d983d8b1d98ad8a920d984d8acd985d98ad8b920d8a7d984d985d988d8a7d8af20d8b9d984d9892054696d65537461792e20d8acd985d98ad8b920d8add982d988d98220d8a7d984d985d984d983d98ad8a920d8a7d984d981d983d8b1d98ad8a920d985d8add981d988d8b8d8a92e20d98ad985d983d986d98320d8a7d984d988d8b5d988d98420d8a5d984d98920d8a7d984d985d988d8a7d8af20d985d9862054696d655374617920d984d8a7d8b3d8aad8aed8afd8a7d985d98320d8a7d984d8b4d8aed8b5d98a20d988d981d982d98bd8a720d984d984d982d98ad988d8af20d8a7d984d985d986d8b5d988d8b520d8b9d984d98ad987d8a720d981d98a20d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d9852e3c2f703e0d0a3c703ed98ad8acd8a820d8b9d984d98ad98320d8b9d8afd9853a3c2f703e0d0a3c756c3e0d0a3c6c693ed8a5d8b9d8a7d8afd8a920d986d8b4d8b120d8a7d984d985d988d8a7d8af20d985d9862054696d65537461793c2f6c693e0d0a3c6c693ed8a8d98ad8b9d88c20d8aad8a3d8acd98ad8b1d88c20d8a3d98820d8a7d984d8aad8b1d8aed98ad8b520d8a7d984d981d8b1d8b9d98a20d984d984d985d988d8a7d8af20d985d9862054696d65537461793c2f6c693e0d0a3c6c693ed8a7d8b3d8aad986d8b3d8a7d8aed88c20d8aad983d8b1d8a7d8b1d88c20d8a3d98820d986d8b3d8ae20d8a7d984d985d988d8a7d8af20d985d9862054696d65537461793c2f6c693e0d0a3c6c693ed8a5d8b9d8a7d8afd8a920d8aad988d8b2d98ad8b920d8a7d984d985d8add8aad988d98920d985d9862054696d65537461793c2f6c693e0d0a3c2f756c3e0d0a3c703ed98ad8a8d8afd8a320d987d8b0d8a720d8a7d984d8a7d8aad981d8a7d98220d985d98620d8aad8a7d8b1d98ad8ae20d8a7d984d98ad988d9852e20d8aad98520d8a5d986d8b4d8a7d8a120d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d98520d8a8d985d8b3d8a7d8b9d8afd8a920d985d988d984d8af20d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d98520d8a7d984d985d8acd8a7d986d98a2e3c2f703e0d0a3c6872202f3e0d0a3c68333ed8a7d984d8aad8b9d984d98ad982d8a7d8aa3c2f68333e0d0a3c703ed98ad8aad98ad8ad20d8a8d8b9d8b620d8a3d8acd8b2d8a7d8a120d987d8b0d8a720d8a7d984d985d988d982d8b920d984d984d985d8b3d8aad8aed8afd985d98ad98620d986d8b4d8b120d988d8aad8a8d8a7d8afd98420d8a7d984d8a2d8b1d8a7d8a120d988d8a7d984d985d8b9d984d988d985d8a7d8aa20d981d98a20d985d986d8a7d8b7d98220d985d8b9d98ad986d8a920d985d98620d8a7d984d985d988d982d8b92e20d984d8a720d8aad982d988d9852054696d655374617920d8a8d981d984d8aad8b1d8a920d8a3d98820d8aad8add8b1d98ad8b120d8a3d98820d986d8b4d8b120d8a3d98820d985d8b1d8a7d8acd8b9d8a920d8a7d984d8aad8b9d984d98ad982d8a7d8aa20d982d8a8d98420d8b8d987d988d8b1d987d8a720d8b9d984d98920d8a7d984d985d988d982d8b92e20d8aad8b9d983d8b320d8a7d984d8aad8b9d984d98ad982d8a7d8aa20d8a2d8b1d8a7d8a120d8a7d984d8b4d8aed8b520d8a7d984d8b0d98a20d986d8b4d8b1d987d8a72e20d984d8a720d8aad8aad8add985d9842054696d655374617920d8a3d98a20d985d8b3d8a4d988d984d98ad8a920d8b9d98620d8a7d984d8a3d8b6d8b1d8a7d8b120d8a3d98820d8a7d984d986d981d982d8a7d8aa20d8a7d984d986d8a7d8acd985d8a920d8b9d98620d8a3d98a20d8a7d8b3d8aad8aed8afd8a7d98520d8a3d98820d986d8b4d8b120d984d984d8aad8b9d984d98ad982d8a7d8aa20d8b9d984d98920d987d8b0d8a720d8a7d984d985d988d982d8b92e3c2f703e0d0a3c703ed8aad8add8aad981d8b82054696d655374617920d8a8d8a7d984d8add98220d981d98a20d985d8b1d8a7d982d8a8d8a920d8acd985d98ad8b920d8a7d984d8aad8b9d984d98ad982d8a7d8aa20d988d8a5d8b2d8a7d984d8a920d8a3d98a20d985d986d987d8a720d982d8af20d98ad98fd8b9d8aad8a8d8b120d8bad98ad8b120d985d986d8a7d8b3d8a820d8a3d98820d985d8b3d98ad8a120d8a3d98820d98ad8b3d8a8d8a820d8aed8b1d982d98bd8a720d984d987d8b0d98720d8a7d984d8b4d8b1d988d8b720d988d8a7d984d8a3d8add983d8a7d9852e3c2f703e0d0a3c6872202f3e0d0a3c68333ed8a7d984d8b1d988d8a7d8a8d8b720d8a5d984d98920d985d8add8aad988d98920d985d988d982d8b9d986d8a73c2f68333e0d0a3c703ed98ad985d983d98620d984d984d985d986d8b8d985d8a7d8aa20d8a7d984d8aad8a7d984d98ad8a920d8a7d984d8a7d8b1d8aad8a8d8a7d8b720d8a8d985d988d982d8b9d986d8a720d8b9d984d98920d8a7d984d8a5d986d8aad8b1d986d8aa20d8afd988d98620d8a7d984d8add8a7d8acd8a920d8a5d984d98920d985d988d8a7d981d982d8a920d983d8aad8a7d8a8d98ad8a920d985d8b3d8a8d982d8a93a3c2f703e0d0a3c756c3e0d0a3c6c693ed8a7d984d988d983d8a7d984d8a7d8aa20d8a7d984d8add983d988d985d98ad8a93c2f6c693e0d0a3c6c693ed985d8add8b1d983d8a7d8aa20d8a7d984d8a8d8add8ab3c2f6c693e0d0a3c6c693ed985d986d8b8d985d8a7d8aa20d8a7d984d8a3d8aed8a8d8a7d8b13c2f6c693e0d0a3c6c693ed985d988d8b2d8b9d98820d8a7d984d8a3d8afd984d8a920d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a93c2f6c693e0d0a3c2f756c3e0d0a3c703ed982d8af20d986d986d8b8d8b120d981d98a20d8a7d984d985d988d8a7d981d982d8a920d8b9d984d98920d8b7d984d8a8d8a7d8aa20d8a7d984d8a7d8b1d8aad8a8d8a7d8b720d985d98620d8a7d984d8a3d986d988d8a7d8b920d8a7d984d8aad8a7d984d98ad8a920d985d98620d8a7d984d985d986d8b8d985d8a7d8aa3a3c2f703e0d0a3c756c3e0d0a3c6c693ed985d8b5d8a7d8afd8b120d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aed8a7d8b5d8a920d8a8d8a7d984d985d8b3d8aad987d984d983d98ad98620d8a3d98820d8a7d984d8b4d8b1d983d8a7d8aa3c2f6c693e0d0a3c6c693ed8a7d984d985d8a4d8b3d8b3d8a7d8aa20d8a7d984d8aad8b9d984d98ad985d98ad8a920d988d8a7d984d8acd985d8b9d98ad8a7d8aa20d8a7d984d8aad8acd8a7d8b1d98ad8a93c2f6c693e0d0a3c2f756c3e0d0a3c6872202f3e0d0a3c68333ed8a5d8b7d8a7d8b1d8a7d8aa2028694672616d6573293c2f68333e0d0a3c703ed8afd988d98620d985d988d8a7d981d982d8a920d983d8aad8a7d8a8d98ad8a920d985d8b3d8a8d982d8a9d88c20d984d8a720d98ad8acd988d8b220d984d98320d8a5d986d8b4d8a7d8a120d8a5d8b7d8a7d8b1d8a7d8aa20d8add988d98420d8b5d981d8add8a7d8aa20d8a7d984d988d98ad8a820d8a7d984d8aed8a7d8b5d8a920d8a8d986d8a720d8aad8bad98ad8b120d8a8d8b4d983d98420d985d8a720d8a7d984d8b9d8b1d8b620d8a3d98820d8a7d984d985d8b8d987d8b120d8a7d984d8a8d8b5d8b1d98a20d984d985d988d982d8b9d986d8a72e3c2f703e0d0a3c6872202f3e0d0a3c68333ed985d8b3d8a4d988d984d98ad8a920d8a7d984d985d8add8aad988d9893c2f68333e0d0a3c703ed984d98620d986d983d988d98620d985d8b3d8a4d988d984d98ad98620d8b9d98620d8a3d98a20d985d8add8aad988d98920d98ad8b8d987d8b120d8b9d984d98920d985d988d982d8b9d9832e20d8aad988d8a7d981d98220d8b9d984d98920d8add985d8a7d98ad8a920d988d8a7d984d8afd981d8a7d8b920d8b9d986d8a720d8b6d8af20d8acd985d98ad8b920d8a7d984d8afd8b9d8a7d988d98920d8a7d984d8aad98a20d8aad986d8b4d8a320d8b9d984d98920d985d988d982d8b9d9832e3c2f703e0d0a3c6872202f3e0d0a3c68333ed8a7d8add8aad981d8a7d8b820d8a7d984d8add982d988d9823c2f68333e0d0a3c703ed986d8add8aad981d8b820d8a8d8a7d984d8add98220d981d98a20d8b7d984d8a820d985d986d98320d8a5d8b2d8a7d984d8a920d8acd985d98ad8b920d8a7d984d8b1d988d8a7d8a8d8b720d8a3d98820d8a3d98a20d8b1d8a7d8a8d8b720d985d8add8afd8af20d8a5d984d98920d985d988d982d8b9d986d8a72e20d8aad988d8a7d981d98220d8b9d984d98920d8a5d8b2d8a7d984d8a920d8acd985d98ad8b920d8a7d984d8b1d988d8a7d8a8d8b720d981d988d8b1d98bd8a720d8a8d986d8a7d8a1d98b20d8b9d984d98920d8b7d984d8a8d986d8a72e3c2f703e0d0a3c6872202f3e0d0a3c68333ed8a5d8b2d8a7d984d8a920d8a7d984d8b1d988d8a7d8a8d8b720d985d98620d985d988d982d8b9d986d8a73c2f68333e0d0a3c703ed8a5d8b0d8a720d988d8acd8afd8aa20d8a3d98a20d8b1d8a7d8a8d8b720d8b9d984d98920d985d988d982d8b9d986d8a720d98ad8b9d8aad8a8d8b120d985d8b3d98ad8a6d98bd8a720d984d8a3d98a20d8b3d8a8d8a8d88c20d98ad985d983d986d98320d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a720d981d98a20d8a3d98a20d988d982d8aa2e20d8b3d986d986d8b8d8b120d981d98a20d8a7d984d8b7d984d8a8d8a7d8aa20d984d8a5d8b2d8a7d984d8a920d8a7d984d8b1d988d8a7d8a8d8b720d988d984d983d986d986d8a720d8bad98ad8b120d985d984d8b2d985d98ad98620d8a8d8b0d984d98320d8a3d98820d8a8d8a7d984d8b1d8af20d8b9d984d98ad98320d985d8a8d8a7d8b4d8b1d8a92e3c2f703e0d0a3c6872202f3e0d0a3c68333ed8a5d8aed984d8a7d8a120d8a7d984d985d8b3d8a4d988d984d98ad8a93c2f68333e0d0a3c703ed8a5d984d98920d8a3d982d8b5d98920d8add8af20d98ad8b3d985d8ad20d8a8d98720d8a7d984d982d8a7d986d988d98620d8a7d984d985d8b9d985d988d98420d8a8d987d88c20d981d8a5d986d986d8a720d986d8b3d8aad8abd986d98a20d8acd985d98ad8b920d8a7d984d8aad985d8abd98ad984d8a7d8aa20d988d8a7d984d8b6d985d8a7d986d8a7d8aa20d988d8a7d984d8b4d8b1d988d8b720d8a7d984d985d8aad8b9d984d982d8a920d8a8d985d988d982d8b9d986d8a720d988d8a7d8b3d8aad8aed8afd8a7d985d9872e20d984d8a720d8b4d98ad8a120d981d98a20d987d8b0d8a720d8a7d984d8a5d8aed984d8a7d8a13a3c2f703e0d0a3c756c3e0d0a3c6c693ed98ad8add8af20d985d98620d8a3d98820d98ad8b3d8aad8a8d8b9d8af20d985d8b3d8a4d988d984d98ad8aad986d8a720d8a3d98820d985d8b3d8a4d988d984d98ad8aad98320d8b9d98620d8a7d984d988d981d8a7d8a920d8a3d98820d8a7d984d8a5d8b5d8a7d8a8d8a920d8a7d984d8b4d8aed8b5d98ad8a93c2f6c693e0d0a3c6c693ed98ad8add8af20d985d98620d8a3d98820d98ad8b3d8aad8a8d8b9d8af20d985d8b3d8a4d988d984d98ad8aad986d8a720d8a3d98820d985d8b3d8a4d988d984d98ad8aad98320d8b9d98620d8a7d984d8a7d8add8aad98ad8a7d98420d8a3d98820d8a7d984d8aad985d8abd98ad98420d8a7d984d8a7d8add8aad98ad8a7d984d98a3c2f6c693e0d0a3c6c693ed98ad8add8af20d985d98620d8a3d98a20d985d98620d985d8b3d8a4d988d984d98ad8a7d8aad986d8a720d8a3d98820d985d8b3d8a4d988d984d98ad8a7d8aad98320d8a8d8a3d98a20d8b7d8b1d98ad982d8a920d984d8a720d98ad8b3d985d8ad20d8a8d987d8a720d8a7d984d982d8a7d986d988d98620d8a7d984d985d8b9d985d988d98420d8a8d9873c2f6c693e0d0a3c2f756c3e, '2023-08-19 23:52:10', '2025-01-03 22:01:05'),
(47, 20, 22, 'Privacy Policy', 'privacy-policy', 0x3c703e3c7374726f6e673e5072697661637920506f6c69637920666f722054696d65537461793c2f7374726f6e673e3c2f703e0d0a3c703e41742054696d65537461792c2061636365737369626c652066726f6d203c6120687265663d22687474703a2f2f7777772e74696d65737461792e636f6d223e7777772e3c2f613e3c6120636c6173733d22632d6c696e6b2220687265663d22687474703a2f2f636f646563616e796f6e382e6b7265617469766465762e636f6d2f74696d657374617922207461726765743d225f626c616e6b222072656c3d226e6f7265666572726572206e6f6f70656e6572223e636f646563616e796f6e382e6b7265617469766465762e636f6d2f74696d65737461793c2f613e2c206f6e65206f66206f7572206d61696e207072696f726974696573206973207468652070726976616379206f66206f75722076697369746f72732e2054686973205072697661637920506f6c69637920646f63756d656e74206f75746c696e657320746865207479706573206f6620696e666f726d6174696f6e207468617420697320636f6c6c656374656420616e64207265636f726465642062792054696d655374617920616e6420686f77207765207573652069742e3c2f703e0d0a3c703e496620796f752068617665206164646974696f6e616c207175657374696f6e73206f722072657175697265206d6f726520696e666f726d6174696f6e2061626f7574206f7572205072697661637920506f6c6963792c20646f206e6f7420686573697461746520746f20636f6e746163742075732e3c2f703e0d0a3c703e54686973205072697661637920506f6c696379206170706c696573206f6e6c7920746f206f7572206f6e6c696e65206163746976697469657320616e642069732076616c696420666f722076697369746f727320746f206f757220776562736974652077697468207265676172647320746f2074686520696e666f726d6174696f6e20746865792073686172656420616e642f6f7220636f6c6c65637420696e2054696d65537461792e205468697320706f6c696379206973206e6f74206170706c696361626c6520746f20616e7920696e666f726d6174696f6e20636f6c6c6563746564206f66666c696e65206f7220766961206368616e6e656c73206f74686572207468616e207468697320776562736974652e3c2f703e0d0a3c68333e436f6e73656e743c2f68333e0d0a3c703e4279207573696e67206f757220776562736974652c20796f752068657265627920636f6e73656e7420746f206f7572205072697661637920506f6c69637920616e6420616772656520746f20697473207465726d732e3c2f703e0d0a3c68333e496e666f726d6174696f6e20576520436f6c6c6563743c2f68333e0d0a3c703e54686520706572736f6e616c20696e666f726d6174696f6e207468617420796f75206172652061736b656420746f2070726f766964652c20616e642074686520726561736f6e732077687920796f75206172652061736b656420746f2070726f766964652069742c2077696c6c206265206d61646520636c65617220746f20796f752061742074686520706f696e742077652061736b20796f7520746f2070726f7669646520796f757220706572736f6e616c20696e666f726d6174696f6e2e3c2f703e0d0a3c703e496620796f7520636f6e74616374207573206469726563746c792c207765206d61792072656365697665206164646974696f6e616c20696e666f726d6174696f6e2061626f757420796f75207375636820617320796f7572206e616d652c20656d61696c20616464726573732c2070686f6e65206e756d6265722c2074686520636f6e74656e7473206f6620746865206d65737361676520616e642f6f72206174746163686d656e747320796f75206d61792073656e642075732c20616e6420616e79206f7468657220696e666f726d6174696f6e20796f75206d61792063686f6f736520746f2070726f766964652e3c2f703e0d0a3c703e5768656e20796f7520726567697374657220666f7220616e206163636f756e742c20626f6f6b206120726f6f6d2c206f72206d616b652061207265736572766174696f6e206f6e2054696d65537461792c207765206d61792061736b20666f7220796f757220636f6e7461637420696e666f726d6174696f6e2c20696e636c7564696e67206974656d73207375636820617320796f7572206e616d652c20656d61696c20616464726573732c2070686f6e65206e756d6265722c207061796d656e742064657461696c732c20616e64206f7468657220696e666f726d6174696f6e2072656c6174656420746f20796f757220626f6f6b696e672e3c2f703e0d0a3c68333e486f772057652055736520596f757220496e666f726d6174696f6e3c2f68333e0d0a3c703e5765207573652074686520696e666f726d6174696f6e20776520636f6c6c65637420696e20766172696f757320776179732c20696e636c7564696e6720746f3a3c2f703e0d0a3c756c3e0d0a3c6c693e50726f766964652c206f7065726174652c20616e64206d61696e7461696e206f7572207765627369746520616e6420626f6f6b696e672073657276696365733c2f6c693e0d0a3c6c693e496d70726f76652c20706572736f6e616c697a652c20616e6420657870616e64206f7572207765627369746520616e642073657276696365733c2f6c693e0d0a3c6c693e556e6465727374616e6420616e6420616e616c797a6520686f7720796f7520757365206f7572207765627369746520616e642073657276696365733c2f6c693e0d0a3c6c693e446576656c6f70206e65772066656174757265732c2073657276696365732c20616e642066756e6374696f6e616c69746965733c2f6c693e0d0a3c6c693e436f6d6d756e6963617465207769746820796f752c20656974686572206469726563746c79206f72207468726f756768206f6e65206f66206f757220706172746e6572732c20696e636c7564696e6720666f7220637573746f6d657220736572766963652c20746f2070726f7669646520796f75207769746820757064617465732c20626f6f6b696e6720636f6e6669726d6174696f6e732c20616e64206d61726b6574696e67206f722070726f6d6f74696f6e616c20707572706f7365733c2f6c693e0d0a3c6c693e53656e6420796f7520656d61696c732072656c6174656420746f20796f757220626f6f6b696e6773206f722070726f6d6f74696f6e616c206f66666572733c2f6c693e0d0a3c6c693e50726576656e7420616e64206465746563742066726175643c2f6c693e0d0a3c6c693e436f6d706c792077697468206c6567616c206f626c69676174696f6e733c2f6c693e0d0a3c2f756c3e0d0a3c68333e4c6f672046696c65733c2f68333e0d0a3c703e54696d655374617920666f6c6c6f77732061207374616e646172642070726f636564757265206f66207573696e67206c6f672066696c65732e2054686573652066696c6573206c6f672076697369746f7273207768656e20746865792076697369742077656273697465732e20416c6c20686f7374696e6720636f6d70616e69657320646f207468697320616e6420612070617274206f6620686f7374696e672073657276696365732720616e616c79746963732e2054686520696e666f726d6174696f6e20636f6c6c6563746564206279206c6f672066696c657320696e636c7564657320696e7465726e65742070726f746f636f6c2028495029206164647265737365732c2062726f7773657220747970652c20496e7465726e657420536572766963652050726f76696465722028495350292c206461746520616e642074696d65207374616d702c20726566657272696e672f657869742070616765732c20616e6420706f737369626c7920746865206e756d626572206f6620636c69636b732e20546865736520617265206e6f74206c696e6b656420746f20616e7920696e666f726d6174696f6e207468617420697320706572736f6e616c6c79206964656e7469666961626c652e2054686520707572706f7365206f66207468697320696e666f726d6174696f6e20697320666f7220616e616c797a696e67207472656e64732c2061646d696e6973746572696e672074686520736974652c20747261636b696e6720757365727327206d6f76656d656e74206f6e2074686520776562736974652c20616e6420676174686572696e672064656d6f6772617068696320696e666f726d6174696f6e2e3c2f703e0d0a3c68333e436f6f6b69657320616e642057656220426561636f6e733c2f68333e0d0a3c703e4c696b6520616e79206f7468657220776562736974652c2054696d655374617920757365732022636f6f6b6965732e2220546865736520636f6f6b69657320617265207573656420746f2073746f726520696e666f726d6174696f6e2c20696e636c7564696e672076697369746f72732720707265666572656e63657320616e6420746865207061676573206f6e2074686520776562736974652074686174207468652076697369746f72206163636573736564206f7220766973697465642e205468697320696e666f726d6174696f6e206973207573656420746f206f7074696d697a65207468652075736572732720657870657269656e636520627920637573746f6d697a696e67206f757220776562207061676520636f6e74656e74206261736564206f6e2076697369746f7273272062726f77736572207479706520616e642f6f72206f7468657220696e666f726d6174696f6e2e3c2f703e0d0a3c68333e54686972642d5061727479204164766572746973696e6720616e6420416e616c79746963733c2f68333e0d0a3c703e5765206d6179207573652074686972642d706172747920736572766963657320746f207365727665206164732c20616e616c797a65207765627369746520747261666669632c20616e64206761746865722064656d6f6772617068696320696e666f726d6174696f6e2e2054686573652074686972642d70617274792076656e646f7273206d61792075736520636f6f6b6965732c204a6176615363726970742c206f722077656220626561636f6e7320746f20747261636b2076697369746f7273206f6e206f757220736974652e20466f72206578616d706c652c20476f6f676c652075736573204441525420636f6f6b69657320666f7220706572736f6e616c697a656420616473206261736564206f6e2075736572732720696e746572616374696f6e732077697468206f757220776562736974652e3c2f703e0d0a3c703e546f206f7074206f7574206f6620476f6f676c65204441525420636f6f6b6965732c20796f752063616e207669736974203c6120687265663d2268747470733a2f2f706f6c69636965732e676f6f676c652e636f6d2f746563686e6f6c6f676965732f616473223e476f6f676c652773205072697661637920506f6c69637920666f72204164733c2f613e2e3c2f703e0d0a3c68333e54686972642d5061727479205072697661637920506f6c69636965733c2f68333e0d0a3c703e54696d6553746179e2809973205072697661637920506f6c69637920646f6573206e6f74206170706c7920746f206f74686572206164766572746973657273206f722077656273697465732e20546875732c20776520617265206164766973696e6720796f7520746f20636f6e73756c74207468652072657370656374697665205072697661637920506f6c6963696573206f662074686573652074686972642d7061727479206164207365727665727320666f72206d6f72652064657461696c656420696e666f726d6174696f6e2e2054686973206d617920696e636c7564652074686569722070726163746963657320616e6420696e737472756374696f6e73206f6e20686f7720746f206f70742d6f7574206f66206365727461696e206f7074696f6e732e3c2f703e0d0a3c703e596f752063616e2063686f6f736520746f2064697361626c6520636f6f6b696573207468726f75676820796f757220696e646976696475616c2062726f77736572206f7074696f6e732e20546f206b6e6f77206d6f72652064657461696c656420696e666f726d6174696f6e2061626f757420636f6f6b6965206d616e6167656d656e742077697468207370656369666963207765622062726f77736572732c20796f752063616e207669736974207468652062726f77736572277320726573706563746976652077656273697465732e3c2f703e0d0a3c68333e434350412050726976616379205269676874732028446f204e6f742053656c6c204d7920506572736f6e616c20496e666f726d6174696f6e293c2f68333e0d0a3c703e556e6465722074686520434350412c20616d6f6e67206f74686572207269676874732c2043616c69666f726e696120636f6e73756d65727320686176652074686520726967687420746f3a3c2f703e0d0a3c756c3e0d0a3c6c693e526571756573742074686174206120627573696e65737320646973636c6f7365207468652063617465676f7269657320616e6420737065636966696320706965636573206f6620706572736f6e616c20646174612074686174206120627573696e6573732068617320636f6c6c65637465642061626f757420636f6e73756d6572732e3c2f6c693e0d0a3c6c693e526571756573742074686174206120627573696e6573732064656c65746520616e7920706572736f6e616c20646174612061626f75742074686520636f6e73756d65722074686174206120627573696e6573732068617320636f6c6c65637465642e3c2f6c693e0d0a3c6c693e526571756573742074686174206120627573696e65737320746861742073656c6c73206120636f6e73756d6572277320706572736f6e616c20646174612c206e6f742073656c6c2074686520636f6e73756d6572277320706572736f6e616c20646174612e3c2f6c693e0d0a3c2f756c3e0d0a3c703e496620796f75206d616b65206120726571756573742c2077652068617665206f6e65206d6f6e746820746f20726573706f6e6420746f20796f752e20496620796f7520776f756c64206c696b6520746f20657865726369736520616e79206f66207468657365207269676874732c20706c6561736520636f6e746163742075732e3c2f703e0d0a3c68333e4744505220446174612050726f74656374696f6e205269676874733c2f68333e0d0a3c703e57652077616e7420746f20656e7375726520796f75206172652066756c6c79206177617265206f6620616c6c20796f757220646174612070726f74656374696f6e207269676874732e204576657279207573657220697320656e7469746c656420746f2074686520666f6c6c6f77696e673a3c2f703e0d0a3c756c3e0d0a3c6c693e3c7374726f6e673e54686520726967687420746f206163636573733c2f7374726f6e673e20e2809320596f7520686176652074686520726967687420746f207265717565737420636f70696573206f6620796f757220706572736f6e616c20646174612e3c2f6c693e0d0a3c6c693e3c7374726f6e673e54686520726967687420746f2072656374696669636174696f6e3c2f7374726f6e673e20e2809320596f7520686176652074686520726967687420746f2072657175657374207468617420776520636f727265637420616e7920696e666f726d6174696f6e20796f752062656c6965766520697320696e6163637572617465206f7220636f6d706c65746520696e666f726d6174696f6e20796f752062656c6965766520697320696e636f6d706c6574652e3c2f6c693e0d0a3c6c693e3c7374726f6e673e54686520726967687420746f20657261737572653c2f7374726f6e673e20e2809320596f7520686176652074686520726967687420746f2072657175657374207468617420776520657261736520796f757220706572736f6e616c20646174612c20756e646572206365727461696e20636f6e646974696f6e732e3c2f6c693e0d0a3c6c693e3c7374726f6e673e54686520726967687420746f2072657374726963742070726f63657373696e673c2f7374726f6e673e20e2809320596f7520686176652074686520726967687420746f20726571756573742074686174207765207265737472696374207468652070726f63657373696e67206f6620796f757220706572736f6e616c20646174612c20756e646572206365727461696e20636f6e646974696f6e732e3c2f6c693e0d0a3c6c693e3c7374726f6e673e54686520726967687420746f206f626a65637420746f2070726f63657373696e673c2f7374726f6e673e20e2809320596f7520686176652074686520726967687420746f206f626a65637420746f206f75722070726f63657373696e67206f6620796f757220706572736f6e616c20646174612c20756e646572206365727461696e20636f6e646974696f6e732e3c2f6c693e0d0a3c6c693e3c7374726f6e673e54686520726967687420746f206461746120706f72746162696c6974793c2f7374726f6e673e20e2809320596f7520686176652074686520726967687420746f20726571756573742074686174207765207472616e73666572207468652064617461207765206861766520636f6c6c656374656420746f20616e6f74686572206f7267616e697a6174696f6e206f72206469726563746c7920746f20796f752c20756e646572206365727461696e20636f6e646974696f6e732e3c2f6c693e0d0a3c2f756c3e0d0a3c703e496620796f75206d616b65206120726571756573742c2077652068617665206f6e65206d6f6e746820746f20726573706f6e6420746f20796f752e20496620796f7520776f756c64206c696b6520746f20657865726369736520616e79206f66207468657365207269676874732c20706c6561736520636f6e746163742075732e3c2f703e0d0a3c68333e4368696c6472656e277320496e666f726d6174696f6e3c2f68333e0d0a3c703e4f6e65206f66206f7572207072696f72697469657320697320746f2070726f76696465206164646974696f6e616c2070726f74656374696f6e20666f72206368696c6472656e207573696e672074686520696e7465726e65742e20576520656e636f757261676520706172656e747320616e6420677561726469616e7320746f206f6273657276652c20706172746963697061746520696e2c20616e642f6f72206d6f6e69746f7220616e64206775696465207468656972206f6e6c696e652061637469766974792e3c2f703e0d0a3c703e54696d655374617920646f6573206e6f74206b6e6f77696e676c7920636f6c6c65637420616e7920706572736f6e616c206964656e7469666961626c6520696e666f726d6174696f6e2066726f6d206368696c6472656e20756e6465722074686520616765206f662031332e20496620796f752062656c69657665207468617420796f7572206368696c64206861732070726f7669646564207375636820696e666f726d6174696f6e206f6e206f757220776562736974652c207765207374726f6e676c7920656e636f757261676520796f7520746f20636f6e7461637420757320696d6d6564696174656c792c20616e642077652077696c6c20646f206f75722062657374206566666f72747320746f2072656d6f7665207375636820696e666f726d6174696f6e2066726f6d206f7572207265636f7264732e3c2f703e0d0a3c68333e4368616e67657320746f2054686973205072697661637920506f6c6963793c2f68333e0d0a3c703e5765206d617920757064617465206f7572205072697661637920506f6c6963792066726f6d2074696d6520746f2074696d652e20546875732c2077652061647669736520796f7520746f207265766965772074686973207061676520706572696f646963616c6c7920666f7220616e79206368616e6765732e2057652077696c6c206e6f7469667920796f75206f6620616e79206368616e67657320627920706f7374696e6720746865206e6577205072697661637920506f6c696379206f6e207468697320706167652e205468657365206368616e676573206172652065666665637469766520696d6d6564696174656c7920616674657220746865792061726520706f737465642e3c2f703e0d0a3c68333e436f6e746163742055733c2f68333e0d0a3c703e496620796f75206861766520616e79207175657374696f6e73206f722073756767657374696f6e732061626f7574206f7572205072697661637920506f6c6963792c20706c6561736520636f6e746163742075733a3c2f703e0d0a3c756c3e0d0a3c6c693e427920656d61696c3a203c613e737570706f72744074696d65737461792e636f6d3c2f613e3c2f6c693e0d0a3c6c693e4279207669736974696e6720746869732070616765206f6e206f757220776562736974653a203c6120636c6173733d22632d6c696e6b2220687265663d22687474703a2f2f636f646563616e796f6e382e6b7265617469766465762e636f6d2f74696d657374617922207461726765743d225f626c616e6b222072656c3d226e6f7265666572726572206e6f6f70656e6572223e636f646563616e796f6e382e6b7265617469766465762e636f6d2f74696d65737461793c2f613ec2a03c2f6c693e0d0a3c2f756c3e, '2023-08-19 23:56:10', '2025-01-03 22:02:19');
INSERT INTO `page_contents` (`id`, `language_id`, `page_id`, `title`, `slug`, `content`, `created_at`, `updated_at`) VALUES
(48, 21, 22, 'سياسة الخصوصية', 'سياسة-الخصوصية', 0x3c68333e3c7374726f6e673ed8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d984d985d988d982d8b920d8aad8a7d98ad98520d8b3d8aad8a7d98a3c2f7374726f6e673e3c2f68333e0d0a3c703ed981d98a20d985d988d982d8b92054696d6553746179d88c20d8a7d984d985d8aad8a7d8ad20d8b9d8a8d8b120d8a7d984d8b1d8a7d8a8d8b7203c6120636c6173733d22632d6c696e6b2220687265663d22687474703a2f2f636f646563616e796f6e382e6b7265617469766465762e636f6d2f74696d657374617922207461726765743d225f626c616e6b222072656c3d226e6f7265666572726572206e6f6f70656e6572223e636f646563616e796f6e382e6b7265617469766465762e636f6d2f74696d65737461793c2f613ec2a0d88c20d8aad8b9d8af20d8aed8b5d988d8b5d98ad8a920d8b2d988d8a7d8b1d986d8a720d988d8a7d8add8afd8a920d985d98620d8a3d988d984d988d98ad8a7d8aad986d8a720d8a7d984d8b1d8a6d98ad8b3d98ad8a92e20d8aad988d8b6d8ad20d987d8b0d98720d8a7d984d988d8abd98ad982d8a920d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a3d986d988d8a7d8b920d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d986d982d988d98520d8a8d8acd985d8b9d987d8a720d988d8aad8b3d8acd98ad984d987d8a720d981d98a20d985d988d982d8b92054696d655374617920d988d983d98ad981d98ad8a920d8a7d8b3d8aad8aed8afd8a7d985d987d8a72e3c2f703e0d0a3c703ed8a5d8b0d8a720d983d8a7d986d8aa20d984d8afd98ad98320d8a3d8b3d8a6d984d8a920d8a5d8b6d8a7d981d98ad8a920d8a3d98820d983d986d8aa20d8a8d8add8a7d8acd8a920d8a5d984d98920d985d8b2d98ad8af20d985d98620d8a7d984d985d8b9d984d988d985d8a7d8aa20d8add988d98420d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d986d8a7d88c20d984d8a720d8aad8aad8b1d8afd8af20d981d98a20d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a72e3c2f703e0d0a3c703ed8aad8b7d8a8d98220d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d987d8b0d98720d981d982d8b720d8b9d984d98920d8a7d984d8a3d986d8b4d8b7d8a920d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aa20d988d987d98a20d8b5d8a7d984d8add8a920d984d984d8b2d988d8a7d8b120d8a7d984d8b0d98ad98620d98ad8b3d8aad8aed8afd985d988d98620d985d988d982d8b9d986d8a720d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d981d98ad985d8a720d98ad8aad8b9d984d98220d8a8d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d8b4d8a7d8b1d983d988d987d8a720d9882fd8a3d98820d8acd985d8b9d986d8a7d987d8a720d981d98a2054696d65537461792e20d984d8a720d8aad986d8b7d8a8d98220d987d8b0d98720d8a7d984d8b3d98ad8a7d8b3d8a920d8b9d984d98920d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d98ad8aad98520d8acd985d8b9d987d8a720d8aed8a7d8b1d8ac20d8a7d984d8a5d986d8aad8b1d986d8aa20d8a3d98820d8b9d8a8d8b120d982d986d988d8a7d8aa20d8a3d8aed8b1d98920d8bad98ad8b120d987d8b0d8a720d8a7d984d985d988d982d8b92e3c2f703e0d0a3c68333e3c7374726f6e673ed8a7d984d985d988d8a7d981d982d8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed8a8d8a7d8b3d8aad8aed8afd8a7d985d98320d984d985d988d982d8b9d986d8a7d88c20d981d8a5d986d98320d8aad988d8a7d981d98220d8b9d984d98920d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d986d8a720d988d8aad988d8a7d981d98220d8b9d984d98920d8b4d8b1d988d8b7d987d8a72e3c2f703e0d0a3c68333e3c7374726f6e673ed8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d986d8acd985d8b9d987d8a73c2f7374726f6e673e3c2f68333e0d0a3c703ed8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8b4d8aed8b5d98ad8a920d8a7d984d8aad98a20d98ad98fd8b7d984d8a820d985d986d98320d8aad982d8afd98ad985d987d8a7d88c20d988d8a7d984d8a3d8b3d8a8d8a7d8a820d8a7d984d8aad98a20d8aad8acd8b9d984d986d8a720d986d8b7d984d8a820d985d986d98320d8aad982d8afd98ad985d987d8a7d88c20d8b3d8aad983d988d98620d988d8a7d8b6d8add8a920d984d98320d981d98a20d8a7d984d986d982d8b7d8a920d8a7d984d8aad98a20d986d8b7d984d8a820d985d986d98320d981d98ad987d8a720d8aad982d8afd98ad98520d985d8b9d984d988d985d8a7d8aad98320d8a7d984d8b4d8aed8b5d98ad8a92e3c2f703e0d0a3c703ed8a5d8b0d8a720d982d985d8aa20d8a8d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a720d985d8a8d8a7d8b4d8b1d8a9d88c20d982d8af20d986d8aad984d982d98920d985d8b9d984d988d985d8a7d8aa20d8a5d8b6d8a7d981d98ad8a920d8b9d986d98320d985d8abd98420d8a7d8b3d985d983d88c20d8b9d986d988d8a7d98620d8a8d8b1d98ad8afd98320d8a7d984d8a5d984d983d8aad8b1d988d986d98ad88c20d8b1d982d98520d987d8a7d8aad981d983d88c20d985d8add8aad988d98920d8a7d984d8b1d8b3d8a7d984d8a920d9882fd8a3d98820d8a7d984d985d8b1d981d982d8a7d8aa20d8a7d984d8aad98a20d982d8af20d8aad8b1d8b3d984d987d8a720d984d986d8a7d88c20d988d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d8a3d8aed8b1d98920d982d8af20d8aad8aed8aad8a7d8b120d8aad982d8afd98ad985d987d8a72e3c2f703e0d0a3c703ed8b9d986d8af20d8aad8b3d8acd98ad984d98320d981d98a20d8a7d984d8add8b3d8a7d8a820d8a3d98820d8a5d8acd8b1d8a7d8a120d8a7d984d8add8acd8b2d88c20d982d8af20d986d8b7d984d8a820d985d986d98320d8aad982d8afd98ad98520d985d8b9d984d988d985d8a7d8aa20d8a7d984d8a7d8aad8b5d8a7d98420d8a7d984d8aed8a7d8b5d8a920d8a8d983d88c20d8a8d985d8a720d981d98a20d8b0d984d98320d8a7d984d8a7d8b3d985d88c20d8b9d986d988d8a7d98620d8a7d984d8a8d8b1d98ad8af20d8a7d984d8a5d984d983d8aad8b1d988d986d98ad88c20d8b1d982d98520d8a7d984d987d8a7d8aad981d88c20d8aad981d8a7d8b5d98ad98420d8a7d984d8afd981d8b9d88c20d988d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d8a3d8aed8b1d98920d8aad8aad8b9d984d98220d8a8d8add8acd8b2d9832e3c2f703e0d0a3c68333e3c7374726f6e673ed983d98ad98120d986d8b3d8aad8aed8afd98520d985d8b9d984d988d985d8a7d8aad9833c2f7374726f6e673e3c2f68333e0d0a3c703ed986d8b3d8aad8aed8afd98520d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d986d8acd985d8b9d987d8a720d8a8d8b7d8b1d98220d985d8aed8aad984d981d8a9d88c20d8a8d985d8a720d981d98a20d8b0d984d9833a3c2f703e0d0a3c756c3e0d0a3c6c693ed8aad988d981d98ad8b120d988d8aad8b4d8bad98ad98420d988d8b5d98ad8a7d986d8a920d985d988d982d8b9d986d8a720d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d988d8aed8afd985d8a7d8aa20d8a7d984d8add8acd8b22e3c2f6c693e0d0a3c6c693ed8aad8add8b3d98ad98620d988d8aad8aed8b5d98ad8b520d988d8aad988d8b3d98ad8b920d985d988d982d8b9d986d8a720d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d988d8aed8afd985d8a7d8aad986d8a72e3c2f6c693e0d0a3c6c693ed981d987d98520d988d8aad8add984d98ad98420d983d98ad981d98ad8a920d8a7d8b3d8aad8aed8afd8a7d985d98320d984d985d988d982d8b9d986d8a720d8a7d984d8a5d984d983d8aad8b1d988d986d98a20d988d8aed8afd985d8a7d8aad986d8a72e3c2f6c693e0d0a3c6c693ed8aad8b7d988d98ad8b120d985d98ad8b2d8a7d8aa20d988d8aed8afd985d8a7d8aa20d988d988d8b8d8a7d8a6d98120d8acd8afd98ad8afd8a92e3c2f6c693e0d0a3c6c693ed8a7d984d8aad988d8a7d8b5d98420d985d8b9d983d88c20d8a5d985d8a720d985d8a8d8a7d8b4d8b1d8a920d8a3d98820d985d98620d8aed984d8a7d98420d8a3d8add8af20d8b4d8b1d983d8a7d8a6d986d8a7d88c20d8a8d985d8a720d981d98a20d8b0d984d98320d8aed8afd985d8a7d8aa20d8a7d984d8b9d985d984d8a7d8a1d88c20d984d8aad8b2d988d98ad8afd98320d8a8d8a7d984d8aad8add8afd98ad8abd8a7d8aad88c20d8aad8a3d983d98ad8afd8a7d8aa20d8a7d984d8add8acd8b2d88c20d988d8a3d8bad8b1d8a7d8b620d8a7d984d8aad8b3d988d98ad98220d8a3d98820d8a7d984d8aad8b1d988d98ad8ac2e3c2f6c693e0d0a3c6c693ed8a5d8b1d8b3d8a7d98420d8b1d8b3d8a7d8a6d98420d8a8d8b1d98ad8af20d8a5d984d983d8aad8b1d988d986d98a20d985d8aad8b9d984d982d8a920d8a8d8add8acd988d8b2d8a7d8aad98320d8a3d98820d8a7d984d8b9d8b1d988d8b620d8a7d984d8aad8b1d988d98ad8acd98ad8a92e3c2f6c693e0d0a3c6c693ed985d986d8b920d988d8a7d983d8aad8b4d8a7d98120d8a7d984d8a7d8add8aad98ad8a7d9842e3c2f6c693e0d0a3c6c693ed8a7d984d8a7d985d8aad8abd8a7d98420d984d984d8a7d984d8aad8b2d8a7d985d8a7d8aa20d8a7d984d982d8a7d986d988d986d98ad8a92e3c2f6c693e0d0a3c2f756c3e0d0a3c68333e3c7374726f6e673ed985d984d981d8a7d8aa20d8a7d984d8b3d8acd9843c2f7374726f6e673e3c2f68333e0d0a3c703ed98ad8aad8a8d8b920d985d988d982d8b92054696d655374617920d8a5d8acd8b1d8a7d8a1d98b20d982d98ad8a7d8b3d98ad98bd8a720d8a8d8a7d8b3d8aad8aed8afd8a7d98520d985d984d981d8a7d8aa20d8a7d984d8b3d8acd9842e20d8aad982d988d98520d987d8b0d98720d8a7d984d985d984d981d8a7d8aa20d8a8d8aad8b3d8acd98ad98420d8a7d984d8b2d988d8a7d8b120d8b9d986d8afd985d8a720d98ad8b2d988d8b1d988d98620d8a7d984d985d988d8a7d982d8b92e20d8aad982d988d98520d8acd985d98ad8b920d8b4d8b1d983d8a7d8aa20d8a7d984d8a7d8b3d8aad8b6d8a7d981d8a920d8a8d8b0d984d983d88c20d988d98ad8b9d8af20d8acd8b2d8a1d98bd8a720d985d98620d8aad8add984d98ad984d8a7d8aa20d8aed8afd985d8a7d8aa20d8a7d984d8a7d8b3d8aad8b6d8a7d981d8a92e20d8aad8b4d985d98420d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d8aad8acd985d8b9d987d8a720d985d984d981d8a7d8aa20d8a7d984d8b3d8acd98420d8b9d986d8a7d988d98ad98620d8a8d8b1d988d8aad988d983d988d98420d8a7d984d8a5d986d8aad8b1d986d8aa2028495029d88c20d986d988d8b920d8a7d984d985d8aad8b5d981d8add88c20d985d8b2d988d8af20d8aed8afd985d8a920d8a7d984d8a5d986d8aad8b1d986d8aa202849535029d88c20d8a7d984d8aad8a7d8b1d98ad8ae20d988d988d982d8aa20d8a7d984d8b7d8a7d8a8d8b920d8a7d984d8b2d985d986d98ad88c20d8a7d984d8b5d981d8add8a7d8aa20d8a7d984d988d8a7d8b1d8afd8a92fd8a7d984d8aed8a7d8b1d8acd98ad8a9d88c20d988d8b1d8a8d985d8a720d8b9d8afd8af20d8a7d984d986d982d8b1d8a7d8aa2e20d987d8b0d98720d8a7d984d985d8b9d984d988d985d8a7d8aa20d984d98ad8b3d8aa20d985d8b1d8aad8a8d8b7d8a920d8a8d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d98ad985d983d98620d8a7d984d8aad8b9d8b1d98120d8b9d984d98ad987d8a720d8b4d8aed8b5d98ad98bd8a72e20d8a7d984d8bad8b1d8b620d985d98620d987d8b0d98720d8a7d984d985d8b9d984d988d985d8a7d8aa20d987d98820d8aad8add984d98ad98420d8a7d984d8a7d8aad8acd8a7d987d8a7d8aad88c20d8a5d8afd8a7d8b1d8a920d8a7d984d985d988d982d8b9d88c20d8aad8aad8a8d8b920d8add8b1d983d8a920d8a7d984d985d8b3d8aad8aed8afd985d98ad98620d8b9d984d98920d8a7d984d985d988d982d8b9d88c20d988d8acd985d8b920d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8afd98ad985d988d8bad8b1d8a7d981d98ad8a92e3c2f703e0d0a3c68333e3c7374726f6e673ed8a7d984d983d988d983d98ad8b220d988d8a7d984d985d986d8a7d8b1d8a7d8aa20d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed985d8abd98420d8a3d98a20d985d988d982d8b920d988d98ad8a820d8a2d8aed8b1d88c20d98ad8b3d8aad8aed8afd98520d985d988d982d8b92054696d65537461792022d8a7d984d983d988d983d98ad8b2222e20d8aad98fd8b3d8aad8aed8afd98520d987d8b0d98720d8a7d984d983d988d983d98ad8b220d984d8aad8aed8b2d98ad98620d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a8d985d8a720d981d98a20d8b0d984d98320d8aad981d8b6d98ad984d8a7d8aa20d8a7d984d8b2d988d8a7d8b120d988d8a7d984d8b5d981d8add8a7d8aa20d8a7d984d8aad98a20d8aad98520d8a7d984d988d8b5d988d98420d8a5d984d98ad987d8a720d8a3d98820d8b2d98ad8a7d8b1d8aad987d8a720d8b9d984d98920d8a7d984d985d988d982d8b92e20d98ad8aad98520d8a7d8b3d8aad8aed8afd8a7d98520d987d8b0d98720d8a7d984d985d8b9d984d988d985d8a7d8aa20d984d8aad8add8b3d98ad98620d8aad8acd8b1d8a8d8a920d8a7d984d985d8b3d8aad8aed8afd985d98ad98620d8b9d98620d8b7d8b1d98ad98220d8aad8aed8b5d98ad8b520d985d8add8aad988d98920d8b5d981d8add8a920d8a7d984d988d98ad8a820d8a8d986d8a7d8a1d98b20d8b9d984d98920d986d988d8b920d8a7d984d985d8aad8b5d981d8ad20d9882fd8a3d98820d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8a3d8aed8b1d98920d984d984d8b2d988d8a7d8b12e3c2f703e0d0a3c68333e3c7374726f6e673ed8a7d984d8a5d8b9d984d8a7d98620d988d8a7d984d8aad8add984d98ad984d8a7d8aa20d985d98620d8a7d984d8a3d8b7d8b1d8a7d98120d8a7d984d8abd8a7d984d8abd8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed982d8af20d986d8b3d8aad8aed8afd98520d8aed8afd985d8a7d8aa20d985d98620d8a3d8b7d8b1d8a7d98120d8abd8a7d984d8abd8a920d984d8b9d8b1d8b620d8a7d984d8a5d8b9d984d8a7d986d8a7d8aad88c20d988d8aad8add984d98ad98420d8add8b1d983d8a920d8a7d984d985d8b1d988d8b120d8b9d984d98920d8a7d984d985d988d982d8b9d88c20d988d8acd985d8b920d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8afd98ad985d988d8bad8b1d8a7d981d98ad8a92e20d982d8af20d8aad8b3d8aad8aed8afd98520d987d8b0d98720d8a7d984d8b4d8b1d983d8a7d8aa20d8a7d984d8aed8a7d8b1d8acd98ad8a920d8a7d984d983d988d983d98ad8b220d8a3d98820d8acd8a7d981d8a720d8b3d983d8b1d98ad8a8d8aa20d8a3d98820d8a7d984d985d986d8a7d8b1d8a7d8aa20d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a920d984d8aad8aad8a8d8b920d8a7d984d8b2d988d8a7d8b120d8b9d984d98920d985d988d982d8b9d986d8a72e20d8b9d984d98920d8b3d8a8d98ad98420d8a7d984d985d8abd8a7d984d88c20d98ad8b3d8aad8aed8afd98520476f6f676c6520d983d988d983d98ad8b2204441525420d984d984d8a5d8b9d984d8a7d986d8a7d8aa20d8a7d984d985d8aed8b5d8b5d8a920d8a8d986d8a7d8a1d98b20d8b9d984d98920d8aad981d8a7d8b9d984d8a7d8aa20d8a7d984d985d8b3d8aad8aed8afd985d98ad98620d985d8b920d985d988d982d8b9d986d8a72e3c2f703e0d0a3c703ed984d8a5d984d8bad8a7d8a120d8a7d984d8a7d8b4d8aad8b1d8a7d98320d981d98a20d983d988d983d98ad8b2204441525420d985d98620476f6f676c65d88c20d98ad985d983d986d98320d8b2d98ad8a7d8b1d8a9203c6120687265663d2268747470733a2f2f706f6c69636965732e676f6f676c652e636f6d2f746563686e6f6c6f676965732f616473223ed8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d984d984d8a5d8b9d984d8a7d986d8a7d8aa20d985d98620476f6f676c653c2f613e2e3c2f703e0d0a3c68333e3c7374726f6e673ed8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d8a7d984d8a3d8b7d8b1d8a7d98120d8a7d984d8abd8a7d984d8abd8a93c2f7374726f6e673e3c2f68333e0d0a3c703ed984d8a720d8aad986d8b7d8a8d98220d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d9802054696d655374617920d8b9d984d98920d8a7d984d985d8b9d984d986d98ad98620d8a3d98820d8a7d984d985d988d8a7d982d8b920d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a920d8a7d984d8a3d8aed8b1d9892e20d984d8b0d8a7d88c20d986d986d8b5d8add98320d8a8d985d8b1d8a7d8acd8b9d8a920d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d983d98420d985d98620d987d8a4d984d8a7d8a120d8a7d984d985d8b9d984d986d98ad98620d985d98620d8a7d984d8a3d8b7d8b1d8a7d98120d8a7d984d8abd8a7d984d8abd8a920d984d984d8add8b5d988d98420d8b9d984d98920d985d8b9d984d988d985d8a7d8aa20d8a3d983d8abd8b120d8aad981d8b5d98ad984d98bd8a72e20d982d8af20d8aad8b4d985d98420d987d8b0d98720d8a7d984d8b3d98ad8a7d8b3d8a7d8aa20d8aad8b9d984d98ad985d8a7d8aa20d8add988d98420d983d98ad981d98ad8a920d8a5d984d8bad8a7d8a120d8a7d984d8a7d8b4d8aad8b1d8a7d98320d981d98a20d8a8d8b9d8b620d8a7d984d8aed98ad8a7d8b1d8a7d8aa2e3c2f703e0d0a3c703ed98ad985d983d986d98320d8a7d8aed8aad98ad8a7d8b120d8aad8b9d8b7d98ad98420d8a7d984d983d988d983d98ad8b220d985d98620d8aed984d8a7d98420d8aed98ad8a7d8b1d8a7d8aa20d985d8aad8b5d981d8add98320d8a7d984d981d8b1d8afd98ad8a92e20d984d985d8b9d8b1d981d8a920d8a7d984d985d8b2d98ad8af20d8add988d98420d8a5d8afd8a7d8b1d8a920d8a7d984d983d988d983d98ad8b220d985d8b920d8a7d984d985d8aad8b5d981d8add8a7d8aa20d8a7d984d985d8aed8aad984d981d8a9d88c20d98ad985d983d986d98320d8b2d98ad8a7d8b1d8a920d8a7d984d985d988d8a7d982d8b920d8a7d984d8a5d984d983d8aad8b1d988d986d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d8a7d984d985d8aad8b5d981d8add8a7d8aa2e3c2f703e0d0a3c68333e3c7374726f6e673ed8add982d988d98220d8a7d984d8aed8b5d988d8b5d98ad8a920d8a8d985d988d8acd8a820434350412028d984d8a720d8aad8a8d98ad8b920d985d8b9d984d988d985d8a7d8aad98a20d8a7d984d8b4d8aed8b5d98ad8a9293c2f7374726f6e673e3c2f68333e0d0a3c703ed8a8d985d988d8acd8a82043435041d88c20d985d98620d8a8d98ad98620d8add982d988d98220d8a3d8aed8b1d989d88c20d98ad8add98220d984d985d8b3d8aad987d984d983d98a20d983d8a7d984d98ad981d988d8b1d986d98ad8a73a3c2f703e0d0a3c756c3e0d0a3c6c693ed8b7d984d8a820d8a3d98620d98ad983d8b4d98120d8a7d984d8b9d985d98420d8b9d98620d981d8a6d8a7d8aa20d988d8a8d98ad8a7d986d8a7d8aa20d985d8b9d98ad986d8a920d8aad98520d8acd985d8b9d987d8a720d8b9d98620d8a7d984d985d8b3d8aad987d984d983d98ad9862e3c2f6c693e0d0a3c6c693ed8b7d984d8a820d8a3d98620d98ad982d988d98520d8a7d984d8b9d985d98420d8a8d8add8b0d98120d8a3d98a20d8a8d98ad8a7d986d8a7d8aa20d8b4d8aed8b5d98ad8a920d8aad98520d8acd985d8b9d987d8a720d8b9d98620d8a7d984d985d8b3d8aad987d984d9832e3c2f6c693e0d0a3c6c693ed8b7d984d8a820d985d98620d8a7d984d8b9d985d98420d8b9d8afd98520d8a8d98ad8b920d8a7d984d8a8d98ad8a7d986d8a7d8aa20d8a7d984d8b4d8aed8b5d98ad8a920d984d984d985d8b3d8aad987d984d9832e3c2f6c693e0d0a3c2f756c3e0d0a3c703ed8a5d8b0d8a720d982d985d8aa20d8a8d8aad982d8afd98ad98520d8b7d984d8a8d88c20d984d8afd98ad986d8a720d8b4d987d8b120d988d8a7d8add8af20d984d984d8b1d8af20d8b9d984d98ad9832e20d8a5d8b0d8a720d983d986d8aa20d8aad8b1d8bad8a820d981d98a20d985d985d8a7d8b1d8b3d8a920d8a3d98a20d985d98620d987d8b0d98720d8a7d984d8add982d988d982d88c20d98ad8b1d8acd98920d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a72e3c2f703e0d0a3c68333e3c7374726f6e673ed8add982d988d98220d8add985d8a7d98ad8a920d8a7d984d8a8d98ad8a7d986d8a7d8aa20d8a8d985d988d8acd8a820d8a7d984d984d8a7d8a6d8add8a920d8a7d984d8b9d8a7d985d8a920d984d8add985d8a7d98ad8a920d8a7d984d8a8d98ad8a7d986d8a7d8aa202847445052293c2f7374726f6e673e3c2f68333e0d0a3c703ed986d8b1d98ad8af20d8a3d98620d986d8aad8a3d983d8af20d985d98620d8a3d986d98320d8b9d984d98920d8afd8b1d8a7d98ad8a920d983d8a7d985d984d8a920d8a8d8acd985d98ad8b920d8add982d988d98220d8add985d8a7d98ad8a920d8a7d984d8a8d98ad8a7d986d8a7d8aa20d8a7d984d8aed8a7d8b5d8a920d8a8d9832e20d98ad8add98220d984d983d98420d985d8b3d8aad8aed8afd98520d8a7d984d8add8b5d988d98420d8b9d984d98920d8a7d984d8add982d988d98220d8a7d984d8aad8a7d984d98ad8a920d8a8d985d988d8acd8a820d8a7d984d984d8a7d8a6d8add8a920d8a7d984d8b9d8a7d985d8a920d984d8add985d8a7d98ad8a920d8a7d984d8a8d98ad8a7d986d8a7d8aa202847445052293a3c2f703e0d0a3c756c3e0d0a3c6c693e3c7374726f6e673ed8add98220d8a7d984d988d8b5d988d9843c2f7374726f6e673e20e2809320d984d8afd98ad98320d8a7d984d8add98220d981d98a20d8b7d984d8a820d986d8b3d8ae20d985d98620d8a8d98ad8a7d986d8a7d8aad98320d8a7d984d8b4d8aed8b5d98ad8a92e3c2f6c693e0d0a3c6c693e3c7374726f6e673ed8add98220d8a7d984d8aad8b5d8add98ad8ad3c2f7374726f6e673e20e2809320d984d8afd98ad98320d8a7d984d8add98220d981d98a20d8b7d984d8a820d8aad8b5d8add98ad8ad20d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d8aad8b9d8aad982d8af20d8a3d986d987d8a720d8bad98ad8b120d8afd982d98ad982d8a920d8a3d98820d8a5d8aad985d8a7d98520d8a7d984d985d8b9d984d988d985d8a7d8aa20d8a7d984d8aad98a20d8aad8b9d8aad982d8af20d8a3d986d987d8a720d8bad98ad8b120d985d983d8aad985d984d8a92e3c2f6c693e0d0a3c6c693e3c7374726f6e673ed8add98220d8a7d984d8add8b0d9813c2f7374726f6e673e20e2809320d984d8afd98ad98320d8a7d984d8add98220d981d98a20d8b7d984d8a820d8add8b0d98120d8a8d98ad8a7d986d8a7d8aad98320d8a7d984d8b4d8aed8b5d98ad8a9d88c20d988d981d982d98bd8a720d984d8b4d8b1d988d8b720d985d8b9d98ad986d8a92e3c2f6c693e0d0a3c6c693e3c7374726f6e673ed8add98220d8aad982d98ad98ad8af20d8a7d984d985d8b9d8a7d984d8acd8a93c2f7374726f6e673e20e2809320d984d8afd98ad98320d8a7d984d8add98220d981d98a20d8b7d984d8a820d8aad982d98ad98ad8af20d985d8b9d8a7d984d8acd8a920d8a8d98ad8a7d986d8a7d8aad98320d8a7d984d8b4d8aed8b5d98ad8a9d88c20d988d981d982d98bd8a720d984d8b4d8b1d988d8b720d985d8b9d98ad986d8a92e3c2f6c693e0d0a3c6c693e3c7374726f6e673ed8add98220d8a7d984d8a7d8b9d8aad8b1d8a7d8b620d8b9d984d98920d8a7d984d985d8b9d8a7d984d8acd8a93c2f7374726f6e673e20e2809320d984d8afd98ad98320d8a7d984d8add98220d981d98a20d8a7d984d8a7d8b9d8aad8b1d8a7d8b620d8b9d984d98920d985d8b9d8a7d984d8acd8aad986d8a720d984d8a8d98ad8a7d986d8a7d8aad98320d8a7d984d8b4d8aed8b5d98ad8a9d88c20d988d981d982d98bd8a720d984d8b4d8b1d988d8b720d985d8b9d98ad986d8a92e3c2f6c693e0d0a3c6c693e3c7374726f6e673ed8add98220d986d982d98420d8a7d984d8a8d98ad8a7d986d8a7d8aa3c2f7374726f6e673e20e2809320d984d8afd98ad98320d8a7d984d8add98220d981d98a20d8b7d984d8a820d986d982d98420d8a7d984d8a8d98ad8a7d986d8a7d8aa20d8a7d984d8aad98a20d8acd985d8b9d986d8a7d987d8a720d8a5d984d98920d985d986d8b8d985d8a920d8a3d8aed8b1d98920d8a3d98820d985d8a8d8a7d8b4d8b1d8a920d8a5d984d98ad983d88c20d988d981d982d98bd8a720d984d8b4d8b1d988d8b720d985d8b9d98ad986d8a92e3c2f6c693e0d0a3c2f756c3e0d0a3c703ed8a5d8b0d8a720d982d985d8aa20d8a8d8aad982d8afd98ad98520d8b7d984d8a8d88c20d984d8afd98ad986d8a720d8b4d987d8b120d988d8a7d8add8af20d984d984d8b1d8af20d8b9d984d98ad9832e20d8a5d8b0d8a720d983d986d8aa20d8aad8b1d8bad8a820d981d98a20d985d985d8a7d8b1d8b3d8a920d8a3d98a20d985d98620d987d8b0d98720d8a7d984d8add982d988d982d88c20d98ad8b1d8acd98920d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a72e3c2f703e0d0a3c68333e3c7374726f6e673ed985d8b9d984d988d985d8a7d8aa20d8a7d984d8a3d8b7d981d8a7d9843c2f7374726f6e673e3c2f68333e0d0a3c703ed8a3d8add8af20d8a3d988d984d988d98ad8a7d8aad986d8a720d987d98820d8aad988d981d98ad8b120d8add985d8a7d98ad8a920d8a5d8b6d8a7d981d98ad8a920d984d984d8a3d8b7d981d8a7d98420d8a3d8abd986d8a7d8a120d8a7d8b3d8aad8aed8afd8a7d98520d8a7d984d8a5d986d8aad8b1d986d8aa2e20d986d8b4d8acd8b920d8a7d984d8a2d8a8d8a7d8a120d988d8a7d984d8a3d988d8b5d98ad8a7d8a120d8b9d984d98920d985d8b1d8a7d982d8a8d8a920d988d985d8b4d8a7d8b1d983d8a920d988d8a5d8b1d8b4d8a7d8af20d8a3d986d8b4d8b7d8a920d8a3d8b7d981d8a7d984d987d98520d8b9d8a8d8b120d8a7d984d8a5d986d8aad8b1d986d8aa2e3c2f703e0d0a3c703ed984d8a720d98ad982d988d9852054696d655374617920d8a8d8acd985d8b920d8a3d98a20d985d8b9d984d988d985d8a7d8aa20d98ad985d983d98620d8a7d984d8aad8b9d8b1d98120d8b9d984d98ad987d8a720d8b4d8aed8b5d98ad98bd8a720d985d98620d8a7d984d8a3d8b7d981d8a7d98420d8afd988d98620d8b3d98620313320d8b9d8a7d985d98bd8a72e20d8a5d8b0d8a720d983d986d8aa20d8aad8b9d8aad982d8af20d8a3d98620d8b7d981d984d98320d982d8af20d982d8afd98520d987d8b0d98720d8a7d984d985d8b9d984d988d985d8a7d8aa20d8b9d984d98920d985d988d982d8b9d986d8a7d88c20d986d8add8abd98320d8b9d984d98920d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a720d981d988d8b1d98bd8a720d988d8b3d986d8a8d8b0d98420d982d8b5d8a7d8b1d98920d8acd987d8afd986d8a720d984d8a5d8b2d8a7d984d8a920d987d8b0d98720d8a7d984d985d8b9d984d988d985d8a7d8aa20d985d98620d8b3d8acd984d8a7d8aad986d8a72e3c2f703e0d0a3c68333e3c7374726f6e673ed8a7d984d8aad8bad98ad98ad8b1d8a7d8aa20d981d98a20d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d987d8b0d9873c2f7374726f6e673e3c2f68333e0d0a3c703ed982d8af20d986d982d988d98520d8a8d8aad8add8afd98ad8ab20d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d985d98620d988d982d8aa20d984d8a2d8aed8b12e20d984d8b0d984d983d88c20d986d986d8b5d8add98320d8a8d985d8b1d8a7d8acd8b9d8a920d987d8b0d98720d8a7d984d8b5d981d8add8a920d8a8d8b4d983d98420d8afd988d8b1d98a20d984d8a3d98a20d8aad8bad98ad98ad8b1d8a7d8aa2e20d8b3d986d982d988d98520d8a8d8a5d8b9d984d8a7d985d98320d8a8d8a3d98a20d8aad8bad98ad98ad8b1d8a7d8aa20d8b9d98620d8b7d8b1d98ad98220d986d8b4d8b120d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8acd8afd98ad8afd8a920d8b9d984d98920d987d8b0d98720d8a7d984d8b5d981d8add8a92e20d8aad8b5d8a8d8ad20d987d8b0d98720d8a7d984d8aad8bad98ad98ad8b1d8a7d8aa20d8b3d8a7d8b1d98ad8a920d981d988d8b120d986d8b4d8b1d987d8a720d8b9d984d98920d987d8b0d98720d8a7d984d8b5d981d8add8a92e3c2f703e0d0a3c68333e3c7374726f6e673ed8a7d8aad8b5d98420d8a8d986d8a73c2f7374726f6e673e3c2f68333e0d0a3c703ed8a5d8b0d8a720d983d8a7d986d8aa20d984d8afd98ad98320d8a3d98a20d8a3d8b3d8a6d984d8a920d8a3d98820d8a7d982d8aad8b1d8a7d8add8a7d8aa20d8add988d98420d8b3d98ad8a7d8b3d8a920d8a7d984d8aed8b5d988d8b5d98ad8a920d8a7d984d8aed8a7d8b5d8a920d8a8d986d8a7d88c20d984d8a720d8aad8aad8b1d8afd8af20d981d98a20d8a7d984d8a7d8aad8b5d8a7d98420d8a8d986d8a73a3c2f703e0d0a3c756c3e0d0a3c6c693ed8b9d8a8d8b120d8a7d984d8a8d8b1d98ad8af20d8a7d984d8a5d984d983d8aad8b1d988d986d98a3a203c613e737570706f72744074696d65737461792e636f6d3c2f613e3c2f6c693e0d0a3c6c693ed8a8d8b2d98ad8a7d8b1d8a920d987d8b0d98720d8a7d984d8b5d981d8add8a920d8b9d984d98920d985d988d982d8b9d986d8a73a203c613e7777772e3c2f613e3c6120636c6173733d22632d6c696e6b2220687265663d22687474703a2f2f636f646563616e796f6e382e6b7265617469766465762e636f6d2f74696d657374617922207461726765743d225f626c616e6b222072656c3d226e6f7265666572726572206e6f6f70656e6572223e636f646563616e796f6e382e6b7265617469766465762e636f6d2f74696d65737461793c2f613e3c613ec2a03c2f613e3c2f6c693e0d0a3c2f756c3e, '2023-08-19 23:56:10', '2025-01-03 22:02:19');

-- --------------------------------------------------------

--
-- Table structure for table `page_headings`
--

CREATE TABLE `page_headings` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `hotel_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `rooms_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `room_checkout_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `blog_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `error_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pricing_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `faq_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `forget_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_forget_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `login_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `signup_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_login_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_signup_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `checkout_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `about_us_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `room_wishlist_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `hotel_wishlist_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `dashboard_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `room_bookings_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `room_booking_details_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `support_ticket_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `support_ticket_create_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `change_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `edit_profile_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `custom_page_heading` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `page_headings`
--

INSERT INTO `page_headings` (`id`, `language_id`, `hotel_page_title`, `rooms_page_title`, `room_checkout_page_title`, `blog_page_title`, `contact_page_title`, `error_page_title`, `pricing_page_title`, `faq_page_title`, `forget_password_page_title`, `vendor_forget_password_page_title`, `login_page_title`, `signup_page_title`, `vendor_login_page_title`, `vendor_signup_page_title`, `checkout_page_title`, `vendor_page_title`, `about_us_title`, `room_wishlist_page_title`, `hotel_wishlist_page_title`, `dashboard_page_title`, `room_bookings_page_title`, `room_booking_details_page_title`, `support_ticket_page_title`, `support_ticket_create_page_title`, `change_password_page_title`, `edit_profile_page_title`, `custom_page_heading`, `created_at`, `updated_at`) VALUES
(9, 20, 'Hotels', 'Rooms', 'Room Checkout', 'Blog', 'Contact', '404', 'Pricing', 'FAQ', 'Forget Password', 'Forget Password', 'Login', 'Signup', 'Vendor Login', 'Vendor Signup', 'Checkout', 'Vendors', 'About Us', 'Saved Rooms', 'Saved Hotels', 'Dashboard', 'Bookings', 'Booking Details', 'Support Tickets', 'Create a Support Ticket', 'Change Password', 'Edit Profile', '{\"21\":\"Terms & Condition\",\"22\":\"Privacy Policy\",\"28\":null}', '2023-08-27 01:23:22', '2025-01-03 21:55:04'),
(10, 21, NULL, NULL, NULL, 'مدونة', 'اتصال', '404', 'التسعير', 'التعليمات', 'نسيت كلمة المرور', 'نسيت كلمة المرور', 'تسجيل الدخول', 'اشتراك', 'تسجيل دخول البائع', 'تسجيل البائع', 'الدفع', 'الباعة', 'معلومات عنا', 'قوائم الامنيات', NULL, 'لوحة القيادة', 'طلبات', NULL, 'تذاكر الدعم الفني', 'إنشاء تذكرة دعم', 'تغيير كلمة المرور', 'تعديل الملف الشخصي', '{\"21\":\"\\u0627\\u0644\\u0634\\u0631\\u0648\\u0637 \\u0648\\u0627\\u0644\\u0623\\u062d\\u0643\\u0627\\u0645\",\"22\":\"\\u0633\\u064a\\u0627\\u0633\\u0629 \\u0627\\u0644\\u062e\\u0635\\u0648\\u0635\\u064a\\u0629\",\"28\":null}', '2024-02-06 02:49:35', '2025-01-03 21:55:16');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_invoices`
--

CREATE TABLE `payment_invoices` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `InvoiceId` bigint UNSIGNED NOT NULL,
  `InvoiceStatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `InvoiceValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `InvoiceDisplayValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `TransactionId` bigint UNSIGNED NOT NULL,
  `TransactionStatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PaymentGateway` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PaymentId` bigint UNSIGNED NOT NULL,
  `CardNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `popups`
--

CREATE TABLE `popups` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `type` smallint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `background_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `background_color_opacity` decimal(3,2) UNSIGNED DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `delay` int UNSIGNED NOT NULL COMMENT 'value will be in milliseconds',
  `serial_number` mediumint UNSIGNED NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0 => deactive, 1 => active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `popups`
--

INSERT INTO `popups` (`id`, `language_id`, `type`, `image`, `name`, `background_color`, `background_color_opacity`, `title`, `text`, `button_text`, `button_color`, `button_url`, `end_date`, `end_time`, `delay`, `serial_number`, `status`, `created_at`, `updated_at`) VALUES
(20, 20, 1, '64e1aff148d67.png', 'Black Friday', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1500, 1, 0, '2023-08-20 00:17:21', '2024-07-15 21:51:52'),
(21, 20, 2, '64e1b8074e80b.png', 'Month End Sale', 'EE1243', 0.80, 'ENJOY 10% OFF', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.', 'Get Offer', 'EE1243', 'https://codecanyon8.kreativdev.com/carlisting', NULL, NULL, 2000, 2, 0, '2023-08-20 00:51:51', '2024-07-15 21:51:55'),
(22, 20, 3, '64e1b8ba1a7a7.jpg', 'Summer Offer', 'EE1243', 0.70, 'Newsletter', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.', 'Subscribe', 'EE1243', NULL, NULL, NULL, 2000, 3, 0, '2023-08-20 00:54:50', '2024-07-15 21:51:48'),
(23, 20, 4, '64e1b95adbe02.jpg', 'Winter Offer', NULL, NULL, 'Get 10% off your sign up', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt', 'Sign up', 'EE1243', 'https://codecanyon8.kreativdev.com/carlisting', NULL, NULL, 2000, 4, 0, '2023-08-20 00:57:30', '2024-07-15 21:51:46'),
(24, 20, 5, '64e1b9ca02dbb.png', 'Email Popup', NULL, NULL, 'Get 10% off your first package purchase', 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt', 'Subscribe', 'EE1243', NULL, NULL, NULL, 2000, 2, 0, '2023-08-20 00:59:22', '2024-07-15 21:51:43'),
(25, 20, 6, '64e1ba4d0151d.png', 'Countdown Popup', NULL, NULL, 'Hurry, Sale Ends This Friday', 'This is your last chance to save 30%', 'Yes,I Want to Save 30%', 'EE1243', 'https://codecanyon8.kreativdev.com/carlisting', '2029-12-27', '12:30:00', 2000, 6, 0, '2023-08-20 01:00:55', '2024-07-15 21:51:41'),
(26, 20, 7, '673c030c599f1.jpg', 'Flash Deal', 'EE1243', NULL, 'Hurry, Sale Ends This Friday', 'This is your last chance to save 30%', 'Yes, I Want to Save 30%', 'A50C2E', 'https://codecanyon8.kreativdev.com/carlisting', '2029-11-29', '01:00:00', 2000, 7, 0, '2023-08-20 01:03:34', '2024-11-21 00:22:07'),
(30, 21, 2, '66a9f2f762782.png', 'rhfghfghfgh', 'FFFFFF', 0.00, '56y', 'reyt', 'eryt', 'FFFFFF', 'try', NULL, NULL, 65546, 54, 0, '2024-07-31 02:16:55', '2024-09-10 00:13:50');

-- --------------------------------------------------------

--
-- Table structure for table `push_subscriptions`
--

CREATE TABLE `push_subscriptions` (
  `id` bigint UNSIGNED NOT NULL,
  `subscribable_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `subscribable_id` bigint UNSIGNED NOT NULL,
  `endpoint` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `public_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `auth_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `content_encoding` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `push_subscriptions`
--

INSERT INTO `push_subscriptions` (`id`, `subscribable_type`, `subscribable_id`, `endpoint`, `public_key`, `auth_token`, `content_encoding`, `created_at`, `updated_at`) VALUES
(92, 'App\\Models\\Guest', 94, 'https://fcm.googleapis.com/fcm/send/dXs7VyhQvcI:APA91bEGXyxoErJavBQyZKwe15j7hy0hkJwbbUwZLYApwf1o_jFSBaf72lp2Q7JYcitOP8oHebbZaTKaMi0KQW2Dw7nO-o0g_qe-3ggEoxusqK3jTN7RGBFkKxJq8ceQRw9PfpruZ9kH', 'BHPMSnEl5erknt0scHqjckWr-lSiZV6SFpOGVPDfeLsjq7N-XMBbB8umpVTZ9bIFB6OP0na4LJU1tI54l_YvfhA', 'GGW-K4Fx6HERAA-eZnTQ2w', NULL, '2023-08-24 05:30:17', '2023-08-24 05:30:17'),
(94, 'App\\Models\\Guest', 96, 'https://fcm.googleapis.com/fcm/send/e7xN0DAsuOM:APA91bGzdy-7dmskHcwwc3uFtR9-expvCDJFZf5_iJkaMeDh9YX57mc9u-hYK2sjpmOBZ9B0jEBTC-ggKHYCqsAb3ikEeSCdBtY1OPpn9X8jWyPWA3xg8uQyLHrjIY--7H5G7eEmWucP', 'BNKjYBbEBbY0loyI__HK_QN-RkfMqobvOCIwdhxuG00MBkMWXLsxSRtSNBVvJ4OsMePDTic-Ysl7OJ--gjsPkZQ', '1TN-cjmZrIm0gD98Z3hfcA', NULL, '2023-08-24 05:30:55', '2023-08-24 05:30:55'),
(95, 'App\\Models\\Guest', 97, 'https://fcm.googleapis.com/fcm/send/c5E5VYPn2Xs:APA91bGys_oMMQqwQ9RbMtTIkK8jKpSFT2hp-yhhJ6PR5o4yIbDPOlbY-v3v3bcNyG2_zPOS95PVx6fYtq9JdTwQfj4vzTft_k_wzpl4meOf4kDP-zKyHfyaAJLKg9zS67w1ojGCNrrC', 'BAhWkMyecQ7eVZD0PXi7_unxi4MgErPwebInlrPmRuobPdsCPw9MZBhGGbb5enmtklsBB1442OPGrj8xCkIPks0', 'Kw9fIZBj4OQkNY4Jct4QUg', NULL, '2023-08-24 05:30:55', '2023-08-24 05:30:55'),
(131, 'App\\Models\\Guest', 36, 'https://fcm.googleapis.com/fcm/send/dqJ3VruH12k:APA91bGmET689d1aDARh_qrSmMLJ0xKquyUAmIm1eDFu6ClfCgnoPNOZ0bOruc6i379sno_MUXl9FUm1lpjs53FuPFR3FThpm88YuO4ZS5c1fVtXLDzk6Ui2urEQcJ69Qm5GQV5YaWA6', 'BJ6RRlGNEOAMz9Sjrm7vY2TMLViGPymEuFNtCAwLk091NzGToCrJ68NFrKiyTHrU6vGKpQb6qBYsRDlBW74StwE', 'zeXd5_mI7gc8e92xJIpLxQ', NULL, '2023-10-16 05:05:05', '2023-10-16 05:05:05'),
(132, 'App\\Models\\Guest', 37, 'https://fcm.googleapis.com/fcm/send/e-zK6591S84:APA91bFqP88kFWno-KbgprFdpnES4i8MRwas-7HlnWYuDDeBMQTqaRYVUgSdJpM_4arXcrD8kI2TUSIdVPaLfeqSkZ4SzuCOkQgzB2wWG3UaWrGyM0AW8TxXwjBych3v2XzkzZZvfJgC', 'BITHURX0Fl2xXGiFuJr9mZ4MuA3vViYTdWT5pBMoewqxqLtDjD-vYGLCnnwAGJLGwoRMy0wLNqgycS4826z5LTs', 'TdhzHrli5lOeVW5zaj9arg', NULL, '2023-10-16 05:24:45', '2023-10-16 05:24:45'),
(134, 'App\\Models\\Guest', 39, 'https://fcm.googleapis.com/fcm/send/dDkxM9Wv8mM:APA91bFToA6OopH3oz-_FgZ81B8TIzwJ77MW9i9KcKYcLz3w6heHGGM7AkoSFqqViskIJpSl6QtSIX28oujIxKmfOGAazywzmM2hr41xASQItzScZC24JzUs93FhQCzdZUnQ3juywiAd', 'BMHQrTEiSslG22jF_EPZsYc3WiSJyyYOLdXR9yDl-o9EVRRZoxVuH20kkX5PSdLvjWeL3wIB2qHw4KWYv3dET6g', 'ytW50czGPWMRneP5leNbbw', NULL, '2023-10-16 21:40:39', '2023-10-16 21:40:39'),
(137, 'App\\Models\\Guest', 2, 'https://fcm.googleapis.com/fcm/send/e1HvKOuEPSU:APA91bF1rz9kML9-43xsqG34mAJwUk6On7Yd8I3Cd4cPEPJFT1t4S88j-MzoEyvNLOQSidsx_9mUN0Inp-q-pHp12cZjU2dcsVnwaQMAbBMMrUZ1V_akeB-lx2I6uNl-IAg2j1okchM1', 'BFrtzb1Px06LEx9oQz7TOjMeUFdZ_Cs8QnBWyUo8xF3KrdxhHwLXd3QUpWZBk-gteF_Y5vqb_X_4GqLgS4WM67Y', '6w7e8y1S7V15AB5z2ttW0Q', NULL, '2024-07-27 04:04:05', '2024-07-27 04:04:05'),
(138, 'App\\Models\\Guest', 3, 'https://fcm.googleapis.com/fcm/send/fY5C1ZQe5bI:APA91bEMWPWBnkPvAw-VEkgmDwAAoYJH7XI5jeKqRp77JVIFa_q3Bp7sst5WGUE26KZlAXajbs3jR8G0GmkCEZXYmAiGLuUn9SPM-sqqCXKJ2TCRXh9jVn_BwibRgcD3fOq9kfLJDQEK', 'BH0wtuz5lpPmGYJVBRsTsdQSxdEM1YIPnnyR3JiyYfs4xQZWVfje2ut4yPwVGOlYShNb53fqe5q9WoH822pFigA', 'Ljr5ET_0rLOW1n4pab_miQ', NULL, '2024-07-29 02:56:54', '2024-07-29 02:56:54'),
(139, 'App\\Models\\Guest', 4, 'https://fcm.googleapis.com/fcm/send/f1XbiGp2boI:APA91bFylhGXISffUK77_LJtT6KYVN-K9Hu3TgSelTlphXDWi-bo75R5bagVPggQcIDFFEkfIE_e80cYGfoUDzYtT7QUPvppXHIKBjH-BpZopBMMzT6oW4Wqakvzvo3xyREwVx7Fmtxs', 'BGgT_SLsMzawIhd6gGal49OCK1YLkvKL5IQ2W2CIiViS0LEJa3hUaD1eTP-2Kc-CGNXP-59iPHlsncGm7XxaygM', 'MKwlhvVJuGoiVIvgOhvefg', NULL, '2024-07-30 03:30:02', '2024-07-30 03:30:02');

-- --------------------------------------------------------

--
-- Table structure for table `quick_links`
--

CREATE TABLE `quick_links` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` smallint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `quick_links`
--

INSERT INTO `quick_links` (`id`, `language_id`, `title`, `url`, `serial_number`, `created_at`, `updated_at`) VALUES
(11, 20, 'About Us', 'https://codecanyon8.kreativdev.com/carlist/about-us', 1, '2023-08-19 23:46:05', '2023-08-28 04:16:52'),
(12, 20, 'Contact', 'https://codecanyon8.kreativdev.com/carlist/contact', 2, '2023-08-19 23:46:32', '2023-08-28 04:16:45'),
(13, 20, 'FAQ', 'https://codecanyon8.kreativdev.com/carlist/faq', 3, '2023-08-19 23:46:51', '2023-08-28 04:16:38'),
(15, 21, 'معلومات عنا', 'https://codecanyon8.kreativdev.com/carlist/about-us', 1, '2023-08-20 00:12:46', '2023-08-28 04:17:13'),
(16, 21, 'اتصال', 'https://codecanyon8.kreativdev.com/carlist/contact', 2, '2023-08-20 00:13:18', '2023-08-28 04:17:08'),
(17, 21, 'التعليمات', 'https://codecanyon8.kreativdev.com/carlist/faq', 3, '2023-08-20 00:13:43', '2023-08-28 04:17:02');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `permissions` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `name`, `permissions`, `created_at`, `updated_at`) VALUES
(4, 'Admin', '[\"Support Tickets\"]', '2021-08-06 22:42:38', '2023-07-17 04:07:24'),
(6, 'Moderator', '[\"Menu Builder\",\"Package Management\",\"Hotel Management\",\"Room Management\",\"Room Bookings\",\"Payment Log\",\"Featured Hotels\",\"Featured Rooms\",\"Hotel Specifications\",\"Shop Management\",\"User Management\",\"Vendors Management\",\"Transaction\",\"Home Page\",\"Support Tickets\",\"Footer\",\"Custom Pages\",\"Blog Management\",\"FAQ Management\",\"Advertisements\",\"Announcement Popups\",\"Withdrawals Management\",\"Payment Gateways\",\"Basic Settings\",\"Admin Management\",\"Language Management\"]', '2021-08-07 22:14:34', '2024-08-01 00:32:56'),
(14, 'Supervisor', '[\"Menu Builder\",\"Pages\",\"Transaction\",\"Withdrawals Management\",\"Package Management\",\"Hotel Management\",\"Room Management\",\"Payment Log\",\"Room Bookings\",\"User Management\",\"Vendors Management\",\"Advertisements\",\"Announcement Popups\",\"Support Tickets\",\"Basic Settings\",\"Admin Management\"]', '2021-11-24 22:48:53', '2024-11-04 00:41:34');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint UNSIGNED NOT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `average_rating` double DEFAULT '0',
  `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` bigint DEFAULT NULL,
  `bed` bigint DEFAULT NULL,
  `min_price` decimal(10,0) DEFAULT '0',
  `max_price` decimal(10,0) NOT NULL DEFAULT '0',
  `adult` int DEFAULT NULL,
  `children` int DEFAULT NULL,
  `bathroom` bigint DEFAULT NULL,
  `number_of_rooms_of_this_same_type` bigint DEFAULT NULL,
  `preparation_time` int NOT NULL DEFAULT '0',
  `area` bigint DEFAULT NULL,
  `prices` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_service` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `hotel_id`, `vendor_id`, `feature_image`, `average_rating`, `latitude`, `longitude`, `status`, `bed`, `min_price`, `max_price`, `adult`, `children`, `bathroom`, `number_of_rooms_of_this_same_type`, `preparation_time`, `area`, `prices`, `additional_service`, `created_at`, `updated_at`) VALUES
(1, 1, 0, '674d75eee279f.png', 0, NULL, NULL, 1, 1, 30, 150, 2, 0, 1, 10, 20, 180, '[\"30\",\"70\",\"120\",\"150\",\"100\"]', '{\"1\":\"100\",\"3\":\"100\",\"4\":\"40\",\"6\":\"123\",\"9\":\"80\"}', '2024-12-02 02:55:10', '2025-01-03 23:58:44'),
(2, 2, 0, '674d788fa3951.png', 0, NULL, NULL, 1, 5, 100, 1200, 6, 4, 3, 15, 30, 270, '[\"100\",\"280\",\"590\",\"1200\",\"100\"]', '{\"1\":\"120\",\"4\":\"40\",\"5\":\"125\",\"7\":\"99\",\"8\":\"69\"}', '2024-12-02 03:06:23', '2025-01-03 23:58:04'),
(3, 3, 0, '1733194626.png', 4, NULL, NULL, 1, 1, 50, 220, 2, 0, 1, 10, 20, 180, '[\"50\",\"130\",\"180\",\"220\",\"100\"]', '{\"3\":\"100\",\"4\":\"199\",\"5\":\"40\",\"6\":\"123\",\"7\":\"99\"}', '2024-12-02 02:55:10', '2025-01-04 01:56:01'),
(4, 4, 0, '1733195222.png', 0, NULL, NULL, 1, 5, 60, 270, 6, 4, 3, 10, 30, 270, '[\"60\",\"150\",\"210\",\"270\",\"100\"]', '{\"1\":\"70\",\"3\":\"90\",\"4\":\"130\",\"5\":\"120\",\"8\":\"150\"}', '2024-12-02 03:06:23', '2025-01-03 23:57:06'),
(5, 5, 0, '1733195555.png', 0, NULL, NULL, 1, 1, 45, 190, 2, 0, 1, 10, 20, 180, '[\"45\",\"110\",\"150\",\"190\",\"100\"]', '{\"1\":\"100\",\"4\":\"40\",\"5\":\"166\",\"8\":\"59\",\"9\":\"120\"}', '2024-12-02 02:55:10', '2025-01-03 23:56:36'),
(6, 6, 0, '1733196602.png', 0, NULL, NULL, 1, 5, 100, 900, 6, 4, 3, 15, 30, 270, '[\"200\",\"500\",\"700\",\"900\",\"100\"]', '{\"1\":\"100\",\"2\":\"30\",\"6\":\"123\",\"8\":\"69\",\"10\":\"177\"}', '2024-12-02 03:06:23', '2025-01-03 23:56:04'),
(7, 7, 0, '1733196967.png', 5, NULL, NULL, 1, 1, 80, 300, 2, 0, 1, 15, 30, 270, '[\"80\",\"160\",\"220\",\"300\",\"100\"]', '{\"1\":\"100\",\"3\":\"45\",\"5\":\"40\",\"7\":\"99\",\"9\":\"67\"}', '2024-12-02 03:06:23', '2025-01-03 23:55:42'),
(8, 8, 0, '1733200252.png', 0, NULL, NULL, 1, 1, 55, 225, 2, 0, 1, 10, 20, 180, '[\"55\",\"135\",\"180\",\"225\",\"100\"]', '{\"1\":\"100\",\"4\":\"199\",\"5\":\"100\",\"9\":\"189\",\"10\":\"177\"}', '2024-12-02 02:55:10', '2025-01-03 23:55:24'),
(9, 9, 0, '1733200536.png', 0, NULL, NULL, 1, 5, 90, 350, 20, 4, 3, 15, 30, 270, '[\"90\",\"200\",\"280\",\"350\",\"100\"]', '{\"1\":\"100\",\"2\":\"30\",\"3\":\"100\",\"5\":\"40\",\"8\":\"65\"}', '2024-12-02 03:06:23', '2025-01-03 23:54:46'),
(10, 10, 0, '1733202557.png', 3.5, NULL, NULL, 1, 5, 25, 100, 6, 4, 3, 15, 30, 270, '[\"25\",\"60\",\"80\",\"100\",\"100\"]', '{\"1\":\"100\",\"2\":\"100\",\"3\":\"100\",\"4\":\"100\",\"9\":\"189\"}', '2024-12-02 03:06:23', '2025-01-04 02:25:01'),
(11, 11, 0, '1733203253.png', 0, NULL, NULL, 1, 5, 100, 430, 6, 4, 3, 15, 30, 270, '[\"120\",\"250\",\"350\",\"430\",\"100\"]', '{\"2\":\"100\",\"4\":\"56\",\"5\":\"100\",\"6\":\"100\",\"8\":\"120\"}', '2024-12-02 03:06:23', '2025-01-03 23:53:55'),
(12, 12, 0, '1733203551.png', 0, NULL, NULL, 1, 5, 100, 550, 6, 4, 3, 15, 30, 270, '[\"150\",\"350\",\"460\",\"550\",\"100\"]', '{\"1\":\"100\",\"3\":\"45\",\"6\":\"100\",\"7\":\"99\",\"9\":\"189\"}', '2024-12-02 03:06:23', '2025-01-03 23:53:37'),
(13, 13, 0, '1733540252.png', 0, NULL, NULL, 1, 1, 20, 180, 2, 0, 1, 10, 20, 180, '[\"20\",\"100\",\"140\",\"180\",\"100\"]', '{\"2\":\"48\",\"4\":\"56\",\"5\":\"40\",\"8\":\"120\",\"9\":\"80\"}', '2024-12-02 02:55:10', '2025-01-03 23:53:13'),
(14, 14, 0, '1733541383.png', 2, NULL, NULL, 1, 5, 50, 240, 6, 4, 3, 15, 30, 270, '[\"50\",\"120\",\"180\",\"240\",\"100\"]', '{\"1\":\"100\",\"2\":\"100\",\"3\":\"100\",\"4\":\"100\",\"9\":\"67\"}', '2024-12-02 03:06:23', '2025-01-04 03:23:48'),
(15, 15, 0, '1733542065.png', 0, NULL, NULL, 1, 5, 100, 1500, 6, 4, 3, 15, 30, 270, '[\"300\",\"800\",\"1200\",\"1500\",\"100\"]', '{\"1\":\"100\",\"2\":\"100\",\"3\":\"100\",\"4\":\"100\",\"5\":\"100\",\"6\":\"100\"}', '2024-12-02 03:06:23', '2024-12-23 22:45:09'),
(17, 21, 0, '1735705662.png', 0, NULL, NULL, 1, 4, 50, 220, 5, 4, 2, 5, 45, 670, '[\"50\",\"130\",\"180\",\"220\"]', '{\"1\":\"100\",\"4\":\"199\",\"5\":\"100\",\"8\":\"65\",\"9\":\"189\"}', '2024-12-31 22:26:56', '2025-01-03 23:51:52'),
(18, 22, 0, '6774c956a9616.png', 0, NULL, NULL, 1, 1, 250, 750, 2, 0, 1, 6, 30, NULL, '[\"250\",\"450\",\"600\",\"750\"]', '{\"4\":\"67\",\"6\":\"123\",\"7\":\"99\",\"9\":\"189\",\"10\":\"177\"}', '2024-12-31 22:49:26', '2025-01-03 23:51:30'),
(19, 23, 0, '6774caeb5b8a4.png', 0, NULL, NULL, 1, 1, 200, 550, 2, 0, 1, 2, 30, 436, '[\"200\",\"350\",\"450\",\"550\"]', '{\"1\":\"100\",\"2\":\"30\",\"3\":\"45\",\"4\":\"199\",\"8\":\"65\"}', '2024-12-31 22:56:11', '2025-01-03 23:51:06');

-- --------------------------------------------------------

--
-- Table structure for table `room_categories`
--

CREATE TABLE `room_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `status` int DEFAULT NULL,
  `serial_number` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_categories`
--

INSERT INTO `room_categories` (`id`, `language_id`, `status`, `serial_number`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 20, 1, 1, 'Business Room', 'business-room', '2024-12-02 02:06:10', '2024-12-02 02:06:10'),
(2, 20, 1, 2, 'Couple Room', 'couple-room', '2024-12-02 02:07:56', '2024-12-02 02:07:56'),
(3, 20, 1, 3, 'Family Room', 'family-room', '2024-12-02 02:08:59', '2024-12-02 02:08:59'),
(4, 20, 1, 4, 'Transit Room', 'transit-room', '2024-12-02 02:09:36', '2024-12-02 02:09:36'),
(5, 20, 1, 5, 'Deluxe Room', 'deluxe-room', '2024-12-02 02:10:23', '2024-12-02 02:10:23'),
(6, 21, 1, 1, 'غرفة رجال الأعمال', 'غرفة-رجال-الأعمال', '2024-12-02 02:06:10', '2025-01-03 21:19:40'),
(7, 21, 1, 2, 'غرفة زوجين', 'غرفة-زوجين', '2024-12-02 02:07:56', '2025-01-03 21:19:29'),
(8, 21, 1, 3, 'غرفة عائلية', 'غرفة-عائلية', '2024-12-02 02:08:59', '2025-01-03 21:19:17'),
(9, 21, 1, 4, 'غرفة العبور', 'غرفة-العبور', '2024-12-02 02:09:36', '2025-01-03 21:18:58'),
(10, 21, 1, 5, 'غرفة ديلوكس', 'غرفة-ديلوكس', '2024-12-02 02:10:23', '2025-01-03 21:18:37'),
(11, 20, 1, 6, 'Conference Rooms', 'conference-rooms', '2024-12-02 21:24:29', '2024-12-25 23:51:00'),
(12, 21, 1, 6, 'قاعات المؤتمرات', 'قاعات-المؤتمرات', '2024-12-02 21:24:49', '2025-01-03 21:18:25');

-- --------------------------------------------------------

--
-- Table structure for table `room_contents`
--

CREATE TABLE `room_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  `room_category` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amenities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_contents`
--

INSERT INTO `room_contents` (`id`, `language_id`, `room_id`, `room_category`, `title`, `slug`, `address`, `amenities`, `description`, `meta_keyword`, `meta_description`, `created_at`, `updated_at`) VALUES
(1, 20, 1, 2, 'Couple\'s Corner', 'couple\'s-corner', NULL, '[\"1\",\"2\",\"6\",\"7\",\"9\"]', '<p><strong>Couple\'s Corner</strong></p>\r\n<p>Experience the perfect blend of comfort, intimacy, and luxury in the <strong>Couple\'s Corner</strong>, an idyllic space designed exclusively for couples seeking a serene getaway. Located within <em>Hourly Haven</em>, this room combines modern amenities with a romantic ambiance to create a haven where love and connection flourish.</p>\r\n<p>From the moment you step into the <strong>Couple\'s Corner</strong>, you\'ll be greeted by a cozy and inviting atmosphere. The room features soft lighting, plush bedding, and elegant décor that exudes warmth and tranquility. The tasteful design incorporates soothing color palettes and textures, providing the ideal backdrop for relaxation and romance.</p>\r\n<p>The spacious king-sized bed is the centerpiece of the room, adorned with premium linens and extra pillows to ensure unparalleled comfort. A private seating area offers the perfect spot for quiet conversations or enjoying a glass of wine together. The en-suite bathroom boasts a luxurious rain shower and premium toiletries, adding a touch of indulgence to your stay.</p>\r\n<p>For added romance, the room includes thoughtful touches such as scented candles, fresh flowers, and the option to personalize your experience with special packages like breakfast in bed or a candlelit dinner for two. The room’s large windows or private balcony (where available) provide stunning views, allowing you to enjoy peaceful moments together while soaking in the beauty of your surroundings.</p>\r\n<p>Whether you\'re celebrating an anniversary, enjoying a honeymoon, or simply taking a break from the daily grind, the <strong>Couple\'s Corner</strong> is the perfect choice for creating unforgettable memories. Its proximity to <em>Hourly Haven\'s</em> top-notch amenities, including fine dining, a spa, and recreational activities, ensures your stay is both comfortable and enjoyable.</p>\r\n<p>At <strong>Couple\'s Corner</strong>, every detail is designed with couples in mind, making it the ultimate romantic retreat for lovebirds seeking a private escape.</p>', NULL, NULL, '2024-12-02 02:55:11', '2024-12-02 02:55:11'),
(2, 21, 1, 7, 'ركن الزوجين', 'ركن-الزوجين', NULL, '[\"14\",\"15\",\"16\",\"18\",\"20\",\"21\"]', '<p><strong>ركن الأزواج</strong></p>\r\n<p>استمتعوا بالمزيج المثالي من الراحة، الحميمية، والفخامة في <strong>ركن الأزواج</strong>، وهو مكان مثالي مصمم خصيصًا للأزواج الباحثين عن ملاذ هادئ. يقع هذا الركن داخل <em>ساعة هافين</em>، حيث يجمع بين وسائل الراحة العصرية والأجواء الرومانسية لخلق ملاذ يزدهر فيه الحب والتواصل.</p>\r\n<p>من اللحظة التي تدخلون فيها إلى <strong>ركن الأزواج</strong>، ستشعرون بجو دافئ ومريح. يتميز الغرفة بإضاءة ناعمة، وأسِرّة مريحة، وديكور أنيق ينبعث منه الدفء والهدوء. يجمع التصميم بين الألوان الهادئة والقوام المريح، مما يوفر خلفية مثالية للاسترخاء والرومانسية.</p>\r\n<p>يتوسط الغرفة سرير كبير بحجم كينغ مزود بأغطية فاخرة ووسائد إضافية لضمان راحة لا تضاهى. كما تحتوي الغرفة على منطقة جلوس خاصة تُعد مكانًا مثاليًا للمحادثات الهادئة أو الاستمتاع بكأس من العصير أو القهوة معًا. ويشمل الحمام الداخلي دش مطري فاخر ومستحضرات عناية شخصية عالية الجودة تضيف لمسة من الترف إلى إقامتكم.</p>\r\n<p>لتعزيز الأجواء الرومانسية، توفر الغرفة لمسات مميزة مثل الشموع العطرية، والزهور الطبيعية، وخيارات تخصيص التجربة، مثل الإفطار في السرير أو عشاء على ضوء الشموع. كما توفر النوافذ الكبيرة أو الشرفة الخاصة (إن وجدت) إطلالات خلابة، مما يتيح لكم قضاء لحظات هادئة معًا أثناء الاستمتاع بجمال المحيط.</p>\r\n<p>سواء كنتم تحتفلون بذكرى سنوية، أو تستمتعون بشهر العسل، أو تأخذون قسطًا من الراحة بعيدًا عن ضغوط الحياة اليومية، فإن <strong>ركن الأزواج</strong> هو الخيار الأمثل لخلق ذكريات لا تُنسى. وبفضل قربه من المرافق الفاخرة داخل <em>ساعة هافين</em>، بما في ذلك المطاعم الراقية، والمنتجع الصحي، والأنشطة الترفيهية، تضمن إقامتكم أن تكون مريحة ومليئة بالمتعة.</p>\r\n<p>في <strong>ركن الأزواج</strong>، تم تصميم كل التفاصيل بعناية لتلبية احتياجات الأزواج، مما يجعله الملاذ الرومانسي المثالي للراغبين في قضاء وقت خاص لا يُنسى.</p>', NULL, NULL, '2024-12-02 02:55:11', '2024-12-02 02:55:11'),
(3, 20, 2, 3, 'Bonding Suite', 'bonding-suite', NULL, '[\"1\",\"4\",\"6\",\"8\",\"9\"]', '<p>Welcome to<strong> Bonding Suite</strong>, the perfect sanctuary for families seeking comfort, convenience, and togetherness. Located within the serene environment of <em>Hourly Haven</em>, this thoughtfully designed suite offers a harmonious blend of space and style, making it ideal for creating cherished memories with your loved ones.</p>\r\n<p>The suite is generously sized to accommodate families of various sizes, featuring interconnected spaces that provide privacy and connection. The main area includes a cozy seating space with comfortable sofas, perfect for family bonding over movies or games. A dining nook allows for intimate meals, while the room’s modern décor ensures a warm and welcoming ambiance.</p>\r\n<p>The sleeping arrangements are tailored to meet diverse needs. A plush king-sized bed awaits the parents in the master area, while an adjacent section is equipped with twin beds or a bunk bed for the children. For larger families, the suite includes an optional pull-out sofa or extra bedding.</p>\r\n<p>The en-suite bathroom is spacious and family-friendly, featuring a shower and bathtub combination, premium toiletries, and ample counter space for everyone’s essentials. Thoughtful touches like soft towels and kid-friendly amenities add to the comfort.</p>\r\n<p>Families will appreciate the suite’s practical features, such as a kitchenette equipped with a microwave, mini-fridge, and basic utensils, making it easy to prepare snacks or light meals. For entertainment, enjoy a flat-screen TV, complimentary Wi-Fi, and access to family-friendly streaming services.</p>\r\n<p>Large windows or a private balcony flood the room with natural light, offering views of the hotel grounds or nearby cityscape. The suite’s proximity to <em>Hourly Haven’s</em> kid-friendly amenities, such as play areas, pools, or activity centers, ensures endless fun for the little ones while parents unwind.</p>\r\n<p>Whether you’re planning a short stay or an extended visit, <strong>The Bonding Suite</strong> offers everything a family needs to feel at home. Its balance of functionality, comfort, and charm makes it the ideal choice for families looking to strengthen their bond in a relaxing and luxurious setting.</p>', NULL, NULL, '2024-12-02 03:06:23', '2024-12-02 03:06:23'),
(4, 21, 2, 8, 'جناح الترابط', 'جناح-الترابط', NULL, '[\"13\",\"16\",\"18\",\"20\",\"22\"]', '<p><strong>جناح الروابط العائلية</strong></p>\r\n<p>مرحبًا بكم في <strong>جناح الروابط العائلية</strong>، الملاذ المثالي للعائلات الباحثة عن الراحة، والعملية، والتواصل العائلي. يقع هذا الجناح داخل الأجواء الهادئة لفندق <em>ساعة هافين</em>، وقد تم تصميمه بعناية ليجمع بين المساحة والأناقة، مما يجعله المكان المثالي لخلق ذكريات جميلة مع أحبائكم.</p>\r\n<p>يتميز الجناح بمساحته الواسعة التي تناسب العائلات بمختلف أحجامها، مع توفير مساحات مترابطة تمنح الخصوصية والتواصل في آنٍ واحد. يضم الجناح منطقة جلوس مريحة بأرائك فخمة، مثالية لقضاء وقت ممتع مع العائلة أثناء مشاهدة الأفلام أو لعب الألعاب. كما يحتوي على ركن لتناول الطعام يتيح لكم الاستمتاع بالوجبات في أجواء حميمة، بينما يضفي الديكور العصري على الغرفة أجواءً دافئة وترحيبية.</p>\r\n<p>تم تصميم أماكن النوم لتلبية احتياجات العائلات المختلفة. يوفر الجناح سريرًا بحجم كينغ للوالدين في المنطقة الرئيسية، بالإضافة إلى قسم مجاور مجهز بأسرة فردية أو سرير بطابقين للأطفال. وللعائلات الكبيرة، يتوفر خيار سرير أريكة قابل للسحب أو أسرّة إضافية.</p>\r\n<p>يتميز الحمام الداخلي بمساحة واسعة ومناسبة للعائلات، ويشمل دشًا وحوض استحمام، إلى جانب مستحضرات عناية شخصية فاخرة ومساحة واسعة لاحتياجات الجميع. وتضفي اللمسات المدروسة مثل المناشف الناعمة والمستلزمات المخصصة للأطفال مزيدًا من الراحة.</p>\r\n<p>ستقدر العائلات الميزات العملية للجناح، مثل المطبخ الصغير المجهز بميكروويف، وثلاجة صغيرة، وأدوات أساسية لتحضير الوجبات الخفيفة. وللترفيه، يمكنكم الاستمتاع بشاشة تلفاز مسطحة، وخدمة Wi-Fi مجانية، والوصول إلى منصات بث مناسبة للعائلة.</p>\r\n<p>توفر النوافذ الكبيرة أو الشرفة الخاصة إضاءة طبيعية رائعة، مع إطلالات جميلة على مرافق الفندق أو المناظر المحيطة. كما أن قرب الجناح من المرافق الصديقة للأطفال في فندق <em>ساعة هافين</em>، مثل مناطق اللعب، أو حمامات السباحة، أو مراكز الأنشطة، يضمن قضاء وقت ممتع للصغار بينما يستمتع الآباء بلحظات من الاسترخاء.</p>\r\n<p>سواء كنتم تخططون لإقامة قصيرة أو زيارة طويلة، يوفر <strong>جناح الروابط العائلية</strong> كل ما تحتاجه العائلة لتشعر وكأنها في منزلها. إنه الخيار الأمثل لتعزيز الروابط العائلية في أجواء مريحة وفاخرة</p>', NULL, NULL, '2024-12-02 03:06:23', '2024-12-02 03:06:23'),
(5, 20, 3, 1, 'Professional Pad', 'professional-pad', NULL, '[\"4\",\"6\",\"7\",\"8\"]', '<p>The <strong>Professional Pad</strong> is designed to meet the modern business traveler’s needs, offering a perfect blend of comfort, style, and productivity. This thoughtfully curated space caters to professionals who value efficiency while enjoying the finer things in life. Whether you\'re visiting for a quick business trip, attending a conference, or seeking a productive environment for remote work, this room is tailored to exceed your expectations.</p>\r\n<p>The Professional Pad boasts a spacious layout that seamlessly combines functionality with aesthetics. The room features a dedicated workstation equipped with an ergonomic chair, a spacious desk, and high-speed internet connectivity, ensuring that you can work without interruptions. Ample power outlets are strategically placed for charging all your devices, keeping you connected and ready for business at all times.</p>\r\n<p>After a long day of meetings or calls, unwind in the luxurious seating area or rest in the plush king-sized bed with premium linens. The calming decor, featuring neutral tones and modern furnishings, creates an atmosphere that promotes relaxation and focus. Large windows flood the room with natural light during the day, while blackout curtains ensure a peaceful night’s sleep.</p>\r\n<p>The Professional Pad also includes a flat-screen TV, a minibar stocked with refreshments, and a coffee maker for those early mornings or late-night brainstorming sessions. The en-suite bathroom is fitted with a walk-in shower, high-quality toiletries, and fluffy towels to provide a spa-like experience.</p>\r\n<p>Guests staying in the Professional Pad enjoy exclusive access to additional business services such as printing, scanning, and private meeting room bookings. With 24/7 room service and a concierge ready to assist with any request, you\'ll find that every detail has been taken care of to make your stay as seamless and comfortable as possible.</p>\r\n<p>Experience the ideal blend of business and leisure in the <strong>Professional Pad</strong>—a space that inspires productivity while allowing you to relax in luxury.</p>', NULL, NULL, '2024-12-02 20:55:44', '2024-12-02 20:55:44'),
(6, 21, 3, 6, 'الوسادة المهنية', 'الوسادة-المهنية', NULL, '[\"13\",\"14\",\"15\",\"16\",\"18\",\"20\"]', '<p><strong>الغرفة المهنية</strong></p>\r\n<p>تم تصميم <strong>الغرفة المهنية</strong> لتلبية احتياجات المسافر العصري من رجال الأعمال، حيث تقدم مزيجًا مثاليًا من الراحة والأناقة والإنتاجية. تم إعداد هذه المساحة بعناية لتلبية احتياجات المحترفين الذين يقدرون الكفاءة مع التمتع بأرقى وسائل الراحة. سواء كنت في رحلة عمل قصيرة، أو تحضر مؤتمرًا، أو تبحث عن بيئة عمل مثالية عن بُعد، فإن هذه الغرفة مصممة لتتجاوز توقعاتك.</p>\r\n<p>تتميز الغرفة المهنية بتصميم واسع يجمع بسلاسة بين الوظيفة والجمال. تحتوي الغرفة على محطة عمل مخصصة مجهزة بكرسي مريح ومكتب واسع واتصال عالي السرعة بالإنترنت لضمان العمل دون انقطاع. تم توزيع منافذ الطاقة بشكل استراتيجي لشحن جميع أجهزتك، مما يبقيك متصلًا وجاهزًا للعمل في أي وقت.</p>\r\n<p>بعد يوم طويل من الاجتماعات أو المكالمات، يمكنك الاسترخاء في منطقة الجلوس الفاخرة أو الراحة على السرير المزدوج الفاخر المجهز ببياضات عالية الجودة. تضيف الديكورات الهادئة ذات الألوان المحايدة والأثاث العصري جوًا يساعد على الاسترخاء والتركيز. تتيح النوافذ الكبيرة دخول الضوء الطبيعي أثناء النهار، بينما تضمن الستائر المعتمة نومًا هادئًا طوال الليل.</p>\r\n<p>تضم الغرفة المهنية أيضًا تلفزيون بشاشة مسطحة، وميني بار يحتوي على المرطبات، وماكينة لصنع القهوة لتلك الصباحات الباكرة أو جلسات العصف الذهني المتأخرة. يحتوي الحمام الداخلي على دش واسع ومستلزمات استحمام عالية الجودة ومناشف ناعمة لتوفر لك تجربة شبيهة بالسبا.</p>\r\n<p>يستمتع نزلاء الغرفة المهنية بخدمات إضافية مخصصة لرجال الأعمال مثل الطباعة والمسح الضوئي وحجز غرف الاجتماعات الخاصة. ومع خدمة الغرف المتاحة على مدار الساعة وخدمة الكونسيرج المستعدة لتلبية جميع احتياجاتك، ستجد أن كل التفاصيل قد تم العناية بها لجعل إقامتك مريحة وسلسة.</p>\r\n<p>اختبر المزيج المثالي بين العمل والراحة في <strong>الغرفة المهنية</strong>—مساحة تلهم الإنتاجية وتتيح لك الاسترخاء في أجواء فاخرة</p>', NULL, NULL, '2024-12-02 20:55:44', '2024-12-02 20:55:44'),
(7, 20, 4, 3, 'Gathering Place', 'gathering-place', NULL, '[\"2\",\"4\",\"6\",\"7\",\"8\",\"9\"]', '<p>The <strong>Gathering Place Room</strong> is the perfect sanctuary for families seeking a harmonious blend of comfort and togetherness. Designed to accommodate families of all sizes, this room provides a welcoming space where everyone can relax, bond, and create lasting memories.</p>\r\n<p>The room features a spacious layout with ample seating and sleeping arrangements to ensure every family member has their own space while staying connected. A large, plush bed and additional sleeping options such as sofa beds or rollaway beds cater to diverse family needs. The warm, inviting decor, complemented by modern furnishings, creates a cozy atmosphere that feels just like home.</p>\r\n<p>For entertainment, the room is equipped with a flat-screen TV, a selection of family-friendly channels, and complimentary high-speed Wi-Fi, ensuring everyone stays entertained and connected. A dedicated dining area allows families to share meals, whether enjoying room service or savoring their own snacks.</p>\r\n<p>The en-suite bathroom is designed with families in mind, featuring a spacious layout, a walk-in shower, and premium toiletries for a refreshing start or end to the day.</p>\r\n<p>Large windows offer beautiful views and plenty of natural light, while blackout curtains ensure restful sleep for all. Whether it\'s a family getaway or a stop during your travels, the <strong>Gathering Place Room</strong> provides the ideal setting for quality time with your loved ones.</p>', NULL, NULL, '2024-12-02 21:06:42', '2024-12-02 21:06:42'),
(8, 21, 4, 8, 'مكان التجمع', 'مكان-التجمع', NULL, '[\"14\",\"15\",\"16\",\"18\",\"20\",\"21\"]', '<p><strong>غرفة ملتقى العائلة</strong></p>\r\n<p>تعد <strong>غرفة ملتقى العائلة</strong> الملاذ المثالي للعائلات التي تبحث عن مزيج متناغم من الراحة والتواصل. تم تصميم هذه الغرفة لتناسب العائلات بمختلف أحجامها، حيث توفر مساحة دافئة تجمع الجميع للاسترخاء والتقارب وخلق ذكريات لا تُنسى.</p>\r\n<p>تتميز الغرفة بتصميم واسع مع أماكن جلوس ونوم مريحة لضمان حصول كل فرد من أفراد العائلة على مساحته الخاصة مع البقاء على اتصال. تشمل الغرفة سريرًا كبيرًا فاخرًا وخيارات نوم إضافية مثل الأرائك القابلة للطي أو الأسرة القابلة للإضافة لتلبية احتياجات العائلة المتنوعة. يضفي الديكور الدافئ والمريح، المزين بأثاث حديث، أجواءً مريحة تشعر وكأنك في المنزل.</p>\r\n<p>للتسلية، تحتوي الغرفة على تلفزيون بشاشة مسطحة مع مجموعة مختارة من القنوات المناسبة للعائلة، بالإضافة إلى اتصال مجاني عالي السرعة بالإنترنت لضمان بقاء الجميع مستمتعين ومتصِّلين. كما تتيح منطقة الطعام المخصصة للعائلات الاستمتاع بالوجبات معًا، سواء من خلال خدمة الغرف أو تناول الوجبات الخفيفة الخاصة بهم.</p>\r\n<p>يتميز الحمام الداخلي بتصميم يناسب العائلات، ويحتوي على دش واسع ومستلزمات استحمام فاخرة لبداية أو نهاية منعشة لليوم.</p>\r\n<p>توفر النوافذ الكبيرة إطلالات جميلة وضوءًا طبيعيًا وافرًا، بينما تضمن الستائر المعتمة نوماً هنيئاً للجميع. سواء كنت في عطلة عائلية أو محطة أثناء سفركم، توفر <strong>غرفة ملتقى العائلة</strong> البيئة المثالية لقضاء وقت ممتع مع أحبائكم</p>', NULL, NULL, '2024-12-02 21:06:42', '2024-12-02 21:06:42'),
(9, 20, 5, 4, 'Skylark Suite', 'skylark-suite', NULL, '[\"2\",\"3\",\"4\",\"6\",\"7\"]', '<p>The <strong>Skylark Suite</strong> is an ideal haven for travelers seeking comfort and convenience during their transit. Designed to cater to the unique needs of short-stay guests, this room provides a tranquil retreat for relaxation and rejuvenation between journeys. Whether you’re on a layover, waiting for a connecting flight, or simply need a brief escape during your travels, the Skylark Suite offers the perfect solution.</p>\r\n<p>The room is thoughtfully furnished with a cozy bed adorned with premium linens, ensuring a restful sleep even during the shortest stays. A comfortable seating area is included for guests to unwind, catch up on work, or enjoy a light meal. Modern interiors, soothing color palettes, and soft lighting create a calm and inviting atmosphere, helping you recharge in style.</p>\r\n<p>To enhance your stay, the Skylark Suite comes equipped with high-speed Wi-Fi, a flat-screen TV with international channels, and a workspace for professionals on the go. A minibar stocked with refreshments and a coffee maker are provided for your convenience, ensuring you stay energized and ready for the next leg of your journey.</p>\r\n<p>The en-suite bathroom features a walk-in shower, luxurious toiletries, and plush towels, offering a refreshing experience that leaves you feeling revitalized.</p>\r\n<p>With its strategic location, streamlined check-in process, and amenities tailored for travelers, the <strong>Skylark Suite</strong> is your go-to transit room for a seamless and restful experience.</p>', NULL, NULL, '2024-12-02 21:12:35', '2024-12-02 21:12:35'),
(10, 21, 5, 9, 'جناح سكايلارك', 'جناح-سكايلارك', NULL, '[\"14\",\"15\",\"18\"]', '<p>يعد <strong>جناح Skylark</strong> الملاذ المثالي للمسافرين الباحثين عن الراحة والسهولة أثناء التوقف بين رحلاتهم. تم تصميم هذا الجناح لتلبية الاحتياجات الفريدة للضيوف الذين يحتاجون إلى إقامة قصيرة، حيث يوفر مكانًا هادئًا للاسترخاء واستعادة النشاط بين الرحلات. سواء كنت في فترة توقف، أو تنتظر رحلة ربط، أو بحاجة إلى استراحة قصيرة خلال رحلتك، فإن جناح Skylark يقدم الحل الأمثل.</p>\r\n<p>الغرفة مجهزة بعناية بسرير مريح مزود ببياضات فاخرة، مما يضمن نومًا هادئًا حتى خلال الإقامات القصيرة. تضم الغرفة أيضًا منطقة جلوس مريحة تتيح لك الاسترخاء أو إنجاز بعض الأعمال أو الاستمتاع بوجبة خفيفة. تعزز التصميمات الداخلية العصرية ولوحة الألوان المهدئة والإضاءة الناعمة الأجواء الهادئة والجذابة، مما يساعدك على استعادة نشاطك براحة تامة.</p>\r\n<p>لتحسين إقامتك، يحتوي جناح Skylark على إنترنت عالي السرعة، وتلفزيون بشاشة مسطحة مع قنوات دولية، ومساحة عمل مخصصة للمحترفين أثناء التنقل. بالإضافة إلى ذلك، يوفر الميني بار مجموعة مختارة من المشروبات وماكينة صنع القهوة لضمان بقائك نشيطًا ومستعدًا للجزء التالي من رحلتك.</p>\r\n<p>يتميز الحمام الداخلي بدش واسع ومستلزمات استحمام فاخرة ومناشف ناعمة، مما يوفر تجربة منعشة تجعلك تشعر بالانتعاش.</p>\r\n<p>بفضل موقعه الاستراتيجي وعملية تسجيل الوصول السلسة والمرافق المصممة للمسافرين، يعد <strong>جناح Skylark</strong> خيارك الأمثل للحصول على إقامة مريحة وتجربة سلسة خلال رحلتك</p>', NULL, NULL, '2024-12-02 21:12:35', '2024-12-02 21:12:35'),
(11, 20, 6, 11, 'Think Tank', 'think-tank', NULL, '[\"2\",\"3\",\"4\",\"5\"]', '<p>The <strong>Think Tank</strong> room at our hotel is designed to foster innovation, collaboration, and strategic thinking. Ideal for brainstorming sessions, corporate meetings, and high-level discussions, this space is tailored to inspire creative solutions and out-of-the-box thinking. With a spacious and modern layout, the Think Tank is perfect for teams looking to develop new ideas, solve complex challenges, or make key decisions.</p>\r\n<p>Equipped with the latest technology, the Think Tank room features state-of-the-art audio-visual tools, high-speed internet connectivity, and interactive whiteboards to ensure smooth and efficient presentations. Whether you\'re conducting a team workshop, a strategy session, or a group brainstorming event, the room is designed to keep your team engaged and productive.</p>\r\n<p>The room is also customizable to meet the specific needs of your event. Flexible seating arrangements allow for a variety of setups, whether you prefer a round-table layout for open discussions or a theater-style arrangement for presentations. The Think Tank is equipped with comfortable seating, providing a relaxed yet focused environment for your team to collaborate and exchange ideas freely.</p>\r\n<p>Natural light floods the room, creating an open and inviting atmosphere, while the minimalist design helps eliminate distractions and keep the focus on the task at hand. Whether you\'re looking to plan a new product launch, develop an innovative marketing strategy, or explore new business opportunities, the Think Tank offers the perfect space to bring your ideas to life.</p>\r\n<p>In addition to its modern amenities, the Think Tank is conveniently located within our hotel, offering easy access to other meeting rooms and event spaces. Our professional staff is always on hand to assist with any technical or logistical needs, ensuring that your event runs smoothly from start to finish.</p>\r\n<p>Book the <strong>Think Tank</strong> room today and take the first step toward turning your ideas into action. Let this collaborative space be the catalyst for your team\'s success, and watch as the power of collective thinking drives your organization forward</p>', NULL, NULL, '2024-12-02 21:29:53', '2024-12-02 21:29:53'),
(12, 21, 6, 12, 'فكر تانك', 'فكر-تانك', NULL, '[\"14\",\"15\",\"16\",\"20\"]', '<div class=\"flex max-w-full flex-col flex-grow\">\r\n<div class=\"min-h-8 text-message flex w-full flex-col items-end gap-2 whitespace-normal break-words [.text-message+&amp;]:mt-5\">\r\n<div class=\"flex w-full flex-col gap-1 empty:hidden first:pt-[3px]\">\r\n<div class=\"markdown prose w-full break-words dark:prose-invert light\">\r\n<p>غرفة <strong>العصف الذهني</strong> في فندقنا مصممة لتعزيز الابتكار والتعاون والتفكير الاستراتيجي. إنها مثالية لجلسات العصف الذهني، الاجتماعات المهنية، والنقاشات عالية المستوى. تم تصميم هذه المساحة لتحفيز الحلول الإبداعية والتفكير خارج الصندوق. مع تصميمها الحديث والواسع، تعتبر غرفة العصف الذهني مثالية للفرق التي تبحث عن تطوير أفكار جديدة، حل تحديات معقدة، أو اتخاذ قرارات هامة.</p>\r\n<p>مجهزة بأحدث التقنيات، تضم غرفة العصف الذهني أدوات سمعية ومرئية متطورة، واتصال إنترنت عالي السرعة، وألواح بيضاء تفاعلية لضمان تقديم العروض بشكل سلس وفعال. سواء كنت تدير ورشة عمل جماعية، أو جلسة استراتيجية، أو حدثًا للعصف الذهني، فإن الغرفة مصممة للحفاظ على تفاعل فريقك وإنتاجيته.</p>\r\n<p>الغرفة قابلة للتخصيص لتلبية احتياجات الحدث الخاص بك. حيث تسمح الترتيبات القابلة للتعديل للجلوس بتنسيقات متنوعة، سواء كنت تفضل ترتيب الطاولة المستديرة للمناقشات المفتوحة أو الترتيب على نمط المسرح للعروض التقديمية. كما تحتوي غرفة العصف الذهني على مقاعد مريحة، مما يوفر بيئة مريحة ولكن مركزة لتمكين فريقك من التعاون وتبادل الأفكار بحرية.</p>\r\n<p>يغمر الضوء الطبيعي الغرفة، مما يخلق جوًا مفتوحًا ودودًا، بينما يساعد التصميم البسيط في القضاء على المشتتات والتركيز على المهمة الأساسية. سواء كنت تخطط لإطلاق منتج جديد، أو تطوير استراتيجية تسويقية مبتكرة، أو استكشاف فرص تجارية جديدة، فإن غرفة العصف الذهني تقدم المساحة المثالية لتحويل أفكارك إلى واقع.</p>\r\n<p>بالإضافة إلى وسائل الراحة الحديثة، تقع غرفة العصف الذهني في موقع مريح داخل فندقنا، مما يوفر سهولة الوصول إلى الغرف الأخرى والمساحات المخصصة للفعاليات. كما أن فريقنا المحترف جاهز دائمًا للمساعدة في أي احتياجات تقنية أو لوجستية، مما يضمن أن الحدث يسير بسلاسة من البداية إلى النهاية.</p>\r\n<p>احجز غرفة <strong>العصف الذهني</strong> اليوم وابدأ الخطوة الأولى نحو تحويل أفكارك إلى عمل. دع هذه المساحة التعاونية تكون الدافع لنجاح فريقك، وشاهد كيف يقود التفكير الجماعي مؤسستك إلى الأمام</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"mb-2 flex gap-3 empty:hidden -ml-2\">\r\n<div class=\"items-center justify-start rounded-xl p-1 flex\">\r\n<div class=\"flex items-center\"> </div>\r\n</div>\r\n</div>', NULL, NULL, '2024-12-02 21:29:53', '2024-12-02 21:30:02'),
(13, 20, 7, 2, 'Moonlit Manor', 'moonlit-manor', NULL, '[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"9\",\"10\",\"11\"]', '<p>Step into a world of tranquility and romance at <strong>Moonlit Manor</strong>, a luxurious retreat designed for those seeking a serene escape under the stars. Nestled within the <em>Hourly Haven</em> hotel, this elegant room combines modern amenities with a touch of enchantment, offering the perfect environment for a romantic getaway or a peaceful night of relaxation.</p>\r\n<p>As you enter <strong>Moonlit Manor</strong>, you\'ll be immediately captivated by the calming ambiance. Soft, ambient lighting and exquisite décor create a sense of calm, making it the ideal space for unwinding. The room features a spacious king-sized bed with premium bedding, ensuring a restful night’s sleep. The carefully chosen furnishings complement the room’s tranquil design, offering a perfect blend of luxury and comfort.</p>\r\n<p>The en-suite bathroom is a sanctuary in itself, with a large soaking tub and a rain shower, providing a spa-like experience. Premium toiletries, plush towels, and soft bathrobes further enhance the feeling of indulgence.</p>\r\n<p>One of the standout features of <strong>Moonlit Manor</strong> is its stunning view of the night sky. Large windows or a private balcony offer breathtaking views of the stars, perfect for stargazing or enjoying the peaceful surroundings. The room also includes a cozy seating area for intimate moments, and the option to customize your experience with extras like a bottle of wine, candles, or flower arrangements.</p>\r\n<p>Whether you\'re celebrating a special occasion or simply escaping the hustle and bustle of daily life, <strong>Moonlit Manor</strong> promises a memorable and romantic experience. The combination of comfort, luxury, and serenity makes it the perfect choice for those seeking a magical retreat.</p>', NULL, NULL, '2024-12-02 21:36:07', '2024-12-02 21:36:07'),
(14, 21, 7, 7, 'مونليت مانور', 'مونليت-مانور', NULL, '[\"15\",\"16\",\"18\",\"19\",\"20\",\"21\",\"22\"]', '<p>ادخلوا إلى عالم من الهدوء والرومانسية في <strong>قصر ضوء القمر</strong>، الملاذ الفاخر المصمم لأولئك الذين يبحثون عن هروب هادئ تحت النجوم. يقع هذا الجناح الأنيق داخل فندق <em>ساعة هافين</em>، حيث يجمع بين وسائل الراحة العصرية ولمسة من السحر، مما يوفر البيئة المثالية لقضاء عطلة رومانسية أو ليلة هادئة من الاسترخاء.</p>\r\n<p>عند دخولكم إلى <strong>قصر ضوء القمر</strong>، ستشعرون على الفور بجو من الراحة والسكينة. توفر الإضاءة الناعمة والديكور الرائع إحساسًا بالهدوء، مما يجعلها المساحة المثالية للاسترخاء. تتميز الغرفة بسرير كينغ واسع مع مفروشات فاخرة لضمان نوم هادئ ومريح. كما تكمل الأثاثات المختارة بعناية تصميم الغرفة الهادئ، مما يوفر مزيجًا مثاليًا من الفخامة والراحة.</p>\r\n<p>يعد الحمام الداخلي ملاذًا في حد ذاته، حيث يحتوي على حوض استحمام كبير ودش مطري، مما يوفر تجربة شبيهة بالمنتجع الصحي. كما توفر مستحضرات العناية الشخصية الفاخرة، والمناشف الناعمة، والروب الفاخر إحساسًا بالتدليل.</p>\r\n<p>أحد أبرز ميزات <strong>قصر ضوء القمر</strong> هو الإطلالة المدهشة على السماء الليلية. توفر النوافذ الكبيرة أو الشرفة الخاصة إطلالات خلابة على النجوم، مما يجعلها مثالية لمراقبة النجوم أو الاستمتاع بالأجواء الهادئة. تشمل الغرفة أيضًا منطقة جلوس مريحة للتمتع باللحظات الحميمة، مع إمكانية تخصيص التجربة بإضافات مثل زجاجة نبيذ، أو الشموع، أو ترتيب الزهور.</p>\r\n<p>سواء كنتم تحتفلون بمناسبة خاصة أو ببساطة ترغبون في الهروب من ضغوط الحياة اليومية، يعد <strong>قصر ضوء القمر</strong> تجربة رومانسية لا تُنسى. إن مزيج الراحة والفخامة والسكينة يجعله الخيار المثالي لأولئك الذين يبحثون عن ملاذ ساح</p>', NULL, NULL, '2024-12-02 21:36:07', '2024-12-02 21:36:07'),
(15, 20, 8, 1, 'Corporate Hub', 'corporate-hub', NULL, '[\"2\",\"3\"]', '<p>The <strong>Corporate Hub</strong> is designed with the modern business traveler in mind, offering a seamless blend of comfort and productivity. Whether you\'re in town for a conference, a business meeting, or a quick work trip, this room is tailored to meet your professional needs while providing the perfect environment for relaxation and focus.</p>\r\n<p>With spacious interiors and modern furnishings, the <strong>Corporate Hub</strong> is equipped with everything you need for a productive stay. The room features a large desk with an ergonomic chair, ensuring you have a comfortable and efficient workspace. High-speed Wi-Fi and ample power outlets are available to keep all your devices fully charged and connected, making it easy to work on projects, attend virtual meetings, or catch up on emails.</p>\r\n<p>The room is designed for both work and rest, with a comfortable king-sized bed fitted with premium linens, ideal for unwinding after a long day. A flat-screen TV with a selection of business and entertainment channels offers a perfect way to relax during your downtime.</p>\r\n<p>For those needing additional space, the room includes a separate seating area that’s perfect for informal meetings or brainstorming sessions. The en-suite bathroom features a walk-in shower, luxurious toiletries, and soft towels for a refreshing experience.</p>\r\n<p>The <strong>Corporate Hub</strong> is more than just a room; it’s an all-encompassing business retreat, providing the ideal environment for both work and leisure. With 24/7 room service, a minibar, and concierge support, your stay is ensured to be both efficient and comfortable, making it the perfect choice for any business traveler.</p>', NULL, NULL, '2024-12-02 22:30:03', '2024-12-02 22:30:03'),
(16, 21, 8, 6, 'مركز الشركة', 'مركز-الشركة', NULL, '[\"14\",\"15\",\"16\",\"20\",\"21\",\"24\"]', '<p>تم تصميم <strong>المركز المؤسسي</strong> مع وضع المسافر العصري في مجال الأعمال في الاعتبار، حيث يقدم مزيجًا سلسًا من الراحة والإنتاجية. سواء كنت في المدينة لحضور مؤتمر، أو اجتماع عمل، أو رحلة عمل قصيرة، فإن هذه الغرفة مصممة لتلبية احتياجاتك المهنية بينما توفر البيئة المثالية للاسترخاء والتركيز.</p>\r\n<p>تتميز الغرفة بمساحاتها الواسعة والأثاث العصري، وهي مجهزة بكل ما تحتاجه لإقامة مثمرة. تحتوي الغرفة على مكتب كبير مزود بكرسي مريح، مما يضمن لك مساحة عمل مريحة وفعالة. يتوفر إنترنت عالي السرعة ومنفذ طاقة وفير لإبقاء جميع أجهزتك مشحونة ومتصلّة، مما يجعل من السهل العمل على المشاريع، وحضور الاجتماعات الافتراضية، أو متابعة رسائل البريد الإلكتروني.</p>\r\n<p>الغرفة مصممة للعمل والراحة على حد سواء، حيث تحتوي على سرير كبير مزود ببياضات فاخرة، مما يوفر لك استراحة مثالية بعد يوم طويل. كما يتوفر تلفزيون بشاشة مسطحة مع مجموعة من القنوات الخاصة بالأعمال والترفيه، مما يوفر لك طريقة مثالية للاسترخاء في أوقات فراغك.</p>\r\n<p>لمن يحتاجون إلى مساحة إضافية، تتضمن الغرفة منطقة جلوس منفصلة، مثالية للاجتماعات غير الرسمية أو جلسات العصف الذهني. يحتوي الحمام الداخلي على دش واسع، ومستحضرات استحمام فاخرة، ومناشف ناعمة لتجربة منعشة.</p>\r\n<p><strong>المركز المؤسسي</strong> هو أكثر من مجرد غرفة؛ إنه ملاذ شامل للأعمال، يوفر البيئة المثالية للعمل والترفيه معًا. مع خدمة الغرف على مدار الساعة، وميني بار، ودعم الكونسيرج، فإن إقامتك ستكون فعّالة ومريحة، مما يجعلها الخيار الأمثل لكل مسافر أعمال</p>', NULL, NULL, '2024-12-02 22:30:03', '2024-12-02 22:30:03'),
(17, 20, 9, 1, 'Office Escape', 'office-escape', NULL, '[\"1\",\"3\",\"4\",\"7\",\"8\",\"9\",\"10\",\"11\"]', '<p>The Office Escape is the ideal retreat for professionals who need a perfect blend of comfort and productivity. Designed with business travelers in mind, this room offers a unique combination of sophisticated style and functionality, making it the perfect space for both relaxation and work.</p>\r\n<p>As you enter the Office Escape, you’re greeted with a modern and sleek design that is both inviting and efficient. The room features a spacious work desk equipped with high-speed internet, multiple charging points, and ample space for documents, making it the ideal setup for catching up on emails or preparing for meetings. Whether you\'re working on a presentation or simply taking a break from your busy schedule, the ergonomic chair ensures you stay comfortable during long hours of work.</p>\r\n<p>The Office Escape is also equipped with a premium king-sized bed, ensuring you get a restful night’s sleep after a productive day. The bed is designed to provide maximum comfort, helping you recharge for the day ahead. A large flat-screen TV offers entertainment options during your downtime, and the room is thoughtfully furnished with a relaxing seating area to help you unwind after work.</p>\r\n<p>The room is designed with business professionals in mind, offering features like blackout curtains for privacy, noise-canceling capabilities to block out distractions, and a soundproofed environment that allows for quiet reflection or confidential phone calls. A well-stocked minibar provides refreshments to keep you energized throughout the day, while a dedicated wardrobe space keeps your business attire neat and organized.</p>\r\n<p>To enhance your stay further, the Office Escape also provides access to premium hotel services such as 24-hour concierge assistance, daily cleaning, and in-room dining options. Whether you’re staying for a few days or a few weeks, this room is designed to meet your every need.</p>\r\n<p>The Office Escape is more than just a room—it’s a sanctuary for business travelers who need the perfect balance of productivity and relaxation.</p>', NULL, NULL, '2024-12-02 22:35:36', '2024-12-02 22:35:36'),
(18, 21, 9, 6, 'الهروب من المكتب', 'الهروب-من-المكتب', NULL, '[\"14\",\"15\",\"16\",\"18\",\"20\",\"21\",\"22\",\"23\"]', '<p>غرفة \"هروب المكتب\" هي المكان المثالي للمحترفين الذين يحتاجون إلى مزيج مثالي من الراحة والإنتاجية. تم تصميم هذه الغرفة خصيصًا للمسافرين من رجال الأعمال، حيث تقدم مزيجًا فريدًا من الأناقة المتطورة والوظائف العملية، مما يجعلها المكان المثالي للاستراحة والعمل معًا.</p>\r\n<p>عند دخولك إلى غرفة \"هروب المكتب\"، ستستقبلك تصميم عصري وأنيق يجمع بين الدعوة والفعالية. تحتوي الغرفة على مكتب عمل واسع مزود بالإنترنت عالي السرعة، ونقاط شحن متعددة، ومساحة كبيرة للوثائق، مما يجعلها إعدادًا مثاليًا لمتابعة رسائل البريد الإلكتروني أو التحضير للاجتماعات. سواء كنت تعمل على تقديم عرض تقديمي أو تأخذ استراحة من جدولك المزدحم، يضمن الكرسي المريح بقاءك مرتاحًا خلال ساعات العمل الطويلة.</p>\r\n<p>تحتوي غرفة \"هروب المكتب\" أيضًا على سرير بحجم كينغ فاخر، مما يضمن لك نومًا هادئًا ومريحًا بعد يوم من العمل المنتج. تم تصميم السرير ليقدم أقصى درجات الراحة، مما يساعدك على استعادة نشاطك للاستعداد ليوم جديد. يوفر التلفزيون الكبير المسطح خيارات ترفيهية خلال وقت الفراغ، بينما تم تأثيث الغرفة بشكل مدروس مع منطقة جلوس مريحة لمساعدتك على الاسترخاء بعد العمل.</p>\r\n<p>تم تصميم الغرفة خصيصًا للمحترفين، حيث توفر ميزات مثل الستائر المعتمة للخصوصية، والقدرة على إلغاء الضوضاء لحجب التشتتات، وبيئة معزولة صوتيًا تتيح لك التأمل الهادئ أو إجراء المكالمات الهاتفية الخاصة. توفر الميني بار المجهزة بشكل جيد المشروبات المنعشة لمساعدتك على البقاء نشيطًا طوال اليوم، بينما يوفر مساحة خزانة مخصصة لتنظيم ملابسك العملية.</p>\r\n<p>لتعزيز إقامتك أكثر، توفر غرفة \"هروب المكتب\" أيضًا الوصول إلى خدمات الفندق الفاخرة مثل خدمة الاستقبال على مدار الساعة، والتنظيف اليومي، وخيارات الطعام في الغرفة. سواء كنت تقيم لبضعة أيام أو أسابيع، تم تصميم هذه الغرفة لتلبية كل احتياجاتك.</p>\r\n<p>غرفة \"هروب المكتب\" هي أكثر من مجرد غرفة – إنها ملاذ للمسافرين من رجال الأعمال الذين يحتاجون إلى التوازن المثالي بين الإنتاجية والراحة</p>', NULL, NULL, '2024-12-02 22:35:36', '2024-12-02 22:35:36'),
(19, 20, 10, 4, 'Transit Oasis', 'transit-oasis', NULL, '[\"1\",\"3\",\"6\",\"7\",\"8\"]', '<p>Welcome to <strong>Transit Oasis</strong>, the ideal solution for travelers in need of comfort and convenience during their journey. Whether you’re between flights, waiting for a train, or just looking for a peaceful spot to recharge, Transit Oasis offers a haven of relaxation.</p>\r\n<p>Designed for short stays, our transit rooms provide everything you need to refresh and rejuvenate. Each room is equipped with a cozy bed, a private bathroom, high-speed Wi-Fi, and essential amenities to ensure your time with us is as comfortable as possible. You can take a quick nap, freshen up, or catch up on work in a serene and quiet environment.</p>\r\n<p>Located strategically near major transport hubs, Transit Oasis ensures that you are never far from where you need to be. Whether you have a few hours or half a day to spare, our flexible booking options allow you to pay only for the time you need.</p>\r\n<p>We understand the demands of travel and strive to make your layover a seamless experience. With a focus on cleanliness, convenience, and customer satisfaction, Transit Oasis is your go-to stopover destination.</p>\r\n<p>Take a break from the hustle of travel and let Transit Oasis be your temporary home away from home. Book your stay now and experience the perfect blend of rest, privacy, and convenience</p>', NULL, NULL, '2024-12-02 23:06:15', '2024-12-02 23:06:15'),
(20, 21, 10, 9, 'واحة العبور', 'واحة-العبور', NULL, '[\"13\",\"14\",\"16\",\"18\",\"19\",\"20\",\"23\"]', '<p>مرحبًا بكم في <strong>واحة الترانزيت</strong>، الحل الأمثل للمسافرين الذين يحتاجون إلى الراحة والسهولة أثناء رحلتهم. سواء كنت بين رحلات الطيران، أو في انتظار القطار، أو تبحث عن مكان هادئ لإعادة شحن طاقتك، فإن واحة الترانزيت تقدم لك ملاذًا من الاسترخاء.</p>\r\n<p>تم تصميم غرف الترانزيت لدينا لتناسب الإقامات القصيرة، حيث نوفر كل ما تحتاجه للتجدد والاسترخاء. تحتوي كل غرفة على سرير مريح، وحمام خاص، وخدمة واي فاي عالية السرعة، وجميع وسائل الراحة الأساسية لضمان أن تكون إقامتك لدينا مريحة قدر الإمكان. يمكنك أخذ قيلولة سريعة، أو الانتعاش، أو إنجاز أعمالك في بيئة هادئة ومريحة.</p>\r\n<p>تقع واحة الترانزيت في مواقع استراتيجية بالقرب من مراكز النقل الرئيسية، مما يضمن أنك لن تكون بعيدًا عن وجهتك. سواء كان لديك بضع ساعات أو نصف يوم لتقضيه، فإن خيارات الحجز المرنة لدينا تتيح لك الدفع فقط مقابل الوقت الذي تحتاجه.</p>\r\n<p>نحن ندرك متطلبات السفر ونسعى لجعل وقت توقفك تجربة سلسة. مع التركيز على النظافة والراحة ورضا العملاء، تُعد واحة الترانزيت وجهتك المثالية للتوقف المؤقت.</p>\r\n<p>خذ استراحة من ضغوط السفر ودع واحة الترانزيت تكون بيتك المؤقت بعيدًا عن المنزل. احجز إقامتك الآن واستمتع بمزيج مثالي من الراحة والخصوصية والسهولة</p>', NULL, NULL, '2024-12-02 23:06:15', '2024-12-02 23:06:15'),
(21, 20, 11, 5, 'Euphoria Suite', 'euphoria-suite', NULL, '[\"2\",\"3\",\"4\",\"5\",\"6\",\"8\",\"10\",\"11\"]', '<p>The Euphoria Suite is designed to offer an unparalleled experience of luxury and tranquility. Nestled in the heart of our hotel, this suite is a harmonious blend of modern sophistication and timeless charm. Perfect for travelers seeking a retreat from the hustle of daily life, the Euphoria Suite combines elegant design with premium amenities to create a sanctuary of relaxation.</p>\r\n<p>Step into a spacious haven adorned with plush furnishings, contemporary artwork, and warm, inviting tones. The suite features a king-sized bed with premium linens, ensuring restful nights, and a private seating area ideal for lounging or indulging in a good book. Floor-to-ceiling windows provide breathtaking views, whether of the bustling city skyline or serene natural landscapes, filling the room with natural light by day and a romantic ambiance by night.</p>\r\n<p>For those who value convenience and indulgence, the Euphoria Suite includes a well-equipped work desk, high-speed Wi-Fi, and a state-of-the-art entertainment system. The luxurious bathroom, fitted with a rain shower and a soaking tub, invites guests to unwind and rejuvenate. Pamper yourself further with our exclusive toiletries and plush bathrobes.</p>\r\n<p>Whether you’re visiting for business or leisure, the Euphoria Suite promises an exquisite stay. Experience the perfect blend of comfort and opulence that redefines modern hospitality.</p>', NULL, NULL, '2024-12-02 23:19:42', '2024-12-02 23:19:42'),
(22, 21, 11, 10, 'جناح النشوة', 'جناح-النشوة', NULL, '[\"16\",\"18\",\"22\"]', '<p>تم تصميم <strong>المركز المؤسسي</strong> مع وضع المسافر العصري في مجال الأعمال في الاعتبار، حيث يقدم مزيجًا سلسًا من الراحة والإنتاجية. سواء كنت في المدينة لحضور مؤتمر، أو اجتماع عمل، أو رحلة عمل قصيرة، فإن هذه الغرفة مصممة لتلبية احتياجاتك المهنية بينما توفر البيئة المثالية للاسترخاء والتركيز.</p>\r\n<p>تتميز الغرفة بمساحاتها الواسعة والأثاث العصري، وهي مجهزة بكل ما تحتاجه لإقامة مثمرة. تحتوي الغرفة على مكتب كبير مزود بكرسي مريح، مما يضمن لك مساحة عمل مريحة وفعالة. يتوفر إنترنت عالي السرعة ومنفذ طاقة وفير لإبقاء جميع أجهزتك مشحونة ومتصلّة، مما يجعل من السهل العمل على المشاريع، وحضور الاجتماعات الافتراضية، أو متابعة رسائل البريد الإلكتروني.</p>\r\n<p>الغرفة مصممة للعمل والراحة على حد سواء، حيث تحتوي على سرير كبير مزود ببياضات فاخرة، مما يوفر لك استراحة مثالية بعد يوم طويل. كما يتوفر تلفزيون بشاشة مسطحة مع مجموعة من القنوات الخاصة بالأعمال والترفيه، مما يوفر لك طريقة مثالية للاسترخاء في أوقات فراغك.</p>\r\n<p>لمن يحتاجون إلى مساحة إضافية، تتضمن الغرفة منطقة جلوس منفصلة، مثالية للاجتماعات غير الرسمية أو جلسات العصف الذهني. يحتوي الحمام الداخلي على دش واسع، ومستحضرات استحمام فاخرة، ومناشف ناعمة لتجربة منعشة.</p>\r\n<p><strong>المركز المؤسسي</strong> هو أكثر من مجرد غرفة؛ إنه ملاذ شامل للأعمال، يوفر البيئة المثالية للعمل والترفيه معًا. مع خدمة الغرف على مدار الساعة، وميني بار، ودعم الكونسيرج، فإن إقامتك ستكون فعّالة ومريحة، مما يجعلها الخيار الأمثل لكل مسافر أعما</p>', NULL, NULL, '2024-12-02 23:19:42', '2024-12-02 23:19:42'),
(23, 20, 12, 5, 'Royal Residence', 'royal-residence', NULL, '[\"2\",\"3\",\"4\",\"6\",\"7\"]', '<p>Step into the epitome of luxury and sophistication with the Royal Residence, where every detail has been thoughtfully crafted to provide an unparalleled experience. This exquisite suite combines timeless elegance with modern comfort, offering a serene escape for guests who desire nothing less than the finest accommodations.</p>\r\n<p>The Royal Residence features a spacious layout with opulent furnishings, including a plush king-sized bed draped in the softest linens and a seating area designed for relaxation. The room is beautifully adorned with rich fabrics, stunning artwork, and elegant lighting that sets a warm and welcoming atmosphere. Guests can enjoy breathtaking views from the large windows, adding to the overall sense of grandeur.</p>\r\n<p>Designed with both relaxation and functionality in mind, the Royal Residence comes equipped with state-of-the-art amenities such as a smart TV, high-speed Wi-Fi, a mini bar, and a lavish bathroom complete with a soaking tub, separate rain shower, and premium toiletries. Whether you\'re winding down after a day of sightseeing or preparing for an exciting evening, the Royal Residence offers the perfect space to unwind.</p>\r\n<p>Ideal for those seeking a truly regal stay, the Royal Residence ensures every moment is one of comfort and luxury. It\'s not just a room; it\'s an experience that leaves you feeling pampered and rejuvenated, making it the ultimate choice for discerning travelers.</p>', NULL, NULL, '2024-12-02 23:24:55', '2024-12-02 23:24:55'),
(24, 21, 12, 10, 'رويال ريزيدنس', 'رويال-ريزيدنس', NULL, '[\"13\",\"14\",\"15\",\"16\",\"18\",\"19\",\"20\",\"21\",\"22\",\"23\"]', '<p>ادخل إلى قمة الفخامة والأناقة مع الإقامة الملكية، حيث تم تصميم كل تفاصيلها بعناية لتوفير تجربة لا مثيل لها. تجمع هذه الجناح الفخم بين الأناقة الكلاسيكية وراحة العصرية، مما يوفر ملاذًا هادئًا للضيوف الذين يتطلعون إلى أفضل وسائل الراحة.</p>\r\n<p>تتميز الإقامة الملكية بتصميم واسع مع أثاث فاخر، بما في ذلك سرير كبير للغاية مزين بأرقى المفروشات ومنطقة جلوس مصممة للاسترخاء. الغرفة مزينة بأقمشة غنية، وفن رائع، وإضاءة أنيقة تضفي جوًا دافئًا وترحيبيًا. يمكن للضيوف الاستمتاع بمناظر خلابة من النوافذ الكبيرة، مما يضيف إلى الشعور العام بالعظمة.</p>\r\n<p>تم تصميم الإقامة الملكية مع مراعاة الاسترخاء والوظائف العملية، فهي مزودة بأحدث وسائل الراحة مثل التلفاز الذكي، والإنترنت عالي السرعة، والميني بار، وحمام فاخر مزود بحوض استحمام عميق ودش مطري منفصل، بالإضافة إلى مستحضرات تجميل فاخرة. سواء كنت تسترخي بعد يوم من التجول أو تستعد لقضاء سهرة ممتعة، فإن الإقامة الملكية توفر لك المساحة المثالية للاسترخاء.</p>\r\n<p>مثالية لأولئك الذين يسعون إلى إقامة ملكية حقًا، تضمن الإقامة الملكية أن كل لحظة ستكون مليئة بالراحة والفخامة. إنها ليست مجرد غرفة، بل تجربة تجعلك تشعر بالرفاهية والانتعاش، مما يجعلها الخيار الأمثل للمسافرين ذوي الذوق الرفيع</p>\r\n<p> </p>', NULL, NULL, '2024-12-02 23:24:55', '2024-12-02 23:24:55'),
(25, 20, 13, 2, 'Moonlit Grove', 'moonlit-grove', NULL, '[\"3\",\"8\",\"9\",\"10\",\"11\",\"12\"]', '<p>Step into the enchanting world of the <strong>Moonlit Grove Room</strong>, where elegance meets tranquility in a serene retreat designed to soothe your senses. Nestled in the heart of the boutique hotel, this room captures the magic of moonlit nights and the calming embrace of nature, offering a one-of-a-kind experience for travelers seeking solace and luxury.</p>\r\n<p>Adorned with soft, earthy tones and natural wood accents, the decor reflects the essence of a peaceful forest bathed in moonlight. A plush king-size bed draped with fine linens invites you to unwind, while the delicate glow of thoughtfully placed lighting creates an ambiance of warmth and relaxation. The room features large windows with sheer curtains that open up to views of a private garden or lush greenery, ensuring you stay connected to the beauty of the outdoors.</p>\r\n<p>Modern amenities blend seamlessly with the rustic charm of the <strong>Moonlit Grove Room</strong>. Enjoy a state-of-the-art en-suite bathroom complete with a rain shower and premium toiletries, a cozy seating area for quiet moments, and high-speed Wi-Fi to keep you connected. For an extra touch of indulgence, a curated selection of herbal teas awaits you, perfect for savoring as you relax on the room’s private balcony or patio.</p>\r\n<p>Whether you’re escaping for a romantic getaway or seeking a quiet reprieve, the <strong>Moonlit Grove Room</strong> promises an unforgettable stay filled with comfort, elegance, and a touch of nature’s magic.</p>', NULL, NULL, '2024-12-06 20:57:32', '2024-12-06 20:57:32'),
(26, 21, 13, 7, 'مونليت جروف', 'مونليت-جروف', NULL, '[\"14\",\"15\",\"16\",\"18\",\"19\",\"22\",\"24\"]', '<p>استمتع بسحر العالم في <strong>غرفة غابة ضوء القمر</strong>، حيث يلتقي الأناقة بالهدوء في ملاذ صُمم لتهدئة الحواس. تقع هذه الغرفة في قلب الفندق البوتيكي، وتجسد جمال الليالي المقمرة ودفء أحضان الطبيعة، لتوفر تجربة فريدة للمسافرين الباحثين عن الراحة والفخامة.</p>\r\n<p>تتميز الغرفة بألوان ناعمة مستوحاة من الطبيعة ولمسات من الخشب الطبيعي، مما يعكس جوهر غابة هادئة تحت ضوء القمر. سرير بحجم ملكي مغطى بأفخم الأقمشة يدعوك للاسترخاء، بينما يضفي الإضاءة الدافئة المنتقاة بعناية أجواءً مريحة ومليئة بالسكينة. تتميز الغرفة بنافذة كبيرة مع ستائر شفافة تكشف عن إطلالات على حديقة خاصة أو مساحات خضراء مورقة، مما يضمن لك البقاء على اتصال بجمال الطبيعة.</p>\r\n<p>تمزج الغرفة بين وسائل الراحة الحديثة وسحر الطابع الريفي. استمتع بحمام داخلي عصري مجهز بدش مطري ومستلزمات فاخرة، ومنطقة جلوس مريحة للحظات الهدوء، بالإضافة إلى شبكة إنترنت لاسلكي عالية السرعة للبقاء على اتصال. ولإضافة لمسة من الفخامة، توفر الغرفة مجموعة مختارة بعناية من شاي الأعشاب، مثالية للاستمتاع بها أثناء الاسترخاء على الشرفة أو التراس الخاص بالغرفة.</p>\r\n<p>سواء كنت تبحث عن عطلة رومانسية أو ملاذ هادئ، تعدك <strong>غرفة غابة ضوء القمر</strong> بإقامة لا تُنسى مليئة بالراحة والأناقة وسحر الطبيعة</p>', NULL, NULL, '2024-12-06 20:57:32', '2024-12-06 20:57:32'),
(27, 20, 14, 3, 'Timeless Retreat', 'timeless-retreat', NULL, '[\"2\",\"7\",\"9\",\"10\",\"11\"]', '<div class=\"flex max-w-full flex-col flex-grow\">\r\n<div class=\"min-h-8 text-message flex w-full flex-col items-end gap-2 whitespace-normal break-words text-start [.text-message+&amp;]:mt-5\">\r\n<div class=\"flex w-full flex-col gap-1 empty:hidden first:pt-[3px]\">\r\n<div class=\"markdown prose w-full break-words dark:prose-invert light\">\r\n<p>The <strong>Timeless Retreat</strong> is the perfect sanctuary for families seeking a blend of vintage elegance and modern comfort. Designed to evoke the charm of a bygone era, this room offers a warm and inviting atmosphere, ideal for creating lasting memories with loved ones.</p>\r\n<p>The room\'s decor features a harmonious mix of antique-inspired furnishings and tasteful modern touches. Soft, neutral tones set the stage for relaxation, complemented by rich wooden accents and vintage details like brass fixtures and patterned upholstery. A spacious layout includes a comfortable king-size bed for the parents and a cozy twin or bunk bed setup for children, ensuring everyone enjoys a restful stay.</p>\r\n<p>Large windows allow natural light to fill the room, with views overlooking the serene garden or the charming streets surrounding <strong>Vintage Charm</strong>. The en-suite bathroom boasts a luxurious clawfoot tub and a walk-in shower, complete with premium toiletries for the ultimate indulgence.</p>\r\n<p>Thoughtfully curated amenities include a flat-screen TV, complimentary Wi-Fi, a minibar stocked with family-friendly snacks, and a vintage-style tea set for cozy evenings in. A small reading nook with classic books and games adds a personal touch, making the room a haven for relaxation and bonding.</p>\r\n<p>Whether it’s a weekend getaway or an extended family vacation, the <strong>Timeless Retreat</strong> is more than just a room—it’s an experience. With its blend of timeless design and family-focused comfort, it promises a stay filled with charm, joy, and unforgettable moments.</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"mb-2 flex gap-3 empty:hidden -ml-2\">\r\n<div class=\"items-center justify-start rounded-xl p-1 flex\">\r\n<div class=\"flex items-center\">\r\n<div class=\"flex\"> </div>\r\n<div class=\"flex items-center pb-0\"><span class=\"overflow-hidden text-clip whitespace-nowrap text-sm\">4o</span></div>\r\n</div>\r\n</div>\r\n</div>', NULL, NULL, '2024-12-06 21:16:23', '2024-12-12 02:27:43');
INSERT INTO `room_contents` (`id`, `language_id`, `room_id`, `room_category`, `title`, `slug`, `address`, `amenities`, `description`, `meta_keyword`, `meta_description`, `created_at`, `updated_at`) VALUES
(28, 21, 14, 8, 'تراجع الخالدة', 'تراجع-الخالدة', NULL, '[\"15\",\"16\",\"18\",\"19\",\"20\",\"21\"]', '<p><strong>ملاذ الزمن</strong> هو الملاذ المثالي للعائلات التي تبحث عن مزيج من الأناقة الكلاسيكية والراحة الحديثة. تم تصميم هذه الغرفة لتجسد سحر حقبة مضت، حيث توفر أجواء دافئة ومريحة مثالية لخلق ذكريات دائمة مع أحبائك.</p>\r\n<p>تتميز ديكورات الغرفة بمزيج متناغم من الأثاث المستوحى من الطراز العتيق مع لمسات عصرية راقية. تضفي الألوان الناعمة والمحايدة جوًا من الاسترخاء، مع تفاصيل خشبية غنية وعناصر قديمة مثل التركيبات النحاسية والأقمشة المزخرفة. توفر المساحة الواسعة سريرًا بحجم ملكي للآباء وسريرًا مزدوجًا أو بطابقين للأطفال، مما يضمن راحة الجميع أثناء الإقامة.</p>\r\n<p>تتيح النوافذ الكبيرة دخول الضوء الطبيعي إلى الغرفة، مع إطلالات على الحديقة الهادئة أو الشوارع الساحرة المحيطة بفندق <strong>Vintage Charm</strong>. يحتوي الحمام الداخلي على حوض استحمام فاخر قائم بذاته ودش مستقل، مع مستلزمات استحمام فاخرة لتجربة مريحة ومميزة.</p>\r\n<p>تشمل وسائل الراحة المختارة بعناية تلفزيون بشاشة مسطحة، وخدمة واي فاي مجانية، وميني بار يحتوي على وجبات خفيفة مناسبة للعائلة، ومجموعة شاي بتصميم كلاسيكي لقضاء أمسيات مريحة داخل الغرفة. يضفي ركن صغير للقراءة مزود بكتب كلاسيكية وألعاب لمسة شخصية، مما يجعل الغرفة ملاذًا مثاليًا للاسترخاء وقضاء الوقت مع العائلة.</p>\r\n<p>سواء كانت عطلة نهاية أسبوع قصيرة أو إجازة عائلية طويلة، فإن <strong>ملاذ الزمن</strong> ليس مجرد غرفة بل تجربة متكاملة. بمزيج من التصميم الكلاسيكي والراحة التي تلبي احتياجات العائلة، يَعِدُ بإقامة مليئة بالسحر والفرح واللحظات التي لا تُنسى.</p>', NULL, NULL, '2024-12-06 21:16:23', '2024-12-06 21:16:23'),
(29, 20, 15, 4, 'Luna Lounge', 'luna-lounge', NULL, '[\"2\",\"4\",\"6\",\"9\",\"10\"]', '<p><strong>Luna Lounge</strong> is a stylish and serene space at Eventide Plaza, offering the perfect setting for both casual gatherings and elegant events. Designed with a modern yet timeless aesthetic, the lounge features soft ambient lighting, plush seating, and sophisticated decor that creates a welcoming and relaxing atmosphere.</p>\r\n<p>The Luna Lounge is an ideal venue for hosting cocktail parties, intimate celebrations, or informal business meetings. Its flexible layout allows it to accommodate a variety of setups, whether you’re arranging a networking event, a casual get-together, or a small private celebration. The lounge also offers state-of-the-art facilities, including high-speed Wi-Fi and customizable lighting and sound systems, ensuring every event is tailored to your needs.</p>\r\n<p>Guests at the Luna Lounge can enjoy a curated menu of gourmet snacks, handcrafted cocktails, and premium beverages prepared by our expert culinary team. The attention to detail in both service and presentation ensures a luxurious experience for all attendees.</p>\r\n<p>Located within Eventide Plaza, the Luna Lounge is easily accessible and pairs seamlessly with the hotel’s other event spaces and amenities. Whether you’re hosting a pre-event gathering or simply looking for a chic space to unwind, the Luna Lounge promises to deliver elegance, comfort, and impeccable service, leaving a lasting impression on your guests.</p>', NULL, NULL, '2024-12-06 21:27:45', '2024-12-06 21:27:45'),
(30, 21, 15, 9, 'صالة لونا', 'صالة-لونا', NULL, '[\"15\",\"16\",\"18\",\"19\",\"20\",\"21\",\"23\"]', '<p>هو مساحة أنيقة وهادئة في إيفينتايد بلازا، وهو المكان المثالي لعقد الاجتماعات غير الرسمية والمناسبات الراقية. صُممت الصالة بعناية لتجمع بين الأناقة العصرية والجمالية الخالدة، مع إضاءة ناعمة، مقاعد مريحة، وديكور أنيق يخلق جوًا مرحبًا ومريحًا.</p>\r\n<p>لونا لاونج هو المكان المثالي لاستضافة حفلات الكوكتيل، الاحتفالات الشخصية الصغيرة، أو الاجتماعات التجارية غير الرسمية. يُتيح التصميم المرن للمكان استيعاب مجموعة متنوعة من الإعدادات، سواء كان ذلك لمناسبة شبكة اجتماعية، اجتماع غير رسمي، أو احتفال خاص. كما توفر الصالة أحدث المرافق، بما في ذلك شبكة واي فاي عالية السرعة وأنظمة إضاءة وصوت قابلة للتخصيص، مما يضمن تلبية جميع الاحتياجات.</p>\r\n<p>يمكن للضيوف في لونا لاونج الاستمتاع بقائمة معدة خصيصًا من الوجبات الخفيفة الراقية، الكوكتيلات المميزة، والمشروبات الفاخرة التي أعدها فريق الطهي المختص. الاهتمام بالتفاصيل في الخدمة والتقديم يضمن تجربة فاخرة لجميع الحاضرين.</p>\r\n<p>تقع لونا لاونج داخل إيفينتايد بلازا، وهي سهل الوصول إليها وتتكامل بسلاسة مع المساحات الأخرى والخدمات في الفندق. سواء كنت تستضيف تجمعًا مسبقًا أو تبحث ببساطة عن مساحة أنيقة للاسترخاء، تعد لونا لاونج بتقديم الأناقة والراحة والخدمة الراقية، مما يترك انطباعًا دائمًا لدى ضيوفك.</p>', NULL, NULL, '2024-12-06 21:27:45', '2024-12-06 21:27:45'),
(32, 20, 17, 3, 'Unity Room', 'unity-room', NULL, '[\"2\",\"3\",\"4\",\"6\",\"7\",\"9\",\"10\",\"11\"]', '<p><strong>Unity Room</strong> is designed with families in mind, providing a spacious and welcoming environment where all members can come together and create lasting memories. Whether you\'re on a weekend getaway, a vacation, or simply need a break from everyday life, this room offers the perfect space for relaxation and bonding. The room is thoughtfully furnished with comfort and convenience in mind, ensuring that everyone in the family feels at home.</p>\r\n<p>Featuring a large, comfortable king-size bed and two cozy twin beds, the Unity Room accommodates families of various sizes. The modern design includes warm tones, soft lighting, and spacious closets, allowing you to easily settle in and feel comfortable during your stay. The room is also equipped with modern amenities such as a flat-screen TV, high-speed internet, and a well-stocked minibar, ensuring everyone has what they need for both relaxation and entertainment.</p>\r\n<p>The Unity Room also includes a cozy sitting area where families can gather for conversation, games, or simply unwind after a day of exploring. The bathroom is equipped with a large bathtub and separate shower, providing an ideal space for everyone to refresh after a long day.</p>\r\n<p>For families traveling with young children, the room offers child-friendly features such as a crib and high chair upon request. Whether you’re here for a short stay or a longer vacation, the Unity Room offers a warm, inviting space that brings families closer together, ensuring a memorable and comfortable stay at our hotel.</p>', NULL, NULL, '2024-12-31 22:26:56', '2024-12-31 22:26:56'),
(33, 21, 17, 8, 'غرفة الوحدة', 'غرفة-الوحدة', NULL, '[\"14\",\"15\",\"18\",\"20\",\"21\"]', '<p>غرفة <strong>الوحدة</strong> مصممة مع وضع العائلات في الاعتبار، حيث توفر بيئة واسعة ومريحة حيث يمكن لجميع الأعضاء التجمع معًا وخلق ذكريات دائمة. سواء كنت في عطلة نهاية أسبوع، أو في إجازة، أو تحتاج ببساطة إلى استراحة من الحياة اليومية، توفر هذه الغرفة المساحة المثالية للاسترخاء والتمتع بالوقت معًا. الغرفة مزينة بعناية لتوفير الراحة والراحة، مما يضمن أن يشعر كل فرد في العائلة وكأنه في منزله.</p>\r\n<p>تتميز الغرفة بسرير كبير مريح بحجم كينغ وسريرين توأميين مريحين، مما يجعل غرفة الوحدة مناسبة للعائلات بمختلف الأحجام. التصميم العصري يتضمن ألوان دافئة، وإضاءة ناعمة، وخزائن واسعة، مما يتيح لك الاستقرار بسهولة والشعور بالراحة أثناء إقامتك. الغرفة مجهزة أيضًا بوسائل الراحة الحديثة مثل تلفزيون بشاشة مسطحة، وإنترنت عالي السرعة، وميني بار مليء بالمشروبات، مما يضمن أن يكون لدى الجميع كل ما يحتاجونه للاسترخاء والترفيه.</p>\r\n<p>تتضمن غرفة الوحدة أيضًا منطقة جلوس مريحة حيث يمكن للعائلات التجمع للمحادثة أو اللعب أو ببساطة الاسترخاء بعد يوم من الاستكشاف. الحمام مجهز بحوض استحمام كبير ودش منفصل، مما يوفر مساحة مثالية للجميع للانتعاش بعد يوم طويل.</p>\r\n<p>للعائلات التي تسافر مع أطفال صغار، تقدم الغرفة ميزات صديقة للأطفال مثل السرير المتنقل وكرسي عالي عند الطلب. سواء كنت هنا لإقامة قصيرة أو إجازة طويلة، توفر غرفة الوحدة مساحة دافئة وجذابة تجمع العائلات معًا، مما يضمن إقامة مريحة وذكريات لا تُنسى في فندقنا</p>', NULL, NULL, '2024-12-31 22:26:56', '2024-12-31 22:26:56'),
(34, 20, 18, 5, 'Platinum Retreat', 'platinum-retreat', NULL, '[\"2\",\"3\",\"4\",\"5\",\"8\",\"9\",\"10\",\"11\"]', '<p><strong>Platinum Retreat</strong> is the epitome of luxury, offering an unparalleled experience for those who seek ultimate comfort, elegance, and sophistication. Designed for discerning guests, this room is a sanctuary of indulgence, blending modern design with timeless elegance. The Platinum Retreat is not just a room; it’s an experience that promises to exceed expectations.</p>\r\n<p>The suite features a king-size bed with the finest linens, plush pillows, and a dedicated sitting area, ensuring the utmost comfort and relaxation. The contemporary furnishings are complemented by elegant décor and ambient lighting, creating a serene and welcoming atmosphere. The expansive space allows guests to unwind in complete privacy while enjoying luxurious amenities and state-of-the-art technology.</p>\r\n<p>The en-suite bathroom is a masterpiece, featuring a soaking tub with a stunning view, a separate rain shower, and double vanity sinks. Premium toiletries and soft towels enhance the experience, making every moment of your stay feel like a personal retreat. The Platinum Retreat also includes a private balcony, offering breathtaking views of the surrounding area, ideal for enjoying a morning coffee or evening cocktail.</p>\r\n<p>Additional amenities include a high-definition flat-screen TV, a well-stocked minibar, a coffee machine, and high-speed internet. Personalized service is available 24/7 to cater to your every need, ensuring a flawless stay.</p>\r\n<p>Whether you’re celebrating a special occasion, indulging in a luxurious getaway, or simply treating yourself to the best, the Platinum Retreat offers a truly unforgettable experience, where elegance meets comfort in perfect harmony.</p>', NULL, NULL, '2024-12-31 22:49:26', '2024-12-31 22:49:26'),
(35, 21, 18, 10, 'تراجع البلاتين', 'تراجع-البلاتين', NULL, '[\"14\",\"15\",\"16\",\"18\",\"19\",\"20\",\"21\",\"22\"]', '<p><strong>ملاذ البلاتين</strong> هو قمة الفخامة، حيث يقدم تجربة لا مثيل لها لأولئك الذين يبحثون عن أقصى درجات الراحة والأناقة والتطور. تم تصميم هذه الغرفة للضيوف المميزين، لتكون ملاذًا من الرفاهية، تجمع بين التصميم العصري والأناقة الخالدة. ملاذ البلاتين ليس مجرد غرفة؛ إنه تجربة تعد بتجاوز كل التوقعات.</p>\r\n<p>تتميز الجناح بسرير بحجم كينغ مع أرقى المفارش، والوسائد الفخمة، ومنطقة جلوس مخصصة، مما يضمن أقصى درجات الراحة والاسترخاء. الأثاث العصري يكمل التصميم الأنيق والإضاءة الهادئة، مما يخلق جوًا هادئًا وترحيبيًا. توفر المساحة الواسعة للضيوف فرصة للاسترخاء في خصوصية تامة مع الاستمتاع بأعلى معايير الراحة والتكنولوجيا المتطورة.</p>\r\n<p>الحمام المرفق هو تحفة فنية، حيث يحتوي على حوض استحمام مريح مع إطلالة رائعة، ودش منفصل، وحوض مزدوج. تشمل وسائل الراحة الفاخرة مستحضرات تجميل عالية الجودة ومناشف ناعمة، مما يجعل كل لحظة في إقامتك كأنها رحلة خاصة. كما يتضمن ملاذ البلاتين شرفة خاصة توفر إطلالات ساحرة على المنطقة المحيطة، وهي مثالية للاستمتاع بفنجان قهوة في الصباح أو مشروب مسائي.</p>\r\n<p>تشمل وسائل الراحة الأخرى شاشة تلفزيون مسطحة عالية الدقة، ميني بار مجهز، آلة قهوة، وإنترنت عالي السرعة. كما يتوفر خدمة شخصية على مدار الساعة لتلبية كل احتياجاتك، مما يضمن إقامة لا مثيل لها.</p>\r\n<p>سواء كنت تحتفل بمناسبة خاصة، أو تستمتع بإجازة فاخرة، أو ببساطة تدلل نفسك بأفضل ما يمكن، يقدم لك <strong>ملاذ البلاتين</strong> تجربة لا تُنسى، حيث يلتقي الفخامة بالراحة في تناغم مثالي</p>', NULL, NULL, '2024-12-31 22:51:03', '2024-12-31 22:51:03'),
(36, 20, 19, 1, 'Luxe Loft', 'luxe-loft', NULL, '[\"1\",\"3\",\"5\",\"7\"]', '<p><strong>Luxe Loft</strong> offers an exclusive and stylish escape, blending modern design with a touch of sophistication. This spacious room is perfect for guests who seek both comfort and luxury, featuring an open-plan layout that highlights the beauty of minimalistic yet elegant décor. The room’s sleek furnishings and chic details create a harmonious atmosphere, ideal for those who appreciate refined living.</p>\r\n<p>The centerpiece of the Luxe Loft is its king-size bed, dressed in high-quality linens, ensuring a restful night’s sleep. Adjacent to the bed is a comfortable sitting area with plush seating, providing a perfect space to relax or enjoy the stunning views through large windows. The room’s design incorporates elements of industrial chic with exposed brick walls and stylish lighting, creating an atmosphere that is both contemporary and inviting.</p>\r\n<p>The en-suite bathroom is a luxurious retreat in itself, featuring a deep soaking tub, a separate rain shower, and high-end toiletries. Soft towels and bathrobes provide an added layer of comfort, ensuring a relaxing and indulgent experience.</p>\r\n<p>For added convenience, the Luxe Loft includes a high-definition flat-screen TV, a minibar stocked with premium selections, and a coffee station with top-tier espresso options. Guests also enjoy access to high-speed internet, making it easy to stay connected or unwind with their favorite entertainment.</p>\r\n<p>Whether you\'re here for a romantic getaway or simply to enjoy a luxurious stay, the <strong>Luxe Loft</strong> offers a perfect blend of style, comfort, and sophistication. It’s a space that invites relaxation while elevating your experience to new heights of luxury.</p>', NULL, NULL, '2024-12-31 22:56:11', '2024-12-31 22:56:11'),
(37, 21, 19, 6, 'دور علوي لوكس', 'دور-علوي-لوكس', NULL, '[\"13\",\"14\",\"16\",\"18\",\"19\",\"21\",\"22\",\"23\"]', '<p><strong>لوفت لوكس</strong> يقدم لك تجربة فاخرة وأنيقة، حيث يجمع بين التصميم العصري ولمسة من الأناقة. هذه الغرفة الفسيحة مثالية للضيوف الذين يبحثون عن الراحة والفخامة، مع تصميم مفتوح يبرز جمال الديكور البسيط والأنيق. الأثاث الأنيق والتفاصيل العصرية تخلق جوًا متناغمًا، مما يجعلها المكان المثالي لأولئك الذين يقدرون الحياة الرفيعة.</p>\r\n<p>المعلمة الرئيسية في <strong>لوفت لوكس</strong> هي السرير الكبير بحجم كينغ، المفروش بأرقى المفارش، مما يضمن لك نومًا هادئًا ومريحًا. بجانب السرير، توجد منطقة جلوس مريحة مع أثاث فاخر، مما يوفر مساحة مثالية للاسترخاء أو الاستمتاع بالإطلالات الرائعة من خلال النوافذ الكبيرة. يتميز تصميم الغرفة بعناصر من الطراز العصري مع جدران من الطوب المكشوف وإضاءة أنيقة، مما يخلق جوًا معاصرًا ودافئًا في الوقت نفسه.</p>\r\n<p>الحمام المرفق هو ملاذ فاخر بحد ذاته، حيث يضم حوض استحمام عميق، ودش منفصل مع أمطار، ومستحضرات تجميل عالية الجودة. المناشف الناعمة والروب الفاخر يضيفان لمسة من الراحة، مما يضمن لك تجربة استرخاء فاخرة.</p>\r\n<p>لراحة إضافية، تشمل <strong>لوفت لوكس</strong> تلفزيون بشاشة مسطحة عالية الدقة، ميني بار مليء بالمشروبات الفاخرة، وركن قهوة مجهز بأفضل الخيارات من الإسبريسو. كما يتمتع الضيوف بخدمة الإنترنت عالي السرعة، مما يسهل البقاء على اتصال أو الاستمتاع بالترفيه المفضل.</p>\r\n<p>سواء كنت هنا لقضاء إجازة رومانسية أو ببساطة للاستمتاع بإقامة فاخرة، يقدم <strong>لوفت لوكس</strong> مزيجًا مثاليًا من الأناقة والراحة والفخامة. إنها مساحة تدعوك للاسترخاء بينما ترتقي بتجربتك إلى آفاق جديدة من الرفاهية.</p>', NULL, NULL, '2024-12-31 22:56:11', '2024-12-31 22:56:11');

-- --------------------------------------------------------

--
-- Table structure for table `room_coupons`
--

CREATE TABLE `room_coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` double DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `rooms` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_coupons`
--

INSERT INTO `room_coupons` (`id`, `vendor_id`, `name`, `code`, `type`, `value`, `start_date`, `end_date`, `rooms`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Hourly Haven 10', 'hourlyhaven10', 'fixed', 20, '2025-01-04', '2024-12-31', '[\"2\",\"17\",\"18\"]', '2024-12-02 02:13:34', '2025-01-03 21:14:05'),
(3, NULL, 'New Year', 'newyear2025', 'fixed', 15, '2025-01-01', '2025-01-02', '[\"17\",\"19\"]', '2024-12-31 23:26:12', '2025-01-03 21:13:57'),
(4, NULL, 'Holiday', 'holiday', 'fixed', 10, '2026-10-30', '2026-10-31', '[\"3\",\"5\",\"6\",\"17\"]', '2025-01-03 21:13:38', '2025-01-03 21:13:52'),
(5, NULL, 'BLACK FRIDAY', 'black99', 'percentage', 12, '2029-12-28', '2029-12-31', '[\"1\",\"2\",\"6\",\"8\",\"18\",\"19\"]', '2025-01-03 21:16:24', '2025-01-03 21:16:24'),
(6, NULL, 'OPENING CEREMONY', 'open22', 'fixed', 19, '2024-12-29', '2029-12-31', '[\"2\",\"4\",\"5\",\"6\",\"15\"]', '2025-01-03 21:17:21', '2025-01-03 21:17:34');

-- --------------------------------------------------------

--
-- Table structure for table `room_features`
--

CREATE TABLE `room_features` (
  `id` bigint UNSIGNED NOT NULL,
  `room_id` bigint DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `vendor_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_symbol_position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `conversation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_features`
--

INSERT INTO `room_features` (`id`, `room_id`, `vendor_id`, `vendor_mail`, `order_number`, `total`, `currency_symbol`, `currency_symbol_position`, `payment_method`, `gateway_type`, `payment_status`, `order_status`, `attachment`, `invoice`, `days`, `start_date`, `end_date`, `conversation_id`, `created_at`, `updated_at`) VALUES
(1, 11, 1, 'test@example.com', '6753c6607018e', 799.00, '$', 'right', 'Paypal', 'online', 'completed', 'apporved', NULL, '1.pdf', '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 21:52:00', '2024-12-06 21:58:48'),
(2, 8, 1, 'test@example.com', '6753c6843988e', 799.00, '$', 'right', 'Citibank', 'offline', 'rejected', 'rejected', NULL, NULL, '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 21:52:36', '2024-12-06 21:59:12'),
(3, 14, 1, 'test@example.com', '6753c6a1be4fa', 799.00, '$', 'right', 'Bank of America', 'offline', 'pending', 'pending', '6753c6a1bdc83.jpg', NULL, '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 21:53:05', '2024-12-06 21:53:05'),
(4, 5, 2, 'test@example.com', '6753c6e08689c', 799.00, '$', 'right', 'Paypal', 'online', 'completed', 'apporved', NULL, '4.pdf', '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 21:54:08', '2024-12-06 21:58:46'),
(5, 3, 3, 'test@example.com', '6753c74e22225', 799.00, '$', 'right', 'Citibank', 'offline', 'completed', 'apporved', NULL, '5.pdf', '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 21:55:58', '2024-12-06 21:59:03'),
(6, 4, 3, 'test@example.com', '6753c7703614e', 799.00, '$', 'right', 'Paypal', 'online', 'completed', 'apporved', NULL, '6.pdf', '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 21:56:32', '2024-12-06 21:58:44'),
(7, 1, 4, 'test@example.com', '6753c7a7e7b6f', 799.00, '$', 'right', 'Bank of America', 'offline', 'pending', 'pending', '6753c7a7e73ad.jpg', NULL, '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 21:57:27', '2024-12-06 21:57:27'),
(8, 10, 3, 'test@example.com', '6753e2b601d31', 799.00, NULL, NULL, 'flutterwave', 'online', 'completed', 'apporved', NULL, NULL, '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 23:52:54', '2024-12-06 23:52:54'),
(9, 7, 0, 'test@example.com', '6753e2cb2958f', 799.00, NULL, NULL, 'paystack', 'online', 'completed', 'apporved', NULL, NULL, '1000', '2024-12-07', '2027-09-03', NULL, '2024-12-06 23:53:15', '2024-12-06 23:53:15'),
(10, 18, 1, 'test@example.com', '6778c62f2f47a', 799.00, '$', 'right', 'Iyzico', 'online', 'completed', 'pending', NULL, '10.pdf', '1000', '2025-01-04', '2027-10-01', '99996778c611195d90.84758140', '2025-01-03 23:25:03', '2025-01-03 23:28:18');

-- --------------------------------------------------------

--
-- Table structure for table `room_images`
--

CREATE TABLE `room_images` (
  `id` bigint UNSIGNED NOT NULL,
  `room_id` bigint DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_images`
--

INSERT INTO `room_images` (`id`, `room_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, '674d750dad8d4.jpg', '2024-12-02 02:51:25', '2024-12-02 02:55:10'),
(2, 1, '674d750de41e2.jpg', '2024-12-02 02:51:25', '2024-12-02 02:55:10'),
(3, 1, '674d750e1c92f.jpg', '2024-12-02 02:51:26', '2024-12-02 02:55:10'),
(4, 1, '674d750eac752.jpg', '2024-12-02 02:51:26', '2024-12-02 02:55:10'),
(5, 2, '674d77f88178a.jpg', '2024-12-02 03:03:52', '2024-12-02 03:06:23'),
(6, 2, '674d77f8a9e7c.jpg', '2024-12-02 03:03:52', '2024-12-02 03:06:23'),
(7, 2, '674d77f8d025b.jpg', '2024-12-02 03:03:52', '2024-12-02 03:06:23'),
(8, 2, '674d77f975be2.jpg', '2024-12-02 03:03:53', '2024-12-02 03:06:23'),
(9, 3, '674e7375647c8.jpg', '2024-12-02 20:56:53', '2024-12-02 20:57:06'),
(10, 3, '674e7375647cf.jpg', '2024-12-02 20:56:53', '2024-12-02 20:57:06'),
(11, 3, '674e73758809f.jpg', '2024-12-02 20:56:53', '2024-12-02 20:57:06'),
(12, 3, '674e73758809b.jpg', '2024-12-02 20:56:53', '2024-12-02 20:57:06'),
(13, 4, '674e75d257af4.jpg', '2024-12-02 21:06:58', '2024-12-02 21:07:02'),
(14, 4, '674e75d259a0b.jpg', '2024-12-02 21:06:58', '2024-12-02 21:07:02'),
(15, 4, '674e75d27b19a.jpg', '2024-12-02 21:06:58', '2024-12-02 21:07:02'),
(16, 4, '674e75d27bba0.jpg', '2024-12-02 21:06:58', '2024-12-02 21:07:02'),
(17, 5, '674e760f0e28b.jpg', '2024-12-02 21:07:59', '2024-12-02 21:12:35'),
(18, 5, '674e760f103ab.jpg', '2024-12-02 21:07:59', '2024-12-02 21:12:35'),
(19, 5, '674e760f31822.jpg', '2024-12-02 21:07:59', '2024-12-02 21:12:35'),
(20, 5, '674e760f33ced.jpg', '2024-12-02 21:07:59', '2024-12-02 21:12:35'),
(21, 6, '674e7b484c8e9.jpg', '2024-12-02 21:30:16', '2024-12-02 21:30:20'),
(22, 6, '674e7b4850708.jpg', '2024-12-02 21:30:16', '2024-12-02 21:30:20'),
(23, 6, '674e7b48758c6.jpg', '2024-12-02 21:30:16', '2024-12-02 21:30:20'),
(24, 6, '674e7b4879f48.jpg', '2024-12-02 21:30:16', '2024-12-02 21:30:20'),
(25, 7, '674e7c9d1c58b.jpg', '2024-12-02 21:35:57', '2024-12-02 21:36:07'),
(26, 7, '674e7c9d20b7a.jpg', '2024-12-02 21:35:57', '2024-12-02 21:36:07'),
(27, 7, '674e7c9d3fe59.jpg', '2024-12-02 21:35:57', '2024-12-02 21:36:07'),
(28, 7, '674e7c9d44317.jpg', '2024-12-02 21:35:57', '2024-12-02 21:36:07'),
(29, 8, '674e897333c54.jpg', '2024-12-02 22:30:43', '2024-12-02 22:30:52'),
(30, 8, '674e897333ca8.jpg', '2024-12-02 22:30:43', '2024-12-02 22:30:52'),
(31, 8, '674e897362b19.jpg', '2024-12-02 22:30:43', '2024-12-02 22:30:52'),
(32, 8, '674e897366ec4.jpg', '2024-12-02 22:30:43', '2024-12-02 22:30:52'),
(33, 9, '674e8a755f0c2.jpg', '2024-12-02 22:35:01', '2024-12-02 22:35:36'),
(34, 9, '674e8a755f19e.jpg', '2024-12-02 22:35:01', '2024-12-02 22:35:36'),
(35, 9, '674e8a7586126.jpg', '2024-12-02 22:35:01', '2024-12-02 22:35:36'),
(36, 9, '674e8a758a005.jpg', '2024-12-02 22:35:01', '2024-12-02 22:35:36'),
(37, 10, '674e927a6718e.jpg', '2024-12-02 23:09:14', '2024-12-02 23:09:17'),
(38, 10, '674e927a71abc.jpg', '2024-12-02 23:09:14', '2024-12-02 23:09:17'),
(39, 10, '674e927a961ff.jpg', '2024-12-02 23:09:14', '2024-12-02 23:09:17'),
(40, 10, '674e927aa247c.jpg', '2024-12-02 23:09:14', '2024-12-02 23:09:17'),
(41, 11, '674e952add71c.jpg', '2024-12-02 23:20:42', '2024-12-02 23:20:53'),
(42, 11, '674e952add827.jpg', '2024-12-02 23:20:42', '2024-12-02 23:20:53'),
(43, 11, '674e952b12021.jpg', '2024-12-02 23:20:43', '2024-12-02 23:20:53'),
(44, 11, '674e952b16ecb.jpg', '2024-12-02 23:20:43', '2024-12-02 23:20:53'),
(45, 12, '674e965c52714.jpg', '2024-12-02 23:25:48', '2024-12-02 23:25:51'),
(46, 12, '674e965c5270a.jpg', '2024-12-02 23:25:48', '2024-12-02 23:25:51'),
(47, 12, '674e965c76d7d.jpg', '2024-12-02 23:25:48', '2024-12-02 23:25:51'),
(48, 12, '674e965c76e67.jpg', '2024-12-02 23:25:48', '2024-12-02 23:25:51'),
(49, 13, '6753b6f383a71.jpg', '2024-12-06 20:46:11', '2024-12-06 20:57:32'),
(50, 13, '6753b6f383a1a.jpg', '2024-12-06 20:46:11', '2024-12-06 20:57:32'),
(51, 13, '6753b6f3a96cc.jpg', '2024-12-06 20:46:11', '2024-12-06 20:57:32'),
(52, 13, '6753b6f3abe5a.jpg', '2024-12-06 20:46:11', '2024-12-06 20:57:32'),
(53, 14, '6753bdd4088bf.jpg', '2024-12-06 21:15:32', '2024-12-06 21:16:23'),
(54, 14, '6753bdd438730.jpg', '2024-12-06 21:15:32', '2024-12-06 21:16:23'),
(55, 14, '6753bdd45cd5a.jpg', '2024-12-06 21:15:32', '2024-12-06 21:16:23'),
(56, 14, '6753bdd5064ea.jpg', '2024-12-06 21:15:33', '2024-12-06 21:16:23'),
(57, 15, '6753c071d7d42.jpg', '2024-12-06 21:26:41', '2024-12-06 21:27:45'),
(58, 15, '6753c0720f8a7.jpg', '2024-12-06 21:26:42', '2024-12-06 21:27:45'),
(59, 15, '6753c07235c5b.jpg', '2024-12-06 21:26:42', '2024-12-06 21:27:45'),
(60, 15, '6753c072db00d.jpg', '2024-12-06 21:26:42', '2024-12-06 21:27:45'),
(66, 17, '6774c3404aac3.jpg', '2024-12-31 22:23:28', '2024-12-31 22:26:56'),
(67, 17, '6774c34053791.jpg', '2024-12-31 22:23:28', '2024-12-31 22:26:56'),
(68, 17, '6774c34079a12.jpg', '2024-12-31 22:23:28', '2024-12-31 22:26:56'),
(69, 17, '6774c3408128a.jpg', '2024-12-31 22:23:28', '2024-12-31 22:26:56'),
(70, 18, '6774c5c0c7a8a.jpg', '2024-12-31 22:34:08', '2024-12-31 22:49:26'),
(71, 18, '6774c5c0c7a63.jpg', '2024-12-31 22:34:08', '2024-12-31 22:49:26'),
(72, 18, '6774c5c0eb9ec.jpg', '2024-12-31 22:34:08', '2024-12-31 22:49:26'),
(73, 18, '6774c5c0ebbf0.jpg', '2024-12-31 22:34:08', '2024-12-31 22:49:26'),
(74, 19, '6774ca039cc2b.jpg', '2024-12-31 22:52:19', '2024-12-31 22:56:11'),
(75, 19, '6774ca039f38f.jpg', '2024-12-31 22:52:19', '2024-12-31 22:56:11'),
(76, 19, '6774ca03db18c.jpg', '2024-12-31 22:52:19', '2024-12-31 22:56:11'),
(77, 19, '6774ca03e1cec.jpg', '2024-12-31 22:52:19', '2024-12-31 22:56:11');

-- --------------------------------------------------------

--
-- Table structure for table `room_reviews`
--

CREATE TABLE `room_reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  `hotel_id` bigint DEFAULT NULL,
  `rating` bigint DEFAULT NULL,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room_wishlists`
--

CREATE TABLE `room_wishlists` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint NOT NULL,
  `room_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `room_wishlists`
--

INSERT INTO `room_wishlists` (`id`, `user_id`, `room_id`, `created_at`, `updated_at`) VALUES
(4, 1, 11, '2024-12-16 00:38:29', '2024-12-16 00:38:29'),
(6, 1, 17, '2025-01-04 00:03:07', '2025-01-04 00:03:07'),
(7, 1, 14, '2025-01-04 00:03:11', '2025-01-04 00:03:11'),
(8, 1, 9, '2025-01-04 00:03:16', '2025-01-04 00:03:16'),
(9, 1, 5, '2025-01-04 00:03:26', '2025-01-04 00:03:26'),
(11, 1, 10, '2025-01-04 00:09:45', '2025-01-04 00:09:45'),
(12, 4, 11, '2025-01-04 03:29:06', '2025-01-04 03:29:06'),
(13, 4, 18, '2025-01-04 03:29:10', '2025-01-04 03:29:10'),
(14, 4, 9, '2025-01-04 03:29:15', '2025-01-04 03:29:15'),
(15, 4, 2, '2025-01-04 03:29:22', '2025-01-04 03:29:22');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint UNSIGNED NOT NULL,
  `city_section_status` int DEFAULT NULL,
  `featured_section_status` int DEFAULT NULL,
  `featured_room_section_status` int DEFAULT NULL,
  `counter_section_status` int DEFAULT NULL,
  `testimonial_section_status` int DEFAULT NULL,
  `blog_section_status` int DEFAULT NULL,
  `call_to_action_section_status` int DEFAULT NULL,
  `benifit_section_status` int DEFAULT NULL,
  `footer_section_status` int DEFAULT '1',
  `custom_section_status` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `about_section_status` int DEFAULT NULL,
  `about_testimonial_section_status` int DEFAULT NULL,
  `about_features_section_status` int DEFAULT NULL,
  `about_counter_section_status` int DEFAULT NULL,
  `about_custom_section_status` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `city_section_status`, `featured_section_status`, `featured_room_section_status`, `counter_section_status`, `testimonial_section_status`, `blog_section_status`, `call_to_action_section_status`, `benifit_section_status`, `footer_section_status`, `custom_section_status`, `about_section_status`, `about_testimonial_section_status`, `about_features_section_status`, `about_counter_section_status`, `about_custom_section_status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '{\"38\":\"1\"}', 1, 1, 1, 1, '{\"41\":\"1\",\"42\":\"1\"}', NULL, '2024-11-17 21:05:10');

-- --------------------------------------------------------

--
-- Table structure for table `section_contents`
--

CREATE TABLE `section_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `hero_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hero_section_subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured_section_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `featured_room_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured_room_section_button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `counter_section_video_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `testimonial_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `testimonial_section_subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `testimonial_section_clients` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blog_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blog_section_button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `benifit_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_to_action_button_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_to_action_section_btn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_to_action_section_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `section_contents`
--

INSERT INTO `section_contents` (`id`, `language_id`, `hero_section_title`, `hero_section_subtitle`, `city_section_title`, `featured_section_title`, `featured_section_text`, `featured_room_section_title`, `featured_room_section_button_text`, `counter_section_video_link`, `testimonial_section_title`, `testimonial_section_subtitle`, `testimonial_section_clients`, `blog_section_title`, `blog_section_button_text`, `benifit_section_title`, `call_to_action_button_url`, `call_to_action_section_btn`, `call_to_action_section_title`, `created_at`, `updated_at`) VALUES
(1, 20, 'Discover the Freedom of Hourly Hotel Bookings for Relax', 'Nestled in the heart of the Pacific Islands resort, on the edge of a tranquil and beautiful Garden Island, CozyStay is a haven', 'Explore By Cities', 'Your Ultimate Hourly Hotel Booking Solution', 'Designing a website for booking hotel rooms hourly requires a user-friendly interface with specific sections facilitate easy browsing, booking, and information access', 'Browse Our Popular Hotel Room for Hourly Booking', 'View All Room', 'https://www.youtube.com/watch?v=bDJKs6r___g', 'What Say Our Trusted Clients About Us', 'Enthusiastically envisioneer user friendly benefits before resource maximizing total linkage. Our stil Professionally unleash magnetic.', '90+', 'Read Our Latest Blog', 'Read All Post', 'Benefit of Hourly Stay', 'https://hottlo.test/rooms', 'Join As a Merchant', 'Your Ultimate Hourly Hotel Booking Solution', '2024-10-29 00:09:15', '2024-12-06 23:55:54'),
(8, 21, 'اكتشف حرية حجوزات الفنادق كل ساعة للاسترخاء', 'تقع جزيرة كوزي ستاي في قلب منتجع جزر المحيط الهادئ، على حافة جاردن آيلاند الهادئة والجميلة، وهي ملاذ', 'استكشاف حسب المدن', 'الحل الأمثل لحجز الفنادق كل ساعة', 'يتطلب تصميم موقع إلكتروني لحجز غرف الفنادق كل ساعة واجهة سهلة الاستخدام تحتوي على أقسام محددة تسهل عملية التصفح والحجز والوصول إلى المعلومات', 'تصفح غرفنا الفندقية الشهيرة للحجز بالساعة', 'عرض جميع الغرف', 'https://www.youtube.com/watch?v=bDJKs6r___g', 'ماذا يقول عملاؤنا الموثوقون عنا؟', 'تصور بحماس فوائد سهلة الاستخدام قبل تعظيم الموارد للربط الإجمالي. أسلوبنا الاحترافي يطلق العنان للمغناطيس.', '90+', 'اقرأ أحدث مدونتنا', 'قراءة جميع المشاركات', 'الاستفادة من الإقامة كل ساعة', 'https://hottlo.test/rooms', 'انضم كتاجر', 'الحل الأمثل لحجز الفنادق كل ساعة', '2024-10-29 00:09:15', '2024-12-07 00:25:26');

-- --------------------------------------------------------

--
-- Table structure for table `seos`
--

CREATE TABLE `seos` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `meta_keyword_home` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_home` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_pricing` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_pricing` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_hotels` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_hotels` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_rooms` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_rooms` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_blog` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_blog` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_faq` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_faq` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_contact` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_contact` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_login` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_login` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_signup` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_signup` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_forget_password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_forget_password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_login` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_vendor_login` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_signup` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_vendor_signup` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_forget_password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_descriptions_vendor_forget_password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_page` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_vendor_page` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_about_page` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_about_page` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `custome_page_meta_keyword` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `custome_page_meta_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `seos`
--

INSERT INTO `seos` (`id`, `language_id`, `meta_keyword_home`, `meta_description_home`, `meta_keyword_pricing`, `meta_description_pricing`, `meta_keyword_hotels`, `meta_description_hotels`, `meta_keyword_rooms`, `meta_description_rooms`, `meta_keyword_blog`, `meta_description_blog`, `meta_keyword_faq`, `meta_description_faq`, `meta_keyword_contact`, `meta_description_contact`, `meta_keyword_login`, `meta_description_login`, `meta_keyword_signup`, `meta_description_signup`, `meta_keyword_forget_password`, `meta_description_forget_password`, `meta_keywords_vendor_login`, `meta_description_vendor_login`, `meta_keywords_vendor_signup`, `meta_description_vendor_signup`, `meta_keywords_vendor_forget_password`, `meta_descriptions_vendor_forget_password`, `meta_keywords_vendor_page`, `meta_description_vendor_page`, `meta_keywords_about_page`, `meta_description_about_page`, `custome_page_meta_keyword`, `custome_page_meta_description`, `created_at`, `updated_at`) VALUES
(5, 20, 'Home', 'Home Descriptions', 'Pricimg', 'Pricing descriptions', 'Hotels', 'Hotel Description', NULL, NULL, 'Blog', 'Blog descriptions', 'Faq', 'faq descriptions', 'contact', 'contact descriptions', 'Login', 'Login descriptions', 'Signup', 'signup descriptions', 'Forget Password', 'Forget Password descriptions', 'Vendor Login', 'Vendor Login descriptions', 'Vendor Signup', 'Vendor Signup descriptions', 'Vendor Forget Password', 'vendor forget password descriptions', 'vendors', 'vendors descriptions', 'About us', 'about us descriptions', '{\"21\":\"fgdh\",\"22\":\"fg\"}', '{\"21\":\"fdhgh\",\"22\":\"dfgh\"}', '2023-08-27 01:03:33', '2024-10-30 21:32:00'),
(6, 21, 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', NULL, NULL, 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقل', 'عرض أقلfghfghfhfg', '{\"21\":null,\"22\":null}', '{\"21\":\"hdfghfgh\",\"22\":\"fgdhghfd\"}', '2024-01-02 03:34:05', '2024-10-30 21:32:17');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `language_id`, `image`, `title`, `text`, `created_at`, `updated_at`) VALUES
(1, 20, '6753b550ef9ab.jpg', 'Your Ultimate Hourly Hotel Booking Solution', 'Nestled in the heart of the Pacific Islands resort, on the edge of a tranquil and beautiful Garden Island, CozyStay is a haven', '2024-12-06 20:39:12', '2024-12-06 20:39:12'),
(6, 21, '6778ad00a9dc3.jpg', 'الحل الأمثل لحجز الفنادق كل ساعة', 'يقع في قلب منتجع جزر المحيط الهادئ، على حافة جزيرة Garden Island الهادئة والجميلة، وهو ملاذ', '2025-01-03 21:37:36', '2025-01-03 21:37:36'),
(7, 20, '6778ad8f33e90.png', 'Your Perfect Stay, Your Perfect Time', 'Discover flexibility in luxury with TimeStay, where your perfect hotel experience is just an hour away. Escape the ordinary and book by the hour in the most serene locations.', '2025-01-03 21:39:59', '2025-01-03 21:39:59'),
(8, 20, '6778adc42a534.png', 'Hourly Hotel Booking, Redefined', 'At TimeStay, we offer an effortless way to book a room that fits your schedule. Whether you’re staying for business or leisure, enjoy ultimate comfort without the commitment', '2025-01-03 21:40:52', '2025-01-03 21:40:52'),
(9, 21, '6778ae028b20e.png', 'إعادة تعريف حجز الفنادق كل ساعة', 'في ، نقدم طريقة سهلة لحجز غرفة تناسب جدولك الزمني. سواء كنت تقيم للعمل أو الترفيه، استمتع بالراحة المطلقة دون أي التزام', '2025-01-03 21:41:54', '2025-01-03 21:41:54'),
(10, 21, '6778ae2bd8523.png', 'إقامتك المثالية، وقتك المثالي', 'اكتشف المرونة في الرفاهية مع ، حيث تقع تجربتك الفندقية المثالية على بعد ساعة واحدة فقط. اهرب من المألوف واحجز بالساعة في أكثر الأماكن هدوءًا.', '2025-01-03 21:42:35', '2025-01-03 21:42:35');

-- --------------------------------------------------------

--
-- Table structure for table `social_medias`
--

CREATE TABLE `social_medias` (
  `id` bigint UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `social_medias`
--

INSERT INTO `social_medias` (`id`, `icon`, `url`, `serial_number`, `created_at`, `updated_at`) VALUES
(1, 'fab fa-facebook-square', 'http://example.com/', 1, '2024-12-03 02:47:42', '2024-12-03 02:48:29'),
(2, 'fab fa-twitter', 'http://example.com/', 2, '2024-12-03 02:48:45', '2024-12-03 02:48:45'),
(3, 'fab fa-youtube', 'http://example.com/', 3, '2024-12-03 02:49:03', '2024-12-03 02:49:03'),
(4, 'fab fa-instagram', 'http://example.com/', 4, '2024-12-03 02:49:23', '2024-12-03 02:49:23');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `country_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `language_id`, `country_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 20, 1, 'Florida', '2024-11-30 23:29:11', '2024-11-30 23:29:11'),
(2, 20, 1, 'California', '2024-11-30 23:29:25', '2024-11-30 23:29:25'),
(3, 20, 3, 'Andhra Pradesh', '2024-11-30 23:29:38', '2024-11-30 23:29:38'),
(4, 20, 4, 'Victoria', '2024-11-30 23:29:53', '2024-11-30 23:29:53'),
(5, 21, 5, 'فلوريدا', '2024-11-30 23:29:11', '2025-01-03 20:55:29'),
(6, 21, 5, 'كاليفورنيا', '2024-11-30 23:29:25', '2025-01-03 20:55:16'),
(7, 21, 7, 'ولاية اندرا براديش', '2024-11-30 23:29:38', '2025-01-03 20:55:04'),
(8, 21, 8, 'فيكتوريا', '2024-11-30 23:29:53', '2025-01-03 20:54:53'),
(9, 20, 3, 'West Bengal', '2024-12-01 23:19:26', '2024-12-01 23:19:26'),
(10, 21, 7, 'ولاية البنغال الغربية', '2024-12-01 23:19:36', '2025-01-03 20:54:41');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint UNSIGNED NOT NULL,
  `email_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` longtext,
  `attachment` varchar(255) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1-pending, 2-open, 3-closed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_message` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket_statuses`
--

CREATE TABLE `support_ticket_statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `support_ticket_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `support_ticket_statuses`
--

INSERT INTO `support_ticket_statuses` (`id`, `support_ticket_status`, `created_at`, `updated_at`) VALUES
(1, 'active', '2022-06-25 03:52:18', '2024-05-11 21:48:31');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `occupation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `language_id`, `image`, `name`, `occupation`, `comment`, `created_at`, `updated_at`) VALUES
(1, 20, '6753d623bf8e1.png', 'Sarah Johnson', 'Freelance Designer', 'Vintage Charm provided me a peaceful place to work and relax. Booking by the hour is so convenient for my schedule!', '2024-12-06 22:59:15', '2024-12-06 22:59:15'),
(2, 20, '6753d648f2862.png', 'Emily Carter', 'Travel Blogger', 'The flexibility of hourly bookings is a lifesaver for business meetings. Great service and cozy rooms!', '2024-12-06 22:59:52', '2024-12-06 22:59:52'),
(3, 20, '6753d66f5f6d7.png', 'Yusuf Al-Mansouri', 'Entrepreneur', 'A perfect retreat for study breaks or relaxing. The environment is quiet and welcoming!', '2024-12-06 23:00:31', '2024-12-06 23:00:31'),
(4, 20, '6753d6a3a600a.png', 'Olivia Brown', 'College Student', 'Having an hourly option makes quick breaks during busy schedules easy. Highly recommended for professionals!', '2024-12-06 23:01:23', '2024-12-06 23:01:23'),
(5, 20, '6753d6e350331.png', 'Jacob Harris', 'Photographer', 'A great place to recharge between photoshoots. The rooms are clean, and the staff is incredibly helpful', '2024-12-06 23:02:27', '2024-12-06 23:02:27'),
(6, 20, '6753d705e9929.png', 'David Kim', 'Tech Consultant', 'Hourly bookings helped me make the most of my layover. Efficient service and great amenities!', '2024-12-06 23:03:01', '2024-12-06 23:03:01'),
(7, 21, '6753da134516e.png', 'سارة جونسون', 'مصمم مستقل', 'لقد وفر لي  مكانًا هادئًا للعمل والاسترخاء. الحجز بالساعة مناسب جدًا لجدول أعمالي!', '2024-12-06 22:59:15', '2025-01-03 21:44:04'),
(8, 21, '6753d86ca8ccb.png', 'إميلي كارتر', 'مدون السفر', 'تعد مرونة الحجوزات بالساعة بمثابة المنقذ لاجتماعات العمل. خدمة رائعة وغرف مريحة!', '2024-12-06 22:59:52', '2024-12-06 23:09:00'),
(9, 21, '6753d846d0b1f.png', 'يوسف المنصوري', 'مُقَاوِل', 'ملاذ مثالي لفترات الدراسة أو الاسترخاء. البيئة هادئة ومرحبة!', '2024-12-06 23:00:31', '2024-12-06 23:08:22'),
(10, 21, '6753d81fc0b56.png', 'أوليفيا براون', 'طالب جامعي', 'وجود خيار بالساعة يجعل فترات الراحة السريعة خلال الجداول الزمنية المزدحمة أمرًا سهلاً. موصى به للغاية للمحترفين!', '2024-12-06 23:01:23', '2024-12-06 23:07:43'),
(11, 21, '6753d7f4c0991.png', 'جاكوب هاريس', 'مصور', 'مكان رائع لإعادة الشحن بين جلسات التصوير. الغرف نظيفة، فريق العمل متعاون بشكل لا يصدق', '2024-12-06 23:02:27', '2024-12-06 23:07:00'),
(12, 21, '6753d7b4b6a0f.png', 'ديفيد كيم', 'مستشار تقني', 'ساعدتني الحجوزات بالساعة في تحقيق أقصى استفادة من توقفي. خدمة فعالة ووسائل راحة رائعة!', '2024-12-06 23:03:01', '2024-12-06 23:05:56');

-- --------------------------------------------------------

--
-- Table structure for table `timezones`
--

CREATE TABLE `timezones` (
  `country_code` char(3) NOT NULL,
  `timezone` varchar(125) NOT NULL DEFAULT '',
  `gmt_offset` float(10,2) DEFAULT NULL,
  `dst_offset` float(10,2) DEFAULT NULL,
  `raw_offset` float(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `timezones`
--

INSERT INTO `timezones` (`country_code`, `timezone`, `gmt_offset`, `dst_offset`, `raw_offset`) VALUES
('AD', 'Europe/Andorra', 1.00, 2.00, 1.00),
('AE', 'Asia/Dubai', 4.00, 4.00, 4.00),
('AF', 'Asia/Kabul', 4.50, 4.50, 4.50),
('AG', 'America/Antigua', -4.00, -4.00, -4.00),
('AI', 'America/Anguilla', -4.00, -4.00, -4.00),
('AL', 'Europe/Tirane', 1.00, 2.00, 1.00),
('AM', 'Asia/Yerevan', 4.00, 4.00, 4.00),
('AO', 'Africa/Luanda', 1.00, 1.00, 1.00),
('AQ', 'Antarctica/Casey', 8.00, 8.00, 8.00),
('AQ', 'Antarctica/Davis', 7.00, 7.00, 7.00),
('AQ', 'Antarctica/DumontDUrville', 10.00, 10.00, 10.00),
('AQ', 'Antarctica/Mawson', 5.00, 5.00, 5.00),
('AQ', 'Antarctica/McMurdo', 13.00, 12.00, 12.00),
('AQ', 'Antarctica/Palmer', -3.00, -4.00, -4.00),
('AQ', 'Antarctica/Rothera', -3.00, -3.00, -3.00),
('AQ', 'Antarctica/South_Pole', 13.00, 12.00, 12.00),
('AQ', 'Antarctica/Syowa', 3.00, 3.00, 3.00),
('AQ', 'Antarctica/Vostok', 6.00, 6.00, 6.00),
('AR', 'America/Argentina/Buenos_Aires', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Catamarca', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Cordoba', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Jujuy', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/La_Rioja', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Mendoza', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Rio_Gallegos', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Salta', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/San_Juan', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/San_Luis', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Tucuman', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Ushuaia', -3.00, -3.00, -3.00),
('AS', 'Pacific/Pago_Pago', -11.00, -11.00, -11.00),
('AT', 'Europe/Vienna', 1.00, 2.00, 1.00),
('AU', 'Antarctica/Macquarie', 11.00, 11.00, 11.00),
('AU', 'Australia/Adelaide', 10.50, 9.50, 9.50),
('AU', 'Australia/Brisbane', 10.00, 10.00, 10.00),
('AU', 'Australia/Broken_Hill', 10.50, 9.50, 9.50),
('AU', 'Australia/Currie', 11.00, 10.00, 10.00),
('AU', 'Australia/Darwin', 9.50, 9.50, 9.50),
('AU', 'Australia/Eucla', 8.75, 8.75, 8.75),
('AU', 'Australia/Hobart', 11.00, 10.00, 10.00),
('AU', 'Australia/Lindeman', 10.00, 10.00, 10.00),
('AU', 'Australia/Lord_Howe', 11.00, 10.50, 10.50),
('AU', 'Australia/Melbourne', 11.00, 10.00, 10.00),
('AU', 'Australia/Perth', 8.00, 8.00, 8.00),
('AU', 'Australia/Sydney', 11.00, 10.00, 10.00),
('AW', 'America/Aruba', -4.00, -4.00, -4.00),
('AX', 'Europe/Mariehamn', 2.00, 3.00, 2.00),
('AZ', 'Asia/Baku', 4.00, 5.00, 4.00),
('BA', 'Europe/Sarajevo', 1.00, 2.00, 1.00),
('BB', 'America/Barbados', -4.00, -4.00, -4.00),
('BD', 'Asia/Dhaka', 6.00, 6.00, 6.00),
('BE', 'Europe/Brussels', 1.00, 2.00, 1.00),
('BF', 'Africa/Ouagadougou', 0.00, 0.00, 0.00),
('BG', 'Europe/Sofia', 2.00, 3.00, 2.00),
('BH', 'Asia/Bahrain', 3.00, 3.00, 3.00),
('BI', 'Africa/Bujumbura', 2.00, 2.00, 2.00),
('BJ', 'Africa/Porto-Novo', 1.00, 1.00, 1.00),
('BL', 'America/St_Barthelemy', -4.00, -4.00, -4.00),
('BM', 'Atlantic/Bermuda', -4.00, -3.00, -4.00),
('BN', 'Asia/Brunei', 8.00, 8.00, 8.00),
('BO', 'America/La_Paz', -4.00, -4.00, -4.00),
('BQ', 'America/Kralendijk', -4.00, -4.00, -4.00),
('BR', 'America/Araguaina', -3.00, -3.00, -3.00),
('BR', 'America/Bahia', -3.00, -3.00, -3.00),
('BR', 'America/Belem', -3.00, -3.00, -3.00),
('BR', 'America/Boa_Vista', -4.00, -4.00, -4.00),
('BR', 'America/Campo_Grande', -3.00, -4.00, -4.00),
('BR', 'America/Cuiaba', -3.00, -4.00, -4.00),
('BR', 'America/Eirunepe', -5.00, -5.00, -5.00),
('BR', 'America/Fortaleza', -3.00, -3.00, -3.00),
('BR', 'America/Maceio', -3.00, -3.00, -3.00),
('BR', 'America/Manaus', -4.00, -4.00, -4.00),
('BR', 'America/Noronha', -2.00, -2.00, -2.00),
('BR', 'America/Porto_Velho', -4.00, -4.00, -4.00),
('BR', 'America/Recife', -3.00, -3.00, -3.00),
('BR', 'America/Rio_Branco', -5.00, -5.00, -5.00),
('BR', 'America/Santarem', -3.00, -3.00, -3.00),
('BR', 'America/Sao_Paulo', -2.00, -3.00, -3.00),
('BS', 'America/Nassau', -5.00, -4.00, -5.00),
('BT', 'Asia/Thimphu', 6.00, 6.00, 6.00),
('BW', 'Africa/Gaborone', 2.00, 2.00, 2.00),
('BY', 'Europe/Minsk', 3.00, 3.00, 3.00),
('BZ', 'America/Belize', -6.00, -6.00, -6.00),
('CA', 'America/Atikokan', -5.00, -5.00, -5.00),
('CA', 'America/Blanc-Sablon', -4.00, -4.00, -4.00),
('CA', 'America/Cambridge_Bay', -7.00, -6.00, -7.00),
('CA', 'America/Creston', -7.00, -7.00, -7.00),
('CA', 'America/Dawson', -8.00, -7.00, -8.00),
('CA', 'America/Dawson_Creek', -7.00, -7.00, -7.00),
('CA', 'America/Edmonton', -7.00, -6.00, -7.00),
('CA', 'America/Glace_Bay', -4.00, -3.00, -4.00),
('CA', 'America/Goose_Bay', -4.00, -3.00, -4.00),
('CA', 'America/Halifax', -4.00, -3.00, -4.00),
('CA', 'America/Inuvik', -7.00, -6.00, -7.00),
('CA', 'America/Iqaluit', -5.00, -4.00, -5.00),
('CA', 'America/Moncton', -4.00, -3.00, -4.00),
('CA', 'America/Montreal', -5.00, -4.00, -5.00),
('CA', 'America/Nipigon', -5.00, -4.00, -5.00),
('CA', 'America/Pangnirtung', -5.00, -4.00, -5.00),
('CA', 'America/Rainy_River', -6.00, -5.00, -6.00),
('CA', 'America/Rankin_Inlet', -6.00, -5.00, -6.00),
('CA', 'America/Regina', -6.00, -6.00, -6.00),
('CA', 'America/Resolute', -6.00, -5.00, -6.00),
('CA', 'America/St_Johns', -3.50, -2.50, -3.50),
('CA', 'America/Swift_Current', -6.00, -6.00, -6.00),
('CA', 'America/Thunder_Bay', -5.00, -4.00, -5.00),
('CA', 'America/Toronto', -5.00, -4.00, -5.00),
('CA', 'America/Vancouver', -8.00, -7.00, -8.00),
('CA', 'America/Whitehorse', -8.00, -7.00, -8.00),
('CA', 'America/Winnipeg', -6.00, -5.00, -6.00),
('CA', 'America/Yellowknife', -7.00, -6.00, -7.00),
('CC', 'Indian/Cocos', 6.50, 6.50, 6.50),
('CD', 'Africa/Kinshasa', 1.00, 1.00, 1.00),
('CD', 'Africa/Lubumbashi', 2.00, 2.00, 2.00),
('CF', 'Africa/Bangui', 1.00, 1.00, 1.00),
('CG', 'Africa/Brazzaville', 1.00, 1.00, 1.00),
('CH', 'Europe/Zurich', 1.00, 2.00, 1.00),
('CI', 'Africa/Abidjan', 0.00, 0.00, 0.00),
('CK', 'Pacific/Rarotonga', -10.00, -10.00, -10.00),
('CL', 'America/Santiago', -3.00, -4.00, -4.00),
('CL', 'Pacific/Easter', -5.00, -6.00, -6.00),
('CM', 'Africa/Douala', 1.00, 1.00, 1.00),
('CN', 'Asia/Chongqing', 8.00, 8.00, 8.00),
('CN', 'Asia/Harbin', 8.00, 8.00, 8.00),
('CN', 'Asia/Kashgar', 8.00, 8.00, 8.00),
('CN', 'Asia/Shanghai', 8.00, 8.00, 8.00),
('CN', 'Asia/Urumqi', 8.00, 8.00, 8.00),
('CO', 'America/Bogota', -5.00, -5.00, -5.00),
('CR', 'America/Costa_Rica', -6.00, -6.00, -6.00),
('CU', 'America/Havana', -5.00, -4.00, -5.00),
('CV', 'Atlantic/Cape_Verde', -1.00, -1.00, -1.00),
('CW', 'America/Curacao', -4.00, -4.00, -4.00),
('CX', 'Indian/Christmas', 7.00, 7.00, 7.00),
('CY', 'Asia/Nicosia', 2.00, 3.00, 2.00),
('CZ', 'Europe/Prague', 1.00, 2.00, 1.00),
('DE', 'Europe/Berlin', 1.00, 2.00, 1.00),
('DE', 'Europe/Busingen', 1.00, 2.00, 1.00),
('DJ', 'Africa/Djibouti', 3.00, 3.00, 3.00),
('DK', 'Europe/Copenhagen', 1.00, 2.00, 1.00),
('DM', 'America/Dominica', -4.00, -4.00, -4.00),
('DO', 'America/Santo_Domingo', -4.00, -4.00, -4.00),
('DZ', 'Africa/Algiers', 1.00, 1.00, 1.00),
('EC', 'America/Guayaquil', -5.00, -5.00, -5.00),
('EC', 'Pacific/Galapagos', -6.00, -6.00, -6.00),
('EE', 'Europe/Tallinn', 2.00, 3.00, 2.00),
('EG', 'Africa/Cairo', 2.00, 2.00, 2.00),
('EH', 'Africa/El_Aaiun', 0.00, 0.00, 0.00),
('ER', 'Africa/Asmara', 3.00, 3.00, 3.00),
('ES', 'Africa/Ceuta', 1.00, 2.00, 1.00),
('ES', 'Atlantic/Canary', 0.00, 1.00, 0.00),
('ES', 'Europe/Madrid', 1.00, 2.00, 1.00),
('ET', 'Africa/Addis_Ababa', 3.00, 3.00, 3.00),
('FI', 'Europe/Helsinki', 2.00, 3.00, 2.00),
('FJ', 'Pacific/Fiji', 13.00, 12.00, 12.00),
('FK', 'Atlantic/Stanley', -3.00, -3.00, -3.00),
('FM', 'Pacific/Chuuk', 10.00, 10.00, 10.00),
('FM', 'Pacific/Kosrae', 11.00, 11.00, 11.00),
('FM', 'Pacific/Pohnpei', 11.00, 11.00, 11.00),
('FO', 'Atlantic/Faroe', 0.00, 1.00, 0.00),
('FR', 'Europe/Paris', 1.00, 2.00, 1.00),
('GA', 'Africa/Libreville', 1.00, 1.00, 1.00),
('GB', 'Europe/London', 0.00, 1.00, 0.00),
('GD', 'America/Grenada', -4.00, -4.00, -4.00),
('GE', 'Asia/Tbilisi', 4.00, 4.00, 4.00),
('GF', 'America/Cayenne', -3.00, -3.00, -3.00),
('GG', 'Europe/Guernsey', 0.00, 1.00, 0.00),
('GH', 'Africa/Accra', 0.00, 0.00, 0.00),
('GI', 'Europe/Gibraltar', 1.00, 2.00, 1.00),
('GL', 'America/Danmarkshavn', 0.00, 0.00, 0.00),
('GL', 'America/Godthab', -3.00, -2.00, -3.00),
('GL', 'America/Scoresbysund', -1.00, 0.00, -1.00),
('GL', 'America/Thule', -4.00, -3.00, -4.00),
('GM', 'Africa/Banjul', 0.00, 0.00, 0.00),
('GN', 'Africa/Conakry', 0.00, 0.00, 0.00),
('GP', 'America/Guadeloupe', -4.00, -4.00, -4.00),
('GQ', 'Africa/Malabo', 1.00, 1.00, 1.00),
('GR', 'Europe/Athens', 2.00, 3.00, 2.00),
('GS', 'Atlantic/South_Georgia', -2.00, -2.00, -2.00),
('GT', 'America/Guatemala', -6.00, -6.00, -6.00),
('GU', 'Pacific/Guam', 10.00, 10.00, 10.00),
('GW', 'Africa/Bissau', 0.00, 0.00, 0.00),
('GY', 'America/Guyana', -4.00, -4.00, -4.00),
('HK', 'Asia/Hong_Kong', 8.00, 8.00, 8.00),
('HN', 'America/Tegucigalpa', -6.00, -6.00, -6.00),
('HR', 'Europe/Zagreb', 1.00, 2.00, 1.00),
('HT', 'America/Port-au-Prince', -5.00, -4.00, -5.00),
('HU', 'Europe/Budapest', 1.00, 2.00, 1.00),
('ID', 'Asia/Jakarta', 7.00, 7.00, 7.00),
('ID', 'Asia/Jayapura', 9.00, 9.00, 9.00),
('ID', 'Asia/Makassar', 8.00, 8.00, 8.00),
('ID', 'Asia/Pontianak', 7.00, 7.00, 7.00),
('IE', 'Europe/Dublin', 0.00, 1.00, 0.00),
('IL', 'Asia/Jerusalem', 2.00, 3.00, 2.00),
('IM', 'Europe/Isle_of_Man', 0.00, 1.00, 0.00),
('IN', 'Asia/Kolkata', 5.50, 5.50, 5.50),
('IO', 'Indian/Chagos', 6.00, 6.00, 6.00),
('IQ', 'Asia/Baghdad', 3.00, 3.00, 3.00),
('IR', 'Asia/Tehran', 3.50, 4.50, 3.50),
('IS', 'Atlantic/Reykjavik', 0.00, 0.00, 0.00),
('IT', 'Europe/Rome', 1.00, 2.00, 1.00),
('JE', 'Europe/Jersey', 0.00, 1.00, 0.00),
('JM', 'America/Jamaica', -5.00, -5.00, -5.00),
('JO', 'Asia/Amman', 2.00, 3.00, 2.00),
('JP', 'Asia/Tokyo', 9.00, 9.00, 9.00),
('KE', 'Africa/Nairobi', 3.00, 3.00, 3.00),
('KG', 'Asia/Bishkek', 6.00, 6.00, 6.00),
('KH', 'Asia/Phnom_Penh', 7.00, 7.00, 7.00),
('KI', 'Pacific/Enderbury', 13.00, 13.00, 13.00),
('KI', 'Pacific/Kiritimati', 14.00, 14.00, 14.00),
('KI', 'Pacific/Tarawa', 12.00, 12.00, 12.00),
('KM', 'Indian/Comoro', 3.00, 3.00, 3.00),
('KN', 'America/St_Kitts', -4.00, -4.00, -4.00),
('KP', 'Asia/Pyongyang', 9.00, 9.00, 9.00),
('KR', 'Asia/Seoul', 9.00, 9.00, 9.00),
('KW', 'Asia/Kuwait', 3.00, 3.00, 3.00),
('KY', 'America/Cayman', -5.00, -5.00, -5.00),
('KZ', 'Asia/Almaty', 6.00, 6.00, 6.00),
('KZ', 'Asia/Aqtau', 5.00, 5.00, 5.00),
('KZ', 'Asia/Aqtobe', 5.00, 5.00, 5.00),
('KZ', 'Asia/Oral', 5.00, 5.00, 5.00),
('KZ', 'Asia/Qyzylorda', 6.00, 6.00, 6.00),
('LA', 'Asia/Vientiane', 7.00, 7.00, 7.00),
('LB', 'Asia/Beirut', 2.00, 3.00, 2.00),
('LC', 'America/St_Lucia', -4.00, -4.00, -4.00),
('LI', 'Europe/Vaduz', 1.00, 2.00, 1.00),
('LK', 'Asia/Colombo', 5.50, 5.50, 5.50),
('LR', 'Africa/Monrovia', 0.00, 0.00, 0.00),
('LS', 'Africa/Maseru', 2.00, 2.00, 2.00),
('LT', 'Europe/Vilnius', 2.00, 3.00, 2.00),
('LU', 'Europe/Luxembourg', 1.00, 2.00, 1.00),
('LV', 'Europe/Riga', 2.00, 3.00, 2.00),
('LY', 'Africa/Tripoli', 2.00, 2.00, 2.00),
('MA', 'Africa/Casablanca', 0.00, 0.00, 0.00),
('MC', 'Europe/Monaco', 1.00, 2.00, 1.00),
('MD', 'Europe/Chisinau', 2.00, 3.00, 2.00),
('ME', 'Europe/Podgorica', 1.00, 2.00, 1.00),
('MF', 'America/Marigot', -4.00, -4.00, -4.00),
('MG', 'Indian/Antananarivo', 3.00, 3.00, 3.00),
('MH', 'Pacific/Kwajalein', 12.00, 12.00, 12.00),
('MH', 'Pacific/Majuro', 12.00, 12.00, 12.00),
('MK', 'Europe/Skopje', 1.00, 2.00, 1.00),
('ML', 'Africa/Bamako', 0.00, 0.00, 0.00),
('MM', 'Asia/Rangoon', 6.50, 6.50, 6.50),
('MN', 'Asia/Choibalsan', 8.00, 8.00, 8.00),
('MN', 'Asia/Hovd', 7.00, 7.00, 7.00),
('MN', 'Asia/Ulaanbaatar', 8.00, 8.00, 8.00),
('MO', 'Asia/Macau', 8.00, 8.00, 8.00),
('MP', 'Pacific/Saipan', 10.00, 10.00, 10.00),
('MQ', 'America/Martinique', -4.00, -4.00, -4.00),
('MR', 'Africa/Nouakchott', 0.00, 0.00, 0.00),
('MS', 'America/Montserrat', -4.00, -4.00, -4.00),
('MT', 'Europe/Malta', 1.00, 2.00, 1.00),
('MU', 'Indian/Mauritius', 4.00, 4.00, 4.00),
('MV', 'Indian/Maldives', 5.00, 5.00, 5.00),
('MW', 'Africa/Blantyre', 2.00, 2.00, 2.00),
('MX', 'America/Bahia_Banderas', -6.00, -5.00, -6.00),
('MX', 'America/Cancun', -6.00, -5.00, -6.00),
('MX', 'America/Chihuahua', -7.00, -6.00, -7.00),
('MX', 'America/Hermosillo', -7.00, -7.00, -7.00),
('MX', 'America/Matamoros', -6.00, -5.00, -6.00),
('MX', 'America/Mazatlan', -7.00, -6.00, -7.00),
('MX', 'America/Merida', -6.00, -5.00, -6.00),
('MX', 'America/Mexico_City', -6.00, -5.00, -6.00),
('MX', 'America/Monterrey', -6.00, -5.00, -6.00),
('MX', 'America/Ojinaga', -7.00, -6.00, -7.00),
('MX', 'America/Santa_Isabel', -8.00, -7.00, -8.00),
('MX', 'America/Tijuana', -8.00, -7.00, -8.00),
('MY', 'Asia/Kuala_Lumpur', 8.00, 8.00, 8.00),
('MY', 'Asia/Kuching', 8.00, 8.00, 8.00),
('MZ', 'Africa/Maputo', 2.00, 2.00, 2.00),
('NA', 'Africa/Windhoek', 2.00, 1.00, 1.00),
('NC', 'Pacific/Noumea', 11.00, 11.00, 11.00),
('NE', 'Africa/Niamey', 1.00, 1.00, 1.00),
('NF', 'Pacific/Norfolk', 11.50, 11.50, 11.50),
('NG', 'Africa/Lagos', 1.00, 1.00, 1.00),
('NI', 'America/Managua', -6.00, -6.00, -6.00),
('NL', 'Europe/Amsterdam', 1.00, 2.00, 1.00),
('NO', 'Europe/Oslo', 1.00, 2.00, 1.00),
('NP', 'Asia/Kathmandu', 5.75, 5.75, 5.75),
('NR', 'Pacific/Nauru', 12.00, 12.00, 12.00),
('NU', 'Pacific/Niue', -11.00, -11.00, -11.00),
('NZ', 'Pacific/Auckland', 13.00, 12.00, 12.00),
('NZ', 'Pacific/Chatham', 13.75, 12.75, 12.75),
('OM', 'Asia/Muscat', 4.00, 4.00, 4.00),
('PA', 'America/Panama', -5.00, -5.00, -5.00),
('PE', 'America/Lima', -5.00, -5.00, -5.00),
('PF', 'Pacific/Gambier', -9.00, -9.00, -9.00),
('PF', 'Pacific/Marquesas', -9.50, -9.50, -9.50),
('PF', 'Pacific/Tahiti', -10.00, -10.00, -10.00),
('PG', 'Pacific/Port_Moresby', 10.00, 10.00, 10.00),
('PH', 'Asia/Manila', 8.00, 8.00, 8.00),
('PK', 'Asia/Karachi', 5.00, 5.00, 5.00),
('PL', 'Europe/Warsaw', 1.00, 2.00, 1.00),
('PM', 'America/Miquelon', -3.00, -2.00, -3.00),
('PN', 'Pacific/Pitcairn', -8.00, -8.00, -8.00),
('PR', 'America/Puerto_Rico', -4.00, -4.00, -4.00),
('PS', 'Asia/Gaza', 2.00, 3.00, 2.00),
('PS', 'Asia/Hebron', 2.00, 3.00, 2.00),
('PT', 'Atlantic/Azores', -1.00, 0.00, -1.00),
('PT', 'Atlantic/Madeira', 0.00, 1.00, 0.00),
('PT', 'Europe/Lisbon', 0.00, 1.00, 0.00),
('PW', 'Pacific/Palau', 9.00, 9.00, 9.00),
('PY', 'America/Asuncion', -3.00, -4.00, -4.00),
('QA', 'Asia/Qatar', 3.00, 3.00, 3.00),
('RE', 'Indian/Reunion', 4.00, 4.00, 4.00),
('RO', 'Europe/Bucharest', 2.00, 3.00, 2.00),
('RS', 'Europe/Belgrade', 1.00, 2.00, 1.00),
('RU', 'Asia/Anadyr', 12.00, 12.00, 12.00),
('RU', 'Asia/Irkutsk', 9.00, 9.00, 9.00),
('RU', 'Asia/Kamchatka', 12.00, 12.00, 12.00),
('RU', 'Asia/Khandyga', 10.00, 10.00, 10.00),
('RU', 'Asia/Krasnoyarsk', 8.00, 8.00, 8.00),
('RU', 'Asia/Magadan', 12.00, 12.00, 12.00),
('RU', 'Asia/Novokuznetsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Novosibirsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Omsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Sakhalin', 11.00, 11.00, 11.00),
('RU', 'Asia/Ust-Nera', 11.00, 11.00, 11.00),
('RU', 'Asia/Vladivostok', 11.00, 11.00, 11.00),
('RU', 'Asia/Yakutsk', 10.00, 10.00, 10.00),
('RU', 'Asia/Yekaterinburg', 6.00, 6.00, 6.00),
('RU', 'Europe/Kaliningrad', 3.00, 3.00, 3.00),
('RU', 'Europe/Moscow', 4.00, 4.00, 4.00),
('RU', 'Europe/Samara', 4.00, 4.00, 4.00),
('RU', 'Europe/Volgograd', 4.00, 4.00, 4.00),
('RW', 'Africa/Kigali', 2.00, 2.00, 2.00),
('SA', 'Asia/Riyadh', 3.00, 3.00, 3.00),
('SB', 'Pacific/Guadalcanal', 11.00, 11.00, 11.00),
('SC', 'Indian/Mahe', 4.00, 4.00, 4.00),
('SD', 'Africa/Khartoum', 3.00, 3.00, 3.00),
('SE', 'Europe/Stockholm', 1.00, 2.00, 1.00),
('SG', 'Asia/Singapore', 8.00, 8.00, 8.00),
('SH', 'Atlantic/St_Helena', 0.00, 0.00, 0.00),
('SI', 'Europe/Ljubljana', 1.00, 2.00, 1.00),
('SJ', 'Arctic/Longyearbyen', 1.00, 2.00, 1.00),
('SK', 'Europe/Bratislava', 1.00, 2.00, 1.00),
('SL', 'Africa/Freetown', 0.00, 0.00, 0.00),
('SM', 'Europe/San_Marino', 1.00, 2.00, 1.00),
('SN', 'Africa/Dakar', 0.00, 0.00, 0.00),
('SO', 'Africa/Mogadishu', 3.00, 3.00, 3.00),
('SR', 'America/Paramaribo', -3.00, -3.00, -3.00),
('SS', 'Africa/Juba', 3.00, 3.00, 3.00),
('ST', 'Africa/Sao_Tome', 0.00, 0.00, 0.00),
('SV', 'America/El_Salvador', -6.00, -6.00, -6.00),
('SX', 'America/Lower_Princes', -4.00, -4.00, -4.00),
('SY', 'Asia/Damascus', 2.00, 3.00, 2.00),
('SZ', 'Africa/Mbabane', 2.00, 2.00, 2.00),
('TC', 'America/Grand_Turk', -5.00, -4.00, -5.00),
('TD', 'Africa/Ndjamena', 1.00, 1.00, 1.00),
('TF', 'Indian/Kerguelen', 5.00, 5.00, 5.00),
('TG', 'Africa/Lome', 0.00, 0.00, 0.00),
('TH', 'Asia/Bangkok', 7.00, 7.00, 7.00),
('TJ', 'Asia/Dushanbe', 5.00, 5.00, 5.00),
('TK', 'Pacific/Fakaofo', 13.00, 13.00, 13.00),
('TL', 'Asia/Dili', 9.00, 9.00, 9.00),
('TM', 'Asia/Ashgabat', 5.00, 5.00, 5.00),
('TN', 'Africa/Tunis', 1.00, 1.00, 1.00),
('TO', 'Pacific/Tongatapu', 13.00, 13.00, 13.00),
('TR', 'Europe/Istanbul', 2.00, 3.00, 2.00),
('TT', 'America/Port_of_Spain', -4.00, -4.00, -4.00),
('TV', 'Pacific/Funafuti', 12.00, 12.00, 12.00),
('TW', 'Asia/Taipei', 8.00, 8.00, 8.00),
('TZ', 'Africa/Dar_es_Salaam', 3.00, 3.00, 3.00),
('UA', 'Europe/Kiev', 2.00, 3.00, 2.00),
('UA', 'Europe/Simferopol', 2.00, 4.00, 4.00),
('UA', 'Europe/Uzhgorod', 2.00, 3.00, 2.00),
('UA', 'Europe/Zaporozhye', 2.00, 3.00, 2.00),
('UG', 'Africa/Kampala', 3.00, 3.00, 3.00),
('UM', 'Pacific/Johnston', -10.00, -10.00, -10.00),
('UM', 'Pacific/Midway', -11.00, -11.00, -11.00),
('UM', 'Pacific/Wake', 12.00, 12.00, 12.00),
('US', 'America/Adak', -10.00, -9.00, -10.00),
('US', 'America/Anchorage', -9.00, -8.00, -9.00),
('US', 'America/Boise', -7.00, -6.00, -7.00),
('US', 'America/Chicago', -6.00, -5.00, -6.00),
('US', 'America/Denver', -7.00, -6.00, -7.00),
('US', 'America/Detroit', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Indianapolis', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Knox', -6.00, -5.00, -6.00),
('US', 'America/Indiana/Marengo', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Petersburg', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Tell_City', -6.00, -5.00, -6.00),
('US', 'America/Indiana/Vevay', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Vincennes', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Winamac', -5.00, -4.00, -5.00),
('US', 'America/Juneau', -9.00, -8.00, -9.00),
('US', 'America/Kentucky/Louisville', -5.00, -4.00, -5.00),
('US', 'America/Kentucky/Monticello', -5.00, -4.00, -5.00),
('US', 'America/Los_Angeles', -8.00, -7.00, -8.00),
('US', 'America/Menominee', -6.00, -5.00, -6.00),
('US', 'America/Metlakatla', -8.00, -8.00, -8.00),
('US', 'America/New_York', -5.00, -4.00, -5.00),
('US', 'America/Nome', -9.00, -8.00, -9.00),
('US', 'America/North_Dakota/Beulah', -6.00, -5.00, -6.00),
('US', 'America/North_Dakota/Center', -6.00, -5.00, -6.00),
('US', 'America/North_Dakota/New_Salem', -6.00, -5.00, -6.00),
('US', 'America/Phoenix', -7.00, -7.00, -7.00),
('US', 'America/Shiprock', -7.00, -6.00, -7.00),
('US', 'America/Sitka', -9.00, -8.00, -9.00),
('US', 'America/Yakutat', -9.00, -8.00, -9.00),
('US', 'Pacific/Honolulu', -10.00, -10.00, -10.00),
('UY', 'America/Montevideo', -2.00, -3.00, -3.00),
('UZ', 'Asia/Samarkand', 5.00, 5.00, 5.00),
('UZ', 'Asia/Tashkent', 5.00, 5.00, 5.00),
('VA', 'Europe/Vatican', 1.00, 2.00, 1.00),
('VC', 'America/St_Vincent', -4.00, -4.00, -4.00),
('VE', 'America/Caracas', -4.50, -4.50, -4.50),
('VG', 'America/Tortola', -4.00, -4.00, -4.00),
('VI', 'America/St_Thomas', -4.00, -4.00, -4.00),
('VN', 'Asia/Ho_Chi_Minh', 7.00, 7.00, 7.00),
('VU', 'Pacific/Efate', 11.00, 11.00, 11.00),
('WF', 'Pacific/Wallis', 12.00, 12.00, 12.00),
('WS', 'Pacific/Apia', 14.00, 13.00, 13.00),
('YE', 'Asia/Aden', 3.00, 3.00, 3.00),
('YT', 'Indian/Mayotte', 3.00, 3.00, 3.00),
('ZA', 'Africa/Johannesburg', 2.00, 2.00, 2.00),
('ZM', 'Africa/Lusaka', 2.00, 2.00, 2.00),
('ZW', 'Africa/Harare', 2.00, 2.00, 2.00);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `transcation_id` varchar(255) DEFAULT NULL,
  `booking_id` varchar(255) DEFAULT NULL,
  `transcation_type` varchar(255) DEFAULT NULL COMMENT '1=Room Booking, 2=Withdraw, 3= balance add, 4 = balance subtract 5 = package booking',
  `user_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `grand_total` double(8,2) DEFAULT NULL,
  `commission` float(8,2) DEFAULT '0.00',
  `pre_balance` float(8,2) DEFAULT '0.00',
  `after_balance` float(8,2) DEFAULT '0.00',
  `gateway_type` varchar(255) DEFAULT NULL,
  `currency_symbol` varchar(255) DEFAULT NULL,
  `currency_symbol_position` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 -> banned or deactive, 1 -> active',
  `verification_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `provider` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `provider_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint UNSIGNED NOT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `to_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `amount` double(8,2) DEFAULT '0.00',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `avg_rating` float(8,2) NOT NULL DEFAULT '0.00',
  `show_email_addresss` tinyint NOT NULL DEFAULT '1',
  `show_phone_number` tinyint NOT NULL DEFAULT '1',
  `show_contact_form` tinyint NOT NULL DEFAULT '1',
  `vendor_theme_version` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'light',
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `lang_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_infos`
--

CREATE TABLE `vendor_infos` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `id` bigint UNSIGNED NOT NULL,
  `room_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`id`, `room_id`, `vendor_id`, `ip_address`, `date`, `created_at`, `updated_at`) VALUES
(1, 2, 4, '127.0.0.1', '2024-12-02', '2024-12-02 03:12:33', '2024-12-02 03:12:33'),
(2, 1, 4, '127.0.0.1', '2024-12-02', '2024-12-02 03:27:36', '2024-12-02 03:27:36'),
(3, 5, 2, '127.0.0.1', '2024-12-03', '2024-12-02 21:12:47', '2024-12-02 21:12:47'),
(4, 2, 4, '127.0.0.1', '2024-12-03', '2024-12-02 22:40:11', '2024-12-02 22:40:11'),
(5, 14, 1, '127.0.0.1', '2024-12-07', '2024-12-06 21:46:42', '2024-12-06 21:46:42'),
(6, 4, 3, '127.0.0.1', '2024-12-07', '2024-12-07 01:24:23', '2024-12-07 01:24:23'),
(7, 11, 1, '127.0.0.1', '2024-12-07', '2024-12-07 01:25:55', '2024-12-07 01:25:55'),
(8, 7, 0, '127.0.0.1', '2024-12-07', '2024-12-07 02:56:19', '2024-12-07 02:56:19'),
(9, 10, 3, '127.0.0.1', '2024-12-07', '2024-12-07 02:59:35', '2024-12-07 02:59:35'),
(10, 3, 3, '127.0.0.1', '2024-12-07', '2024-12-07 03:00:25', '2024-12-07 03:00:25'),
(11, 13, 1, '127.0.0.1', '2024-12-07', '2024-12-07 03:02:08', '2024-12-07 03:02:08'),
(12, 5, 2, '127.0.0.1', '2024-12-07', '2024-12-07 03:03:18', '2024-12-07 03:03:18'),
(13, 12, 0, '127.0.0.1', '2024-12-08', '2024-12-08 02:20:51', '2024-12-08 02:20:51'),
(14, 5, 2, '127.0.0.1', '2024-12-09', '2024-12-08 21:36:04', '2024-12-08 21:36:04'),
(15, 12, 0, '127.0.0.1', '2024-12-09', '2024-12-08 21:50:56', '2024-12-08 21:50:56'),
(16, 11, 1, '127.0.0.1', '2024-12-09', '2024-12-08 22:27:31', '2024-12-08 22:27:31'),
(17, 7, 0, '127.0.0.1', '2024-12-09', '2024-12-09 03:53:32', '2024-12-09 03:53:32'),
(18, 11, 1, '127.0.0.1', '2024-12-10', '2024-12-09 20:36:43', '2024-12-09 20:36:43'),
(19, 12, 0, '127.0.0.1', '2024-12-10', '2024-12-09 21:04:42', '2024-12-09 21:04:42'),
(20, 7, 0, '127.0.0.1', '2024-12-10', '2024-12-10 01:59:57', '2024-12-10 01:59:57'),
(21, 11, 1, '127.0.0.1', '2024-12-11', '2024-12-10 20:39:49', '2024-12-10 20:39:49'),
(22, 3, 3, '127.0.0.1', '2024-12-11', '2024-12-10 21:19:55', '2024-12-10 21:19:55'),
(23, 11, 1, '127.0.0.1', '2024-12-12', '2024-12-11 22:17:30', '2024-12-11 22:17:30'),
(24, 1, 4, '127.0.0.1', '2024-12-12', '2024-12-12 00:07:24', '2024-12-12 00:07:24'),
(25, 10, 3, '127.0.0.1', '2024-12-14', '2024-12-14 00:50:14', '2024-12-14 00:50:14'),
(26, 11, 1, '127.0.0.1', '2024-12-15', '2024-12-14 22:05:36', '2024-12-14 22:05:36'),
(27, 10, 3, '127.0.0.1', '2024-12-15', '2024-12-15 03:14:43', '2024-12-15 03:14:43'),
(28, 9, 0, '127.0.0.1', '2024-12-15', '2024-12-15 03:14:59', '2024-12-15 03:14:59'),
(29, 1, 4, '127.0.0.1', '2024-12-15', '2024-12-15 03:15:07', '2024-12-15 03:15:07'),
(30, 2, 4, '127.0.0.1', '2024-12-15', '2024-12-15 03:18:21', '2024-12-15 03:18:21'),
(31, 6, 2, '127.0.0.1', '2024-12-15', '2024-12-15 03:19:53', '2024-12-15 03:19:53'),
(32, 15, 0, '127.0.0.1', '2024-12-15', '2024-12-15 03:22:05', '2024-12-15 03:22:05'),
(33, 15, 0, '127.0.0.1', '2024-12-22', '2024-12-22 00:38:40', '2024-12-22 00:38:40'),
(34, 15, 0, '127.0.0.1', '2024-12-24', '2024-12-23 22:45:19', '2024-12-23 22:45:19'),
(35, 11, 1, '127.0.0.1', '2024-12-24', '2024-12-23 22:48:31', '2024-12-23 22:48:31'),
(36, 11, 1, '127.0.0.1', '2024-12-25', '2024-12-24 22:56:15', '2024-12-24 22:56:15'),
(37, 15, 0, '127.0.0.1', '2024-12-25', '2024-12-24 22:56:18', '2024-12-24 22:56:18'),
(38, 14, 1, '127.0.0.1', '2024-12-25', '2024-12-25 01:10:07', '2024-12-25 01:10:07'),
(39, 14, 1, '127.0.0.1', '2024-12-26', '2024-12-25 20:40:37', '2024-12-25 20:40:37'),
(41, 11, 1, '127.0.0.1', '2024-12-26', '2024-12-25 23:14:18', '2024-12-25 23:14:18'),
(42, 19, 3, '127.0.0.1', '2025-01-01', '2024-12-31 23:13:29', '2024-12-31 23:13:29'),
(43, 10, 3, '127.0.0.1', '2025-01-02', '2025-01-02 00:00:14', '2025-01-02 00:00:14'),
(44, 5, 2, '127.0.0.1', '2025-01-02', '2025-01-02 00:01:02', '2025-01-02 00:01:02'),
(45, 7, 0, '127.0.0.1', '2025-01-04', '2025-01-03 22:33:49', '2025-01-03 22:33:49'),
(46, 18, 1, '127.0.0.1', '2025-01-04', '2025-01-03 23:50:16', '2025-01-03 23:50:16'),
(47, 3, 3, '127.0.0.1', '2025-01-04', '2025-01-04 01:54:24', '2025-01-04 01:54:24'),
(48, 10, 3, '127.0.0.1', '2025-01-04', '2025-01-04 01:57:25', '2025-01-04 01:57:25'),
(49, 14, 1, '127.0.0.1', '2025-01-04', '2025-01-04 02:25:34', '2025-01-04 02:25:34'),
(50, 11, 1, '127.0.0.1', '2025-01-04', '2025-01-04 03:00:27', '2025-01-04 03:00:27');

-- --------------------------------------------------------

--
-- Table structure for table `withdraws`
--

CREATE TABLE `withdraws` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `withdraw_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_id` int DEFAULT NULL,
  `amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payable_amount` float(8,2) NOT NULL DEFAULT '0.00',
  `total_charge` float(8,2) NOT NULL DEFAULT '0.00',
  `additional_reference` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `feilds` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_method_inputs`
--

CREATE TABLE `withdraw_method_inputs` (
  `id` bigint UNSIGNED NOT NULL,
  `withdraw_payment_method_id` bigint DEFAULT NULL,
  `type` tinyint DEFAULT NULL COMMENT '1-text, 2-select, 3-checkbox, 4-textarea, 5-datepicker, 6-timepicker, 7-number',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placeholder` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required` tinyint NOT NULL DEFAULT '0' COMMENT '1-required, 0- optional',
  `order_number` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_method_options`
--

CREATE TABLE `withdraw_method_options` (
  `id` bigint UNSIGNED NOT NULL,
  `withdraw_method_input_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_payment_methods`
--

CREATE TABLE `withdraw_payment_methods` (
  `id` bigint UNSIGNED NOT NULL,
  `min_limit` double(8,2) DEFAULT NULL,
  `max_limit` double(8,2) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `fixed_charge` float(8,2) DEFAULT '0.00',
  `percentage_charge` float(8,2) DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_us`
--
ALTER TABLE `about_us`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `additional_services`
--
ALTER TABLE `additional_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `additional_service_contents`
--
ALTER TABLE `additional_service_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_username_unique` (`username`),
  ADD UNIQUE KEY `admins_email_unique` (`email`),
  ADD KEY `admins_role_id_foreign` (`role_id`);

--
-- Indexes for table `advertisements`
--
ALTER TABLE `advertisements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `amenities`
--
ALTER TABLE `amenities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `basic_settings`
--
ALTER TABLE `basic_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `benifits`
--
ALTER TABLE `benifits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_categories_language_id_foreign` (`language_id`);

--
-- Indexes for table `blog_informations`
--
ALTER TABLE `blog_informations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_informations_language_id_foreign` (`language_id`),
  ADD KEY `blog_informations_blog_category_id_foreign` (`blog_category_id`),
  ADD KEY `blog_informations_blog_id_foreign` (`blog_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `booking_hours`
--
ALTER TABLE `booking_hours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cookie_alerts_language_id_foreign` (`language_id`);

--
-- Indexes for table `counter_informations`
--
ALTER TABLE `counter_informations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_sections`
--
ALTER TABLE `custom_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_section_contents`
--
ALTER TABLE `custom_section_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faqs_language_id_foreign` (`language_id`);

--
-- Indexes for table `featured_hotel_charges`
--
ALTER TABLE `featured_hotel_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `featured_room_charges`
--
ALTER TABLE `featured_room_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `footer_contents`
--
ALTER TABLE `footer_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `footer_texts_language_id_foreign` (`language_id`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotel_categories`
--
ALTER TABLE `hotel_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotel_contents`
--
ALTER TABLE `hotel_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotel_counters`
--
ALTER TABLE `hotel_counters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotel_counter_contents`
--
ALTER TABLE `hotel_counter_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotel_features`
--
ALTER TABLE `hotel_features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotel_images`
--
ALTER TABLE `hotel_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotel_wishlists`
--
ALTER TABLE `hotel_wishlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hourly_room_prices`
--
ALTER TABLE `hourly_room_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_templates`
--
ALTER TABLE `mail_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_builders`
--
ALTER TABLE `menu_builders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offline_gateways`
--
ALTER TABLE `offline_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `online_gateways`
--
ALTER TABLE `online_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_contents`
--
ALTER TABLE `page_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_contents_language_id_foreign` (`language_id`),
  ADD KEY `page_contents_page_id_foreign` (`page_id`);

--
-- Indexes for table `page_headings`
--
ALTER TABLE `page_headings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_headings_language_id_foreign` (`language_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payment_invoices`
--
ALTER TABLE `payment_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `popups`
--
ALTER TABLE `popups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `popups_language_id_foreign` (`language_id`);

--
-- Indexes for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `push_subscriptions_endpoint_unique` (`endpoint`),
  ADD KEY `push_subscriptions_subscribable_type_subscribable_id_index` (`subscribable_type`,`subscribable_id`);

--
-- Indexes for table `quick_links`
--
ALTER TABLE `quick_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quick_links_language_id_foreign` (`language_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_categories`
--
ALTER TABLE `room_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_contents`
--
ALTER TABLE `room_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_coupons`
--
ALTER TABLE `room_coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_features`
--
ALTER TABLE `room_features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_images`
--
ALTER TABLE `room_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_reviews`
--
ALTER TABLE `room_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_wishlists`
--
ALTER TABLE `room_wishlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `section_contents`
--
ALTER TABLE `section_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seos`
--
ALTER TABLE `seos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seos_language_id_foreign` (`language_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_medias`
--
ALTER TABLE `social_medias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscribers_email_id_unique` (`email_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_ticket_statuses`
--
ALTER TABLE `support_ticket_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timezones`
--
ALTER TABLE `timezones`
  ADD PRIMARY KEY (`country_code`,`timezone`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_infos`
--
ALTER TABLE `vendor_infos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraws`
--
ALTER TABLE `withdraws`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_method_inputs`
--
ALTER TABLE `withdraw_method_inputs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_method_options`
--
ALTER TABLE `withdraw_method_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_payment_methods`
--
ALTER TABLE `withdraw_payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about_us`
--
ALTER TABLE `about_us`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `additional_services`
--
ALTER TABLE `additional_services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `additional_service_contents`
--
ALTER TABLE `additional_service_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `advertisements`
--
ALTER TABLE `advertisements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `amenities`
--
ALTER TABLE `amenities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `basic_settings`
--
ALTER TABLE `basic_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `benifits`
--
ALTER TABLE `benifits`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `blog_informations`
--
ALTER TABLE `blog_informations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `booking_hours`
--
ALTER TABLE `booking_hours`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `counter_informations`
--
ALTER TABLE `counter_informations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `custom_sections`
--
ALTER TABLE `custom_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_section_contents`
--
ALTER TABLE `custom_section_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `featured_hotel_charges`
--
ALTER TABLE `featured_hotel_charges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `featured_room_charges`
--
ALTER TABLE `featured_room_charges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `features`
--
ALTER TABLE `features`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `footer_contents`
--
ALTER TABLE `footer_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `hotel_categories`
--
ALTER TABLE `hotel_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `hotel_contents`
--
ALTER TABLE `hotel_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `hotel_counters`
--
ALTER TABLE `hotel_counters`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `hotel_counter_contents`
--
ALTER TABLE `hotel_counter_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=321;

--
-- AUTO_INCREMENT for table `hotel_features`
--
ALTER TABLE `hotel_features`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `hotel_images`
--
ALTER TABLE `hotel_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `hotel_wishlists`
--
ALTER TABLE `hotel_wishlists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `hourly_room_prices`
--
ALTER TABLE `hourly_room_prices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `mail_templates`
--
ALTER TABLE `mail_templates`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `menu_builders`
--
ALTER TABLE `menu_builders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `offline_gateways`
--
ALTER TABLE `offline_gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `online_gateways`
--
ALTER TABLE `online_gateways`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `page_contents`
--
ALTER TABLE `page_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `page_headings`
--
ALTER TABLE `page_headings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payment_invoices`
--
ALTER TABLE `payment_invoices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `popups`
--
ALTER TABLE `popups`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `quick_links`
--
ALTER TABLE `quick_links`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `room_categories`
--
ALTER TABLE `room_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `room_contents`
--
ALTER TABLE `room_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `room_coupons`
--
ALTER TABLE `room_coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `room_features`
--
ALTER TABLE `room_features`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `room_images`
--
ALTER TABLE `room_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `room_reviews`
--
ALTER TABLE `room_reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `room_wishlists`
--
ALTER TABLE `room_wishlists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `section_contents`
--
ALTER TABLE `section_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `seos`
--
ALTER TABLE `seos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `social_medias`
--
ALTER TABLE `social_medias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_ticket_statuses`
--
ALTER TABLE `support_ticket_statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `vendor_infos`
--
ALTER TABLE `vendor_infos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `withdraws`
--
ALTER TABLE `withdraws`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_method_inputs`
--
ALTER TABLE `withdraw_method_inputs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_method_options`
--
ALTER TABLE `withdraw_method_options`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_payment_methods`
--
ALTER TABLE `withdraw_payment_methods`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `role_permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD CONSTRAINT `blog_categories_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_informations`
--
ALTER TABLE `blog_informations`
  ADD CONSTRAINT `blog_informations_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_informations_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_informations_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  ADD CONSTRAINT `cookie_alerts_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `footer_contents`
--
ALTER TABLE `footer_contents`
  ADD CONSTRAINT `footer_texts_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `page_contents`
--
ALTER TABLE `page_contents`
  ADD CONSTRAINT `page_contents_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `page_contents_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `popups`
--
ALTER TABLE `popups`
  ADD CONSTRAINT `popups_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quick_links`
--
ALTER TABLE `quick_links`
  ADD CONSTRAINT `quick_links_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seos`
--
ALTER TABLE `seos`
  ADD CONSTRAINT `seos_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
