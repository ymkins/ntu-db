import 'reflect-metadata';
import { DataSource } from 'typeorm';
import { AreasStaffHistory } from './entity/AreasStaffHistory';
import { AreasStaffSchedule } from './entity/AreasStaffSchedule';
import { GuestData } from './entity/GuestData';
import { GuestIds } from './entity/GuestIds';
import { RoomAreas } from './entity/RoomAreas';
import { Rooms } from './entity/Rooms';
import { RoomsGuests } from './entity/RoomsGuests';
import { RoomTypes } from './entity/RoomTypes';
import { StaffData } from './entity/StaffData';
import { StaffIds } from './entity/StaffIds';
import { User } from './entity/User';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: 'pg',
  port: 5432,
  username: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_DB,
  synchronize: false,
  logging: parseInt(process.env.LOG_LEVEL) > 2,
  entities: [
    AreasStaffHistory,
    AreasStaffSchedule,
    GuestData,
    GuestIds,
    RoomAreas,
    RoomTypes,
    Rooms,
    RoomsGuests,
    StaffData,
    StaffIds,
    User,
  ],
  migrations: [],
  subscribers: [],
});
