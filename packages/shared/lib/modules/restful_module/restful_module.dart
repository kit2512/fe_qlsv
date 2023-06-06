import '../../network/options.dart';
import '../../network/response.dart';

abstract class RestfulModule {
  Future<String?> get authToken;

  Future<void> saveAuthToken(String authToken);

  Future<void> removeAuthToken();

  Future<CommonResponse<T>> get<T>(
    String uri, {
    Map<String, dynamic>? query,
    CommonRequestOptions? options,
  });

  Future<CommonResponse<T>> post<T>(
    String uri,
    data, {
    Map<String, dynamic>? query,
    CommonRequestOptions? options,
  });

  Future<CommonResponse<T>> put<T>(
    String uri, {
    data,
    Map<String, dynamic>? query,
    CommonRequestOptions? options,
  });

  Future<CommonResponse<T>> delete<T>(
    String uri, {
    data,
    Map<String, dynamic>? query,
    CommonRequestOptions? options,
  });
}
