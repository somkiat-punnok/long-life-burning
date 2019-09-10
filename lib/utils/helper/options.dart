import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:long_life_burning/utils/helper/constants.dart' show Gender;

class StaticValues {

  StaticValues._();

  static final UserOptions userOption = UserOptions();
  static final EventOptions eventOption = EventOptions();
  static final bool login = false;
  
}

class UserOptions {

  UserOptions({
    this.user,
    this.name,
    this.username,
    this.gender,
    this.dateOfBirth,
    this.height,
    this.weight,
  });

  final FirebaseUser user;
  final String name;
  final String username;
  final Gender gender;
  final DateTime dateOfBirth;
  final num height;
  final num weight;

  UserOptions copyWith({
    FirebaseUser user,
    String name,
    String username,
    Gender gender,
    DateTime dateOfBirth,
    num height,
    num weight,
  }) => UserOptions(
      user: user ?? this.user,
      name: name ?? this.name,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType)
      return false;
    final UserOptions typedOther = other;
    return user == typedOther.user
        && name == typedOther.name
        && username == typedOther.username
        && gender == typedOther.gender
        && dateOfBirth == typedOther.dateOfBirth
        && height == typedOther.height
        && weight == typedOther.weight;
  }

  @override
  int get hashCode => hashValues(
    user,
    name,
    username,
    gender,
    dateOfBirth,
    height,
    weight,
  );

  @override
  String toString() {
    return '$runtimeType($user)';
  }

}

class EventOptions {

  EventOptions({
    this.province,
    this.categories,
  });

  final String province;
  final String categories;

  EventOptions copyWith({
    String province,
    String categories,
  }) => EventOptions(
      province: province ?? this.province,
      categories: categories ?? this.categories,
    );
  
  EventOptions reset() => EventOptions(
    province: this.province,
    categories: this.categories,
  );

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType)
      return false;
    final EventOptions typedOther = other;
    return province == typedOther.province
        && categories == typedOther.categories;
  }

  @override
  int get hashCode => hashValues(
    province,
    categories,
  );

  @override
  String toString() {
    return '$runtimeType(Province: $province, Categories: $categories)';
  }

}
