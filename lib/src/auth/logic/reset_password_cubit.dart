import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';

part 'reset_password_state.dart';
part 'reset_password_cubit.freezed.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final api = getIt<ApiService>();
  final AuthCubit authCubit = getIt<AuthCubit>();
  ResetPasswordCubit(this.phone) : super(const ResetPasswordState.initial()) {
    resetPassword();
  }
  final String phone;
 

  void resetPassword() async {
    emit(const ResetPasswordState.loading());
    try {
      final response = await api.requestResetPasswordOtp(phone);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        emit(const ResetPasswordState.otpSent());
      } else {
        emit(ResetPasswordState.error(
            response.statusMessage ?? "An error occurred"));
      }
    } on Exception catch (e) {
      emit(ResetPasswordState.error(e.toString()));
    }
  }

  void verifyOtp(String otp) async {
    emit(const ResetPasswordState.loading());
    try {
     
      final response = await api.verifyResetPasswordOtp(phone, otp);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final resetToken = response.data["resetToken"];
        emit(ResetPasswordState.otpVerified(resetToken));
      } else {
        emit(ResetPasswordState.error(
            response.statusMessage ?? "An error occurred"));
      }
    } on Exception catch (e) {
      emit(ResetPasswordState.error(e.toString()));
    }
  }

  void resetPasswordWithToken(String password, String resetToken) async {
    emit(const ResetPasswordState.loading());
    try {
      final response = await api.resetPassword(resetToken, password);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        emit(const ResetPasswordState.success());
      } else {
        emit(ResetPasswordState.error(
            response.statusMessage ?? "An error occurred"));
      }
    } on Exception catch (e) {
      emit(ResetPasswordState.error(e.toString()));
    }
  }
}
