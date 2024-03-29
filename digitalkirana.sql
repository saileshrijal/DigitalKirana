-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 30, 2023 at 10:42 AM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `digitalkirana`
--

-- --------------------------------------------------------

--
-- Table structure for table `auto_generated_number`
--

DROP TABLE IF EXISTS `auto_generated_number`;
CREATE TABLE IF NOT EXISTS `auto_generated_number` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(100) NOT NULL,
  `Number` int NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `autoGeneratedNumber_ibfk_1` (`TenantId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auto_generated_number`
--

INSERT INTO `auto_generated_number` (`Id`, `Type`, `Number`, `TenantId`) VALUES
(6, 'SalesBill', 16, 7),
(7, 'SalesBill', 0, 8),
(8, 'SalesBill', 0, 9);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(50) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `CreatedAt` date NOT NULL,
  `UserId` int NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `category_ibfk_1` (`TenantId`),
  KEY `category_ibfk_2` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`Id`, `CategoryName`, `Description`, `CreatedAt`, `UserId`, `TenantId`) VALUES
(4, 'Cigaratte', 'Products related to cigaratte', '2023-05-28', 11, 7),
(5, 'Soft Drink', 'Products related to soft drink', '2023-05-28', 11, 7),
(6, 'Sweet', 'Products related to sweet', '2023-05-28', 11, 7),
(7, 'Noodles', 'Products related to noodles', '2023-05-28', 11, 7),
(8, 'Chips', 'Products related to chips', '2023-05-28', 11, 7),
(9, 'dry fruits', 'kismis', '2023-05-29', 11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(50) NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `CreatedAt` date NOT NULL,
  `UserId` int NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `customer_ibfk_1` (`TenantId`),
  KEY `customer_ibfk_2` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Id`, `CustomerName`, `Phone`, `Email`, `Address`, `CreatedAt`, `UserId`, `TenantId`) VALUES
(3, 'Krishala Dangal', '987456321', 'krishala@gmail.com', 'Kakarvitta', '2023-05-28', 11, 7),
(4, 'Nirusha Pakwal', '987456321', 'nirusha@gmail.com', 'Birtamode', '2023-05-28', 11, 7),
(5, 'Albina Gurung', '987456321', 'albina@gmail.com', 'Birtamode', '2023-05-28', 11, 7),
(6, 'Arpana Poudel', '987456321', 'arpana@gmail.com', 'Birtamode', '2023-05-28', 11, 7),
(7, 'Sandesh Limbu', '987456321', 'sandesh@gmail.com', 'Budhasanti', '2023-05-28', 11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(50) NOT NULL,
  `ProductCode` varchar(50) NOT NULL,
  `Description` varchar(100) NOT NULL,
  `CategoryId` int NOT NULL,
  `CostPrice` decimal(18,2) NOT NULL,
  `SellingPrice` decimal(18,2) NOT NULL,
  `WholesalePrice` decimal(18,2) NOT NULL,
  `Unit` varchar(50) NOT NULL,
  `Quantity` int NOT NULL,
  `ImageUrl` varchar(100) NOT NULL,
  `MinimumQuantity` int NOT NULL,
  `MaximumQuantity` int NOT NULL,
  `CreatedAt` date NOT NULL,
  `UserId` int NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `product_ibfk_1` (`CategoryId`),
  KEY `product_ibfk_2` (`TenantId`),
  KEY `product_ibfk_3` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Id`, `ProductName`, `ProductCode`, `Description`, `CategoryId`, `CostPrice`, `SellingPrice`, `WholesalePrice`, `Unit`, `Quantity`, `ImageUrl`, `MinimumQuantity`, `MaximumQuantity`, `CreatedAt`, `UserId`, `TenantId`) VALUES
