part of 'user_list_bloc.dart';

abstract class UserListEvent {
  const UserListEvent();

}

class GetUsersEvent extends UserListEvent {
  const GetUsersEvent();
}
