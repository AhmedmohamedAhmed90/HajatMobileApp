

part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.authenticated(Session session) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.error(String message) = _Error;
  const factory AuthState.guest() = _Guest;

  // OTP-related states
const factory AuthState.otpSent() = _OtpSent;
// OTP wrong code
const factory AuthState.otpWrongCode() = _OtpWrongCode;

}
