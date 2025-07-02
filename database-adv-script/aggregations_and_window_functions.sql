-- Connect to database
\c airbnb
\x

-- Find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT
  users.user_id,
  users.first_name,
  users.last_name,
  COUNT(user_id) total_booking
FROM
  users
  INNER JOIN bookings USING(user_id)
GROUP BY
  users.user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT
  properties.property_id,
  properties.name,
  properties.description,
  properties.location,
  properties.price_per_night,
  COUNT(property_id) total_bookings,
  ROW_NUMBER() OVER (
    ORDER BY
      COUNT(property_id)
  ) property_row_rank,
  RANK() OVER (
    ORDER BY
      COUNT(property_id)
  ) property_rank
FROM
  properties
  INNER JOIN bookings USING (property_id)
GROUP BY
  property_id
ORDER BY
  total_bookings desc;
