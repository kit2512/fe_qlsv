import 'package:get/get.dart';

import 'subject_classes_controller.dart';

class SubjectClassesBindings extends Bindings {
@override
  void dependencies() {
    Get.lazyPut<SubjectClassesController>(() => SubjectClassesController());
  }
}
