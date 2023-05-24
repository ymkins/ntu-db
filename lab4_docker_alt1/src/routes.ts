import { APIv1Controller } from './controller/APIv1Controller';
import { APIv2Controller } from './controller/APIv2Controller';
import { RoomsController } from './controller/RoomsController';
import { UserController } from './controller/UserController';

export const Routes = [
  {
    method: 'get',
    route: '/api/v1/guests/from/:addresses',
    controller: APIv1Controller,
    action: 'getGuestsByAddress',
  },
  {
    method: 'get',
    route: '/api/v1/guests/rooms/:roomCode',
    controller: APIv1Controller,
    action: 'getGuestsByRoom',
  },
  {
    method: 'get',
    route: '/api/v1/staff/rooms/:roomCode/:logged',
    controller: APIv1Controller,
    action: 'getLoggedStaffByRoom',
  },

  {
    method: 'get',
    route: '/api/v2/guests/from/:addresses',
    controller: APIv2Controller,
    action: 'getGuestsByAddress',
  },
  {
    method: 'get',
    route: '/api/v2/guests/rooms/:roomCode',
    controller: APIv2Controller,
    action: 'getGuestsByRoom',
  },
  {
    method: 'get',
    route: '/api/v2/staff/rooms/:roomCode/:logged',
    controller: APIv2Controller,
    action: 'getLoggedStaffByRoom',
  },

  {
    method: 'get',
    route: '/rooms',
    controller: RoomsController,
    action: 'all',
  },
  {
    method: 'get',
    route: '/rooms/:id',
    controller: RoomsController,
    action: 'one',
  },
  {
    method: 'post',
    route: '/rooms',
    controller: RoomsController,
    action: 'save',
  },
  {
    method: 'delete',
    route: '/rooms/:id',
    controller: RoomsController,
    action: 'remove',
  },
  {
    method: 'get',
    route: '/users',
    controller: UserController,
    action: 'all',
  },

  {
    method: 'get',
    route: '/users/:id',
    controller: UserController,
    action: 'one',
  },
  {
    method: 'post',
    route: '/users',
    controller: UserController,
    action: 'save',
  },
  {
    method: 'delete',
    route: '/users/:id',
    controller: UserController,
    action: 'remove',
  },
];
