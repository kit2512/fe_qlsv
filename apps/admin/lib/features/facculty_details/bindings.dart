import 'package:get/get.dart';

import 'faculty_details_controller.dart';

class FacultyDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FacultyDetailsController>(() => FacultyDetailsController());
  }
}