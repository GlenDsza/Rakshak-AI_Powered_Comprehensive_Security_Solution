import 'package:dio/dio.dart';

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
    //intercept api request
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    super.onError(err, handler);
    //intercept api exceptions
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
    //intercept api responses
  }
}
