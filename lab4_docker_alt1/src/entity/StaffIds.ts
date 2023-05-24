import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { AreasStaffHistory } from './AreasStaffHistory';
import { AreasStaffSchedule } from './AreasStaffSchedule';
import { StaffData } from './StaffData';

@Index('staff_ids_pkey', ['staffId'], { unique: true })
@Entity('staff_ids', { schema: 'public' })
export class StaffIds {
  @PrimaryGeneratedColumn({ type: 'integer', name: 'staff_id' })
  staffId: number;

  @Column('date', { name: 'created', nullable: true })
  created: string | null;

  @OneToMany(
    () => AreasStaffHistory,
    (areasStaffHistory) => areasStaffHistory.staff,
  )
  areasStaffHistories: AreasStaffHistory[];

  @OneToMany(
    () => AreasStaffSchedule,
    (areasStaffSchedule) => areasStaffSchedule.staff,
  )
  areasStaffSchedules: AreasStaffSchedule[];

  @OneToMany(() => StaffData, (staffData) => staffData.staff)
  staffData: StaffData[];
}
