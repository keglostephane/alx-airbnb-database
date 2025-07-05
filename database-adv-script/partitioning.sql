-- Connect to the database
\c airbnb

-- Partition Bookings table based on the `start_date` column
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

-- Insert data from original Bookings to partitioned Booking table
INSERT INTO
  bookings_partitioned
SELECT
  *
FROM
  bookings;
