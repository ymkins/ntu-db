
-- про клієнтів, які проживають у заданому номері
SELECT *
	FROM public.rooms_guests as rr_gst
	LEFT JOIN public.rooms as rr ON rr.room_id = rr_gst.room_id
	LEFT JOIN public.guest_data as gst ON gst.guest_id = rr_gst.guest_id
	WHERE room_code = '1-3' 
	AND check_in <= CURRENT_DATE
	AND check_out >= CURRENT_DATE
;
