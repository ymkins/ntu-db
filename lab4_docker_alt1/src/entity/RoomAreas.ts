import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { AreasStaffHistory } from './AreasStaffHistory';
import { AreasStaffSchedule } from './AreasStaffSchedule';
import { Rooms } from './Rooms';

@Index('room_areas_pkey', ['roomAreaId'], { unique: true })
@Entity('room_areas', { schema: 'public' })
export class RoomAreas {
  @PrimaryGeneratedColumn({ type: 'integer', name: 'room_area_id' })
  roomAreaId: number;

  @Column('character varying', {
    name: 'room_area',
    nullable: true,
    length: 64,
  })
  roomArea: string | null;

  @OneToMany(
    () => AreasStaffHistory,
    (areasStaffHistory) => areasStaffHistory.roomArea,
  )
  areasStaffHistories: AreasStaffHistory[];

  @OneToMany(
    () => AreasStaffSchedule,
    (areasStaffSchedule) => areasStaffSchedule.roomArea,
  )
  areasStaffSchedules: AreasStaffSchedule[];

  @OneToMany(() => Rooms, (rooms) => rooms.roomArea)
  rooms: Rooms[];
}
