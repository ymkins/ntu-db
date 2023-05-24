import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { GuestIds } from './GuestIds';

@Entity('guest_data', { schema: 'public' })
export class GuestData {
  @Column('text', { name: 'idcode', nullable: true })
  idcode: string | null;

  @Column('date', { name: 'archived', nullable: true })
  archived: string | null;

  @Column('text', { name: 'addresses', nullable: true })
  addresses: string | null;

  @Column('text', { name: 'phones', nullable: true })
  phones: string | null;

  @Column('text', { name: 'names', nullable: true })
  names: string | null;

  @Column('text', { name: 'notes', nullable: true })
  notes: string | null;

  @ManyToOne(() => GuestIds, (guestIds) => guestIds.guestData, {
    onDelete: 'CASCADE',
  })
  @JoinColumn([{ name: 'guest_id', referencedColumnName: 'guestId' }])
  guest: GuestIds;
}
