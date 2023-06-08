import 'package:get/get.dart';

import '../presentation/controllers/add_student_controller.dart';

class AddStudentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddStudentController());
  }
}
