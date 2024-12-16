
import 'package:dio/dio.dart';
import 'package:hajat_mobile_app/src/services/dio/append_token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  const DioFactory(this._baseUrl, this._appendTokentampInterceptor);

  final String _baseUrl;

  final AppendTokenInterceptor _appendTokentampInterceptor;

  Dio create() => Dio(_createBaseOptions())
    ..interceptors.add(_appendTokentampInterceptor)
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));

  BaseOptions _createBaseOptions() {

    return BaseOptions(
   
      baseUrl: _baseUrl,
      headers: {
        'Content-Type': 'application/json',
         //'Authorization': 'Bearer s'
      },
      // Common query parameters for each request
      //queryParameters: <String, dynamic>{'parameter1': 'value1'},

      ///Common headers for each request
      // headers: <String, dynamic>{
      //   //"authorization": 'bearer $token',
      //   'accept': 'application/json',
      //   'content-type': 'application/json',
      // },
    );
  }
}
