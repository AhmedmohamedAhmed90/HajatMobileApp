import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
// import 'package:hajat/src/services/log.dart'; logger to be implemented

class ApiService {
  Dio dio;

  ApiService(this.dio);

  

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
