-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2018 at 02:50 AM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `online`
--

-- --------------------------------------------------------

--
-- Table structure for table `accountdetails`
--

CREATE TABLE IF NOT EXISTS `accountdetails` (
  `accountno` bigint(15) NOT NULL,
  `custmid` int(10) NOT NULL,
  `accountstatus` varchar(10) NOT NULL,
  `opendate` varchar(12) NOT NULL,
  `type` varchar(10) NOT NULL,
  `accbalance` double(10,2) NOT NULL,
  `ifsc` varchar(15) NOT NULL,
  `transpass` int(6) NOT NULL,
  `aadharr` bigint(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accountdetails`
--

INSERT INTO `accountdetails` (`accountno`, `custmid`, `accountstatus`, `opendate`, `type`, `accbalance`, `ifsc`, `transpass`, `aadharr`) VALUES
(1205941580, 19493, 'active', '', 'saving', 0.00, 'SRI0000246', 0, 6543217890),
(1213141516, 54321, 'active', '', 'saving', 400.00, 'SRI0000246', 12345, 2345678901),
(1628338383, 40152, 'active', '', 'saving', 0.00, 'SRI0000246', 0, 3456789012),
(2223242526, 31522, 'active', '', 'saving', 3600.00, 'SRI0000246', 12345, 4456789012),
(3294099481, 50064, 'active', '', 'saving', 0.00, 'SRI0000246', 0, 76543245678),
(5490536819, 52755, 'active', '', 'saving', 0.00, 'SRI0000246', 0, 0),
(5686928388, 75684, 'active', '', 'saving', 0.00, 'SRI0000246', 0, 56778912345),
(5962408528, 76839, 'active', '', 'saving', 0.00, 'SRI0000246', 0, 9862341234567),
(7995852993, 76815, 'active', '', 'saving', 0.00, 'SRI0000246', 0, 545789621);

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE IF NOT EXISTS `branches` (
  `ifsc` varchar(15) NOT NULL,
  `address` varchar(30) NOT NULL,
  `city` text NOT NULL,
  `pin` int(11) NOT NULL,
  `district` text NOT NULL,
  `contact` bigint(11) NOT NULL,
  `state` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`ifsc`, `address`, `city`, `pin`, `district`, `contact`, `state`) VALUES
('SRI0000246', 'ascfd', 'kakinada', 123, 'EGDT', 9876543214, 'Andhra Pradesh'),
('SRI0000578', 'werf', 'Rajahmundry', 533101, 'EGDT', 8426795465, 'Andhra Pradesh');

-- --------------------------------------------------------

--
-- Table structure for table `custmdetails`
--

CREATE TABLE IF NOT EXISTS `custmdetails` (
  `custmid` int(10) NOT NULL,
  `loginid` varchar(30) NOT NULL,
  `password` varchar(10) NOT NULL,
  `status` text NOT NULL,
  `transpass` int(6) NOT NULL,
  `aadhar` decimal(15,0) NOT NULL,
  `ifsc` varchar(15) NOT NULL,
  `value` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `custmdetails`
--

INSERT INTO `custmdetails` (`custmid`, `loginid`, `password`, `status`, `transpass`, `aadhar`, `ifsc`, `value`) VALUES
(19493, '145876', '06-06-1995', 'active', 0, '6543217890', 'SRI0000246', 0),
(40152, '959575', '13-08-1992', 'active', 0, '3456789012', 'SRI0000246', 0),
(50064, '899183', '34-78', 'active', 0, '76543245678', 'SRI0000246', 0),
(52755, '860361', '06/06/1997', 'active', 0, '0', 'SRI0000246', 0),
(54321, 'sai@sri.com', 'sai123', 'active', 12345, '2345678901', 'SRI0000246', 0),
(65110, '207913', '20-20-2018', 'active', 0, '1234567890', 'SRI0000246', 0),
(75684, '143967', '8-56-1339', 'active', 0, '56778912345', 'SRI0000246', 0),
(76815, '779658', '13-08-2000', 'active', 0, '545789621', 'SRI0000246', 0),
(76839, '607619', '19-05-1997', 'active', 0, '9862341234567', 'SRI0000246', 0);

-- --------------------------------------------------------

--
-- Table structure for table `details`
--

CREATE TABLE IF NOT EXISTS `details` (
  `rollno` int(10) DEFAULT NULL,
  `name` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `employeedetails`
--

CREATE TABLE IF NOT EXISTS `employeedetails` (
`id` int(100) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `dof` varchar(15) NOT NULL,
  `phone` bigint(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `aadhar` bigint(15) NOT NULL,
  `birthplace` varchar(20) NOT NULL,
  `martialstatus` varchar(15) NOT NULL,
  `address` varchar(30) NOT NULL,
  `city` varchar(15) NOT NULL,
  `state` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employeedetails`
--

INSERT INTO `employeedetails` (`id`, `first_name`, `last_name`, `dof`, `phone`, `email`, `aadhar`, `birthplace`, `martialstatus`, `address`, `city`, `state`) VALUES
(1, 'sai', 'yashwanth', '06-06-1997', 897456248, 'sai@gmail.com', 1234525789526, 'rjy', 'single', 'xxcccyyy', 'rjy', 'ap');

-- --------------------------------------------------------

--
-- Table structure for table `employeelogin`
--

CREATE TABLE IF NOT EXISTS `employeelogin` (
  `empid` int(20) NOT NULL,
  `loginid` varchar(10) NOT NULL,
  `password` int(15) NOT NULL,
  `aadhar` bigint(16) NOT NULL,
  `ifsc` varchar(10) NOT NULL,
  `role` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employeelogin`
--

INSERT INTO `employeelogin` (`empid`, `loginid`, `password`, `aadhar`, `ifsc`, `role`) VALUES
(99099, '123456', 1234, 1234525789526, 'SRI0000246', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `registerdmem`
--

CREATE TABLE IF NOT EXISTS `registerdmem` (
`id` int(10) NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `father_name` text NOT NULL,
  `dof` varchar(13) NOT NULL,
  `phone` int(11) NOT NULL,
  `city` text NOT NULL,
  `pin` int(10) NOT NULL,
  `district` text NOT NULL,
  `state` text NOT NULL,
  `martialstatus` varchar(22) NOT NULL,
  `pan` varchar(15) NOT NULL,
  `aadhar` bigint(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `accstatus` varchar(15) NOT NULL,
  `address` varchar(225) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `country` varchar(225) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `registerdmem`
--

INSERT INTO `registerdmem` (`id`, `first_name`, `last_name`, `father_name`, `dof`, `phone`, `city`, `pin`, `district`, `state`, `martialstatus`, `pan`, `aadhar`, `email`, `accstatus`, `address`, `date`, `country`) VALUES
(1, 'somavarapu sai', 'sai yashwanth', 'vasu', '06-06-1995', 1234567890, 'East Godavari', 533101, 'egst', 'AP', 'single', '1234567890', 2345678901, 'saikkdyashwanth@gmail.com', 'ACCEPTED', 'hsb sf dcdb   saiuashwanthnhjsd ', '2018-02-06 15:53:23', 'India'),
(2, 'sai', 'kiran', 'srnivas', '20-20-2018', 2147483647, 'rangampeta', 533101, 'EST', 'AP', 'single', 'pan1234567', 1234567890, 'saikkdyashwanth@gmail.com', 'Accept', '', '2018-02-06 15:53:23', 'India'),
(3, 'vissu', 'potti', 'vissu father', '', 703554488, 'kkd', 533434, 'EGST', 'AP', 'single', '7896541230', 545789621, 'saikkdyashwanth@gmail.com', 'accept', '', '2018-02-06 15:53:23', 'India'),
(4, 'laljan', 'sk', 'hassain', '13-08-1992', 1234567891, 'kkd', 533210, 'EGST', 'Ap', 'single', '3456789012', 3456789012, 'saikkdyashwanth@gmail.com', 'accept', '', '2018-02-09 05:57:58', ''),
(5, 'sai', 'lam', 'vasan', '06-06-1995', 2147483647, 'qwe', 1234456, 'werthgfd', 'fghjhgfd', 'single', '234567890987654', 6543217890, 'saikkdyashwanth@gmail.com', 'accept', '', '2018-02-14 15:30:47', ''),
(7, 'sai', 'hmjk', 'dfghj', '8-56-1339', 45796321, 'ertyuj', 0, 'dfghjk', 'single', 'single', 'wertyu345678', 56778912345, 'saikkdyashwanth@gmail.com', 'accept', '', '2018-02-14 16:19:09', ''),
(8, 'kiran', 'nethi', 'srinivas', '19-05-1997', 2147483647, 'ragangampeta', 533101, 'egst', 'ap', 'single', 'pan123456789', 9862341234567, 'saikkdyashwanth@gmail.com', 'accept', '', '2018-02-14 16:22:19', ''),
(9, 'ertyuj', 'ertyu', 'ertyui', '34-78', 1234567890, 'wert', 0, 'wertyu', 'asdf', 'single', '234567890', 76543245678, 'saikkdyashwanth@gmail.com', 'accept', '', '2018-02-15 15:46:29', ''),
(10, 'sai', 'yashwanth', 'vasudevarao', '06/06/1997', 106923989, 'rajahmndry', 533101, 'east godavari', 'Andhra Pradesh', 'single', 'pan2345678', 0, 'saikkdyashwanth@gmail.com', 'accept', '', '2018-03-11 13:39:33', ''),
(11, 'sai', 'sai', 'vasu', '20-06-1997', 2147483647, 'rjy', 533101, 'egst', 'ap', 'single', 'pan234567987', 2222221111111, 'saikkdyashwanth@gmail.com', 'NOT ACCEPTED', '', '2018-03-16 06:46:35', ''),
(12, 'sai', 'sowmya', 'kishore', '20-06-1997', 966813444, 'rjy', 533101, 'egst', 'Andhra Pradesh', 'single', 'pan12345675', 221145525552, '', 'NOT ACCEPTED', '', '2018-03-16 06:57:57', '');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `accountno` int(15) NOT NULL,
`transid` int(15) NOT NULL,
  `date` varchar(12) NOT NULL,
  `purpose` text NOT NULL,
  `widthdraw` double(10,2) NOT NULL,
  `credited` double(10,2) NOT NULL,
  `status` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`accountno`, `transid`, `date`, `purpose`, `widthdraw`, `credited`, `status`) VALUES
(2147483647, 2, '', 'Bill', 500.00, 0.00, 'SUCCESS'),
(2147483647, 3, '', 'bill', 0.00, 500.00, 'SUCCESS'),
(2147483647, 4, '', 'Bill', 500.00, 0.00, 'SUCCESS'),
(2147483647, 5, '', 'bill', 0.00, 500.00, 'SUCCESS'),
(2147483647, 6, '', 'Bill', 500.00, 0.00, 'SUCCESS'),
(2147483647, 7, '', 'bill', 0.00, 500.00, 'SUCCESS'),
(2147483647, 8, '', 'Bill', 100.00, 0.00, 'SUCCESS'),
(2147483647, 9, '', 'bill', 0.00, 100.00, 'SUCCESS');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accountdetails`
--
ALTER TABLE `accountdetails`
 ADD PRIMARY KEY (`accountno`), ADD UNIQUE KEY `aadharr` (`aadharr`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
 ADD PRIMARY KEY (`ifsc`);

--
-- Indexes for table `custmdetails`
--
ALTER TABLE `custmdetails`
 ADD PRIMARY KEY (`custmid`), ADD UNIQUE KEY `aadhar` (`aadhar`);

--
-- Indexes for table `employeedetails`
--
ALTER TABLE `employeedetails`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `aadhar` (`aadhar`), ADD UNIQUE KEY `aadhar_2` (`aadhar`), ADD UNIQUE KEY `aadhar_3` (`aadhar`);

--
-- Indexes for table `employeelogin`
--
ALTER TABLE `employeelogin`
 ADD PRIMARY KEY (`aadhar`);

--
-- Indexes for table `registerdmem`
--
ALTER TABLE `registerdmem`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `aadhar` (`aadhar`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
 ADD PRIMARY KEY (`transid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employeedetails`
--
ALTER TABLE `employeedetails`
MODIFY `id` int(100) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `registerdmem`
--
ALTER TABLE `registerdmem`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
MODIFY `transid` int(15) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
