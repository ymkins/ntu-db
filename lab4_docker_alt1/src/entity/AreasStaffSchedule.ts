import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { RoomAreas } from './RoomAreas';
import { StaffIds } from './StaffIds';

@Entity('areas_staff_schedule', { schema: 'public' })
export class AreasStaffSchedule {
  @Column('integer', { name: 'dayofweek', nullable: true })
  dayofweek: number | null;

  @Column('date', { name: 'archived', nullable: true })
  archived: string | null;

  @ManyToOne(() => RoomAreas, (roomAreas) => roomAreas.areasStaffSchedules, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'room_area_id', referencedColumnName: 'roomAreaId' }])
  roomArea: RoomAreas;

  @ManyToOne(() => StaffIds, (staffIds) => staffIds.areasStaffSchedules, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'staff_id', referencedColumnName: 'staffId' }])
  staff: StaffIds;
}
