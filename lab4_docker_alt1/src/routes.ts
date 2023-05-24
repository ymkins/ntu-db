import { RoomsController } from './controller/RoomsController';
import { UserController } from './controller/UserController';

export const Routes = [
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
