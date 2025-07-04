-- Connect to database
\c airbnb

-- Retrieve all bookings along with the user details, property details and payment details
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
ORDER BY
  total_price DESC;

-- Reduce sorting time of query results when sorting by `total_price`
CREATE INDEX booking_total_price_idx ON bookings (total_price DESC);
