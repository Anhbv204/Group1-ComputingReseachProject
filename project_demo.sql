-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2021 at 05:15 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mvc_project`
--

-- --------------------------------------------------------

--
-- Database: healthtrackai

-- 1. Table: Users (store user information)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2. Table: HealthMetrics (store health-related metrics)
CREATE TABLE HealthMetrics (
    metric_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    weight DECIMAL(5, 2),        -- in kilograms
    height DECIMAL(5, 2),        -- in meters
    blood_pressure VARCHAR(10),  -- e.g., "120/80"
    heart_rate INT,              -- in bpm
    physical_activity_minutes INT, -- activity time per day
    sleep_hours DECIMAL(4, 2),   -- in hours
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- 3. Table: Admins (store admin information)
CREATE TABLE Admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 4. Table: User_Search_Log (log admin's search activities)
CREATE TABLE User_Search_Log (
    search_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT,
    search_term VARCHAR(100),
    search_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES Admins(admin_id) ON DELETE CASCADE
);

-- 5. Table: AI_Recommendations (store AI-generated recommendations)
CREATE TABLE AI_Recommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    recommendation_text TEXT,
    recommendation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- 6. Table: User_Sessions (track login sessions for security)
CREATE TABLE User_Sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    session_token VARCHAR(255) NOT NULL,
    login_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    logout_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- 7. Table: Activity_Logs (track system changes made by admins)
CREATE TABLE Activity_Logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT,
    action_taken TEXT NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES Admins(admin_id) ON DELETE CASCADE
);