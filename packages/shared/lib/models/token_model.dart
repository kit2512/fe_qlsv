class TokenModel {
  final String? token;
  final String? uid;
  final String? msg;

  TokenModel({
    this.token,
    this.uid,
    this.msg,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'],
      uid: json['uid'],
      msg: json['msg'],
    );
  }
}
