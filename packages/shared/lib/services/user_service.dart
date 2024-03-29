// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:shared/constants/endpoints.dart';
import 'package:shared/flavors/flavors.dart';
import 'package:shared/models/models.dart';
import 'package:shared/modules/modules.dart';
import 'package:shared/results/results.dart';
import 'package:url_launcher/url_launcher.dart';

class UserService extends GetxService {
  final RestfulModule restfulModule;
  final LocalStorageModule _localStorageModule;

  UserService({
    required this.restfulModule,
    required LocalStorageModule localStorageModule,
  }) : _localStorageModule = localStorageModule;

  final checkTokenUrl =
      '${FlavorConfig.instance.variables['baseUrl']}user/token/check-expiration';
  final logoutUrl = '${FlavorConfig.instance.variables['baseUrl']}user/logout';
  Rx<UserModel?> user = Rx<UserModel?>(null);

  bool get isLoggedIn => user.value != null;

  Future<bool> checkTokenExpire() async {
    return true;
    try {
      final RestfulModule restfulModule = Get.find();

      var res = await restfulModule.get(checkTokenUrl);
      if (res.body['data'] == null) {
        return false;
      } else {
        user.value = UserModel.fromJson(res.body['data']);

        return true;
      }
    } catch (e) {
      // logger.e("Error check token $e $stacktrace");
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      document.cookie = "token=" ";domain=fe-qlsv.web.app";
      _localStorageModule.clear();
      user.value = null;
      late final String url;
      switch (user.value?.roleName) {
        case UserRole.admin:
          url = AppFlavor.current.admin.variables['uri'] + '/login';
          break;
        case UserRole.student:
          url = AppFlavor.current.student.variables['uri'] + '/login';
          break;
        case UserRole.lecturer:
          url = AppFlavor.current.lecturer.variables['uri'] + '/login';
          break;
        default:
          url = AppFlavor.current.admin.variables['uri'] + '/login';
          break;
      }
      launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Either<Failure, bool>> login(String username, String password) async {
    try {
      final res = await restfulModule.post(
        FlavorConfig.instance.variables['baseUrl'] + 'login',
        {
          "email": username,
          "password": password,
        },
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final token = data["token"];
        document.cookie = "token=$token";
        final result = await getCurrentUserInfo();
        result.fold(
          (l) => const SystemFailure(message: "Error login"),
          (r) => user.value = r,
        );
        return const Right(true);
      } else {
        return Left(
          SystemFailure(
            message: res.statusMessage,
          ),
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(
          SystemFailure(
            message: "Username or password is incorrect",
          ),
        );
      } else {
        return const Left(
            AuthFailure(message: "Error login, please try again"));
      }
    }
  }

  Future<Either<Failure, UserModel>> getCurrentUserInfo() async {
    final res = await restfulModule.get(Endpoints.users);
    if (res.statusCode == 200) {
      return Right(UserModel.fromJson(jsonDecode(res.body)));
    } else {
      return Left(
        SystemFailure(
          message: res.statusMessage,
        ),
      );
    }
  }
}
