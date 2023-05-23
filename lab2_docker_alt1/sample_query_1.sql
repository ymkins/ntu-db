
-- про те, хто із службовців прибирав номер у заданий день
SELECT *
	FROM public.rooms as rr
	LEFT JOIN public.areas_staff_history as st_hst ON rr.room_area_id = st_hst.room_area_id
	LEFT JOIN public.staff_data as st ON st_hst.staff_id = st.staff_id
	WHERE room_code = '2-2' AND logged = '2001-01-11'
;
