import 'package:flutter_flavor/flutter_flavor.dart';

class Endpoints {
  static final String baseUrl = FlavorConfig.instance.variables['baseUrl'];

  // login
  static final String login = "${baseUrl}login";

  // users
  static final String getAllUsers = "${baseUrl}users/all";
  static final String users = "${baseUrl}users";

  static final String lecturer = "${baseUrl}lecturer";

  static String get subjectClasses => "${baseUrl}subjectClass/all";
  static String lecturerDetails(String id) => "${baseUrl}lecturer/$id";
  static String userDetails(String uid) => "${baseUrl}users/$uid";
  static final String changeRole = "${baseUrl}users/change_role";

  // classes
  static String lecturerClasses(String lecturerId) => "${baseUrl}lecturer/$lecturerId/subject_class";

  // password
  static final String changePassword = "${baseUrl}change_password";
  static final String resetPassword = "${baseUrl}reset_password";

  // faculty
  static final String faculty = "${baseUrl}faculty";
  static String facultyDetails(id) => "${baseUrl}faculty/$id";
  static String facultyMajors(int facultyId) => "${baseUrl}faculty/$facultyId/major";
  static String facultyLecturers(int facultyId) =>
      "${baseUrl}faculty/$facultyId/lecturer";
  static String facultyStudents(int facultyId) => "${baseUrl}faculty/$facultyId/student";

  // Subject
  static final String subject = "${baseUrl}subject";

  // major
  static final String major = "${baseUrl}major";
  static String majorStudents(String uid) => "${baseUrl}major/$uid/student";

  // student
  static final String student = "${baseUrl}student";
  static final String allStudents = "${baseUrl}student/all";

  static String subjectClassDetails(String id) => "${baseUrl}subjectClass/$id";
}
