import 'package:built_value/built_value.dart';

part 'password.g.dart';

abstract class Password implements Built<Password, PasswordBuilder> {
  String get value;

  Password._() {
    if (value.length < 5) {
      throw ArgumentError('Password must be at least 5 characters');
    }

    final RegExp passwordRegExp =  RegExp(r'^\d{5}$');

    if (!passwordRegExp.hasMatch(value)) {
      throw ArgumentError('Password can only contain alphanumeric characters');
    }
  }
  factory Password([void Function(PasswordBuilder) updates]) = _$Password;
}
