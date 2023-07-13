// ignore_for_file: deprecated_member_use

part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  final List<UserModel> ? users;
  final String ? error;


  const UserListState({
    this.users,
    this.error,
  });
  
  @override
  List<Object> get props => [users!, error!];
}

class UserListInitial extends UserListState {}


class UserListLoading extends UserListState {
  const UserListLoading();
}

class UserListDone extends UserListState {
  const UserListDone(List<UserModel> user) : super(users: user);
}

class UserListError extends UserListState {
  const UserListError(error) : super(error: error);
}