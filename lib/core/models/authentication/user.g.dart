// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userid: json['userid'] as String?,
      login: json['login'] as String?,
      userrole: json['userrole'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userid': instance.userid,
      'login': instance.login,
      'userrole': instance.userrole,
    };
