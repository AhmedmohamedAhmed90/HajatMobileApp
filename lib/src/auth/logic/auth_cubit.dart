import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/auth/models/session.dart';
import 'package:hajat_mobile_app/src/auth/models/user.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';
import 'package:hajat_mobile_app/src/services/storage/storage_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/auth/models/session.dart';


part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final api = getIt<ApiService>();
  static Session? session;
  static get instance => getIt<AuthCubit>();
  
  AuthCubit() : super(const AuthState.initial()) {
    checkAuthStatus();
  }

  void signUp(
    String firstName,
    String lastName,
    String phone,
    String password,
    int type,
  ) async {
    emit(const AuthState.loading());

    try {
      phone = "20${phone.substring(1)}";
      final response =
          await api.signUp(firstName, lastName, phone, password, type);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        session = Session.fromJson(response.data);
        await getIt<StorageService>()
            .setString("session", jsonEncode(session!.toJson()));
        getIt<StorageService>().setString("token", session!.token);
        sendOtp();
      } else {
        emit(AuthState.error(response.statusMessage ?? "An error occurred"));
      }
    } on DioException catch (e) {
      getIt<Log>().error("dio exception ${e.response}");
      emit(AuthState.error(e.response?.data["message"] ?? e.toString()));
    } catch (e) {
      getIt<Log>().error(e.toString());
      emit(AuthState.error(e.toString()));
    }
  }

  void sendOtp() async {
    emit(const AuthState.loading());

    try {
      // get token from session
      final token = await getIt<StorageService>().getString("token");
      final otpResponse = await api.sendOtp(token!);

      if (otpResponse.statusCode != null &&
          otpResponse.statusCode! >= 200 &&
          otpResponse.statusCode! < 300) {
        emit(const AuthState.otpSent());
      } else {
        emit(
            AuthState.error(otpResponse.statusMessage ?? "Failed to send OTP"));
      }
    } on DioException catch (e) {
      getIt<Log>().error("dio exception ${e.response}");
      emit(AuthState.error(e.response?.data["message"] ?? e.toString()));
    } catch (e) {
      getIt<Log>().error(e.toString());
      emit(AuthState.error(e.toString()));
    }
  }

  void verifyOtp(String otp) async {
    emit(const AuthState.loading());

    try {
      // get token from session
      final token = await getIt<StorageService>().getString("token");
      final response = await api.verifyOtp(token!, otp);
      getIt<Log>().error("SHIT ${response}");
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().error("SHIT in if ${response}");
     
        final isVerified = response.data["is_verified"];
        if (isVerified) {
          // get session from storage
          final sessionString = await getIt<StorageService>().getString("session");
          if (sessionString != null) {
            session = Session.fromJson(jsonDecode(sessionString));
            // update the user object in the session is_verified to true
            User newUser = session!.user.copyWith(isVerified: true);
            session = session!.copyWith(user: newUser);
            await getIt<StorageService>()
                .setString("session", jsonEncode(session!.toJson()));
            emit(AuthState.authenticated(session!));
          }
        }
      } else {
        emit(AuthState.error(
            response.data["message"] ?? "Failed to verify OTP"));
      }
    } on DioException catch (e) {
      getIt<Log>().error("dio exception ${e.response}");
      if (e.response!.data["is_verified"] == false) {
        emit(const AuthState.otpWrongCode());
      } else {
        emit(AuthState.error(
            e.response!.data["message"] ?? "Failed to verify OTP"));
      }
    } catch (e) {
      getIt<Log>().error(e.toString());
      emit(AuthState.error(e.toString()));
    }
  }

  void login(String phone, String password) async {
    emit(const AuthState.loading());
    try {
      phone = "218${phone.substring(1)}";
      final response = await api.login(phone, password);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        session = Session.fromJson(response.data);
        await getIt<StorageService>()
            .setString("session", jsonEncode(session!.toJson()));
        getIt<StorageService>().setString("token", session!.token);
        emit(AuthState.authenticated(session!));
      } else {
        emit(AuthState.error(response.statusMessage ?? "An error occurred"));
      }
    } on DioException catch (e) {
      getIt<Log>().error("dio exception ${e.response}");
      emit(AuthState.error(e.response?.data["message"] ?? e.toString()));
    } catch (e) {
      getIt<Log>().error(e.toString());
      emit(AuthState.error(e.toString()));
    }
  }

  void checkAuthStatus() async {
    emit(const AuthState.loading());
    try {
      final sessionString = await getIt<StorageService>().getString("session");
      if (sessionString != null) {
        session = Session.fromJson(jsonDecode(sessionString));
        emit(AuthState.authenticated(session!));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      emit(const AuthState.unauthenticated());
    }
  }

  void logout() async {
    emit(const AuthState.loading());
    try {
      await getIt<StorageService>().clearAll();
      session = null;
      emit(const AuthState.unauthenticated());
    } catch (e) {
      getIt<Log>().error(e.toString());
      emit(AuthState.error(e.toString()));
    }
  }

  void setAddress(double latitude, double longitude, String street) async {
    emit(const AuthState.loading());
    try {
      final response = await api.setAddress(latitude, longitude, street);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final sessionString =
            await getIt<StorageService>().getString("session");
        if (sessionString != null) {
          session = Session.fromJson(jsonDecode(sessionString));
          User user = session!.user.copyWith(
            latitude: latitude,
            longitude: longitude,
            street: street,
          );
          session = session!.copyWith(user: user);
          await getIt<StorageService>()
              .setString("session", jsonEncode(session!.toJson()));
          emit(AuthState.authenticated(session!));
        }
      } else {
        emit(AuthState.error(response.statusMessage ?? "An error occurred"));
      }
    } on DioException catch (e) {
      getIt<Log>().error("dio exception ${e.response}");
      emit(AuthState.error(e.response?.data["message"] ?? e.toString()));
    } catch (e) {
      getIt<Log>().error(e.toString());
      emit(AuthState.error(e.toString()));
    }
  }

  void updateUser(User updatedUser)async {
    emit(const AuthState.loading());
    try {
      final sessionString = await getIt<StorageService>().getString("session");
      if (sessionString != null) {
        session = Session.fromJson(jsonDecode(sessionString));
        session = session!.copyWith(user: updatedUser);
        await getIt<StorageService>()
            .setString("session", jsonEncode(session!.toJson()));
        emit(AuthState.authenticated(session!));
      }
    } catch (e) {
      getIt<Log>().error(e.toString());
      emit(AuthState.error(e.toString()));
    }
  }

 void loginAsGuest() async {
      emit(const AuthState.guest());
  }

}
