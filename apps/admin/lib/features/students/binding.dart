import 'package:get/get.dart';

import 'presentation/controllers/students_controller.dart';

class StudentsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentsController());
  }
}
