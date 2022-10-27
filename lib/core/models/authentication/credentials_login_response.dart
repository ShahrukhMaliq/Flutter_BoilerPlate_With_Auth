import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credentials_login_response.g.dart';

@JsonSerializable()
class CredentialsLoginResponse extends Equatable {
  final String? id;
  final String? accessToken;
  final int? expiresIn;
  final String? refreshToken;

  CredentialsLoginResponse({this.id, this.accessToken, this.expiresIn, this.refreshToken});

  @override
  List<Object?> get props => [id, accessToken, expiresIn, refreshToken];

  factory CredentialsLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$CredentialsLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsLoginResponseToJson(this);
}
