import 'package:flutter_flavor/flutter_flavor.dart';

class Endpoints {
  static final String baseUrl = FlavorConfig.instance.variables['baseUrl'];

  // login
  static final String login = "${baseUrl}login";

  // users
  static final String getAllUsers = "${baseUrl}users/all";
  static final String users = "${baseUrl}users";
  static String user(String uid) => "${baseUrl}users/$uid";
  static final String changeRole = "${baseUrl}users/change_role";

  // password
  static final String changePassword = "${baseUrl}change_password";
  static final String resetPassword = "${baseUrl}reset_password";

  // faculty
  static final String faculty = "${baseUrl}faculty";
  static String facultyDetails(String uid) => "${baseUrl}faculty/$uid";
  static String facultyMajors(String uid) => "${baseUrl}faculty/$uid/major";
  static String facultyLecturers(String uid) =>
      "${baseUrl}faculty/$uid/lecturer";
  static String facultyStudents(String uid) => "${baseUrl}faculty/$uid/student";

  // Subject
  static final String subject = "${baseUrl}subject";

  // major
  static final String major = "${baseUrl}major";
  static String majorStudents(String uid) => "${baseUrl}major/$uid/student";

  // student
  static final String student = "${baseUrl}student";
}
