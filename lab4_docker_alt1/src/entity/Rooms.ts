import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { RoomAreas } from './RoomAreas';
import { RoomsGuests } from './RoomsGuests';
import { RoomTypes } from './RoomTypes';

@Index('rooms_pkey', ['roomId'], { unique: true })
@Entity('rooms', { schema: 'public' })
export class Rooms {
  @PrimaryGeneratedColumn({ type: 'integer', name: 'room_id' })
  roomId: number;

  @Column('character varying', {
    name: 'room_phone',
    nullable: true,
    length: 16,
  })
  roomPhone: string | null;

  @Column('character varying', {
    name: 'room_code',
    nullable: true,
    length: 64,
  })
  roomCode: string | null;

  @Column('date', { name: 'archived', nullable: true })
  archived: string | null;

  @Column('simple-json', { name: 'notes', nullable: true })
  notes: string | null;

  @ManyToOne(() => RoomAreas, (roomAreas) => roomAreas.rooms, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'room_area_id', referencedColumnName: 'roomAreaId' }])
  roomArea: RoomAreas;

  @ManyToOne(() => RoomTypes, (roomTypes) => roomTypes.rooms, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'room_type_id', referencedColumnName: 'roomTypeId' }])
  roomType: RoomTypes;

  @OneToMany(() => RoomsGuests, (roomsGuests) => roomsGuests.room)
  roomsGuests: RoomsGuests[];
}
