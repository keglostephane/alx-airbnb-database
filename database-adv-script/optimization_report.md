# Optimize Complex Queries

## Retrieve all bookings along with the user details, property details and payment details

```sql
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
  total_price DESC
```

## Query measurement

```sql
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
  total_price DESC
```
```sql
 Sort  (cost=51.04..51.82 rows=310 width=252) (actual time=0.216..0.224 rows=3 loops=1)
   Sort Key: bookings.total_price DESC
   Sort Method: quicksort  Memory: 25kB
   ->  Hash Join  (cost=17.42..38.21 rows=310 width=252) (actual time=0.181..0.194 rows=3 loops=1)
         Hash Cond: (payments.booking_id = bookings.booking_id)
         ->  Seq Scan on payments  (cost=0.00..17.80 rows=776 width=20) (actual time=0.029..0.032 rows=3 loops=1)
               Filter: (payment_method IS NOT NULL)
         ->  Hash  (cost=17.40..17.40 rows=2 width=248) (actual time=0.129..0.134 rows=5 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Nested Loop  (cost=1.09..17.40 rows=2 width=248) (actual time=0.070..0.116 rows=5 loops=1)
                     Join Filter: (bookings.property_id = properties.property_id)
                     Rows Removed by Join Filter: 20
                     ->  Seq Scan on properties  (cost=0.00..1.05 rows=5 width=112) (actual time=0.007..0.009 rows=5 loops=1)
                     ->  Materialize  (cost=1.09..16.20 rows=2 width=168) (actual time=0.012..0.017 rows=5 loops=5)
                           ->  Hash Join  (cost=1.09..16.20 rows=2 width=168) (actual time=0.050..0.064 rows=5 loops=1)
                                 Hash Cond: (users.user_id = bookings.user_id)
                                 ->  Seq Scan on users  (cost=0.00..13.70 rows=370 width=112) (actual time=0.006..0.008 rows=5 loops=1)
                                 ->  Hash  (cost=1.06..1.06 rows=2 width=88) (actual time=0.029..0.030 rows=5 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                       ->  Seq Scan on bookings  (cost=0.00..1.06 rows=2 width=88) (actual time=0.012..0.018 rows=5 loops=1)
                                             Filter: (status = ANY ('{confirmed,pending}'::status_enum[]))
 Planning Time: 1.360 ms
 Execution Time: 0.417 ms
(23 rows)
```

## Query performance analysis

* Sorting rows using quicksort algorithm took 75.84 ms
* the right join (payments.booking_id = bookings.booking_id) because we want to 
show users that book a property evenif they don't make a payment took 17.45 ms.

Overall, this query performs well. We can improve its performance by finding a way to reduce the time it takes to sort the query results by `total_price`.

## Query performance improvements

### Refactor Query

```sql
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
  INNER JOIN payments USING (booking_id)
ORDER BY
  total_price DESC
```

### Limit query result rows using WHERE, LIMIT 

### Create indexes to limit and order query result quickly

```sql
CREATE INDEX booking_total_price_idx ON bookings (total_price);

CREATE INDEX payment_method ON payments (payment_method);
```

**Execution Time (before optimization)**: 0.352 ms

**Execution Time (after optimization)**: 0.258 ms


