import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tet_flutter_app/features/auth/domain/use_cases/sign_in_use_case.dart';

import '../../../domain/values_objects/password.dart';
import '../../../domain/values_objects/username.dart';
import '../form_status.dart';
import '../password_status.dart';
import '../username_status.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {

  final SignInUseCase _signInUseCase;

  SignInCubit({
    required SignInUseCase signInUseCase,
  })  : _signInUseCase = signInUseCase,
        super(const SignInState());

  
  void usernameChanged(String value) {
    try {
      Username username = Username((username) => username..value = value);
      emit(state.copyWith(
        username: username,
        usernameStatus: UsernameStatus.valid,
      ));
    } on ArgumentError {
      emit(state.copyWith(usernameStatus: UsernameStatus.invalid));
    }
    refreshFormStatus();
  }

  void passwordChanged(String value) {
    try {
      Password password = Password((password) => password..value = value);
      emit(
        state.copyWith(
          password: password,
          passwordStatus: PasswordStatus.valid,
        ),
      );
    } on ArgumentError {
      emit(state.copyWith(passwordStatus: PasswordStatus.invalid));
    }
    refreshFormStatus();
  }

  void signIn()  {
    if (!(state.usernameStatus == UsernameStatus.valid) ||
        !(state.passwordStatus == PasswordStatus.valid)) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
      emit(state.copyWith(formStatus: FormStatus.invalid));
      return;
    }

    emit(state.copyWith(formStatus: FormStatus.submissionInProgress));
    try {
      emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(formStatus: FormStatus.submissionFailure));
    }
  }

  void refreshFormStatus() {
    if (!(state.usernameStatus == UsernameStatus.valid) ||
        !(state.passwordStatus == PasswordStatus.valid)) {
      // emit(state.copyWith(formStatus: FormStatus.submissionFailure));
      emit(state.copyWith(formStatus: FormStatus.invalid));
      return;
    }
    emit(state.copyWith(formStatus: FormStatus.submissionSuccess));
  }


}
