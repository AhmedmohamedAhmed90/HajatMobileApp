import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {


  const factory User({
    required int id,
    required String phone,
    required String name,
     String? type,
    bool? isVerified,
    double? latitude,
    double? longitude,
    String? street,
  }) = _User;


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}
