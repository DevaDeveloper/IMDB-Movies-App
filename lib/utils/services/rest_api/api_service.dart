import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imdb_movies_app/models/failure_model.dart';

import '../../../consts/api/api_path.dart';
import '../../exceptions/repo_exception.dart';

class ApiService {
  static String url = dotenv.env[ApiPaths.BASE_URL] ?? 'BASE_URL';
  static final ApiService _instance = ApiService._internal();

  ApiService._internal();

  static ApiService get instance => _instance;

  factory ApiService() {
    return _instance;
  }

  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    connectTimeout: const Duration(seconds: 25),
    receiveTimeout: const Duration(seconds: 25),
    contentType: 'json/application',
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static final dio = createDio();
  static final dioToken = Dio(dio.options);
  static final baseAPI = addInterceptors(dio);

  static Dio addInterceptors(Dio dio) {
    dio.interceptors.add(LogInterceptor(responseBody: true, responseHeader: true, requestBody: true));
    return dio..interceptors.add(ImdbInterceptor(baseURI: opts.baseUrl));
  }

  static dynamic requestInterceptor(RequestOptions options, tokenAccess) {
    options.headers["Authorization"] = "Bearer $tokenAccess";
    return options;
  }

  Future<Response?> getHTTP(String url, Map<String, dynamic>? queryParameters) async {
    Response response;

    try {
      response = await baseAPI.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<Response?> postHTTP(
    String url,
    dynamic data,
  ) async {
    Response response;
    try {
      response = await baseAPI.post(url, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<Response?> putHTTP(String url, dynamic data) async {
    Response response;
    try {
      response = await baseAPI.put(url, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<Response?> patchHTTP(String url, dynamic data) async {
    Response response;
    try {
      response = await baseAPI.patch(url, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
    return null;
  }

  Future<Response?> deleteHTTP(String url) async {
    Response response;
    try {
      response = await baseAPI.delete(url);
      return response;
    } on DioException catch (e) {
      _handleError(e);
    }
    return null;
  }

  _handleError(e) {
    String message = e.response.toString();
    int code = 500;
    String key = 'Something wrong on server';
    try {
      message = e.response != null && e.response.data != null && e.response.data['message'] != null
          ? e.response.data['message']
          : "Something went wrong";
      key = e.response != null && e.response.data != null && e.response.data['key'] != null ? e.response.data['key'] : "UNKNOWN";
      code = e.response != null && e.response?.statusCode != null ? e.response.statusCode : 1000;
    } catch (ex) {
      throw RepoException(
        message: 'Error during parse repo exception',
        failure: const Failure(code: '501', message: 'Error', key: 'PARSE_ERROR'),
      );
    }
    throw RepoException(
      message: e.message,
      failure: Failure(code: 'code', message: message, key: key),
    );
  }
}

class ImdbInterceptor extends Interceptor {
  List<Map<dynamic, dynamic>> failedRequests = [];
  bool isRefreshing = false;
  String baseURI;

  ImdbInterceptor({required this.baseURI});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    final String imdbAccessToken = dotenv.env['ACCESS_TOKEN_MOVIES'] ?? 'ACCESS_TOKEN_MOVIES';
    options.headers['content-Type'] = 'application/json';
    options.headers["Authorization"] = "Bearer $imdbAccessToken";
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      "RESPONSE[CODE: ${response.statusCode} => MESSAGE: ${response.statusMessage} => DATA: ${response.data}]",
    );
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, IS REFRESHING: ${isRefreshing.toString()}',
    );
    return handler.next(err);
  }
}
