import 'package:equatable/equatable.dart';

// They are the business objects of the application (Enterprise-wide business rules)
// and encapsulate the most general and high-level rules.
class AuthUser extends Equatable {
  final String username;


  const AuthUser({
    required this.username,
  });


  @override
  List<Object?> get props => [username];
}
