import 'dart:html';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:shared/flavors/base_flavor.dart';
import 'package:url_launcher/url_launcher.dart';

enum AppType { candidate, firm, admin, console, agency }

class AppUtils {
  AppUtils._();

  static loginRouter(r) {
    if (r.role.toLowerCase() == 'admin') {
      launchUrl(
          Uri.parse(AppFlavor.current.admin.variables['uri'] + '/students'),
          webOnlyWindowName: '_self');
    } else if (r.role.toLowerCase() == 'student') {
      launchUrl(
          Uri.parse(AppFlavor.current.student.variables['uri'] + '/profile'),
          webOnlyWindowName: '_self');
    } else if (r.role.toLowerCase() == "lecturer") {
      launchUrl(
        Uri.parse(AppFlavor.current.lecturer.variables["uri"] + "/profile"),
      );
    }
  }

  static String getTimeNotification(DateTime time) {
    var diffTime = DateTime.now().difference(time);

    if (diffTime.inDays > 0) {
      return '${diffTime.inDays} days ago';
    } else {
      if (diffTime.inHours > 0) {
        return '${diffTime.inHours} hours ago';
      } else {
        if (diffTime.inMinutes > 0) {
          return '${diffTime.inMinutes} minutes ago';
        } else {
          return 'A few seconds ago';
        }
      }
    }
  }

  static Future<Uint8List> convertToBytes(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoad.first;
    var imageData = reader.result as Uint8List;

    return imageData;
  }

  static logOut() {
    document.cookie = '';
    launchUrl(Uri.parse(AppFlavor.current.console.variables['uri'] + '/login'),
        webOnlyWindowName: '_self');
  }

  static Map<String, dynamic> getAuthorization() {
    final cookie = document.cookie!;
    if (cookie != '') {
      final entity = cookie.split("; ").map((item) {
        final split = item.split("=");
        return MapEntry(split[0], split[1]);
      });

      final Map<String, dynamic> cookieMap = Map.fromEntries(entity);
      print(cookieMap);
      return cookieMap;
    } else {
      return {};
    }
  }

  static String getAppUriBase(AppType type) {
    switch (type) {
      case AppType.admin:
        return 'https://dev-admin.higate.io';
      case AppType.agency:
        return 'https://dev-agency.higate.io';
      case AppType.candidate:
        return 'https://dev-candidate.higate.io';
      case AppType.console:
        return 'https://dev-console.higate.io';
      case AppType.firm:
        return 'https://dev-firm.higate.io';
      default:
        return 'https://dev-console.higate.io';
    }
  }

  static bool validatePassword(String password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (!regex.hasMatch(password)) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static bool validateUsername(String username) {
    RegExp regex =
        RegExp(r'^(?!.*[-_]{2,})[a-zA-Z][a-zA-Z0-9-_]{4,22}[a-zA-Z0-9]$');
    if (!regex.hasMatch(username)) {
      return false;
    } else {
      return true;
    }
  }

  /// return ["Closed"] when the [jobStatus] is closed, otherwise return [applyStatus]
  static String getJobStatus(String? status, String? applyStatus) {
    if (status == "closed") {
      return "Closed";
    }

    return applyStatus ?? "";
  }
}
