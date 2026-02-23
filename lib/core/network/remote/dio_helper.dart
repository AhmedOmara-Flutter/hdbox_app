import'package:hdbox_app/core/helpers/app_imports.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        receiveDataWhenStatusError: true,
      ),
    );


dio!.interceptors.add(PrettyDioLogger(
  requestHeader: false,
  requestBody: false,
  responseBody: false,
  responseHeader: true,
));


  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }
}
