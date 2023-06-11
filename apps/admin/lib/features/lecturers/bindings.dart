import 'package:get/get.dart';

import 'lecturers_controller.dart';

class LecturersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LecturersController>(() => LecturersController());
  }
}