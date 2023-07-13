import 'package:built_value/built_value.dart';

part 'username.g.dart';

abstract class Username implements Built<Username, UsernameBuilder> {
  String get value;

  Username._() {
    final RegExp emailRegExp = RegExp(r'^[a-zA-Z]+$');

    if (!emailRegExp.hasMatch(value)) {
      throw ArgumentError('Invalid email format');
    }
  }
  factory Username([void Function(UsernameBuilder) updates]) = _$Username;
}