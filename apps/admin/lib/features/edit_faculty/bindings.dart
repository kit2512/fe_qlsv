import 'package:get/get.dart';

import 'edit_faculty_controller.dart';

class EditFacultyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditFacultyController>(() => EditFacultyController());
  }
}