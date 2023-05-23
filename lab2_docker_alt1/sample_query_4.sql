
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
