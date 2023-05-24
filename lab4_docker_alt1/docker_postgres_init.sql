CREATE DATABASE demo1
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

--

\c postgres

DROP DATABASE IF EXISTS labdb;
-- REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public from lauser;

DROP USER IF EXISTS lauser;
CREATE USER lauser WITH PASSWORD 'lapass';
GRANT lauser TO CURRENT_USER;

CREATE DATABASE labdb ENCODING 'UTF8' OWNER lauser;

GRANT ALL PRIVILEGES ON DATABASE labdb to lauser;

\c labdb

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

--

INSERT INTO room_areas (room_area) VALUES ('floor 1'), ('floor 2'), ('floor 3');

INSERT INTO room_types (room_type, room_capacity) VALUES ('one bedroom',2), ('two bedrooms',5);

INSERT INTO rooms (room_area_id, room_type_id, room_phone, room_code)
    VALUES  (1,1,'1111-101','1-1'), (1,1,'1111-102','1-2'), (1,1,'1111-103','1-3'), (1,1,'1111-104','1-4'),
            (2,2,'1111-201','2-1'), (2,2,'1111-202','2-2'),
            (3,2,'1111-301','3-1'), (3,2,'1111-302','3-2')
    ;

INSERT INTO guest_ids (created) VALUES ('2001-01-01'), ('2001-01-01'), ('2001-01-02');

INSERT INTO guest_data (guest_id, idcode, addresses, phones, names, notes)
    VALUES  (1,'AAA-111-BB-CCCC','["st.Apple","12","Kharkiv","Ukraine"]','["380671112233","380501112233"]','["Petro","Pup"]','["vegan"]'),
            (2,'ABB-100-XX-NNNN','["av.Poleva","21","Kyiv","Ukraine"]','["380508884411"]','["Ivan","Bogun"]','[]'),
            (3,'BBC-800-DD-BBBB','["st.Nagorna","3","Dykanka","Ukraine","Poltavska"]','["380501234400"]','["Olga","Kalyna"]','[]')
    ;

INSERT INTO rooms_guests (room_id, guest_id, check_in, check_out)
    VALUES  (1,1,'2001-01-01','2001-01-10'), (2,2,'2001-01-01','2001-01-09'), (3,3,'2001-01-05','2001-01-11'),
            (1,2,'2001-03-01','2001-03-10'), (2,2,'2001-03-21','2001-03-29'), (2,3,'2001-04-05','2001-04-11'),
            (1,1,'2011-10-01','2011-10-10'), (2,2,'2011-10-21','2011-11-29'), (3,3,'2022-01-01','2031-11-11'),
            (4,3,'2011-10-01','2011-10-10'), (5,2,'2011-12-21','2011-12-29'), (6,1,'2022-01-01','2031-11-11')
    ;

INSERT INTO staff_ids (created) VALUES ('2000-12-01'), ('2000-12-01'), ('2000-12-02'), ('2000-12-02'), ('2000-12-02');

INSERT INTO staff_data (staff_id, phones, names, notes)
    VALUES  (1,'["380974442233","380504442233"]','["Vasyl","Mogyla"]','[]'),
            (2,'["380505554411"]','["Ganna","Shpak"]','[]'),
            (3,'["380503210044"]','["Taras","Malyna"]','["vegan"]'),
            (4,'["380668882233"]','["Maria","Malyna"]','["weekender"]'),
            (5,'["380990102030"]','["Alex","Grak"]','["weekender"]')
    ;

INSERT INTO areas_staff_schedule (dayofweek, room_area_id, staff_id)
    VALUES  (1,1,1),(2,1,3),(3,1,2),(4,1,1),(5,1,3),(6,1,4),(7,1,5),
            (1,2,2),(2,2,1),(3,2,3),(4,2,2),(5,2,1),(6,2,5),(7,2,4),
            (1,3,3),(2,3,2),(3,3,1),(4,3,3),(5,3,2),(6,3,1),(7,3,3)
    ;


CREATE TEMP TABLE temp_areas_staff_history (
    logged DATE,
    room_area_id INTEGER,
    staff_id INTEGER
);

