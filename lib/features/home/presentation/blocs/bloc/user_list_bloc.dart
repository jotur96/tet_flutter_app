import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tet_flutter_app/features/home/domain/usecases/get_users_usecase.dart';

import '../../../data/models/user_model.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {


  final GetUsersUseCase _getUsersUseCase;

  UserListBloc(this._getUsersUseCase) : super(const UserListLoading()) {
    on<GetUsersEvent>((event, emit) async {
      await onGetUsers(event, emit);
    });
  }

  Future<void> onGetUsers(GetUsersEvent event, Emitter<UserListState> emit) async {
    try {
      final List<UserModel> users = await _getUsersUseCase();

      if (users.isNotEmpty) {
        emit(UserListDone(users));
      } else {
        emit(const UserListError('No se encontraron usuarios.'));
      }
    } catch (error) {
      emit(UserListError('Error al obtener los usuarios: $error'));
    }
  }

}
