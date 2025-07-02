# Implement Indexes for Optimization

## Some high-usage columns in Users, Bookings, Properties tables

### Users

* user_id
* email

### Bookings

* booking_id
* property_id
* user_id

### Properties

* property_id
* host_id

## Optimizations

### Create indexes

```sql
CREATE INDEX user_email_idx ON users (email);
CREATE INDEX booking_property_idx ON bookings (property_id);
CREATE INDEX payment_booking_idx ON payments (booking_id);
CREATE INDEX booking_user_idx ON bookings (user_id);
CREATE INDEX property_host_idx ON properties (host_id);
```
## Queries performance

### List the number of properties owned per users

```sql
EXPLAIN 
ANALYZE 
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
**Execution time (before optimization)**: 0.267 ms

**Execution time (after optimization)**: 0.100 ms

### List the properties owned by a specific user

```sql
EXPLAIN
ANALYZE
SELECT
  *
FROM
  properties
  WHERE host_id = 'b1eebc99-9c0b-4ef8-bb6d-6bb9bd380a12';
```
**Execution time (before optimization)**: 0.102 ms

**Execution time (after optimization)**: 0.038 ms

### List all bookings made by a specific user with booking details

```sql
EXPLAIN
ANALYZE
SELECT
  bookings.booking_id,
  properties.name,
  properties.description,
  bookings.total_price,
  users.first_name,
  users.last_name
FROM
  bookings
  INNER JOIN properties ON bookings.property_id = properties.property_id
  INNER JOIN users ON bookings.user_id = users.user_id
WHERE
  bookings.user_id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';
```
**Execution time (before optimization)**: 0.288 ms

**Execution time (after optimization)**: 0.145 ms
