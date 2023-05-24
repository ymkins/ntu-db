import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Rooms } from './Rooms';

@Index('room_types_pkey', ['roomTypeId'], { unique: true })
@Entity('room_types', { schema: 'public' })
export class RoomTypes {
  @PrimaryGeneratedColumn({ type: 'integer', name: 'room_type_id' })
  roomTypeId: number;

  @Column('character varying', {
    name: 'room_type',
    nullable: true,
    length: 64,
  })
  roomType: string | null;

  @Column('integer', { name: 'room_capacity', nullable: true })
  roomCapacity: number | null;

  @OneToMany(() => Rooms, (rooms) => rooms.roomType)
  rooms: Rooms[];
}
