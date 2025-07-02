-- Connect to database
\c airbnb
\x

-- Create indexes on bookings and text-properties
CREATE INDEX booking_user_idx ON bookings (user_id);
CREATE INDEX property_host_idx ON properties (host_id);
