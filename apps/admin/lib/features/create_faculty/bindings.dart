import 'package:get/get.dart';

import 'create_faculty_controller.dart';

class CreateFacultyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateFacultyController(), fenix: true);
  }
}