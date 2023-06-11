import 'package:get/get.dart';

import 'students_controller.dart';

class StudentsBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => StudentsController(), fenix: true);
  }
}
