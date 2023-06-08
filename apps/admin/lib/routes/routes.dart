import 'package:get/get.dart';

abstract class Routes {
  static Routes get instance => Get.find<Routes>();

  String get profile;
  String get students;
  String get lecturers;
  String get classes;
  String get login;
  String get addStudent;
}
