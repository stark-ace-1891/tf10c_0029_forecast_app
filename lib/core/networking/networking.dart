import 'package:dio/dio.dart';
import 'package:tf10c_0029_forecast_app/core/exceptions/exceptions.dart';

class Networking {
  final dio = Dio();
  Networking() {
    dio.options.baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
    dio.options.responseType = ResponseType.json;
  }
  Future<Map<String, dynamic>> get({
    required String operationPath,
    Map<String, dynamic>? params,
  }) async {
    Map<String, dynamic> queryParams = {};
    final appIdParam = {'appid': '346fa825d426fdce42d2f911e212e9ed'};
    if (params != null) {
      queryParams.addAll(params);
      queryParams.addAll(appIdParam);
    } else {
      queryParams.addAll(appIdParam);
    }
    try {
      final response = await dio.get(
        operationPath,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioError catch (e) {
      final dioException = e;
      final errorResponse = dioException.response;
      if (errorResponse != null) {
        if (errorResponse.statusCode == 400) {
          throw NothingGeocodeException();
        } else if (errorResponse.statusCode == 401) {
          throw InvalidApiKeyException();
        }
      }
      throw ServerErrorException();
    }
  }
}
