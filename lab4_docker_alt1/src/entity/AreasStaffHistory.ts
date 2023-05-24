import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { RoomAreas } from './RoomAreas';
import { StaffIds } from './StaffIds';

@Entity('areas_staff_history', { schema: 'public' })
export class AreasStaffHistory {
  @PrimaryGeneratedColumn()
  id: number;

  @Column('date', { name: 'logged', nullable: true })
  logged: string | null;

  @Column('simple-json', { name: 'notes', nullable: true })
  notes: string | null;

  @ManyToOne(() => RoomAreas, (roomAreas) => roomAreas.areasStaffHistories, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'room_area_id', referencedColumnName: 'roomAreaId' }])
  roomArea: RoomAreas;

  @ManyToOne(() => StaffIds, (staffIds) => staffIds.areasStaffHistories, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'staff_id', referencedColumnName: 'staffId' }])
  staff: StaffIds;
}
