import { NextFunction, Request, Response } from 'express';
import { AppDataSource } from '../data-source';
import { AreasStaffHistory } from '../entity/AreasStaffHistory';
import { GuestData } from '../entity/GuestData';
import { Rooms } from '../entity/Rooms';
import { RoomsGuests } from '../entity/RoomsGuests';
import { StaffData } from '../entity/StaffData';

export class APIv1Controller {
  private roomsRepo = AppDataSource.getRepository(Rooms);
  private roomsGuestsRepo = AppDataSource.getRepository(RoomsGuests);
  private areasStaffHistoryRepo =
    AppDataSource.getRepository(AreasStaffHistory);
  private guestsRepo = AppDataSource.getRepository(GuestData);
  private staffRepo = AppDataSource.getRepository(StaffData);

  async getGuestsByAddress(req: Request, res: Response, next: NextFunction) {
    const currentDate = new Date().toJSON();
    const addresses = req.params.addresses;
    await this.roomsGuestsRepo
      .createQueryBuilder('rr_gst')
      .leftJoinAndSelect('rooms', 'rr', 'rr.room_id = rr_gst.room_id')
      .leftJoinAndSelect('guest_data', 'gst', 'gst.guest_id = rr_gst.guest_id')
      .where('gst.addresses like :a', { a: `%${addresses}%` })
      .andWhere('rr_gst.check_in <= :cIN', { cIN: currentDate })
      .andWhere('rr_gst.check_out >= :cOUT', { cOUT: currentDate })
      .printSql()
      .getRawAndEntities()
      .then(
        (r) => (r ? res.json(r) : res.status(404).json('empty result')),
        (error) => res.status(500).json({ error }),
      );
  }

  async getGuestsByRoom(req: Request, res: Response, next: NextFunction) {
    const currentDate = new Date().toJSON();
    const roomCode = req.params.roomCode;
    await this.roomsGuestsRepo
      .createQueryBuilder('rr_gst')
      .leftJoinAndSelect('rooms', 'rr', 'rr.room_id = rr_gst.room_id')
      .leftJoinAndSelect('guest_data', 'gst', 'gst.guest_id = rr_gst.guest_id')
      .where('rr.room_code = :roomCode', { roomCode })
      .andWhere('rr_gst.check_in <= :cIN', { cIN: currentDate })
      .andWhere('rr_gst.check_out >= :cOUT', { cOUT: currentDate })
      .printSql()
      .getRawAndEntities()
      .then(
        (r) => (r ? res.json(r) : res.status(404).json('empty result')),
        (error) => res.status(500).json({ error }),
      );
  }

  async getLoggedStaffByRoom(req: Request, res: Response, next: NextFunction) {
    const logged = req.params.logged;
    const roomCode = req.params.roomCode;
    await this.roomsRepo
      .createQueryBuilder('rr')
      .leftJoinAndSelect(
        'areas_staff_history',
        'st_hst',
        'st_hst.logged = :logged AND st_hst.room_area_id = rr.room_area_id',
        { logged },
      )
      .leftJoinAndSelect('staff_data', 'st', 'st_hst.staff_id = st.staff_id')
      .where({ roomCode })
      .printSql()
      .getRawAndEntities()
      .then(
        (r) => (r ? res.json(r) : res.status(404).json('empty result')),
        (error) => res.status(500).json({ error }),
      );
  }
}
