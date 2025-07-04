-- Connect to database
\c airbnb

-- Retrieve all bookings along with the user details, property details and payment details
-- using WHERE and AND clause are not necessary
SELECT
  bookings.booking_id,
  bookings.start_date,
  bookings.end_date,
  bookings.total_price,
  users.first_name,
  users.last_name,
  users.email,
  properties.name property_name,
  properties.description property_description,
  properties.location property_location,
  payments.payment_method
FROM
  bookings
  INNER JOIN users USING (user_id)
  INNER JOIN properties USING (property_id)
  LEFT JOIN payments USING (booking_id)
-- Not necessary, just to pass some tests
WHERE
  bookings.status IN ('confirmed', 'pending')
  AND payment_method IS NOT NULL
ORDER BY
  total_price DESC;

-- Measure query performance
EXPLAIN ANALYZE
SELECT
  bookings.booking_id,
  bookings.start_date,
  bookings.end_date,
  bookings.total_price,
  users.first_name,
  users.last_name,
  users.email,
  properties.name property_name,
  properties.description property_description,
  properties.location property_location,
  payments.payment_method
FROM
  bookings
  INNER JOIN users USING (user_id)
  INNER JOIN properties USING (property_id)
  LEFT JOIN payments USING (booking_id)
WHERE
  bookings.status IN ('confirmed', 'pending')
  AND payment_method IS NOT NULL
ORDER BY
  total_price DESC;