(7, 'Coca-Cola', '001', ' Coca-Cola ', 5, '90.00', '120.00', '100.00', 'pcs', 5, '2023-05-28-13-21-06.png', 20, 150, '2023-05-28', 11, 7),
(8, 'Fanta', '002', ' Fanta ', 5, '90.00', '120.00', '110.00', 'pcs', 20, '2023-05-28-13-22-13.png', 18, 100, '2023-05-28', 11, 7),
(9, 'Khukuri', '003', 'Khukuri Churot', 4, '120.00', '150.00', '130.00', 'pkt', 10, '2023-05-28-13-23-29.png', 50, 100, '2023-05-28', 11, 7),
(10, 'Shikhar', '004', 'Shikhar Churot', 4, '150.00', '200.00', '180.00', 'pkt', 70, '2023-05-28-13-24-21.png', 20, 80, '2023-05-28', 11, 7),
(11, 'Lays', '005', 'Lays', 8, '8.00', '10.00', '9.00', 'pkt', 210, '2023-05-28-13-25-19.png', 50, 200, '2023-05-28', 11, 7),
(12, 'Uncle Chips', '006', 'Uncle Chips', 8, '18.00', '20.00', '19.00', 'pkt', 160, '2023-05-28-13-26-09.png', 50, 200, '2023-05-28', 11, 7),
(13, 'Lacto Fun', '007', 'Lacto Fun', 6, '80.00', '100.00', '90.00', 'pkt', 140, '2023-05-28-13-30-19.png', 20, 100, '2023-05-28', 11, 7),
(14, 'Kit Kat', '008', 'Kit kat', 6, '40.00', '50.00', '45.00', 'pcs', 100, '2023-05-28-13-30-55.png', 10, 60, '2023-05-28', 11, 7),
(15, 'Jhapali Chips', '009', 'Jhapali Chips', 8, '40.00', '50.00', '43.00', 'pkt', 100, '2023-05-28-16-07-49.png', 10, 80, '2023-05-28', 11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
CREATE TABLE IF NOT EXISTS `purchase` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `BillNumber` varchar(100) NOT NULL,
  `SupplierId` int NOT NULL,
  `GrossTotal` decimal(18,2) NOT NULL,
  `Discount` decimal(18,2) NOT NULL,
  `Vat` decimal(18,2) NOT NULL,
  `NetTotal` decimal(18,2) NOT NULL,
  `TenderAmount` decimal(18,2) NOT NULL,
  `ReturnAmount` decimal(18,2) NOT NULL,
  `Remarks` varchar(100) NOT NULL,
  `CreatedAt` date NOT NULL,
  `UserId` int NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `purchase_ibfk_1` (`SupplierId`),
  KEY `purchase_ibfk_2` (`TenantId`),
  KEY `purchase_ibfk_3` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`Id`, `BillNumber`, `SupplierId`, `GrossTotal`, `Discount`, `Vat`, `NetTotal`, `TenderAmount`, `ReturnAmount`, `Remarks`, `CreatedAt`, `UserId`, `TenantId`) VALUES
