-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2024 at 08:55 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_barang`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_keluar` int(10) NOT NULL,
  `nama_barang` varchar(30) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `jumlah_keluar` varchar(30) NOT NULL,
  `id_masuk` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_keluar`, `nama_barang`, `tanggal_keluar`, `jumlah_keluar`, `id_masuk`) VALUES
(120, 'Pensil', '2023-08-04', '125', NULL),
(123, 'pulpen', '2023-08-02', '125', NULL),
(125, 'spidol', '2023-08-01', '12', NULL),
(126, 'pensil', '2023-08-02', '33', NULL),
(127, 'Kertas', '2023-08-03', '10', NULL),
(128, 'Kertas', '2023-08-03', '10', NULL),
(129, 'Kertas', '2023-08-03', '15', NULL),
(130, 'Kertas', '2023-08-03', '15', NULL),
(131, 'Kertas', '2023-08-03', '10', NULL),
(132, 'Kertas', '2023-08-03', '10', NULL),
(145, 'Botol', '2023-08-03', '129', NULL),
(146, 'Pulpen', '2023-08-03', '15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_masuk` int(10) NOT NULL,
  `nama_barang` varchar(30) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `jumlah_masuk` varchar(30) NOT NULL,
  `status` enum('belum_keluar','sudah_keluar') DEFAULT 'belum_keluar'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_masuk`, `nama_barang`, `tanggal_masuk`, `jumlah_masuk`, `status`) VALUES
(123, 'Pensil', '2023-08-03', '19', 'belum_keluar'),
(124, 'Kertas', '2023-08-03', '10', 'belum_keluar');

--
-- Triggers `barang_masuk`
--
DELIMITER $$
CREATE TRIGGER `move_to_barang_keluar` AFTER DELETE ON `barang_masuk` FOR EACH ROW BEGIN
    IF OLD.status = 'belum_keluar' THEN
        INSERT INTO barang_keluar (nama_barang, tanggal_keluar, jumlah_keluar)
        VALUES (OLD.nama_barang, OLD.tanggal_masuk, OLD.jumlah_masuk);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tabel_user`
--

CREATE TABLE `tabel_user` (
  `id` int(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tabel_user`
--

INSERT INTO `tabel_user` (`id`, `username`, `password`) VALUES
(123, 'admin', '123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`id_keluar`),
  ADD KEY `fk_barang_keluar_id_masuk` (`id_masuk`);

--
-- Indexes for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_masuk`);

--
-- Indexes for table `tabel_user`
--
ALTER TABLE `tabel_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  MODIFY `id_keluar` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  MODIFY `id_masuk` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `tabel_user`
--
ALTER TABLE `tabel_user`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `fk_barang_keluar_id_masuk` FOREIGN KEY (`id_masuk`) REFERENCES `barang_masuk` (`id_masuk`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
