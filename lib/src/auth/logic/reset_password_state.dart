part of 'reset_password_cubit.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.loading() = _Loading;
  const factory ResetPasswordState.error(String message) = _Error;
  const factory ResetPasswordState.otpSent() = _OtpSent;
  const factory ResetPasswordState.otpVerified(String resetToken) = _OtpVerified;
  const factory ResetPasswordState.success() = _Success;
  
}