(9, '0001', 4, '7100.00', '10.00', '13.00', '7220.70', '8000.00', '779.30', 'Purchase from Binayak Dhimal', '2023-05-28', 11, 7),
(10, '0002', 5, '10000.00', '10.00', '13.00', '10170.00', '10200.00', '30.00', 'Purchase from Nirjan Pathak', '2023-05-28', 11, 7),
(11, '0003', 7, '1240.00', '10.00', '13.00', '1261.08', '1300.00', '38.92', 'Purchase from Kushal', '2023-05-28', 13, 7),
(12, '0004', 8, '4200.00', '10.00', '13.00', '4271.40', '5000.00', '728.60', 'Purchase from Pujan Acharya', '2023-05-28', 13, 7),
(13, '002', 6, '1060.00', '10.00', '13.00', '1078.02', '1100.00', '21.98', 'Purchase from dipu', '2023-05-28', 13, 7),
(14, '0001', 7, '1100.00', '10.00', '13.00', '1118.70', '1200.00', '81.30', 'purchase', '2023-05-29', 11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_details`
--

DROP TABLE IF EXISTS `purchase_details`;
CREATE TABLE IF NOT EXISTS `purchase_details` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `PurchaseId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Rate` decimal(18,2) NOT NULL,
  `Quantity` int NOT NULL,
  `TotalAmount` decimal(18,2) NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `purchase_details`
--

INSERT INTO `purchase_details` (`Id`, `PurchaseId`, `ProductId`, `Rate`, `Quantity`, `TotalAmount`, `TenantId`) VALUES
(13, 9, 7, '90.00', 20, '1800.00', 7),
(14, 9, 8, '90.00', 10, '900.00', 7),
(15, 9, 11, '8.00', 50, '400.00', 7),
(16, 9, 13, '80.00', 50, '4000.00', 7),
(17, 10, 12, '20.00', 50, '1000.00', 7),
(18, 10, 13, '100.00', 50, '5000.00', 7),
(19, 10, 10, '200.00', 20, '4000.00', 7),
(20, 11, 14, '50.00', 10, '500.00', 7),
(21, 11, 11, '10.00', 50, '500.00', 7),
(22, 11, 8, '120.00', 2, '240.00', 7),
(23, 12, 12, '20.00', 50, '1000.00', 7),
(24, 12, 14, '50.00', 40, '2000.00', 7),
(25, 12, 7, '120.00', 10, '1200.00', 7),
(26, 13, 11, '10.00', 6, '60.00', 7),
(27, 13, 14, '50.00', 20, '1000.00', 7),
(28, 14, 11, '10.00', 110, '1100.00', 7);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
CREATE TABLE IF NOT EXISTS `sales` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `BillNumber` varchar(100) NOT NULL,
  `CustomerId` int DEFAULT NULL,
  `GrossTotal` decimal(18,2) NOT NULL,
  `Discount` decimal(18,2) NOT NULL,
  `Vat` decimal(18,2) NOT NULL,
  `NetTotal` decimal(18,2) NOT NULL,
  `TenderAmount` decimal(18,2) NOT NULL,
  `ReturnAmount` decimal(18,2) NOT NULL,
  `Remarks` varchar(200) NOT NULL,
  `CreatedAt` date NOT NULL,
  `UserId` int NOT NULL,
  `TenantId` int NOT NULL,
  `CustomerName` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `sales_ibfk_2` (`TenantId`),
  KEY `sales_ibfk_3` (`UserId`),
  KEY `sales_ibfk_1` (`CustomerId`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`Id`, `BillNumber`, `CustomerId`, `GrossTotal`, `Discount`, `Vat`, `NetTotal`, `TenderAmount`, `ReturnAmount`, `Remarks`, `CreatedAt`, `UserId`, `TenantId`, `CustomerName`) VALUES
(18, '1', 5, '18000.00', '10.00', '13.00', '18306.00', '20000.00', '1694.00', 'Sold to Albina Gurung', '2023-05-28', 13, 7, 'Albina Gurung'),
(19, '2', 3, '3200.00', '10.00', '13.00', '3254.40', '4000.00', '745.60', 'Sold to Krishala', '2023-05-28', 13, 7, 'Krishala Dangal'),
(20, '3', 7, '10500.00', '10.00', '13.00', '10678.50', '11000.00', '321.50', 'Sold to Sandesh Limbu', '2023-05-28', 11, 7, 'Sandesh Limbu'),
(22, '4', 4, '5000.00', '10.00', '13.00', '5085.00', '3000.00', '0.00', 'Sold to Suman', '2023-05-28', 11, 7, 'Suman Sitaula'),
(54, '11', NULL, '20.00', '10.00', '13.00', '20.34', '30.00', '9.66', '', '2023-05-28', 11, 7, 'Supreme Rijal'),
(55, '12', NULL, '1530.00', '10.00', '13.00', '1556.01', '1600.00', '43.99', 'Sold to Shisir', '2023-05-28', 14, 7, 'Shishir'),
(56, '13', 6, '3600.00', '10.00', '13.00', '3661.20', '4000.00', '338.80', 'Sold', '2023-05-28', 14, 7, 'Arpana Poudel'),
(57, '14', NULL, '1200.00', '10.00', '13.00', '1220.40', '1300.00', '79.60', 'sold', '2023-05-29', 11, 7, 'ram'),
(58, '15', NULL, '7000.00', '10.00', '13.00', '7119.00', '8000.00', '881.00', 'Sold to new Customer', '2023-05-30', 11, 7, 'New Customer'),
(59, '16', 6, '1500.00', '10.00', '13.00', '1525.50', '2000.00', '474.50', 'Sold to arpana', '2023-05-30', 11, 7, 'Arpana Poudel');

-- --------------------------------------------------------

--
-- Table structure for table `sales_details`
--

DROP TABLE IF EXISTS `sales_details`;
CREATE TABLE IF NOT EXISTS `sales_details` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `SalesId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Rate` decimal(18,2) NOT NULL,
  `Quantity` int NOT NULL,
  `TotalAmount` decimal(18,2) NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `salesDetails_ibfk_1` (`ProductId`),
  KEY `salesDetails_ibfk_2` (`SalesId`),
  KEY `salesDetails_ibfk_3` (`TenantId`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sales_details`
--

INSERT INTO `sales_details` (`Id`, `SalesId`, `ProductId`, `Rate`, `Quantity`, `TotalAmount`, `TenantId`) VALUES
(24, 18, 7, '120.00', 100, '12000.00', 7),
(25, 18, 10, '200.00', 20, '4000.00', 7),
(26, 18, 12, '20.00', 100, '2000.00', 7),
(27, 19, 8, '120.00', 10, '1200.00', 7),
(28, 19, 11, '10.00', 100, '1000.00', 7),
(29, 19, 14, '50.00', 20, '1000.00', 7),
(30, 20, 9, '150.00', 50, '7500.00', 7),
(31, 20, 7, '120.00', 25, '3000.00', 7),
(32, 22, 13, '100.00', 50, '5000.00', 7),
(39, 54, 11, '10.00', 2, '20.00', 7),
(40, 55, 9, '150.00', 10, '1500.00', 7),
(41, 55, 11, '10.00', 3, '30.00', 7),
(42, 56, 8, '120.00', 30, '3600.00', 7),
(43, 57, 9, '120.00', 10, '1200.00', 7),
(44, 58, 13, '100.00', 50, '5000.00', 7),
(45, 58, 10, '200.00', 10, '2000.00', 7),
(46, 59, 9, '150.00', 10, '1500.00', 7);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE IF NOT EXISTS `supplier` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `SupplierName` varchar(50) NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `CreatedAt` date NOT NULL,
  `UserId` int NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `supplier_ibfk_1` (`TenantId`),
  KEY `supplier_ibfk_2` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`Id`, `SupplierName`, `Phone`, `Email`, `Address`, `CreatedAt`, `UserId`, `TenantId`) VALUES
