-- Lab 1: Books Read Tracker
--Author: Muhammad Anees
--Date: feb-24-2026
-- Create table 
CREATE TABLE books_read (
book_id SERIAL PRIMARY KEY,
title VARCHAR(200) NOT NULL,
author VARCHAR(100) NOT NULL,
category VARCHAR(50),
pages INTEGER CHECK (pages > 0),
date_finished DATE,
rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 5.0),
notes TEXT
);
-- Insert sample data
INSERT INTO books_read (title, author, category, pages, date_finished, rating,
notes) VALUES
[('Python for Data Analysis', 'Wes McKinney', 'Data Science', 542, '2024-01-15', 4.5, 'Great pandas coverage'),
('Hands-On ML with Scikit-Learn', 'Aurélien Géron', 'Machine Learning', 851, '2024-02-20', 5.0, 'Best ML book'),
('Learning SQL', 'Alan Beaulieu', 'Databases', 348, '2024-02-28', 4.0, 'Solid fundamentals'),
('Deep Learning', 'Ian Goodfellow', 'Machine Learning', 775, '2024-04-10', 4.8, 'Dense but worth it'),
('Designing Data-Intensive Apps', 'Martin Kleppmann', 'Databases', 611, '2024-06-05', 4.9, 'Modern classic');];


