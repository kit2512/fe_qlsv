import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared/constants/constants.dart';
import 'package:shared/utils/utils.dart';

import './restful_module.dart';
import '../../network/options.dart';
import '../../network/response.dart';
import '../local_storage_module/local_storage_module.dart';

class RestfulModuleDioImpl implements RestfulModule {
  final GetConnect getConnect = GetConnect();

  final LocalStorageModule localStorageModule;

  RestfulModuleDioImpl({
    required this.localStorageModule,
  });

  Dio get _dio => _initDio();

  Dio _initDio() {
    Logger logger = Get.find();
    final dio = Dio();
    final logging = FlavorConfig.instance.variables["logging"] ?? false;
    dio
      ..options.connectTimeout = const Duration(milliseconds: 120000)
      ..options.receiveTimeout = const Duration(milliseconds: 120000)
      ..options.headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Access-Control-Allow-Origin': 'true'
      }
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (
            RequestOptions options,
            RequestInterceptorHandler requestInterceptorHandler,
          ) async {
            Map<String, dynamic>? cookie = AppUtils.getAuthorization();

            String? token = cookie['token'];

            if (kDebugMode) logger.d('Token: $token');

            if (token != null) {
              options.headers
                  .putIfAbsent('Authorization', () => 'Bearer $token');
            } else {
              String? localToken = await authToken;
              if (localToken != null) {
                document.cookie = "token=$localToken;domain=.higate.io";
              }
              logger.w('Auth token is null');
            }
            return requestInterceptorHandler.next(options);
          },
          onError: (dioError, handler) => handler.next(dioError),
        ),
      );
    if (logging) {
      dio.interceptors.add(LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          error: true,
          logPrint: print));
    } else {
      dio.interceptors.add(LogInterceptor(error: true, logPrint: print));
    }
    if (!kIsWeb) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    return dio;
  }

  @override
  Future<CommonResponse<T>> get<T>(String uri,
      {Map<String, dynamic>? query, CommonRequestOptions? options}) async {
    final result = await _dio.get<T>(
      uri,
      queryParameters: query,
      options:
          Options(headers: options?.headers, contentType: options?.contentType),
    );
    return CommonResponse(
      body: result.data,
      headers: Map<String, String>.from(
          result.headers.map.map((key, value) => MapEntry(key, value[0]))),
      statusCode: result.statusCode,
      statusMessage: result.statusMessage,
    );
  }

  @override
  Future<CommonResponse<T>> post<T>(String uri, data,
      {Map<String, dynamic>? query, CommonRequestOptions? options}) async {
    final result = await _dio.post<T>(
      uri,
      data: data,
      queryParameters: query,
      options:
          Options(headers: options?.headers, contentType: options?.contentType),
    );
    return CommonResponse(
      body: result.data,
      headers: Map<String, String>.from(
          result.headers.map.map((key, value) => MapEntry(key, value[0]))),
      statusCode: result.statusCode,
      statusMessage: result.statusMessage,
    );
  }

  @override
  Future<CommonResponse<T>> put<T>(String uri,
      {data,
      Map<String, dynamic>? query,
      CommonRequestOptions? options}) async {
    final result = await _dio.put<T>(
      uri,
      data: data,
      queryParameters: query,
      options:
          Options(headers: options?.headers, contentType: options?.contentType),
    );
    return CommonResponse(
      body: result.data,
      headers: Map<String, String>.from(
          result.headers.map.map((key, value) => MapEntry(key, value[0]))),
      statusCode: result.statusCode,
      statusMessage: result.statusMessage,
    );
  }

  @override
  Future<CommonResponse<T>> delete<T>(String uri,
      {data,
      Map<String, dynamic>? query,
      CommonRequestOptions? options}) async {
    final result = await _dio.delete<T>(
      uri,
      queryParameters: query,
      data: data,
      options:
          Options(headers: options?.headers, contentType: options?.contentType),
    );
    return CommonResponse(
      body: result.data,
      headers: Map<String, String>.from(
          result.headers.map.map((key, value) => MapEntry(key, value[0]))),
      statusCode: result.statusCode,
      statusMessage: result.statusMessage,
    );
  }

  @override
  Future<String?> get authToken async {
    return localStorageModule.get<String>(LocalDBConstant.token);
  }

  @override
  Future<void> removeAuthToken() async {
    await localStorageModule.remove(LocalDBConstant.token);
  }

  @override
  Future<void> saveAuthToken(String authToken) async {
    await localStorageModule.set<String>(LocalDBConstant.token, authToken);
  }
}