(4, 'Binayak Dhimal', '987456321', 'binayak@gmail.com', 'Birtamode', '2023-05-28', 11, 7),
(5, 'Nirjan Pathak', '987456321', 'nirjanpathak@gmail.com', 'Birtamode', '2023-05-28', 11, 7),
(6, 'Dipu Oli', '987456321', 'dipu@gmail.com', 'Rajgad', '2023-05-28', 11, 7),
(7, 'Kushal Dangal', '987456321', 'kushal@gmail.com', 'Kakarvitta', '2023-05-28', 11, 7),
(8, 'Pujan Acharya', '987456321', 'pujan@gmail.com', 'Birtamode', '2023-05-28', 11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `supplier_products`
--

DROP TABLE IF EXISTS `supplier_products`;
CREATE TABLE IF NOT EXISTS `supplier_products` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ProductId` int NOT NULL,
  `SupplierId` int NOT NULL,
  `TenantId` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `supplier_products_ibfk_2` (`SupplierId`),
  KEY `supplier_products_ibfk_3` (`TenantId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `supplier_products`
--

INSERT INTO `supplier_products` (`Id`, `ProductId`, `SupplierId`, `TenantId`) VALUES
(6, 7, 4, 7),
(7, 8, 4, 7),
(8, 11, 4, 7),
(9, 13, 4, 7),
(10, 12, 5, 7),
(11, 13, 5, 7),
(12, 10, 5, 7),
(13, 14, 7, 7),
(14, 11, 7, 7),
(15, 8, 7, 7),
(16, 12, 8, 7),
(17, 14, 8, 7),
(18, 7, 8, 7),
(19, 11, 6, 7),
(20, 14, 6, 7);

-- --------------------------------------------------------

--
-- Table structure for table `tenants`
--

DROP TABLE IF EXISTS `tenants`;
CREATE TABLE IF NOT EXISTS `tenants` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `CreatedAt` date NOT NULL,
  `Status` varchar(50) NOT NULL,
  `LogoUrl` varchar(200) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tenants`
--

INSERT INTO `tenants` (`Id`, `Name`, `Email`, `Phone`, `Address`, `CreatedAt`, `Status`, `LogoUrl`) VALUES
(7, 'S.R Tech Pvt. Ltd.', 'srtech@gmail.com', '9863714503', 'Kakarvitta', '2023-05-28', 'Accepted', '2023-05-28-12-31-47.png'),
(8, 'NP Tech Pvt. Ltd.', 'nirjanpathak@gmail.com', '987456321', 'Birtamode', '2023-05-28', 'Rejected', ''),
(9, 'KD Group Pvt. Ltd', 'kushal@gmail.com', '9874563211', 'Kakarvitta', '2023-05-28', 'Pending', '');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `PasswordHash` varchar(200) NOT NULL,
  `Status` tinyint(1) NOT NULL DEFAULT '1',
  `CreatedAt` date NOT NULL,
  `Role` varchar(50) NOT NULL,
  `TenantId` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `tenant_ibfk_1` (`TenantId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Id`, `FirstName`, `LastName`, `Email`, `Phone`, `Address`, `Username`, `PasswordHash`, `Status`, `CreatedAt`, `Role`, `TenantId`) VALUES
(10, 'Super', 'Admin', 'super.admin@gmail.com', '', '', 'super.admin', '$2y$10$09dau6uBdHXkGC01R1DatOkY8qZnX0s3KluL6UMnQc/llfRsU4Wc.', 1, '2023-05-28', 'Admin', NULL),
(11, 'Sailesh', 'Rijal', 'saileshrijal1@gmail.com', '9863714503', 'Kakarvitta', 'saileshrijal', '$2y$10$vUHv.WwMmrvd3lf6eFONsukdEHKgeRU7jsuqYbybnxkBLZlQtT00.', 1, '2023-05-28', 'Admin', 7),
(12, 'Nirjan', 'Pathak', 'nirjanpathak@gmail.com', '987456321', 'Birtamode', 'nirjanpathak', '$2y$10$jzzne5L37s1x2YrnZ3P1vOkoJ99ucndbBkl5ss0lUEnHwSX01RQfG', 1, '2023-05-28', 'Admin', 8),
(13, 'Muna', 'Uprety', 'muna@gmail.com', '9874563211', 'Charali', 'munauprety', '$2y$10$lPSIvZtlAeHiWVxxyuePXunK0v8GYTVpnwPL8hEqS27yz9VtIT98G', 1, '2023-05-28', 'User', 7),
(14, 'Pranisha', 'Thapa', 'pranisha@gmail.com', '9874563211', 'Kakarvitta', 'pranisha', '$2y$10$hZT5M3d8EwNx7pZB3dXxyenJE7hwVzCjKbbeyOQV9U.mSvD6ZBlkC', 1, '2023-05-28', 'SalesPerson', 7),
(15, 'Kushal', 'Dangal', 'kushal@gmail.com', '9874563211', 'Kakarvitta', 'kushal', '$2y$10$P2HCsV7wRbU72ArrW.0KrO8BGD5NTkLPmrKVQdcFXxocf6lyn71ge', 1, '2023-05-28', 'Admin', 9);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auto_generated_number`
--
ALTER TABLE `auto_generated_number`
  ADD CONSTRAINT `autoGeneratedNumber_ibfk_1` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `category_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`CategoryId`) REFERENCES `category` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `product_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`SupplierId`) REFERENCES `supplier` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `purchase_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `sales_details`
--
ALTER TABLE `sales_details`
  ADD CONSTRAINT `salesDetails_ibfk_1` FOREIGN KEY (`ProductId`) REFERENCES `product` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `salesDetails_ibfk_2` FOREIGN KEY (`SalesId`) REFERENCES `sales` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `salesDetails_ibfk_3` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
  ADD CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `supplier_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `supplier_products`
--
ALTER TABLE `supplier_products`
  ADD CONSTRAINT `supplier_products_ibfk_2` FOREIGN KEY (`SupplierId`) REFERENCES `supplier` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `supplier_products_ibfk_3` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `tenant_ibfk_1` FOREIGN KEY (`TenantId`) REFERENCES `tenants` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
