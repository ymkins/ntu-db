import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { StaffIds } from './StaffIds';

@Entity('staff_data', { schema: 'public' })
export class StaffData {
  @Column('date', { name: 'archived', nullable: true })
  archived: string | null;

  @Column('text', { name: 'phones', nullable: true })
  phones: string | null;

  @Column('text', { name: 'names', nullable: true })
  names: string | null;

  @Column('text', { name: 'notes', nullable: true })
  notes: string | null;

  @ManyToOne(() => StaffIds, (staffIds) => staffIds.staffData, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'staff_id', referencedColumnName: 'staffId' }])
  staff: StaffIds;
}
