-- 1. Create/Reset Database
CREATE DATABASE IF NOT EXISTS spiderverse_chronicle;
USE spiderverse_chronicle;

-- Disable foreign key checks to allow dropping tables freely
SET FOREIGN_KEY_CHECKS = 0;

-- ==========================================
-- 2. Create Tables (Based on your new Diagram)
-- ==========================================

-- Table: decades
-- Matches the "decades" box in your image
DROP TABLE IF EXISTS `decades`;
CREATE TABLE `decades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `year` INT NOT NULL,              -- Changed from 'decade' string to 'year' integer per diagram
  `decade_summary` TEXT,
  `character_summary` TEXT,         -- New column to hold character info
  `comic_id` INT,                   -- Optional: Can link to a "featured" comic
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: comics
-- Matches the "comics" box in your image
DROP TABLE IF EXISTS `comics`;
CREATE TABLE `comics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `decade_id` INT,                  -- Added to link this comic to a decade (Required for 1-to-Many)
  `title` VARCHAR(255),
  `image_filepath` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`decade_id`) REFERENCES `decades`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================
-- 3. Insert Sample Data (The 1960s)
-- ==========================================

-- Insert 1960s Data into 'decades'
INSERT INTO `decades` (`year`, `decade_summary`, `character_summary`) VALUES 
(1960, 
 'The 1960s marked the birth of Spider-Man. Created by Stan Lee and Steve Ditko, Peter Parker first appeared in Amazing Fantasy #15 (1962). This era defined the core mythos: the spider bite, the tragic death of Uncle Ben, and the lesson that with great power comes great responsibility.',
 'Key Characters: Spider-Man (Peter Parker), Uncle Ben, Aunt May, J. Jonah Jameson, Green Goblin, and Doctor Octopus.'
);

-- Insert Comics (Linked to the 1960s decade we just created, assumed ID=1)
INSERT INTO `comics` (`decade_id`, `title`, `image_filepath`) VALUES 
(1, 'Amazing Fantasy #15', '/assets/covers/amazing_fantasy_15.jpg'),
(1, 'The Amazing Spider-Man #1', '/assets/covers/amazing_spiderman_1.jpg'),
(1, 'The Amazing Spider-Man #50', '/assets/covers/amazing_spiderman_50.jpg');
