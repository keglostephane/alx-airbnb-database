-- Connect to the database
\c airbnb;

-- Seed Users Table (5 records)
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'John', 'Smith', 'john.smith@example.com', '$2a$10$E3ZTAOAdN7W8QN5U5YvJv.3XzVZQ1bH5J5vLhLf5Yr5Jd5K5Yb5W', '+1 (415) 555-2671', 'guest'),
('b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Emily', 'Johnson', 'emily.j@example.com', '$2a$10$L5P5Y5N5U5Y5vJv.3XzVZQ1bH5J5vLhLf5Yr5Jd5K5Yb5W3XzVZQ', '+1 (212) 555-4892', 'host'),
('c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Michael', 'Williams', 'michael.w@example.com', '$2a$10$N5U5Y5vJv.3XzVZQ1bH5J5vLhLf5Yr5Jd5K5Yb5W3XzVZQ1bH5J', '+1 (310) 555-7364', 'guest'),
('d3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Sarah', 'Brown', 'sarah.b@example.com', '$2a$10$Y5vJv.3XzVZQ1bH5J5vLhLf5Yr5Jd5K5Yb5W3XzVZQ1bH5J5vLh', '+1 (305) 555-9215', 'host'),
('e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'David', 'Jones', 'david.j@example.com', '$2a$10$vJv.3XzVZQ1bH5J5vLhLf5Yr5Jd5K5Yb5W3XzVZQ1bH5J5vLhLf', '+1 (503) 555-3486', 'guest');

-- Seed Properties Table (5 records)
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight) VALUES
('f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Cozy Downtown Apartment', 'Modern 1-bedroom apartment in the heart of the city with great views.', 'New York, NY', 189.99),
('f6eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Beachfront Villa', 'Luxury villa with private beach access and infinity pool.', 'Miami, FL', 425.50),
('f7eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Mountain Cabin Retreat', 'Rustic cabin with modern amenities nestled in the mountains.', 'Aspen, CO', 275.00),
('f8eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Lakeview Cottage', 'Charming cottage on the lake with private dock.', 'Lake Tahoe, CA', 225.75),
('f9eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Garden Studio', 'Bright studio with private garden in quiet neighborhood.', 'Portland, OR', 129.99);

-- Seed Bookings Table (5 records)
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '2023-06-15', '2023-06-20', 949.95, 'confirmed'),
('b2eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'f6eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '2023-07-01', '2023-07-08', 2978.50, 'confirmed'),
('c3eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 'f7eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', '2023-08-12', '2023-08-15', 825.00, 'pending'),
('d4eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 'f8eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '2023-09-05', '2023-09-10', 1128.75, 'confirmed'),
('e5eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 'f9eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', '2023-10-20', '2023-10-25', 649.95, 'pending');

-- Seed Payments Table (5 records)
INSERT INTO payments (payment_id, booking_id, amount, payment_method, payment_date) VALUES
('a6eebc99-9c0b-4ef8-bb6d-6bb9bd380a26', 'a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a21', 949.95, 'credit_card', '2023-05-20 14:32:45'),
('b7eebc99-9c0b-4ef8-bb6d-6bb9bd380a27', 'b2eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 2978.50, 'paypal', '2023-06-15 09:18:22'),
('c8eebc99-9c0b-4ef8-bb6d-6bb9bd380a28', 'c3eebc99-9c0b-4ef8-bb6d-6bb9bd380a23', 825.00, 'credit_card', '2023-07-28 16:45:33'),
('d9eebc99-9c0b-4ef8-bb6d-6bb9bd380a29', 'd4eebc99-9c0b-4ef8-bb6d-6bb9bd380a24', 1128.75, 'stripe', '2023-08-20 11:27:19'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a30', 'e5eebc99-9c0b-4ef8-bb6d-6bb9bd380a25', 649.95, 'paypal', '2023-09-30 13:52:07');

-- Seed Reviews Table (5 records)
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at) VALUES
('a1eebc99-9c0b-4ef8-bb6d-6bb9bd380a31', 'f5eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 5, 'Fantastic location and very clean apartment. Host was extremely responsive.', '2023-06-22 10:15:00'),
('b2eebc99-9c0b-4ef8-bb6d-6bb9bd380a32', 'f6eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 4, 'Beautiful villa, the beach access was amazing. Would have liked better kitchen equipment.', '2023-07-10 14:30:00'),
('c3eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'f7eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 5, 'Perfect mountain getaway! The cabin had everything we needed and more.', '2023-08-17 09:45:00'),
('d4eebc99-9c0b-4ef8-bb6d-6bb9bd380a34', 'f8eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 4, 'Lovely cottage with great views. The dock was perfect for morning coffee.', '2023-09-12 16:20:00'),
('e5eebc99-9c0b-4ef8-bb6d-6bb9bd380a35', 'f9eebc99-9c0b-4ef8-bb6d-6bb9bd380a20', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 3, 'Nice studio but smaller than expected. The garden was lovely though.', '2023-10-28 11:10:00');

-- Seed Messages Table (5 records)
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('a6eebc99-9c0b-4ef8-bb6d-6bb9bd380a36', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Hi, I was wondering if the apartment has parking available?', '2023-05-10 08:15:22'),
('b7eebc99-9c0b-4ef8-bb6d-6bb9bd380a37', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Yes, there is a parking spot included with the rental.', '2023-05-10 09:03:45'),
('c8eebc99-9c0b-4ef8-bb6d-6bb9bd380a38', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Is the villa pet friendly? We have a small dog.', '2023-06-20 14:25:33'),
('d9eebc99-9c0b-4ef8-bb6d-6bb9bd380a39', 'd3eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'c2eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Yes, we allow small pets with an additional $50 cleaning fee.', '2023-06-20 15:12:18'),
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380a40', 'e4eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'What time is check-in at the mountain cabin?', '2023-07-25 10:45:07');
