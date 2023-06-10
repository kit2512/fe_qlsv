import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthMiddleware extends GetMiddleware {
  final UserService _userService;

  AuthMiddleware({required UserService userService})
      : _userService = userService;

  @override
  RouteSettings? redirect(String? route) {
    try {
      final cookies = AppUtils.getAuthorization();
      if (cookies["token"] == null || cookies["token"]!.trim().isEmpty) {
        logger.e("TOKEN IS NULL");
        launchUrl(
            Uri.parse(AppFlavor.current.admin.variables['uri'] + "/login"),
            webOnlyWindowName: '_self');
      }
    } catch (e, stacktrace) {
      logger.e("AUTH MIDDLEWARE ERROR", e.toString(), stacktrace);
    }
    return null;
  }
}
