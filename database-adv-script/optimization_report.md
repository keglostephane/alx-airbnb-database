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
ORDER BY
  total_price DESC
```
```sql
 Sort  (cost=75.84..77.79 rows=780 width=252) (actual time=0.193..0.197 rows=5 loops=1)
   Sort Key: bookings.total_price DESC
   Sort Method: quicksort  Memory: 26kB
   ->  Hash Right Join  (cost=17.45..38.37 rows=780 width=252) (actual time=0.138..0.148 rows=5 loops=1)
         Hash Cond: (payments.booking_id = bookings.booking_id)
         ->  Seq Scan on payments  (cost=0.00..17.80 rows=780 width=20) (actual time=0.003..0.003 rows=3 loops=1)
         ->  Hash  (cost=17.39..17.39 rows=5 width=248) (actual time=0.117..0.119 rows=5 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Hash Join  (cost=2.23..17.39 rows=5 width=248) (actual time=0.101..0.109 rows=5 loops=1)
                     Hash Cond: (bookings.property_id = properties.property_id)
                     ->  Hash Join  (cost=1.11..16.25 rows=5 width=168) (actual time=0.054..0.060 rows=5 loops=1)
                           Hash Cond: (users.user_id = bookings.user_id)
                           ->  Seq Scan on users  (cost=0.00..13.70 rows=370 width=112) (actual time=0.003..0.004 rows=5 loops=1)
                           ->  Hash  (cost=1.05..1.05 rows=5 width=88) (actual time=0.011..0.012 rows=5 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                 ->  Seq Scan on bookings  (cost=0.00..1.05 rows=5 width=88) (actual time=0.004..0.005 rows=5 loops=1)
                     ->  Hash  (cost=1.05..1.05 rows=5 width=112) (actual time=0.029..0.030 rows=5 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  Seq Scan on properties  (cost=0.00..1.05 rows=5 width=112) (actual time=0.014..0.016 rows=5 loops=1)
 Planning Time: 1.833 ms
 Execution Time: 0.352 ms
(21 rows)
```

## Query performance analysis

* Sorting rows using quicksort algorithm took 75.84 ms
* the right join (payments.booking_id = bookings.booking_id) because we want to 
show users that book a property evenif they don't make a payment took 17.45 ms.

Overall, this query performs well. We can improve its performance by finding a way to reduce the time it takes to sort the query results by `total_price`.

## Query performance improvement

To reduce time when sorting the query results by `total_price`, we can create
an index on `total_price` column of `bookings` table.

```sql
CREATE INDEX booking_total_price_idx ON bookings (total_price DESC);
```

**Execution Time (before optimization)**: 0.352 ms

**Execution Time (after optimization)**: 0.258 ms


