import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';
// import 'package:hajat/src/services/log.dart'; logger to be implemented

class ApiService {
  Dio dio;

  ApiService(this.dio);



  
  Future<Response> signUp(String firstName, String lastName, String mobile,
      String passwords, int type) async {
    var data = json.encode({
      "name": "$firstName $lastName",
      "phone": mobile,
      "password": passwords,
      "type": type,
    });

    try {
      var response = await dio.request(
        '/api/users/signup',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(json.encode(response.data));
      } else {
        getIt<Log>().info(response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      getIt<Log>().error(e.toString());
      rethrow;
    }
  }

  Future<Response> login(String mobile, String password) async {
    var data = json.encode({
      "phone": mobile,
      "password": password,
    });

    try {
      var response = await dio.request(
        '/api/users/login',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(json.encode(response.data));
      } else {
        // ignore: prefer_interpolation_to_compose_strings
        getIt<Log>().warn("From API Service: " + response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      getIt<Log>().error(e.toString());
      rethrow;
    }
  }


   // set address /api/users/location takes (latitude, longitude, street)
  Future<Response> setAddress(
      double latitude, double longitude, String street) async {
    var data = json.encode({
      "latitude": latitude,
      "longitude": longitude,
      "street": street,
    });

    try {
      var response = await dio.request(
        '/api/users/location',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(json.encode(response.data));
      } else {
        getIt<Log>().warn(response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      getIt<Log>().error(e.toString());
      rethrow;
    }
  }

// /api/users/request-otp
  Future<Response> sendOtp(String token) async {
    try {
      var response = await dio.request(
        '/api/users/request-otp',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(json.encode(response.data));
      } else {
        getIt<Log>().warn(response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      getIt<Log>().error(e.toString());
      rethrow;
    }
  }

  // /api/users/verify-otp
  Future<Response> verifyOtp(String token, String otp) async {
    var data = json.encode({"otp": otp});

    try {
      var response = await dio.request(
        '/api/users/verify-otp',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(json.encode(response.data));
      } else {
        getIt<Log>().warn("ELSE" + response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      getIt<Log>().error("CATCH$e");
      rethrow;
    }
  }


  
  // request reset password otp, takes (phone), request-reset-otp

  Future<Response> requestResetPasswordOtp(String phone) async {
    var data = json.encode({"phone": phone});

    try {
      var response = await dio.request(
        '/api/users/request-reset-otp',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(json.encode(response.data));
      } else {
        getIt<Log>().warn("ELSE" + response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      getIt<Log>().error("CATCH$e");
      rethrow;
    }
  }

  // verify reset password otp, takes (phone, otp), verify-reset-otp
  Future<Response> verifyResetPasswordOtp(String phone, String otp) async {
    var data = json.encode({"phone": phone, "otp": otp});

    try {
      var response = await dio.request(
        '/api/users/verify-reset-otp',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(json.encode(response.data));
      } else {
        getIt<Log>().warn("ELSE" + response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      getIt<Log>().error("CATCH$e");
      rethrow;
    }
  }

  // reset password, takes (resetToken, newPassword), reset-password
  Future<Response> resetPassword(String resetToken, String newPassword) async {
    var data =
        json.encode({"resetToken": resetToken, "newPassword": newPassword});

    try {
      var response = await dio.request(
        '/api/users/reset-password',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(json.encode(response.data));
      } else {
        getIt<Log>().warn("ELSE" + response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      getIt<Log>().error("CATCH$e");
      rethrow;
    }
  }

  

  // get all banners, /api/banners
  Future<Response> getBanners() async {
    try {
      var response = await dio.request(
        '/api/banners',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
       // getIt<Log>().info(json.encode(response.data));
      } else {
        //getIt<Log>().warn("ELSE" + response.data);
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
     // getIt<Log>().error("CATCH$e");
      rethrow;
    }
  }

  
}
