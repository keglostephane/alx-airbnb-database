# Partitioning Large Tables

## Partition Bookings table based on the `start_date` column

```sql
-- CREATE a partitioned version of bookings table
CREATE TABLE bookings_partitioned (
    booking_id UUID,
    property_id UUID REFERENCES properties(property_id),
    user_id UUID REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status status_enum NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);
```

## Create some partitions

```sql
-- Bookings of June 2023
CREATE TABLE
  bookings_june_23 PARTITION OF bookings_partitioned FOR
VALUES
FROM
  ('2023-06-01') TO ('2023-07-01');
  
-- Bookings of July 2023
CREATE TABLE
  bookings_july_23 PARTITION OF bookings_partitioned FOR
VALUES
FROM
  ('2023-07-01') TO ('2023-08-01');
  
-- Bookings of August 2023
CREATE TABLE
  bookings_august_23 PARTITION OF bookings_partitioned FOR
VALUES
FROM
  ('2023-08-01') TO ('2023-09-01');
  
-- Bookings of September 2023
CREATE TABLE
  bookings_september_23 PARTITION OF bookings_partitioned FOR
VALUES
FROM
  ('2023-09-01') TO ('2023-10-01');

-- Bookings of October 2023
CREATE TABLE
  bookings_october_23 PARTITION OF bookings_partitioned FOR
VALUES
FROM
  ('2023-10-01') TO ('2023-11-01');
```

## Copy data from original bookings table to partitioned booking table

```sql
-- Insert data from original Bookings to partitioned Booking table
INSERT INTO
  bookings_partitioned
SELECT
  *
FROM
  bookings;
```

## Fetching some bookings

```sql
-- Fetching bookings for June 2023
SELECT
  *
FROM
  bookings_partitioned
WHERE
  start_date >= '2023-06-01'
  and start_date <= '2023-06-30';
  
-- Fetching bookings from August 2023 to October 2023
SELECT
  *
FROM
  bookings_partitioned
WHERE
  start_date >= '2023-08-01'
  and start_date <= '2023-10-31';
```

## Queries performance

### Fetchings bookings from August to October 2023

```sql
EXPLAIN ANALYZE
SELECT
  *
FROM
  bookings
WHERE
  start_date >= '2023-08-01'
  and start_date <= '2023-10-31';
```
**Execution Time**: 0.073 ms

```sql
EXPLAIN ANALYZE
SELECT
  *
FROM
  bookings_partitioned
WHERE
  start_date >= '2023-08-01'
  and start_date <= '2023-10-31';
```
**Execution Time**: 0.147 ms

### Fetchings bookings for June 2023

```sql
EXPLAIN ANALYZE
SELECT
  *
FROM
  bookings
WHERE
  start_date >= '2023-06-01'
  and start_date <= '2023-07-01'
```
**Execution Time**: 0.115 ms

```sql
EXPLAIN ANALYZE
SELECT
  *
FROM
  bookings_partitioned
WHERE
  start_date >= '2023-06-01'
  and start_date <= '2023-07-01'
```
**Execution Time**: 0.086 ms

## Report

Fetching some group of bookings from original `bookings` table takes less time than `bookings_partitioned` while fetching some bookings takes more time. On real-world production databases, tables can contain million to billion of rows. even indexing some columns can no longer improver information retrieval significantly. So partionning big tables can help retrieve specific information faster.
