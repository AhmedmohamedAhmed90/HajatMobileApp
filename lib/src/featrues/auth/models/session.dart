import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/featrues/auth/models/user.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required User user,
    required String token,
  }) = _Session;



  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
}