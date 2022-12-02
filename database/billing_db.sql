-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 07, 2020 at 04:42 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `billing_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

CREATE TABLE `billing` (
  `id` int(30) NOT NULL,
  `billing_date` date NOT NULL DEFAULT current_timestamp(),
  `tenant_id` int(30) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=pending,1=paid',
  `total_amount` double NOT NULL,
  `amount_tendered` double NOT NULL,
  `amount_change` double NOT NULL,
  `invoice` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `billing`
--

INSERT INTO `billing` (`id`, `billing_date`, `tenant_id`, `status`, `total_amount`, `amount_tendered`, `amount_change`, `invoice`) VALUES
(1, '2020-08-23', 2, 1, 9500, 10000, 500, ''),
(2, '2020-08-23', 1, 1, 8500, 10000, 1500, ''),
(3, '2020-09-23', 2, 0, 8000, 0, 0, ''),
(5, '2020-09-01', 1, 0, 6500, 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` int(30) NOT NULL,
  `billing_id` int(30) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '1= block rent, 2= electricity,3=water',
  `reading` int(30) NOT NULL,
  `consumption` int(30) NOT NULL,
  `rate` double NOT NULL,
  `previous_reading` int(30) NOT NULL,
  `previous_consumption` int(30) NOT NULL,
  `amount` double NOT NULL,
  `previous_amount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `billing_id`, `type`, `reading`, `consumption`, `rate`, `previous_reading`, `previous_consumption`, `amount`, `previous_amount`) VALUES
(1, 1, 1, 0, 0, 5000, 0, 0, 5000, 5000),
(2, 1, 2, 100, 100, 15, 0, 0, 1500, 0),
(3, 1, 3, 300, 300, 10, 0, 0, 3000, 0),
(4, 2, 1, 0, 0, 3000, 0, 0, 3000, 3000),
(5, 2, 2, 300, 300, 15, 0, 0, 4500, 0),
(6, 2, 3, 100, 100, 10, 0, 0, 1000, 0),
(7, 3, 1, 0, 0, 5000, 0, 0, 5000, 5000),
(8, 3, 2, 100, 200, 15, 100, 100, 1500, 1),
(9, 3, 3, 150, 450, 10, 300, 300, 1500, 3),
(13, 5, 1, 0, 0, 3000, 0, 0, 3000, 3000),
(14, 5, 2, 100, 400, 15, 300, 300, 1500, 4),
(15, 5, 3, 200, 300, 10, 100, 100, 2000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `block_locations`
--

CREATE TABLE `block_locations` (
  `id` int(11) NOT NULL,
  `block` text NOT NULL,
  `floor` text NOT NULL,
  `rate` double NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1= Available, 2-Unavailable'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `block_locations`
--

INSERT INTO `block_locations` (`id`, `block`, `floor`, `rate`, `status`) VALUES
(1, '1', 'Ground', 5000, 2),
(2, '2', 'Ground', 3000, 1),
(3, '3-A', '2nd', 3000, 2);

-- --------------------------------------------------------

--
-- Table structure for table `system_configuration`
--

CREATE TABLE `system_configuration` (
  `id` int(30) NOT NULL,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `contact` text NOT NULL,
  `electricity_rate` double NOT NULL,
  `water_rate` double NOT NULL,
  `establishment_logo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `system_configuration`
--

INSERT INTO `system_configuration` (`id`, `name`, `address`, `contact`, `electricity_rate`, `water_rate`, `establishment_logo`) VALUES
(1, 'Sample Establishment', 'Sample Address', '+1234567899', 15, 10, '0');

-- --------------------------------------------------------

--
-- Table structure for table `tenants`
--

CREATE TABLE `tenants` (
  `id` int(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `owner` varchar(100) NOT NULL,
  `block_ids` text NOT NULL,
  `contact` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tenants`
--

INSERT INTO `tenants` (`id`, `name`, `owner`, `block_ids`, `contact`) VALUES
(1, 'Nike', 'John Smith', '3', '+18456-5455-55'),
(2, 'Department Store', 'George Wilson', '1', '8747808787');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(30) NOT NULL,
  `name` text NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 2 COMMENT '1 = Admin, 2= establishment_staff',
  `username` varchar(100) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `type`, `username`, `password`) VALUES
(1, 'Administrator', 1, 'admin', '0192023a7bbd73250516f069df18b500'),
(2, 'Staff User', 2, 'staff', '1253208465b1efa876f982d8a9e73eef');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `block_locations`
--
ALTER TABLE `block_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_configuration`
--
ALTER TABLE `system_configuration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tenants`
--
ALTER TABLE `tenants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `block_locations`
--
ALTER TABLE `block_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `system_configuration`
--
ALTER TABLE `system_configuration`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tenants`
--
ALTER TABLE `tenants`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
