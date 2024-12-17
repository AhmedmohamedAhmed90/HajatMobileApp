import 'package:freezed_annotation/freezed_annotation.dart';


part 'banner.freezed.dart';
part 'banner.g.dart';

@freezed
class Banner with _$Banner {

  const factory Banner({
    required int id,
    required String image,
  }) = _Banner;

  /// Connect the generated function to the `fromJson` factory.
  factory Banner.fromJson(Map<String, dynamic> json) =>
      _$BannerFromJson(json);
}

