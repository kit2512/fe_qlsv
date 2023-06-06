/// Request options, base on Dio

class CommonRequestOptions {
  /// Http request headers. The keys of initial headers will be converted to lowercase,
  /// for example 'Content-Type' will be converted to 'content-type'.
  ///
  /// The key of Header Map is case-insensitive, eg: content-type and Content-Type are
  /// regard as the same key.
  Map<String, String>? headers;

  /// The request Content-Type. The default value is [ContentType.json].
  /// If you want to encode request body with 'application/x-www-form-urlencoded',
  /// you can set `ContentType.parse('application/x-www-form-urlencoded')`, and [Dio]
  /// will automatically encode the request body.
  String contentType = 'application/json; charset=utf-8';

  CommonRequestOptions({
    this.headers,
    this.contentType = 'application/json; charset=utf-8',
  });
}
