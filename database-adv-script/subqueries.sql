-- Connect to database
\c airbnb;

-- Find all properties where the average rating is greater than 4.0 using a subquery.
SELECT
  *
FROM
  properties
WHERE
  properties.property_id IN (
    SELECT
      reviews.property_id
    FROM
      reviews
    WHERE
      reviews.rating IS NOT NULL
    GROUP BY
      reviews.property_id
    HAVING
      avg(reviews.rating) > 4.0
  );

-- Find users who have made more than 3 bookings using a correlated subquery
SELECT
  *
FROM
  users
WHERE
  (
    SELECT
      count(*)
    FROM
      bookings
    WHERE
      bookings.user_id = users.user_id
  ) = 2;
