
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String? userid;
  final String? login;
  final String? userrole;

  const User({this.userid, this.login, this.userrole});

  @override
  List<Object?> get props => [userid, login, userrole];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
