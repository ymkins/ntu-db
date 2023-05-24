import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { StaffIds } from './StaffIds';

@Entity('staff_data', { schema: 'public' })
export class StaffData {
  @PrimaryGeneratedColumn()
  id: number;

  @Column('date', { name: 'archived', nullable: true })
  archived: string | null;

  @Column('simple-json', { name: 'phones', nullable: true })
  phones: string | null;

  @Column('simple-json', { name: 'names', nullable: true })
  names: string | null;

  @Column('simple-json', { name: 'notes', nullable: true })
  notes: string | null;

  @ManyToOne(() => StaffIds, (staffIds) => staffIds.staffData, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'staff_id', referencedColumnName: 'staffId' }])
  staff: StaffIds;
}
