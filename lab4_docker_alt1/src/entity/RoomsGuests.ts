import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { GuestIds } from './GuestIds';
import { Rooms } from './Rooms';

@Entity('rooms_guests', { schema: 'public' })
export class RoomsGuests {
  @Column('date', { name: 'check_in', nullable: true })
  checkIn: string | null;

  @Column('date', { name: 'check_out', nullable: true })
  checkOut: string | null;

  @Column('text', { name: 'notes', nullable: true })
  notes: string | null;

  @ManyToOne(() => GuestIds, (guestIds) => guestIds.roomsGuests, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'guest_id', referencedColumnName: 'guestId' }])
  guest: GuestIds;

  @ManyToOne(() => Rooms, (rooms) => rooms.roomsGuests, { onDelete: 'CASCADE' })
  @JoinColumn([{ name: 'room_id', referencedColumnName: 'roomId' }])
  room: Rooms;
}
