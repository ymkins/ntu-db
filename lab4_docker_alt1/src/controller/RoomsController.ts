import { NextFunction, Request, Response } from 'express';
import { AppDataSource } from '../data-source';
import { Rooms } from '../entity/Rooms';

export class RoomsController {
  private roomsRepository = AppDataSource.getRepository(Rooms);

  async all(request: Request, response: Response, next: NextFunction) {
    return this.roomsRepository.find();
  }

  async one(request: Request, response: Response, next: NextFunction) {
    const roomId = parseInt(request.params.roomId);

    const room = await this.roomsRepository.findOne({
      where: { roomId },
    });

    if (!room) {
      return 'unregistered room';
    }
    return room;
  }

  async save(request: Request, response: Response, next: NextFunction) {
    const { roomPhone, roomCode, roomArea, roomType, notes } = request.body;

    const room = Object.assign(new Rooms(), {
      roomPhone,
      roomCode,
      roomArea,
      roomType,
      notes,
    });

    return this.roomsRepository.save(room);
  }

  async remove(request: Request, response: Response, next: NextFunction) {
    const roomId = parseInt(request.params.roomId);

    const roomToRemove = await this.roomsRepository.findOneBy({ roomId });

    if (!roomToRemove) {
      return 'this room not exist';
    }

    await this.roomsRepository.remove(roomToRemove);

    return 'room has been removed';
  }
}