INSERT INTO temp_areas_staff_history (logged, room_area_id, staff_id)
    VALUES  ('2001-01-01',1,1),('2001-01-02',1,3),('2001-01-03',1,2),('2001-01-04',1,1),('2001-01-05',1,3),('2001-01-06',1,4),('2001-01-07',1,5),
            ('2001-01-01',2,2),('2001-01-02',2,1),('2001-01-03',2,3),('2001-01-04',2,2),('2001-01-05',2,1),('2001-01-06',2,5),('2001-01-07',2,4),
            ('2001-01-01',3,3),('2001-01-02',3,2),('2001-01-03',3,1),('2001-01-04',3,3),('2001-01-05',3,2),('2001-01-06',3,1),('2001-01-07',3,3),
            ('2001-01-08',1,1),('2001-01-09',1,3),('2001-01-10',1,2),('2001-01-11',1,1),('2001-01-12',1,3),('2001-01-13',1,4),('2001-01-14',1,5),
            ('2001-01-08',2,2),('2001-01-09',2,1),('2001-01-10',2,3),('2001-01-11',2,2),('2001-01-12',2,1),('2001-01-13',2,5),('2001-01-14',2,4),
            ('2001-01-08',3,3),('2001-01-09',3,2),('2001-01-10',3,1),('2001-01-11',3,3),('2001-01-12',3,2),('2001-01-13',3,1),('2001-01-14',3,3),
            ('2001-01-15',1,1),('2001-01-16',1,3),('2001-01-17',1,2),('2001-01-18',1,1),('2001-01-19',1,3),('2001-01-20',1,4),('2001-01-21',1,5),
            ('2001-01-15',2,2),('2001-01-16',2,1),('2001-01-17',2,3),('2001-01-18',2,2),('2001-01-19',2,1),('2001-01-20',2,5),('2001-01-21',2,4),
            ('2001-01-15',3,3),('2001-01-16',3,2),('2001-01-17',3,1),('2001-01-18',3,3),('2001-01-19',3,2),('2001-01-20',3,1),('2001-01-21',3,3),
            ('2001-01-22',1,1),('2001-01-23',1,3),('2001-01-24',1,2),('2001-01-25',1,1),('2001-01-26',1,3),('2001-01-27',1,4),('2001-01-28',1,5),
            ('2001-01-22',2,2),('2001-01-23',2,1),('2001-01-24',2,3),('2001-01-25',2,2),('2001-01-26',2,1),('2001-01-27',2,5),('2001-01-28',2,4),
            ('2001-01-22',3,3),('2001-01-23',3,2),('2001-01-24',3,1),('2001-01-25',3,3),('2001-01-26',3,2),('2001-01-27',3,1),('2001-01-28',3,3),
            ('2001-01-29',1,1),('2001-01-30',1,3),('2001-01-31',1,2),
            ('2001-01-29',2,2),('2001-01-30',2,1),('2001-01-31',2,3),
            ('2001-01-29',3,3),('2001-01-30',3,2),('2001-01-31',3,1)
    ;

INSERT INTO areas_staff_history (logged, room_area_id, staff_id)
    SELECT logged, room_area_id, staff_id
        FROM temp_areas_staff_history
        ORDER BY logged, room_area_id, staff_id
;

DROP TABLE temp_areas_staff_history;

--

-- про те, хто із службовців прибирав номер у заданий день
SELECT *
	FROM public.rooms as rr
	LEFT JOIN public.areas_staff_history as st_hst ON rr.room_area_id = st_hst.room_area_id
	LEFT JOIN public.staff_data as st ON st_hst.staff_id = st.staff_id
	WHERE room_code = '2-2' AND logged = '2001-01-11'
;

-- про клієнтів, які проживають у заданому номері
SELECT *
	FROM public.rooms_guests as rr_gst
	LEFT JOIN public.rooms as rr ON rr.room_id = rr_gst.room_id
	LEFT JOIN public.guest_data as gst ON gst.guest_id = rr_gst.guest_id
	WHERE room_code = '1-3' 
	AND check_in <= CURRENT_DATE
	AND check_out >= CURRENT_DATE
;

-- про клієнтів, які прибули із заданого міста
SELECT *
	FROM public.rooms_guests as rr_gst
	LEFT JOIN public.rooms as rr ON rr.room_id = rr_gst.room_id
	LEFT JOIN public.guest_data as gst ON gst.guest_id = rr_gst.guest_id
	WHERE addresses LIKE '%Kharkiv%'
	AND check_in <= CURRENT_DATE
	AND check_out >= CURRENT_DATE
;

-- про те, хто із службовців прибирав номер вказаного клієнта у заданий день
SELECT *
	FROM public.rooms_guests as rr_gst
	LEFT JOIN public.rooms as rr ON rr.room_id = rr_gst.room_id
	LEFT JOIN public.guest_data as gst ON gst.guest_id = rr_gst.guest_id
	LEFT JOIN public.areas_staff_history as st_hst ON rr.room_area_id = st_hst.room_area_id
	LEFT JOIN public.staff_data as st ON st_hst.staff_id = st.staff_id
	WHERE gst.names LIKE '%Petro%' AND gst.names LIKE '%Pup%'
	AND logged = '2001-01-10'
	AND check_in <= '2001-01-10'
	AND check_out >= '2001-01-10'
;

-- чи є в готелі вільні місця та вільні номери і, якщо є, то скільки
SELECT COUNT(*) as rooms_av, SUM(room_capacity) as capacity_av
	FROM public.rooms as rr
	LEFT JOIN public.room_types as rr_t ON rr_t.room_type_id = rr.room_type_id
	WHERE rr.room_id NOT IN (
		SELECT room_id
			FROM public.rooms_guests as rr_gst
			WHERE check_in <= CURRENT_DATE AND check_out >= CURRENT_DATE
	)
;

--
