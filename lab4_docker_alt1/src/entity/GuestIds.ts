import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { GuestData } from './GuestData';
import { RoomsGuests } from './RoomsGuests';

@Index('guest_ids_pkey', ['guestId'], { unique: true })
@Entity('guest_ids', { schema: 'public' })
export class GuestIds {
  @PrimaryGeneratedColumn({ type: 'integer', name: 'guest_id' })
  guestId: number;

  @Column('date', { name: 'created', nullable: true })
  created: string | null;

  @OneToMany(() => GuestData, (guestData) => guestData.guest)
  guestData: GuestData[];

  @OneToMany(() => RoomsGuests, (roomsGuests) => roomsGuests.guest)
  roomsGuests: RoomsGuests[];
}
