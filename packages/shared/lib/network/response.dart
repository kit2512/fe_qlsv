import 'dart:convert';

class CommonResponse<T> {
  CommonResponse({
    this.body,
    this.headers,
    this.statusCode,
    this.statusMessage,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  T? body;

  /// Response headers.
  Map<String, dynamic>? headers;

  /// Http status code.
  int? statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String? statusMessage;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (body is Map) {
      return json.encode(body);
    }
    return body.toString();
  }
}
