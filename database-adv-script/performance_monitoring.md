# Monitor and Refine Database Performance

## Monitor performance of some queries

```sql
-- Find the total number of bookings made by each user
EXPLAIN ANALYZE
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
```
**Execution Time**: 0.222 ms

```sql
-- Retrieve all properties and their reviews, including properties that have no reviews
EXPLAIN ANALYZE
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
```
**Execution Time**: 0.257 ms

```sql
-- List the number of properties owned per users
EXPLAIN ANALYZE 
SELECT
  users.user_id,
  users.first_name,
  users.last_name, COUNT(user_id) owned_properties
FROM
  properties
  INNER JOIN users ON users.user_id = properties.host_id
GROUP BY
  user_id;
```
**Execution Time**: 0.213 ms

## Improvements

Most queries perform well. Execution time can be reduced by creating indexes on columns used to filter and group query results. Partitioning tables with a lot of records can speed up information retrieval.

