import 'package:get/get.dart';

import 'edit_lecturer_controller.dart';

class EditLecturerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditLecturerController());
  }
}