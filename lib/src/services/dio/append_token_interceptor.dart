import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hajat_mobile_app/src/featrues/auth/models/session.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';
import 'package:hajat_mobile_app/src/services/storage/storage_service.dart';

class AppendTokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? x = await getIt<StorageService>().getString("token");
    if (x == null) {
      getIt<Log>().fatal('Token is null');
      return super.onRequest(options, handler);
    }
    final session = await getIt<StorageService>().getString("session");

    Session auth = Session.fromJson(jsonDecode(session!));

    getIt<Log>().fatal("THIS IS AUTH " + auth.toString());
    options.headers = {
      HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
      // HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    return super.onRequest(options, handler);
  }
}
