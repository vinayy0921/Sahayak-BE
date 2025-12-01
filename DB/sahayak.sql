-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2025 at 08:39 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sahayak`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbladmins`
--

CREATE TABLE `tbladmins` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblbookings`
--

CREATE TABLE `tblbookings` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `booking_date` date NOT NULL,
  `time_slot` varchar(20) NOT NULL,
  `status` enum('pending','confirmed','completed','cancelled') DEFAULT 'pending',
  `address` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblcategories`
--

CREATE TABLE `tblcategories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblcategories`
--

INSERT INTO `tblcategories` (`id`, `name`, `image_url`) VALUES
(1, 'Plumber', 'plumber.png'),
(2, 'Electrician', 'electrician.png'),
(3, 'Cleaning', 'cleaning.png'),
(4, 'Tutor', 'tutor.png');

-- --------------------------------------------------------

--
-- Table structure for table `tblcustomers`
--

CREATE TABLE `tblcustomers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` text DEFAULT NULL,
  `locality` varchar(255) DEFAULT NULL,
  `profile_img` varchar(255) DEFAULT 'default_user.png',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblcustomers`
--

INSERT INTO `tblcustomers` (`id`, `name`, `email`, `password`, `phone`, `address`, `locality`, `profile_img`, `created_at`) VALUES
(1, 'Ravi Patel', 'ravi@gmail.com', '$2y$10$Tw.v.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1', '9876500001', 'B-201, Rajhans Point, Adajan, Surat', NULL, 'default_user.png', '2025-12-01 07:32:31'),
(2, 'Sneha Desai', 'sneha@gmail.com', '$2y$10$Tw.v.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1', '9876500002', 'A-405, Vesu VIP Road, Surat', NULL, 'default_user.png', '2025-12-01 07:32:31'),
(3, 'Amit Shah', 'amit@gmail.com', '$2y$10$Tw.v.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1', '9876500003', 'C-12, Pal Gam, Surat', NULL, 'default_user.png', '2025-12-01 07:32:31');

-- --------------------------------------------------------

--
-- Table structure for table `tblproviders`
--

CREATE TABLE `tblproviders` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `city` varchar(50) NOT NULL,
  `bio` text DEFAULT NULL,
  `profession` varchar(255) DEFAULT NULL,
  `experience_years` int(11) DEFAULT 0,
  `profile_img` varchar(255) DEFAULT 'default_provider.png',
  `is_verified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblproviders`
--

INSERT INTO `tblproviders` (`id`, `name`, `email`, `password`, `phone`, `city`, `bio`, `profession`, `experience_years`, `profile_img`, `is_verified`, `created_at`) VALUES
(1, 'Raju Mistry', 'rajesh@gmail.com', '$2y$10$Tw.v.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1', '9898011111', 'Surat', 'Expert Plumber with 10 years of experience in pipe fitting and leakage.', NULL, 10, 'default_provider.png', 1, '2025-12-01 07:34:17'),
(2, 'Sunita Cleaning', 'sunita@gmail.com', '$2y$10$Tw.v.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1', '9898022222', 'Surat', 'Professional home deep cleaning and sofa cleaning services.', NULL, 5, 'default_provider.png', 1, '2025-12-01 07:34:17'),
(3, 'Vijay Electricals', 'vijay@gmail.com', '$2y$10$Tw.v.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1.1', '9898033333', 'Surat', 'AC Repair and House Wiring specialist. Available 24/7.', NULL, 8, 'default_provider.png', 0, '2025-12-01 07:34:17');

-- --------------------------------------------------------

--
-- Table structure for table `tblprovider_services`
--

CREATE TABLE `tblprovider_services` (
  `id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `service_name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price_per_hour` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblprovider_services`
--

INSERT INTO `tblprovider_services` (`id`, `provider_id`, `category_id`, `service_name`, `description`, `price_per_hour`) VALUES
(1, 1, 1, 'Tap Leakage Repair', 'Fixing dripping taps and valves.', 200.00),
(2, 1, 1, 'Water Tank Installation', 'Full installation of 500L/1000L tanks.', 1500.00),
(3, 2, 3, 'Full Home Deep Cleaning', 'Includes floor, kitchen, and washroom cleaning.', 999.00),
(4, 3, 2, 'Fan & Light Installation', 'Installing new ceiling fans and tubelights.', 150.00),
(5, 3, 2, 'AC Gas Filling', 'Split AC gas refilling and servicing.', 2500.00);

-- --------------------------------------------------------

--
-- Table structure for table `tblreviews`
--

CREATE TABLE `tblreviews` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbltransactions`
--

CREATE TABLE `tbltransactions` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `admin_commission` decimal(10,2) NOT NULL,
  `provider_earnings` decimal(10,2) NOT NULL,
  `payment_status` enum('paid','refunded') DEFAULT 'paid',
  `transaction_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmins`
--
ALTER TABLE `tbladmins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `tblbookings`
--
ALTER TABLE `tblbookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `provider_id` (`provider_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `tblcategories`
--
ALTER TABLE `tblcategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblcustomers`
--
ALTER TABLE `tblcustomers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `tblproviders`
--
ALTER TABLE `tblproviders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `tblprovider_services`
--
ALTER TABLE `tblprovider_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `provider_id` (`provider_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `tblreviews`
--
ALTER TABLE `tblreviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `provider_id` (`provider_id`);

--
-- Indexes for table `tbltransactions`
--
ALTER TABLE `tbltransactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbladmins`
--
ALTER TABLE `tbladmins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblbookings`
--
ALTER TABLE `tblbookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblcategories`
--
ALTER TABLE `tblcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblcustomers`
--
ALTER TABLE `tblcustomers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tblproviders`
--
ALTER TABLE `tblproviders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tblprovider_services`
--
ALTER TABLE `tblprovider_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblreviews`
--
ALTER TABLE `tblreviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbltransactions`
--
ALTER TABLE `tbltransactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblbookings`
--
ALTER TABLE `tblbookings`
  ADD CONSTRAINT `tblbookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `tblcustomers` (`id`),
  ADD CONSTRAINT `tblbookings_ibfk_2` FOREIGN KEY (`provider_id`) REFERENCES `tblproviders` (`id`),
  ADD CONSTRAINT `tblbookings_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `tblprovider_services` (`id`);

--
-- Constraints for table `tblprovider_services`
--
ALTER TABLE `tblprovider_services`
  ADD CONSTRAINT `tblprovider_services_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `tblproviders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tblprovider_services_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `tblcategories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tblreviews`
--
ALTER TABLE `tblreviews`
  ADD CONSTRAINT `tblreviews_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `tblbookings` (`id`),
  ADD CONSTRAINT `tblreviews_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `tblcustomers` (`id`),
  ADD CONSTRAINT `tblreviews_ibfk_3` FOREIGN KEY (`provider_id`) REFERENCES `tblproviders` (`id`);

--
-- Constraints for table `tbltransactions`
--
ALTER TABLE `tbltransactions`
  ADD CONSTRAINT `tbltransactions_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `tblbookings` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
