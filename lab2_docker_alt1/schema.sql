DROP DATABASE IF EXISTS lab2;

CREATE ROLE testuser LOGIN;

--For linux
CREATE DATABASE lab2 ENCODING 'UTF-8' LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8' TEMPLATE template0 OWNER testuser;

\c lab2

SET ROLE testuser;


--

CREATE TABLE room_areas (
    room_area_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_area varchar(64)
);

CREATE TABLE room_types (
    room_type_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_type varchar(64),
    room_capacity INTEGER
);

CREATE TABLE rooms (
    room_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_area_id INTEGER REFERENCES room_areas(room_area_id) ON DELETE CASCADE,
    room_type_id INTEGER REFERENCES room_types(room_type_id) ON DELETE CASCADE,
    room_phone varchar(16),
    room_code varchar(64),
    archived DATE,
    -- json arrays
    notes TEXT
);


CREATE TABLE guest_ids (
    guest_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created DATE
);

CREATE TABLE guest_data (
    guest_id INTEGER REFERENCES guest_ids(guest_id) ON DELETE CASCADE,
    idcode TEXT,
    archived DATE,
    -- json arrays
    addresses TEXT,
    phones TEXT,
    names TEXT,
    notes TEXT
);


CREATE TABLE rooms_guests (
    room_id INTEGER REFERENCES rooms(room_id) ON DELETE CASCADE,
    guest_id INTEGER REFERENCES guest_ids(guest_id) ON DELETE CASCADE,
    check_in DATE,
    check_out DATE,
    -- json arrays
    notes TEXT
);


CREATE TABLE staff_ids (
    staff_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created DATE
);

CREATE TABLE staff_data (
    staff_id INTEGER REFERENCES staff_ids(staff_id) ON DELETE CASCADE,
    archived DATE,
    -- json arrays
    phones TEXT,
    names TEXT,
    notes TEXT
);

CREATE TABLE areas_staff_schedule (
    dayofweek INTEGER,
    room_area_id INTEGER REFERENCES room_areas(room_area_id) ON DELETE CASCADE,
    staff_id INTEGER REFERENCES staff_ids(staff_id) ON DELETE CASCADE,
    archived DATE
);

CREATE TABLE areas_staff_history (
    logged DATE,
    room_area_id INTEGER REFERENCES room_areas(room_area_id) ON DELETE CASCADE,
    staff_id INTEGER REFERENCES staff_ids(staff_id) ON DELETE CASCADE,
    -- json arrays
    notes TEXT
);
