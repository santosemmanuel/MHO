-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2026 at 03:23 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mhob_django_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Member Record', 7, 'add_patientrecord'),
(26, 'Can change Member Record', 7, 'change_patientrecord'),
(27, 'Can delete Member Record', 7, 'delete_patientrecord'),
(28, 'Can view Member Record', 7, 'view_patientrecord');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'animal_bite', 'patientrecord'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-08-02 08:22:44.882335'),
(2, 'auth', '0001_initial', '2026-08-02 08:22:53.430826'),
(3, 'admin', '0001_initial', '2026-08-02 08:22:55.431263'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-08-02 08:22:55.472371'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-08-02 08:22:55.516030'),
(6, 'animal_bite', '0001_initial', '2026-08-02 08:22:55.799132'),
(7, 'contenttypes', '0002_remove_content_type_name', '2026-08-02 08:22:57.487058'),
(8, 'auth', '0002_alter_permission_name_max_length', '2026-08-02 08:22:58.300222'),
(9, 'auth', '0003_alter_user_email_max_length', '2026-08-02 08:22:58.456349'),
(10, 'auth', '0004_alter_user_username_opts', '2026-08-02 08:22:58.529008'),
(11, 'auth', '0005_alter_user_last_login_null', '2026-08-02 08:22:59.110748'),
(12, 'auth', '0006_require_contenttypes_0002', '2026-08-02 08:22:59.150921'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2026-08-02 08:22:59.212073'),
(14, 'auth', '0008_alter_user_username_max_length', '2026-08-02 08:22:59.308471'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2026-08-02 08:22:59.432880'),
(16, 'auth', '0010_alter_group_name_max_length', '2026-08-02 08:22:59.569407'),
(17, 'auth', '0011_update_proxy_permissions', '2026-08-02 08:22:59.649827'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2026-08-02 08:22:59.819366'),
(19, 'sessions', '0001_initial', '2026-08-02 08:23:00.148739');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('3eal7o2ynyrjcd3c6919s0ixdg3iasfh', '.eJw9j09rAkEMxb-KvPMIrrV_dm5KPQhqS2t7laybSmAmu8xkiyJ-9zIovSUvv7yXXEAqkcK-EeN9Tyastm_JCP6CXhQek4fJ9HE6m9X1UwWHQNm2FBken8vtGxx-JP1L69WuSEqRlyeDBxyitG3gO_A-_9h9redbOLRdA4-qfq7Gk5dxVcMh8wkeGwpcGkvMd4-GEumRzsWhawIdpNPRq2RLcrDR6rvEDCoH6SmIFWwxJBpYy6BrJJRsOHAkCbfy_u0qbzg2nOBx5lzO4p61ZTV4HUJwyHJULvvxBjok7hNnViOTX75x1-sfG09p9A:1wrABx:MZG97z3cNuJP5MWx8xiPToP3JZSJbbmiG8s5Is60fwQ', '2026-08-18 08:08:05.394241'),
('3tcoljw1vkbw6cbtddmsdedk635u5ao1', '.eJw9j91qwkAQRl9FvusVYtRS9k5JKIGqRUrpnUySqQzsbsLupCjiu5dF6d38nJkzcwMF8eROrSifRlLhoKeelGBvGCXAYrEs18XLerUolq8wcJR0T55h8bV5b6oNDH4k_hf3h-O2Pn4eYBDIc31RWMDAS987fkJv9fGwr5oM9UMLi7IoVvOinJdZkfgCix05zolG5ueOliKFM11h8TG0jjoZwqySpFE6nTXfWTMF6WQkJ5qx7RRp4pAbQysuu2HAnsQ9wufPTdqxbznC4sopn8Ujh56DwobJOYMk58B53j9Ag8hj5MRBSeWXH9z9_gc9uWt8:1wwbWx:-jLsMD70VbXdiYfPM8ercUqeIfAs1tsYUdpm1znaVH4', '2026-09-02 08:20:15.266837'),
('e69picjkmrfmrwmlmob6ob0c0w0rnlbo', '.eJxlkF1rwjAUhv-KnOsKaZ1u7V3mZ5l1oqwwGMipOdMDaRradDjE_z5iize7S3jf5DnnuQIaLlEfCnZ0sOiYjDsodAjJFSwbSCAciWg8GkWhiCMIQGPjNlgSJLCdf7VCqFDOJATwzfUjkbs83UAABkuaXxwkAAGUrJSmvpFJuVy9byEAVRWeEj9PhqEYhp7R0MVXUJO_uJqo_6LAGs0Jfz28KjQeuTKDGTeu5qMbpLmntIaPbFGz87XXtsaWjA-qgrVHQwBUIuvu2C-dNhmVBdWQgKn8VGTJKDLOi1Bkt72LaPwkwjCexC9dae1X_OdCkV30wX4ls883OVju5HTeRVkf5el6LTcf87x_MrubiISYDEU8jHrC_i5jQWWnQ5F9GK1Jo-PKNGe2kMD0zFrBLYCGT4Y8oex28k1bU0PGoeMfgsS0Wt9uf6QJm_A:1wqghW:rfqxQQgUxDhrozh1heVUFlCTTqQwaaHK0BdtKcj-nII', '2026-08-17 00:38:42.451110'),
('gs7fggmbhrf9076jxshom7qm5it9ow5y', '.eJxNkMFqwzAMht_lP6cQp4euvqVbB4OmHet2LsqspQLbMYkzWkrffTjJxnyyPgvp_3wDeXFkT7VEPgWKwj6eDEWCviGIh0ae50qpYjzIYKmPe3IMjWO5fz8ckeFLuj-4rapy_7HdIYMnx9tLhAYyODHG8ty0Kd82h2OJDKatoaHW69VC5QulkKHnCzQqspyK2DHPI2rqyDd0hUZpyTdiyafJg5dPCWQljk_1cG2bxNtabNqGDOxI7HSdLV_6il3NHTR8m4JwYG_Yx2RuOLz-yi-Xy6Io1BjNcNglK2j05GPbT-x5ZuzcmMhwqGZUD1P9NHoWuVou8oeFWk30-F_VcPj7rY4tRWl9f5YAjcezWIN7hl4az2mum8KnztBxzz5SlG-G9oO19_sP_zaRsA:1wwCz6:IElXJAv4g3uRLMk_5ZqrUlPZzGpIjMWj5wYNngty1fI', '2026-09-01 06:07:40.501097'),
('gv0a0gf8i6wth1deh2vs96sdpvg1ao86', '.eJxdkUFv4jAQhf9KNOewIgmwkBttwgqJlCpVq6UXNIlnYSTHsexh1RXiv1cuoer2Zr83njfz-QxouEO9b1hob1GYjOwVCkJ-BssGckiycTrNZpNsls4gBo1eHrAjyKGslkVZQQx_2H2K9fZXudk9QAwGOyrfBHKAGDpWStOtplw9l_XrFmJQfRMyFovJKElG6QRi8PQGOayoQ03hKo5o6NKgQ3PAf5DDY99obLk3UcFeHLcSrX-HoJPhli1qllB2d3J4IhOMvmEd0iEG6pD19TgsvfYVdQ05yMH0YS6yZBQZCSAU2ceBRTrN0myezX-GSRXZjfnGQpFdDdr9ZleU0V293BVlAKLIVoP1lQDZ4gNCOk4Wo3EyGs-v6tMHh-pKQZH9ZOlIo3Bv_JFtiDmyVnCJwfPBUOjuyDryZASF_4bX34T8HJTbL25e1vUyqn5EX4ZyZOv_U7ZyJOdvFvo-8Lgyi9hHbFq02LKgkILL5fIOGpS7xw:1xAzvL:kPMq23q6iRMSK7Vy7tcwI5hEaJECZAMLdRWK8m_nf30', '2026-10-12 01:12:55.049930'),
('uqfp8syho6bk8fi9ks7x4lr9jxo1g7gn', '.eJw9j0FrAkEMhf9KeecRuorIzm2lHoSultqeJeumEpjJLjPZooj_vQxKb3nJ9_KSG0glUjh2YnwcyYTVjj0Zwd8wisKjruvlcjmfzxeLBRwCZdtRZHgcmt3X_gCHH0n_zU3bNrvvzTsclCJvLgYPOETp-8BPaN18rveHBg790MGjqlerWfU6qyo4ZL7Ao6XARVhifq7oKJGe6QqPj6ELdJJBX94kW5KTvWxLyKRykpGCWKHWU6KJtQyGTkJJhgNHkvAonx9vc8ux4wSPK-dyFY-sPavB6xSCQ5azcvHHB-iQeEycWY1MfvnB3e9_jiRq8w:1wtEyZ:spqMxilZ3QiZuLIquwndO0kAXZcp1Oyb81qrta-KGLI', '2026-08-24 01:38:51.411121'),
('y806jqg7hh4y6lvzq156ijc044ad6yqu', '.eJxNj8Fqw0AMRH8lzHkDTm7dW5K24EOSkkNPBSPbahDsymZXLgkh_14Wm1KdJOaNRnqAVCKFphXjZiQTVmt6MoJ_YBSFR_Wv4BAo24kiw2O_-5qqqt-cD3D4lvQnvF92p8MZDkqR324GDzhE6fvAC3Kpi94PLTy2VbVZVy_rbdmf-QaPIwUugyXmxd5SIr3SHR4fQxuok0FXr5ItSWerz7ouEZNKJyMFscLtp0QTaxGGVkLJhQNHkjC3y8d1PnJsOcHjzrncxSNrz2rwOoXgkOWqXPxxBh0Sj4kzq5HJD8_c8_kLLU5qpA:1x9u3O:w1o8YQDndbwtEeEO5K1ls5TfMzRz2vut_ySrBbN64co', '2026-10-09 00:44:42.002048');

-- --------------------------------------------------------

--
-- Table structure for table `patient_records`
--

CREATE TABLE `patient_records` (
  `id` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `middleName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) NOT NULL,
  `nameExt` varchar(10) DEFAULT NULL,
  `Barangay` varchar(100) NOT NULL,
  `PIN` varchar(50) NOT NULL,
  `Membership` varchar(50) NOT NULL,
  `Day0` date DEFAULT NULL,
  `DateandTime` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_records`
--

INSERT INTO `patient_records` (`id`, `firstName`, `middleName`, `lastName`, `nameExt`, `Barangay`, `PIN`, `Membership`, `Day0`, `DateandTime`) VALUES
(2, 'SHAMYKA GRACE', 'VILLANUEVA', 'PEÑADA', '', 'Poblacion District IV', '132540119698', 'Dependent', '2026-08-03', '2026-08-03 00:38:42.326473'),
(4, 'ARVIN', 'MAAGHOP', 'PEÑADA', '', 'Poblacion District IV', '130253321092', 'Member', '2026-08-03', '2026-08-03 01:04:28.555695'),
(5, 'AUSTIN CALEB', 'GABRIELES', 'GASTALLA', '', 'San Pablo', '132536776684', 'Dependent', '2026-08-03', '2026-08-03 01:14:52.378196'),
(6, 'JOYLYN', 'ANAYO', 'ARAÑA', '', 'Laguiwan', '132028108676', 'Member', '2026-08-03', '2026-08-03 01:22:02.326831'),
(7, 'MICHELLE', 'MACA', 'QUIMBO', '', 'Arado', '132025266653', 'Member', '2026-08-03', '2026-08-03 01:29:32.748490'),
(8, 'MARK JACOB', 'CANDELA', 'NARCA', '', 'Malaihao (San Ramon)', '132533894457', 'Dependent', '2026-08-03', '2026-08-03 01:42:48.737354'),
(9, 'FAYE', 'N/A', 'LABANTA', '', 'Patong', '132535742611', 'Dependent', '2026-08-03', '2026-08-03 02:11:33.141684'),
(10, 'LETECIA', 'DAGAMI', 'REBECHE', '', 'San Esteban', '132026225926', 'Member', '2026-08-03', '2026-08-03 02:22:13.078391'),
(11, 'DYLEN', 'ALMODAL', 'QUIÑO', '', 'Limburan', '132016502417', 'Member', '2026-08-03', '2026-08-03 02:38:46.660921'),
(12, 'ZACK ALDRICH', 'AGUIRRE', 'LUMBRE', '', 'Libas', '132537131776', 'Dependent', '2026-08-03', '2026-08-03 02:48:30.419524'),
(13, 'VANESSA', 'CREBILLO', 'CONDE', '', 'Kalao', '132539174634', 'Dependent', '2026-08-03', '2026-08-03 03:01:11.078885'),
(14, 'ANIKA MAE', 'DUMAGAT', 'ROMERO', '', 'Poblacion District VI', '132525154843', 'Dependent', '2026-08-03', '2026-08-03 03:08:28.600599'),
(15, 'SHAN CHRISTOPER', 'QUITON', 'GALICIA', '', 'Kalipayan', '000000000000', 'Member', '2026-08-03', '2026-08-03 08:44:21.018217'),
(16, 'JIRAH', 'MACEDA', 'REDUBLA', '', 'Cagangon', '000000000000', 'Member', '2026-08-03', '2026-08-03 08:45:54.249629'),
(17, 'LITO', 'PARTULAN', 'SENO', '', 'Poblacion District IV', '030252449961', 'Member', '2026-08-03', '2026-08-03 08:08:05.353358'),
(18, 'ROSALINDA', 'ROCABO', 'TALIPTIP', '', 'Tambis (Naboya)', '132019689879', 'Member', '2026-08-06', '2026-08-06 00:02:00.948838'),
(20, 'KITLYN', 'LUMBRE', 'VELARDE', '', 'San Pablo', '132535535225', 'Dependent', '2026-08-06', '2026-08-06 00:28:06.813678'),
(21, 'DARYL LYN', 'BROSAS', 'TAN', '', 'Poblacion District VIII', '130000813428', 'Member', '2026-08-06', '2026-08-06 00:32:59.863736'),
(22, 'REZA', 'BELARMINO', 'AMARILLE', '', 'Esperanza', '132534507384', 'Member', '2026-08-06', '2026-08-06 00:42:42.261019'),
(23, 'LEA MARIE', 'PALADIN', 'CAHINDE', '', 'Hapunan', '132030224519', 'Member', '2026-08-06', '2026-08-06 00:52:20.279462'),
(24, 'CATHY', 'PEDERE', 'BANTULA', '', 'Poblacion District III', '130250807199', 'Member', '2026-08-06', '2026-08-06 01:00:16.395438'),
(25, 'KRISTINE JOY', 'ANIANO', 'CASERES', '', 'Lobe-lobe', '130254350673', 'Member', '2026-08-06', '2026-08-06 01:17:48.286682'),
(26, 'MARIA MANILYN', 'DAGAMI', 'SUYOM', '', 'Moguing', '132029040102', 'Member', '2026-08-06', '2026-08-06 01:50:54.155349'),
(27, 'JEVIE', 'TONIDO', 'MODINA', '', 'Catagbacan', '132015510513', 'Member', '2026-08-06', '2026-08-06 02:15:22.308916'),
(28, 'ROTESSA', 'LUCENA', 'PRECIA', '', 'Bagong Lipunan', '080259695884', 'Member', '2026-08-06', '2026-08-06 02:23:04.558806'),
(29, 'PRINCE EJ', 'PATEÑO', 'CAÑEDO', '', 'Maabab', '132539162342', 'Dependent', '2026-08-06', '2026-08-06 03:08:54.084102'),
(30, 'VRENT MATTHEW', 'TOLIBAS', 'MODINA', '', 'Catagbacan', '132530788966', 'Dependent', '2026-08-06', '2026-08-06 03:20:59.042675'),
(31, 'JACKIELYN', 'URBINO', 'BERIDA', '', 'Tabuanon', '000000000000', 'Member', '2026-08-06', '2026-08-06 05:43:02.693273'),
(32, 'JEAN ROSE', 'NAVILLA', 'ARPON', '', 'Tabuanon', '000000000000', 'Dependent', '2026-08-06', '2026-08-06 06:00:44.436950'),
(33, 'NORBERTO', 'GERONDIO', 'VALIDA', '', 'Poblacion District IX', '132506541038', 'Member', '2026-08-10', '2026-08-10 00:51:59.719141'),
(34, 'ROSELDA', 'PANUBIO', 'TISMO', '', 'Malabca', '132021219456', 'Member', '2026-08-10', '2026-08-10 00:57:27.263429'),
(35, 'ALEEYA RAESSA', 'MAALLO', 'LANDECHO', '', 'Dumalag (Pusod)', '132539085542', 'Dependent', '2026-08-10', '2026-08-10 01:11:03.918648'),
(37, 'RIZA', 'BARELA', 'ALBAO', '', 'Villa Aurora', '000000000000', 'Member', '2026-08-10', '2026-08-10 01:24:37.306467'),
(40, 'JACOB', 'N/A', 'ESTRELLA', '', 'Poblacion District IV', '132538140426', 'Dependent', '2026-08-10', '2026-08-10 01:37:04.423401'),
(43, 'BARTOLOME', 'T', 'GERILLA', '', 'San Esteban', '132503807177', 'Dependent', '2026-08-10', '2026-08-10 01:46:35.907612'),
(44, 'PRINCESS MAUREEN', 'ALOS', 'BASILAN', '', 'Tambis (Naboya)', '132537411558', 'Dependent', '2026-08-10', '2026-08-10 01:54:20.336094'),
(45, 'SHANIAH HYVIE', 'MESIAS', 'ABUYOT', '', 'Poblacion District VIII', '022514535845', 'Dependent', '2026-08-10', '2026-08-10 02:01:03.846826'),
(46, 'ALVIN', 'TABANAS', 'ABUYOT', '', 'San Pablo', '030504417669', 'Member', '2026-08-10', '2026-08-10 02:05:48.874480'),
(47, 'APRIL RHEA MAE', 'ALERE', 'CARMINADA', '', 'San Jose East', '132530796535', 'Dependent', '2026-08-10', '2026-08-10 02:15:13.234790'),
(48, 'RANDY', 'LIBERATO', 'CADION', '', 'Matin-ao', '132018411974', 'Member', '2026-08-10', '2026-08-10 02:23:42.123731'),
(49, 'MA CONCHITA', 'CORITANA', 'ADION', '', 'Villa Rosas (Cabang)', '130252153218', 'Member', '2026-08-10', '2026-08-10 02:28:14.877460'),
(50, 'MARK LORENZ', 'NUIZ', 'DUMAGAT', '', 'Poblacion District III', '132025705991', 'Member', '2026-08-10', '2026-08-10 02:34:10.284306'),
(51, 'SAMANTHA', 'N/A', 'AGUIRRE', '', 'Poblacion District VII', '132528087519', 'Dependent', '2026-08-10', '2026-08-10 02:45:18.390516'),
(52, 'LEMUEL', 'CACEREZ', 'ALUPERE', '', 'San Jose East', '132531809843', 'Dependent', '2026-08-10', '2026-08-10 02:56:53.304617'),
(53, 'TRINIDAD', 'CHUA', 'RAGA', '', 'Abuyogon', '130253193531', 'Member', '2026-08-10', '2026-08-10 03:02:56.683128'),
(57, 'JOEL', 'SALILI', 'SACAY', '', 'Maghubas', '000000000000', 'Member', '2026-08-06', '2026-08-06 05:02:15.939762'),
(58, 'GALEA', 'DEJAPIN', 'GERNALE', '', 'Poblacion District VI', '132019695895', 'Member', '2026-08-13', '2026-08-13 00:16:17.450971'),
(59, 'MERABELLE', 'PARAME', 'REDUBLA', '', 'Anonang', '000000000000', 'Dependent', '2026-08-13', '2026-08-13 00:29:14.698856'),
(60, 'RINA BELLE', 'MANIDLANGAN', 'PARAME', '', 'Anonang', '080270818440', 'Member', '2026-08-13', '2026-08-13 00:30:15.379847'),
(62, 'JONIL', 'GRABATO', 'BALBADA', '', 'San Esteban', '130500637332', 'Member', '2026-08-13', '2026-08-13 00:43:23.063276'),
(63, 'RACQUEL', 'OCIER', 'BUENDIA', '', 'Calsadahay', '132504027590', 'Dependent', '2026-08-13', '2026-08-13 00:50:40.100909'),
(64, 'REGINE', 'ANTILLON', 'ANTIDO', '', 'Balorinay', '132538376349', 'Dependent', '2026-08-13', '2026-08-13 00:56:57.101333'),
(65, 'SHAMYKA GRACE', 'VILLANUEVA', 'PEÑADA', '', 'Poblacion District IV', '132540119698', 'Dependent', '2026-08-13', '2026-08-13 01:08:10.409410'),
(66, 'LEONEL', 'ABRILLO', 'QUIMBO', 'Jr.', 'Arado', '132533934092', 'Dependent', '2026-08-13', '2026-08-13 01:17:58.595310'),
(67, 'BENEDICTA', 'GALAS', 'POLANCOS', '', 'Villa Aurora', '132003451562', 'Member', '2026-08-13', '2026-08-13 01:22:50.482608'),
(68, 'JUMALYN', 'MALQUISTO', 'CINCO', '', 'San Pablo', '072018697182', 'Member', '2026-08-13', '2026-08-13 01:30:13.558793'),
(69, 'RICHELLE', 'N/A', 'GO', '', 'Poblacion District I', '132028092648', 'Member', '2026-08-13', '2026-08-13 01:37:13.002252'),
(70, 'EDITH', 'CORAL', 'DY', '', 'Poblacion District II', '130000425169', 'Member', '2026-08-13', '2026-08-13 01:42:53.795126'),
(71, 'JAIRUS TOTTIE', 'RIPALDA', 'ASIS', '', 'Poblacion District II', '132025339073', 'Member', '2026-08-13', '2026-08-13 01:55:10.922056'),
(72, 'PENILYN', 'CORITANA', 'PERANTE', '', 'Poblacion District V', '010256722823', 'Member', '2026-08-13', '2026-08-13 02:02:21.977031'),
(73, 'ESTRELIETA', 'ODQUIN', 'CORITANA', '', 'Villa Rosas (Cabang)', '130251692387', 'Member', '2026-08-13', '2026-08-13 02:08:26.238419'),
(74, 'JULIANA FRANCINE', 'MAS-ING', 'PASTOR', '', 'Poblacion District VIII', '132539680998', 'Dependent', '2026-08-13', '2026-08-13 02:18:56.563088'),
(77, 'MARILYN', '-', 'ANTILLON', '', 'Balorinay', '132029785671', 'Member', '2026-08-17', '2026-08-17 00:07:47.734575'),
(78, 'MERY GRACE', 'SILVANO', 'LUCIO', '', 'San Esteban', '132529012989', 'Member', '2026-08-17', '2026-08-17 00:18:40.929847'),
(79, 'GLENDA', 'AGRAVA', 'COMORA', '', 'Hibonawan', '130251256161', 'Member', '2026-08-17', '2026-08-17 00:34:56.607331'),
(80, 'GERALD', 'N/A', 'TOLIBAS', '', 'Malaihao (San Ramon)', '132537875570', 'Dependent', '2026-08-17', '2026-08-17 00:42:31.365083'),
(81, 'ROSALIE', 'MARBIBI', 'SUPLENTE', '', 'Paghudlan', '130250137843', 'Member', '2026-08-17', '2026-08-17 00:49:44.555202'),
(82, 'JUDITH', 'TA?O', 'JUANICO', '', 'Moguing', '130000871053', 'Member', '2026-08-17', '2026-08-17 00:57:11.251092'),
(83, 'LUCRISIA', 'MUTYA', 'LACOSTA', '', 'Paghudlan', '132023561151', 'Member', '2026-08-17', '2026-08-17 01:12:12.843124'),
(84, 'MARIA ZIA', 'CORITANA', 'MAS-ING', '', 'Villa Rosas (Cabang)', '132535873724', 'Dependent', '2026-08-17', '2026-08-17 01:24:53.132171'),
(85, 'FELISICIMO', 'GERILLA', 'REBATO', '', 'Poblacion District VI', '230054804844', 'Member', '2026-08-17', '2026-08-17 01:30:12.930889'),
(86, 'DANNY', 'PORTILLO', 'PALATINO', '', 'Cansiboy', '132019687000', 'Member', '2026-08-17', '2026-08-17 01:59:27.193465'),
(87, 'MARLINE', 'ANTIVO', 'TISMO', '', 'Paghudlan', '000000000000', 'Member', '2026-08-17', '2026-08-17 03:11:01.508489'),
(88, 'PRINCESS MAE', 'TINAYA', 'ROMBO', '', 'Tabuanon', '000000000000', 'Member', '2026-08-17', '2026-08-17 03:12:03.473377'),
(89, 'MA ELENA', 'DUMANSAY', 'RENOMERON', '', 'Poblacion District V', '000000000000', 'Member', '2026-08-17', '2026-08-17 03:14:13.064735'),
(90, 'ALBERT', 'BIRON', 'MORANTE', '', 'San Jose East', '000000000000', 'Member', '2026-08-17', '2026-08-17 03:15:33.871753'),
(91, 'ZAIQA AYSHIN', 'N/A', 'PERANTE', '', 'Poblacion District IX', '000000000000', 'Dependent', '2026-08-17', '2026-08-17 03:22:57.828158'),
(103, 'ZYRA MAE', 'NABOYA', 'ARROJO', '', 'Arado', '132529091862', 'Dependent', '2026-08-20', '2026-08-20 00:16:43.028271'),
(104, 'LEONEL', 'GEVEN', 'QUIMBO', '', 'Arado', '130001212363', 'Member', '2026-08-20', '2026-08-20 00:27:37.425002'),
(105, 'AJ', 'RAEL', 'SALAZAR', '', 'Poblacion District II', '132538275623', 'Dependent', '2026-08-20', '2026-08-20 00:39:05.284488'),
(106, 'LE DANNAH', 'ABRILLO', 'QUIMBO', '', 'Arado', '132536124237', 'Dependent', '2026-08-20', '2026-08-20 00:47:20.639837'),
(107, 'ELEUTERIO', 'CORAL', 'COSTIMIANO', '', 'Malaihao (San Ramon)', '132015521051', 'Member', '2026-08-20', '2026-08-20 00:53:41.354709'),
(108, 'GABRIEL ANGELO', 'MACARAY', 'CINCO', '', 'Esperanza', '132540343148', 'Dependent', '2026-08-20', '2026-08-20 01:08:02.891699'),
(110, 'RON RON', 'CABILING', 'MARBIBI', '', 'Hibonawan', '000000000000', 'Member', '2026-08-20', '2026-08-20 01:13:28.359681'),
(111, 'JOHN MATTHEW', 'CORDA', 'SABALLA', '', 'Poblacion District IV', '000000000000', 'Dependent', '2026-08-20', '2026-08-20 01:27:13.448234'),
(112, 'NOAH JED', 'CONDE', 'BORLAZA', '', 'Abuyogon', '132536160098', 'Dependent', '2026-08-20', '2026-08-20 01:31:46.217612'),
(113, 'JIN ARGUS', 'LUCENA', 'MANDREZA', '', 'Poblacion District II', '132535438084', 'Dependent', '2026-08-20', '2026-08-20 01:37:38.612458'),
(114, 'KENT VINCENT', 'VILLASANTE', 'FEDELIS', '', 'Kalipayan', '000000000000', 'Member', '2026-08-20', '2026-08-20 01:45:20.452397'),
(115, 'YASHIKA AZRIEL', 'LOZANO', 'DUMANTAY', '', 'Poblacion District V', '132534146691', 'Dependent', '2026-08-20', '2026-08-20 01:49:50.435760'),
(116, 'JENIFER', 'ALCOBER', 'ABREGO', '', 'San Esteban', '012555348256', 'Member', '2026-08-20', '2026-08-20 01:56:34.615772'),
(117, 'DWAYNE KAIZER', 'MABANAN', 'SILVANO', '', 'Dacay', '132538995936', 'Dependent', '2026-08-20', '2026-08-20 02:05:39.082080'),
(118, 'ELLIANA DELLE', 'ALLA', 'OCTA', '', 'Moguing', '132539203154', 'Dependent', '2026-08-20', '2026-08-20 02:14:17.041789'),
(119, 'REYNALDO', 'PALANA', 'CINCO', '', 'San Pablo', '132023512681', 'Member', '2026-08-20', '2026-08-20 02:22:33.194613'),
(121, 'JUSTIN', 'TEJOME', 'GRIMS', '', 'Moguing', '132029143440', 'Member', '2026-09-03', '2026-09-03 00:15:43.771218'),
(122, 'JUSTINE', 'MAURO', 'RAGA', '', 'Malaguinabot', '132503949702', 'Dependent', '2026-09-03', '2026-09-03 00:28:07.731012'),
(123, 'TIMOLA', 'TILA-ON', 'TIMOLA', '', 'Poblacion District IV', '132503831248', 'Dependent', '2026-09-03', '2026-09-03 00:37:58.407372'),
(124, 'JOHN DALE', 'GARCIA', 'NABOYA', '', 'Villa Rosas (Cabang)', '132537963135', 'Dependent', '2026-09-03', '2026-09-03 00:47:13.865458'),
(125, 'JHOCHEL RAIN', 'BERON', 'LADOY', '', 'Mahagnao', '000000000000', 'Dependent', '2026-09-03', '2026-09-03 01:03:31.605999'),
(126, 'MARY ANN', 'MERDEGIA', 'BASILAN', '', 'Maabab', '130254846121', 'Member', '2026-09-03', '2026-09-03 01:04:47.065898'),
(127, 'HARLENE AVERY', 'MODINA', 'GEVEN', '', 'Poblacion District III', '132522964062', 'Dependent', '2026-09-03', '2026-09-03 01:14:45.874904'),
(128, 'LE DANIEL', 'ABRILLO', 'QUIMBO', '', 'Arado', '000000000000', 'Dependent', '2026-09-03', '2026-09-03 01:24:28.705562'),
(129, 'VIRGINIA', 'ITIG', 'TONIDO', '', 'Poblacion District IX', '182013669997', 'Member', '2026-09-03', '2026-09-03 01:25:49.290955'),
(130, 'MARITES', 'COBALIDA', 'VILLABLANCA', '', 'Villa Rosas (Cabang)', '130253444895', 'Member', '2026-09-03', '2026-09-03 01:29:48.548005'),
(131, 'YHANNA KRYSTELLE', 'COMORA', 'SEVILLA', '', 'Hibonawan', '132530219724', 'Dependent', '2026-09-03', '2026-09-03 01:42:55.229502'),
(132, 'BEATRISE', 'LIGAO', 'ISOY', '', 'Libas', '132532109594', 'Dependent', '2026-09-03', '2026-09-03 01:57:29.766254'),
(133, 'VANESSA', 'CREBILLO', 'CONDE', '', 'Kalao', '132539174634', 'Dependent', '2026-09-03', '2026-09-03 02:08:24.025161'),
(134, 'RAMIL JOSE', 'SORTILLO', 'CORNISTA', '', 'Balorinay', '130254712001', 'Member', '2026-09-03', '2026-09-03 02:27:44.035176'),
(135, 'BENITA', 'MENDOZA', 'VIDAL', '', 'Tagkip', '130256109639', 'Member', '2026-09-03', '2026-09-03 03:42:22.851284'),
(136, 'MATT KAIDEN', 'MODINO', 'MANIDLANGAN', '', 'Poblacion District III', '132525167872', 'Dependent', '2026-09-03', '2026-09-03 06:15:47.424973'),
(137, 'LEANN CLARE', 'ESPINOSA', 'CORPIN', '', 'Arado', '132529487626', 'Dependent', '2026-09-07', '2026-09-07 00:15:14.222856'),
(138, 'RICHARD', 'DAGAMI', 'MITRA', '', 'Sambel', '132009166177', 'Member', '2026-09-07', '2026-09-07 00:20:16.371309'),
(139, 'ASHLEY NICOLE', 'MANIDLANGAN', 'ALERE', '', 'Dina-ayan', '132532253598', 'Dependent', '2026-09-07', '2026-09-07 00:28:03.474611'),
(140, 'DIVINA', 'TIMONERA', 'GASTALLA', '', 'San Pablo', '132504019091', 'Member', '2026-09-07', '2026-09-07 00:32:14.092957'),
(141, 'FEBRELLE', 'MORALES', 'RAGA', '', 'Matin-ao', '132535821724', 'Dependent', '2026-09-07', '2026-09-07 00:41:14.058209'),
(142, 'REY', 'REFUERZO', 'LAUROSA', '', 'Kalao', '132539151553', 'Dependent', '2026-09-07', '2026-09-07 00:53:23.686278'),
(143, 'RONNIE CYNTH', 'BERNAL', 'RENOMERON', '', 'Villa Corazon', '132532262899', 'Member', '2026-09-07', '2026-09-07 01:08:05.784604'),
(144, 'MONICA', 'MALATE', 'REFUERZO', '', 'Kalao', '132503991679', 'Member', '2026-09-07', '2026-09-07 01:18:03.436002'),
(145, 'MICHELLE', 'MALATE', 'TOLIBAS', '', 'San Jose East', '132531994012', 'Dependent', '2026-09-07', '2026-09-07 01:30:25.943101'),
(146, 'CLARK BELLE', 'COSTA', 'ORTEGA', '', 'Maghubas', '130500608227', 'Member', '2026-09-07', '2026-09-07 01:38:31.606677'),
(147, 'NILDA', 'CORAÑES', 'QUILLOTES', '', 'Maghubas', '132031352081', 'Member', '2026-09-07', '2026-09-07 01:46:42.595811'),
(148, 'SUSAN', 'BARROS', 'REDUBLA', '', 'Cagangon', '132026374174', 'Member', '2026-09-07', '2026-09-07 01:54:28.567884'),
(149, 'MARVIN', 'MENDOZA', 'GALLAMOS', '', 'Tabuanon', '132025276705', 'Member', '2026-09-07', '2026-09-07 02:11:11.394751'),
(150, 'ALMA', 'PARADO', 'PAREDES', '', 'Poblacion District IX', '120000201303', 'Member', '2026-09-07', '2026-09-07 02:56:21.151166'),
(151, 'WYNE', 'VIGAL', 'HERMANO', '', 'Poblacion District VI', '132540342478', 'Dependent', '2026-09-07', '2026-09-07 05:05:52.659002'),
(152, 'ZACK JADRIN', 'GELIG', 'ARCENAS', '', 'Poblacion District VII', '122540669056', 'Dependent', '2026-09-10', '2026-09-10 00:26:05.512273'),
(153, 'ACE JARED', 'GELIG', 'ARCENAS', '', 'Poblacion District VII', '132535774114', 'Dependent', '2026-09-10', '2026-09-10 00:34:59.433683'),
(154, 'MARY CLAIRE', 'BACUÑATA', 'RODRIGUEZ', '', 'Villa Rosas (Cabang)', '132529883181', 'Dependent', '2026-09-10', '2026-09-10 00:42:36.778277'),
(155, 'ELMER', 'REDUBLA', 'GENITO', '', 'Poblacion District IV', '230073157442', 'Member', '2026-09-10', '2026-09-10 00:49:13.845763'),
(156, 'MARK', 'MANINGO', 'LASTIMADO', '', 'Poblacion District IV', '130251592994', 'Member', '2026-09-10', '2026-09-10 00:56:30.734493'),
(157, 'MARIA GIRLIE', 'AVELINO', 'CAMPOSANO', '', 'Patong', '130251236845', 'Member', '2026-09-10', '2026-09-10 01:06:10.491300'),
(158, 'IRENE', 'DONGSAL', 'CADARO', '', 'San Jose East', '130251236861', 'Member', '2026-09-10', '2026-09-10 01:12:38.801782'),
(159, 'JENNY ANN', 'BARRES', 'REDUBLA', '', 'Cagangon', '130256426782', 'Member', '2026-09-10', '2026-09-10 01:28:31.647562'),
(160, 'NICA', 'ROM', 'REDUBLA', '', 'Anonang', '132533000081', 'Dependent', '2026-09-10', '2026-09-10 01:36:42.297430'),
(161, 'KRISHA MAE', 'REDUBLA', 'BELARMINO', '', 'San Jose West', '132028779724', 'Member', '2026-09-10', '2026-09-10 01:43:13.091277'),
(162, 'ÑIARA ELLIX', 'BAGAYAS', 'BURANDAY', '', 'Calsadahay', '172535612159', 'Dependent', '2026-09-10', '2026-09-10 01:52:58.745149'),
(163, 'FE', 'BUENDIA', 'DECINA', '', 'Poblacion District III', '132012502005', 'Member', '2026-09-10', '2026-09-10 02:20:25.390703'),
(164, 'RAMSES LAWRENCE', 'PATENTE', 'GUNDAN', '', 'Esperanza', '132533323239', 'Dependent', '2026-09-10', '2026-09-10 02:29:51.293553'),
(165, 'BIENVINIDO', 'CANDELA', 'BADEO', '', 'Arado', '000000000000', 'Member', '2026-09-10', '2026-09-10 02:56:59.378477'),
(166, 'BENJIE', 'CONDE', 'SOYOSA', '', 'Matin-ao', '000000000000', 'Dependent', '2026-09-10', '2026-09-10 03:00:25.219357'),
(167, 'BIENVENIDO', 'CANDELA', 'BADEO', '', 'Arado', '132031597033', 'Member', '2026-09-10', '2026-09-16 01:31:45.478234'),
(168, 'AJ CARL', 'DAGAMI', 'MABALLO', '', 'Limburan', '132534244316', 'Dependent', '2026-09-21', '2026-09-20 23:55:35.472231'),
(169, 'MARIA CRISTELYN', 'DA-A', 'CONDE', '', 'Poblacion District II', '130254344398', 'Member', '2026-09-21', '2026-09-21 00:02:57.484075'),
(170, 'ELISA', 'MALATE', 'MENOC', '', 'Poblacion District IV', '132013875573', 'Member', '2026-09-21', '2026-09-21 00:11:13.737726'),
(171, 'EMMANUEL', 'DE PAZ', 'CASUELA', '', 'Mahagnao', '230022461694', 'Member', '2026-09-21', '2026-09-21 00:34:01.523366'),
(172, 'EVANGELINE', 'MAGAYONES', 'GERILLA', '', 'San Esteban', '130250627859', 'Member', '2026-09-21', '2026-09-21 00:40:51.092186'),
(173, 'MARK', 'ABRIL', 'PEREZ', '', 'Kalipayan', '130251013846', 'Member', '2026-09-21', '2026-09-21 00:47:30.842879'),
(174, 'RAYMART', 'AMAT', 'CELEDIO', '', 'Patag', '132023565203', 'Member', '2026-09-21', '2026-09-21 00:52:37.063135'),
(175, 'KYLIAN', 'CAYUBIT', 'AQUINO', '', 'Balorinay', '132537242632', 'Dependent', '2026-09-21', '2026-09-21 01:06:23.506424'),
(176, 'ANNA ROSE', 'ANTIDO', 'RELADOR', '', 'Balorinay', '132027890044', 'Member', '2026-09-21', '2026-09-21 01:11:55.591970'),
(177, 'JENNEL', 'LORETO', 'TUSCANO', '', 'San Pablo', '132536223812', 'Dependent', '2026-09-21', '2026-09-21 01:21:05.152255'),
(178, 'FRANCE JAKE', 'BUGHO', 'REATAZA', '', 'Poblacion District IV', '022533241631', 'Dependent', '2026-09-21', '2026-09-21 01:31:54.970184'),
(179, 'RAIDEN RYLEE', 'N/A', 'TADIC', '', 'Hibonawan', '132539719762', 'Dependent', '2026-09-21', '2026-09-21 01:46:37.761072'),
(180, 'DIVINE GRACE', 'CABUDOC', 'CULABAN', '', 'Abuyogon', '132538895400', 'Dependent', '2026-09-21', '2026-09-21 02:01:01.847300'),
(181, 'JAMES KING', 'CABUDOC', 'CULABAN', '', 'Abuyogon', '132525269187', 'Dependent', '2026-09-21', '2026-09-21 02:08:29.049036'),
(182, 'VINCENT', 'REGERO', 'APLACA', '', 'Poblacion District III', '000000000000', 'Member', '2026-09-21', '2026-09-21 02:19:57.610994'),
(183, 'EVELYN', 'ALVERO', 'VIJAR', '', 'Poblacion District VI', '000000000000', 'Member', '2026-09-21', '2026-09-21 02:21:53.307026'),
(184, 'SHIRLY', 'BUENO', 'ECHON', '', 'Buri', '132012451265', 'Member', '2026-09-21', '2026-09-21 04:17:15.116709'),
(185, 'GERONIMO', 'CONDE', 'PARTA', 'Jr.', 'Poblacion District IV', '132536067624', 'Dependent', '2026-09-24', '2026-09-24 00:15:24.399013'),
(186, 'MYKA', 'MALTOS', 'RIVAS', '', 'Poblacion District III', '132540409297', 'Dependent', '2026-09-24', '2026-09-24 00:33:44.684149'),
(187, 'MELANIE', 'REATAZA', 'RENOMERON', '', 'Arado', '132031546730', 'Member', '2026-09-24', '2026-09-24 00:44:13.196154'),
(188, 'JARED', 'ANDRADE', 'CAINDOY', '', 'Poblacion District VI', '132506242677', 'Dependent', '2026-09-24', '2026-09-24 00:56:49.308025'),
(189, 'NONEGO', 'NABELLA', 'LORENO', '', 'Libas', '130500454009', 'Member', '2026-09-24', '2026-09-24 01:10:27.833788'),
(190, 'WILFREDO', 'RELADOR', 'REFUERZO', '', 'Poblacion District IX', '220000382825', 'Member', '2026-09-24', '2026-09-24 01:35:23.104140'),
(191, 'WILFREDO', 'RELADOR', 'REFUERZO', '', 'Poblacion District IX', '220000382825', 'Member', '2026-09-24', '2026-09-24 01:35:23.504156'),
(192, 'ARCHIE', 'N/A', 'REDUBLA', '', 'Moguing', '130253377802', 'Member', '2026-09-24', '2026-09-24 02:11:36.949559'),
(193, 'SEAN', 'ALIPAR', 'ROSEL', '', 'San Jose East', '132536074523', 'Dependent', '2026-09-24', '2026-09-24 02:20:36.138563'),
(194, 'ELINDA', 'CARINAN', 'DE PAZ', '', 'Maghubas', '132013281215', 'Member', '2026-09-24', '2026-09-24 02:26:58.658077'),
(221, 'ALTHEA JEAN', 'PORTILLO', 'BALANSAG', '', 'Villa Corazon', '000000000000', 'Dependent', '2026-09-25', '2026-09-24 00:07:58.205607'),
(222, 'PRINCE DARWIN', 'N/A', 'DAROLE', '', 'Poblacion District II', '000000000000', 'Dependent', '2026-09-25', '2026-09-24 00:16:48.838649'),
(223, 'ALTHEA JANE', 'SOTELO', 'MARBIBI', '', 'Poblacion District VII', '000000000000', 'Dependent', '2026-09-25', '2026-09-24 00:18:03.076216'),
(224, 'NATHALYN', 'DAGAMI', 'MANABAT', '', 'Anonang', '000000000000', 'Dependent', '2026-09-25', '2026-09-24 00:19:09.433821'),
(225, 'JOHN LYZAN', 'IBEA', 'GARCIA', '', 'Poblacion District IX', '000000000000', 'Dependent', '2026-09-25', '2026-09-24 00:41:42.412748'),
(226, 'JOHN MICHAEL', 'SUAREZ', 'TANGKI-ON', '', 'Malabca', '000000000000', 'Dependent', '2026-09-25', '2026-09-24 00:43:55.239881'),
(227, 'FRANCO', 'RIO', 'BAÑOC', '', 'Poblacion District VII', '000000000000', 'Member', '2026-09-25', '2026-09-24 00:44:41.950469'),
(228, 'PRINCE DARWIN', 'N/A', 'DAROLE', '', 'Poblacion District II', '132532333745', 'Dependent', '2026-09-28', '2026-09-27 23:53:01.932857'),
(229, 'ARCHZIENY CHIEN', 'N/A', 'PEDERE', '', 'Arado', '132536201592', 'Dependent', '2026-09-28', '2026-09-28 00:18:10.855821'),
(230, 'JAY VIC', 'EQUIPAJE', 'CESAR', '', 'Maghubas', '130250770023', 'Member', '2026-09-28', '2026-09-28 00:37:27.768775'),
(231, 'MICO', 'CINCO', 'EMADEM', '', 'Malaihao (San Ramon)', '132532109535', 'Dependent', '2026-09-28', '2026-09-28 00:47:10.077081'),
(232, 'CLYDE BRAYDEN', 'REFUERZO', 'EMADEM', '', 'Poblacion District IX', '132532383874', 'Dependent', '2026-09-28', '2026-09-28 01:12:54.994538');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `patient_records`
--
ALTER TABLE `patient_records`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `patient_records`
--
ALTER TABLE `patient_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=233;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
