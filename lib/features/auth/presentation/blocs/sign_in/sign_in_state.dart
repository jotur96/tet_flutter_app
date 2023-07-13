part of 'sign_in_cubit.dart';

class SignInState extends Equatable {

  final Username? username;
  final Password? password;
  final UsernameStatus usernameStatus;
  final PasswordStatus passwordStatus;
  final FormStatus formStatus;

  const SignInState({
    this.username,
    this.password,
    this.usernameStatus = UsernameStatus.unknown,
    this.passwordStatus = PasswordStatus.unknown,
    this.formStatus = FormStatus.initial,
  });

  SignInState copyWith({
    Username? username,
    Password? password,
    UsernameStatus? usernameStatus,
    PasswordStatus? passwordStatus,
    FormStatus? formStatus,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      passwordStatus: passwordStatus ?? this.passwordStatus,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        usernameStatus,
        passwordStatus,
        formStatus,
      ];
}


