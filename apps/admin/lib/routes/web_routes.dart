import 'routes.dart';

class WebRoutes extends Routes {
  @override
  String get classes => "/classes";

  @override
  String get lecturers => "/lectures";

  @override
  String get profile => "/profile";

  @override
  String get students => "/students";

  @override
  String get login => "/login";

  @override
  String get addStudent => "/students/add";
}
