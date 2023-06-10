import 'package:get/get.dart';

import 'create_subject_controller.dart';

class CreateSubjectBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateSubjectController>(() => CreateSubjectController(), fenix: true);
  }
}