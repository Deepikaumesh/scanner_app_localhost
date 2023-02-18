-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2023 at 06:36 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scanner_project`
--
CREATE DATABASE IF NOT EXISTS `scanner_project` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `scanner_project`;

-- --------------------------------------------------------

--
-- Table structure for table `customer_payment`
--

CREATE TABLE `customer_payment` (
  `id` int(255) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `bank` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ac_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total_amt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customer_payment`
--

INSERT INTO `customer_payment` (`id`, `name`, `bank`, `phone`, `ac_no`, `total_amt`, `order_id`, `uid`) VALUES
(41, 'eded', 'dd', 'vht', 'rt', 'gg', '21', '58'),
(42, 'Vbh', 'cgg', '235', '5586969696', '70.0', '22', '58'),
(43, 'Ftt', 'fgg', '8956236969', '9696963696', '150.0', '23', '58');

-- --------------------------------------------------------

--
-- Table structure for table `customer_registration`
--

CREATE TABLE `customer_registration` (
  `id` int(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer_registration`
--

INSERT INTO `customer_registration` (`id`, `username`, `email`, `phone`, `password`) VALUES
(58, 'deepika', 'deepi@gmail.com', '9526843393', 'deepz'),
(60, 'sanvi', 'ffgg@gmail.com', '8952369852', 'mol'),
(61, 'cus', 'ff', '34', 'cus');

-- --------------------------------------------------------

--
-- Table structure for table `cust_cart_product`
--

CREATE TABLE `cust_cart_product` (
  `id` int(255) NOT NULL,
  `productid` varchar(255) NOT NULL,
  `product_qty` varchar(255) NOT NULL,
  `uid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cust_cart_product`
--

INSERT INTO `cust_cart_product` (`id`, `productid`, `product_qty`, `uid`) VALUES
(325, '101', '1', '60'),
(326, '103', '1', '60');

-- --------------------------------------------------------

--
-- Table structure for table `merchant_add_product`
--

CREATE TABLE `merchant_add_product` (
  `id` int(255) NOT NULL,
  `productid` varchar(255) NOT NULL,
  `productname` varchar(255) NOT NULL,
  `productprice` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `stock` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `merchant_registration`
--

CREATE TABLE `merchant_registration` (
  `id` int(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `merchant_registration`
--

INSERT INTO `merchant_registration` (`id`, `username`, `email`, `phone`, `password`) VALUES
(48, 'abc', 'cc@gmail.com', '8956231478', 'cc'),
(49, 'mer', '123', '2323', 'mer'),
(50, 'merch', 'gihih@gmail.com', '9696963696', 'vv');

-- --------------------------------------------------------

--
-- Table structure for table `order_items_tb`
--

CREATE TABLE `order_items_tb` (
  `id` int(255) NOT NULL,
  `productid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `product_qty` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `order_items_tb`
--

INSERT INTO `order_items_tb` (`id`, `productid`, `product_qty`, `order_id`, `uid`) VALUES
(9, '101', '1', '21', '58'),
(10, '100', '1', '21', '58'),
(11, '100', '1', '22', '58'),
(12, '101', '1', '23', '58'),
(13, '102', '1', '23', '58'),
(14, '100', '2', '23', '58'),
(15, '103', '1', '23', '58');

-- --------------------------------------------------------

--
-- Table structure for table `order_tb`
--

CREATE TABLE `order_tb` (
  `order_id` int(255) NOT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order_date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total_amt` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `order_tb`
--

INSERT INTO `order_tb` (`order_id`, `uid`, `order_date`, `total_amt`) VALUES
(21, '58', '14/02/2023', 'gg'),
(22, '58', '14/02/2023', '70.0'),
(23, '58', '14/02/2023', '150.0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer_payment`
--
ALTER TABLE `customer_payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_registration`
--
ALTER TABLE `customer_registration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cust_cart_product`
--
ALTER TABLE `cust_cart_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `merchant_add_product`
--
ALTER TABLE `merchant_add_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `merchant_registration`
--
ALTER TABLE `merchant_registration`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items_tb`
--
ALTER TABLE `order_items_tb`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_tb`
--
ALTER TABLE `order_tb`
  ADD PRIMARY KEY (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer_payment`
--
ALTER TABLE `customer_payment`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `customer_registration`
--
ALTER TABLE `customer_registration`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `cust_cart_product`
--
ALTER TABLE `cust_cart_product`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;

--
-- AUTO_INCREMENT for table `merchant_add_product`
--
ALTER TABLE `merchant_add_product`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

--
-- AUTO_INCREMENT for table `merchant_registration`
--
ALTER TABLE `merchant_registration`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `order_items_tb`
--
ALTER TABLE `order_items_tb`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `order_tb`
--
ALTER TABLE `order_tb`
  MODIFY `order_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
