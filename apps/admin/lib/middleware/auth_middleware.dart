import 'dart:html';

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
      // _userService.checkTokenExpire().then((value) {
      //   if (!value) {
      //     launchUrl(Uri.parse(AppFlavor.current.console.variables['uri']),
      //         webOnlyWindowName: '_self');
      //   }
      // });
      if (document.cookie == null || document.cookie!.isEmpty) {
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
