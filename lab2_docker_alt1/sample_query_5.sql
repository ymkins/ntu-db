
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
