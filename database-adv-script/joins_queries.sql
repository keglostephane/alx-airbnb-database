-- Connect to the database
\c airbnb;

-- Retrieve all bookings and the respective users who made those bookings
SELECT
  bookings.booking_id,
  bookings.start_date,
  bookings.end_date,
  bookings.status,
  bookings.total_price,
  users.first_name,
  users.last_name
FROM
  bookings
  INNER JOIN users ON bookings.user_id = users.user_id
ORDER BY
  bookings.total_price DESC;

-- Retrieve all properties and their reviews, including properties that have no reviews
SELECT
  properties.property_id,
  properties.name,
  properties.description,
  properties.location,
  properties.price_per_night,
  reviews.rating,
  reviews.comment
FROM
  properties
  LEFT JOIN reviews USING (property_id)
ORDER BY
  reviews.rating DESC;

-- Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT
  users.user_id,
  users.first_name,
  users.last_name,
  bookings.status,
  bookings.start_date,
  bookings.end_date
FROM
  users
  FULL OUTER JOIN bookings USING (user_id);


