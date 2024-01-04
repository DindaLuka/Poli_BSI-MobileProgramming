import 'package:dio/dio.dart';

final Dio dio = Dio(BaseOptions(
    baseUrl: "https://65698e15de53105b0dd73928.mockapi.io/",
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3)));

class ApiClient {
  Future<Response> get(
    String path,
  ) async {
    try {
      final response = await dio.get(Uri.encodeFull(path));
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      final Response = await dio.post(Uri.encodeFull(path), data: data);
      return Response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final Response = await dio.delete(Uri.encodeFull(path));
      return Response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
