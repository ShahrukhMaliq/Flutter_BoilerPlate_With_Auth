// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credentials_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialsLoginResponse _$CredentialsLoginResponseFromJson(
        Map<String, dynamic> json) =>
    CredentialsLoginResponse(
      id: json['id'] as String?,
      accessToken: json['accessToken'] as String?,
      expiresIn: json['expiresIn'] as int?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$CredentialsLoginResponseToJson(
        CredentialsLoginResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accessToken': instance.accessToken,
      'expiresIn': instance.expiresIn,
      'refreshToken': instance.refreshToken,
    };
